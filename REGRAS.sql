-- ==========================================================================================
-- TRIGGER: tg_validar_ocupacao
-- OBJETIVO: Garantir consistência entre vagas_reais e vagas_disponiveis.
-- 
-- CENÁRIOS:
-- VAGAS_REAIS:
-- 1. Se vagas_reais for NULL → define com base na capacidade total do veículo.
-- 2. Permite valores menores ou iguais à capacidade do veículo.
-- 3. Bloqueia valor maior que a capacidade do veículo.
--
-- VAGAS_DISPONIVEIS:
-- 4. Se vagas_disponiveis for NULL → assume o valor de vagas_reais.
-- 5. Bloqueia valor maior que vagas_reais.
-- ==========================================================================================

DELIMITER //

CREATE TRIGGER tg_validar_ocupacao
BEFORE INSERT ON ocupacao
FOR EACH ROW
BEGIN
    DECLARE v_vagas_maximas INT;

    -- ================================
    -- 1. Buscar capacidade do veículo
    -- ================================
    SET v_vagas_maximas = (
        SELECT v.vagas 
        FROM veiculo v
        INNER JOIN historico_veiculo hv 
            ON v.cod_veiculo = hv.cod_veiculo
        WHERE hv.cod_historico_veiculo = NEW.cod_historico_veiculo
        LIMIT 1
    );

    -- ================================
    -- 2. REGRA: vagas_reais
    -- ================================

    -- Se NULL → usa capacidade máxima
    IF NEW.vagas_reais IS NULL THEN
        SET NEW.vagas_reais = v_vagas_maximas;

    -- Não pode ser maior que a capacidade
    ELSEIF NEW.vagas_reais > v_vagas_maximas THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'ERRO: vagas_reais não pode ser maior que a capacidade do veículo.';
    END IF;

    -- ================================
    -- 3. REGRA: vagas_disponiveis
    -- ================================

    -- Se NULL → assume vagas_reais (já validado acima)
    IF NEW.vagas_disponiveis IS NULL THEN
        SET NEW.vagas_disponiveis = NEW.vagas_reais;

    -- Não pode ser maior que vagas_reais
    ELSEIF NEW.vagas_disponiveis > NEW.vagas_reais THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRO: vagas_disponiveis não pode ser maior que vagas_reais.';
    END IF;

END //

DELIMITER ;

-- ==========================================================================================
-- TRIGGER: tg_impedir_alteracao_estrutural
-- OBJETIVO: Bloquear alterações em campos críticos da tabela ocupacao após sua criação.
-- 
-- CENÁRIO DE PROTEÇÃO:
-- 1. Veículo (cod_historico_veiculo): Impede que troquem o carro da viagem.
--
-- ==========================================================================================

DELIMITER //

CREATE TRIGGER tg_impedir_alteracao_estrutural
BEFORE UPDATE ON ocupacao
FOR EACH ROW
BEGIN
    IF OLD.cod_historico_veiculo <> NEW.cod_historico_veiculo THEN
       
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRO: Não é permitido alterar o veículo da ocupação.';
    
    END IF;
END //

DELIMITER ;

-- ==========================================================================================
-- EVENT SCHEDULER
-- Ativa e verifica o agendador de eventos do MySQL
-- ==========================================================================================

SET GLOBAL event_scheduler = ON;
SELECT @@event_scheduler;

-- ==========================================================================================
-- EVENTO: ev_remocao_diaria_agendamentos
-- OBJETIVO: Realizar a remoção diária de agendamentos cancelados após o período de retenção.
--
-- REGRA DE NEGÓCIO:
-- Agendamentos com status = 0 e com data_cadastro superior a 6 meses
-- são considerados elegíveis para exclusão.
--
-- COMPORTAMENTO:
-- A exclusão ocorre em lote controlado (LIMIT 500),
-- garantindo execução eficiente e com baixo impacto no banco de dados.
--
-- FREQUÊNCIA:
-- Executado automaticamente 1 vez por dia pelo Event Scheduler do MySQL.
--
-- FINALIDADE:
-- Garantir a limpeza de dados antigos e atuar como reforço ao processo
-- contínuo de manutenção da base.
--
-- OBSERVAÇÃO:
-- Este processo não depende do backend, sendo totalmente gerenciado pelo banco de dados.
-- A data de referência (data_cadastro) é fornecida pelo backend no momento do registro.
-- ==========================================================================================

CREATE EVENT IF NOT EXISTS ev_remocao_diaria_agendamentos
ON SCHEDULE EVERY 1 DAY
STARTS TIMESTAMP(CURRENT_DATE, '02:00:00')
DO
DELETE FROM agendamento
WHERE status = 0
AND data_cadastro <= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
LIMIT 500;

-- ==========================================================================================
-- EVENTO: ev_remocao_incremental_agendamentos
-- OBJETIVO: Realizar a remoção gradual de agendamentos cancelados para evitar acúmulo de dados.
--
-- REGRA DE NEGÓCIO:
-- Agendamentos com status = 0 e com data_cadastro superior a 6 meses
-- são considerados elegíveis para exclusão.
--
-- COMPORTAMENTO:
-- A exclusão ocorre de forma controlada e em pequenos lotes (LIMIT 100),
-- garantindo baixo impacto no desempenho do banco de dados.
--
-- FREQUÊNCIA:
-- Executado automaticamente a cada 2 horas pelo Event Scheduler do MySQL.
--
-- FINALIDADE:
-- Manter a base de dados enxuta no dia a dia, evitando sobrecarga
-- e complementando o processo de limpeza diária.
--
-- OBSERVAÇÃO:
-- Este processo não depende do backend, sendo totalmente gerenciado pelo banco de dados.
-- A data de referência (data_cadastro) é fornecida pelo backend no momento do registro.
-- ==========================================================================================

CREATE EVENT IF NOT EXISTS ev_remocao_incremental_agendamentos
ON SCHEDULE EVERY 2 HOUR
DO
DELETE FROM agendamento
WHERE status = 0
AND data_cadastro <= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
LIMIT 100;

/*
-- ==========================================================================================
-- TESTE MANUAL DOS EVENTS
-- Simula a remoção de agendamentos cancelados com mais de 6 meses
-- ==========================================================================================

-- Evento diário (lote maior)
DELETE FROM agendamento
WHERE status = 0
AND data_cadastro <= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
LIMIT 500;

-- Evento recorrente (lote menor)
DELETE FROM agendamento
WHERE status = 0
AND data_cadastro <= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
LIMIT 100;
*/