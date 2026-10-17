CREATE DATABASE script;

USE script;

CREATE TABLE IF NOT EXISTS instituicao (
  cod_instituicao BIGINT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(150) NOT NULL,
  razao_social VARCHAR(200) NOT NULL,
  data_cadastro DATE NOT NULL, -- Definido pelo Back-end
  status BOOLEAN DEFAULT 1 COMMENT 'Ativo (1) ou Inativo (0)',
  PRIMARY KEY (cod_instituicao),

UNIQUE (nome),
UNIQUE (razao_social),
CONSTRAINT chk_instituicao_status CHECK (status IN (1, 0))
);

CREATE TABLE IF NOT EXISTS aluno (
  cod_aluno BIGINT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(150) NOT NULL,
  data_nascimento DATE NOT NULL,
  telefone VARCHAR(15) NOT NULL COMMENT 'DDD + Número (11 dígitos)',
  email VARCHAR(255) NOT NULL,
  keycloak_id VARCHAR(36) NOT NULL COMMENT 'UUID do usuário no servidor de autenticação (Keycloak)',
  cod_instituicao BIGINT NOT NULL,
  data_cadastro DATE NOT NULL, -- Definido pelo Back-end
  status BOOLEAN DEFAULT 1 COMMENT 'Ativo (1) ou Inativo (0)',
  PRIMARY KEY (cod_aluno),

UNIQUE (telefone),
CONSTRAINT chk_aluno_telefone CHECK (telefone REGEXP '^[0-9]{11}$'),
CONSTRAINT chk_aluno_status CHECK (status IN (1, 0))
);

CREATE TABLE IF NOT EXISTS endereco (
  cod_endereco BIGINT NOT NULL AUTO_INCREMENT,
  cep VARCHAR(15) NOT NULL COMMENT 'Sem traços ou pontos, exatamente 8 dígitos numéricos',
  rua VARCHAR(150) NOT NULL,
  numero INT NULL,
  complemento VARCHAR(100) NULL,
  bairro VARCHAR(100) NOT NULL,
  cidade VARCHAR(150) NOT NULL,
  estado VARCHAR(50) NOT NULL,
  cod_aluno BIGINT NOT NULL,
  data_cadastro DATE NOT NULL, -- Definido pelo Back-end
  status BOOLEAN DEFAULT 1 COMMENT 'Ativo (1) ou Inativo (0)',
  PRIMARY KEY (cod_endereco),

UNIQUE (cod_aluno),
CONSTRAINT chk_endereco_cep CHECK (cep REGEXP '^[0-9]{8}$'),
CONSTRAINT chk_endereco_status CHECK (status IN (1, 0))
);

CREATE TABLE IF NOT EXISTS campus (
  cod_campus BIGINT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(150) NOT NULL,
  razao_social VARCHAR(200) NOT NULL,
  data_cadastro DATE NOT NULL, -- Definido pelo Back-end
  status BOOLEAN DEFAULT 1 COMMENT 'Ativo (1) ou Inativo (0)',
  PRIMARY KEY (cod_campus),

UNIQUE (nome),
UNIQUE (razao_social),
CONSTRAINT chk_campus_status CHECK (status IN (1, 0))
);

CREATE TABLE IF NOT EXISTS veiculo (
  cod_veiculo BIGINT NOT NULL AUTO_INCREMENT,
  placa VARCHAR(60) NOT NULL,
  modelo VARCHAR(100) NOT NULL,
  descricao VARCHAR(100) NULL,
  vagas INT NOT NULL COMMENT 'Capacidade total',
  coordenadas POINT NULL COMMENT 'Localização geográfica (Latitude e Longitude)',
  cod_campus BIGINT NOT NULL,
  data_cadastro DATE NOT NULL, -- Definido pelo Back-end
  status BOOLEAN DEFAULT 1 COMMENT 'Ativo (1) ou Inativo (0)',
  PRIMARY KEY (cod_veiculo),
  
UNIQUE (placa),
CONSTRAINT chk_ocupacao_vagas CHECK (vagas >= 0),
CONSTRAINT chk_veiculo_status CHECK (status IN (1, 0))
);

CREATE TABLE IF NOT EXISTS itinerario (
  cod_itinerario BIGINT NOT NULL AUTO_INCREMENT,
  ponto_partida VARCHAR(150) NOT NULL,
  ponto_chegada VARCHAR(150) NOT NULL,
  data_cadastro DATE NOT NULL, -- Definido pelo Back-end
  status BOOLEAN DEFAULT 1 COMMENT 'Ativo (1) ou Inativo (0)',
  PRIMARY KEY (cod_itinerario),

UNIQUE (ponto_partida, ponto_chegada),
CONSTRAINT chk_itinerario_status CHECK (status IN (1, 0))
);

CREATE TABLE IF NOT EXISTS horario (
  cod_horario BIGINT NOT NULL AUTO_INCREMENT,
  horario_partida TIME NOT NULL,
  horario_chegada TIME NOT NULL,
  data_cadastro DATE NOT NULL, -- Definido pelo Back-end
  status BOOLEAN DEFAULT 1 COMMENT 'Ativo (1) ou Inativo (0)',
  PRIMARY KEY (cod_horario),
  
UNIQUE (horario_partida, horario_chegada),
CONSTRAINT chk_horario_status CHECK (status IN (1, 0))
);

CREATE TABLE IF NOT EXISTS historico_veiculo (
  cod_historico_veiculo BIGINT NOT NULL AUTO_INCREMENT,
  cod_veiculo BIGINT NOT NULL,
  cod_itinerario BIGINT NOT NULL,
  cod_horario BIGINT NOT NULL,
  data_cadastro DATE NOT NULL, -- Definido pelo Back-end
  status BOOLEAN DEFAULT 1 COMMENT 'Ativo (1) ou Inativo (0)',
  PRIMARY KEY (cod_historico_veiculo),
  
CONSTRAINT chk_historico_veiculo_status CHECK (status IN (1, 0))
);

CREATE TABLE IF NOT EXISTS motorista (
  cod_motorista BIGINT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(150) NOT NULL,
  data_nascimento DATE NOT NULL,
  telefone VARCHAR(15) NOT NULL COMMENT 'DDD + Número (11 dígitos)',
  data_cadastro DATE NOT NULL, -- Definido pelo Back-end
  status BOOLEAN DEFAULT 1 COMMENT 'Ativo (1) ou Inativo (0)',
  PRIMARY KEY (cod_motorista),
  
UNIQUE (telefone),
CONSTRAINT chk_motorista_telefone CHECK (telefone REGEXP '^[0-9]{11}$'),
CONSTRAINT chk_motorista_status CHECK (status IN (1, 0))
);

CREATE TABLE IF NOT EXISTS ocupacao (
  cod_ocupacao BIGINT NOT NULL AUTO_INCREMENT,
  vagas_reais INT NULL COMMENT 'Capacidade disponível',
  vagas_disponiveis INT NULL COMMENT 'Saldo atual de vagas',
  cod_historico_veiculo BIGINT NOT NULL,
  cod_motorista BIGINT NOT NULL,
  data_cadastro DATE NOT NULL, -- Definido pelo Back-end
  status BOOLEAN DEFAULT 1 COMMENT 'Ativo (1) ou Inativo (0)',
  PRIMARY KEY (cod_ocupacao),

CONSTRAINT chk_ocupacao_vagas_reais CHECK (vagas_reais IS NULL OR vagas_reais >= 0),
CONSTRAINT chk_ocupacao_vagas_disponiveis CHECK (vagas_disponiveis IS NULL OR vagas_disponiveis >= 0),
CONSTRAINT chk_ocupacao_status CHECK (status IN (1, 0))
);

CREATE TABLE IF NOT EXISTS usuario_sistema (
  cod_usuario_sistema BIGINT NOT NULL AUTO_INCREMENT,
  email VARCHAR(255) NOT NULL,
  keycloak_id VARCHAR(36) NOT NULL COMMENT 'UUID do usuário no servidor de autenticação (Keycloak)',
  data_cadastro DATE NOT NULL, -- Definido pelo Back-end
  status BOOLEAN DEFAULT 1 COMMENT 'Ativo (1) ou Inativo (0)',
  PRIMARY KEY (cod_usuario_sistema),
  
UNIQUE (email),
CONSTRAINT chk_usuario_sistema_status CHECK (status IN (1, 0))
);
  
CREATE TABLE IF NOT EXISTS agendamento (
  cod_agendamento BIGINT NOT NULL AUTO_INCREMENT,
  data_reserva DATE NOT NULL, -- Definido pelo Back-end
  hora_reserva TIME NOT NULL, -- Definido pelo Back-end
  chamada_ida CHAR(1) DEFAULT NULL COMMENT 'Presente (P) ou Falta (F)',
  chamada_volta CHAR(1) DEFAULT NULL COMMENT 'Presente (P) ou Falta (F)', 
  cod_ocupacao BIGINT NOT NULL,
  cod_aluno BIGINT NOT NULL,
  cod_usuario_sistema BIGINT NULL,
  data_cadastro DATE NOT NULL, -- Definido pelo Back-end
  status BOOLEAN DEFAULT 1 COMMENT 'Ativo (1) ou Inativo (0)',
  PRIMARY KEY (cod_agendamento),

CONSTRAINT chk_agendamento_chamada_ida CHECK (chamada_ida IN ('P','F') OR chamada_ida IS NULL),
CONSTRAINT chk_agendamento_chamada_volta CHECK (chamada_volta IN ('P','F') OR chamada_volta IS NULL),
CONSTRAINT chk_agendamento_usuario_chamada CHECK ((chamada_ida IS NULL AND chamada_volta IS NULL) OR cod_usuario_sistema IS NOT NULL),
UNIQUE (data_reserva, hora_reserva, cod_ocupacao, cod_aluno), -- Impede agendamentos idênticos para o mesmo aluno
CONSTRAINT chk_agendamento_status CHECK (status IN (1, 0))
);

# ===========================================
#                 FOREIGN KEY
# ===========================================

# ===========================================
#               TABLE - ALUNO
# ===========================================

ALTER TABLE aluno
ADD CONSTRAINT fk_aluno_instituicao
FOREIGN KEY (cod_instituicao) 
REFERENCES instituicao(cod_instituicao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

# ===========================================
#              TABLE - ENDERECO
# ===========================================

ALTER TABLE endereco
ADD CONSTRAINT fk_endereco_aluno
FOREIGN KEY (cod_aluno) 
REFERENCES aluno(cod_aluno)
ON DELETE CASCADE
ON UPDATE NO ACTION;

# ===========================================
#              TABLE - OCUPACAO
# ===========================================

ALTER TABLE ocupacao
ADD CONSTRAINT fk_ocupacao_historico_veiculo
FOREIGN KEY (cod_historico_veiculo) 
REFERENCES historico_veiculo(cod_historico_veiculo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE ocupacao
ADD CONSTRAINT fk_ocupacao_motorista
FOREIGN KEY (cod_motorista) 
REFERENCES motorista(cod_motorista)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

# ===========================================
#            TABLE - AGENDAMENTO
# ===========================================

ALTER TABLE agendamento
ADD CONSTRAINT fk_agendamento_ocupacao
FOREIGN KEY (cod_ocupacao) 
REFERENCES ocupacao(cod_ocupacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE agendamento
ADD CONSTRAINT fk_agendamento_aluno
FOREIGN KEY (cod_aluno) 
REFERENCES aluno(cod_aluno)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE agendamento
ADD CONSTRAINT fk_agendamento_aluno_usuario_sistema
FOREIGN KEY (cod_usuario_sistema) 
REFERENCES usuario_sistema(cod_usuario_sistema)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

# ===========================================
#             TABLE - VEICULO
# ===========================================

ALTER TABLE veiculo
ADD CONSTRAINT fk_veiculo_campus
FOREIGN KEY (cod_campus)
REFERENCES campus(cod_campus)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

# ===========================================
#         TABLE - HISTORICO_VEICULO
# ===========================================

ALTER TABLE historico_veiculo
ADD CONSTRAINT fk_historico_veiculo
FOREIGN KEY (cod_veiculo)
REFERENCES veiculo(cod_veiculo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_veiculo
ADD CONSTRAINT fk_historico_itinerario
FOREIGN KEY (cod_itinerario)
REFERENCES itinerario(cod_itinerario)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_veiculo
ADD CONSTRAINT fk_historico_horario
FOREIGN KEY (cod_horario)
REFERENCES horario(cod_horario)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

# ================================================================
# == TRIGGERS DE PADRONIZAÇÃO DE DADOS
# ================================================================

# =============================================================
# POLÍTICA DE PADRONIZAÇÃO DE TEXTO (UPPERCASE)
# =============================================================
# Estas triggers são responsáveis por garantir a consistência dos dados
# automaticamente, convertendo colunas específicas para MAIÚSCULO (UPPERCASE)
# antes de cada inserção ou atualização.
# =============================================================

DELIMITER //

-- =========================
-- INSTITUICAO
-- =========================
CREATE TRIGGER tg_instituicao_insert_upper
BEFORE INSERT ON instituicao
FOR EACH ROW
BEGIN
  SET NEW.nome = UPPER(NEW.nome);
  SET NEW.razao_social = UPPER(NEW.razao_social);
END //

CREATE TRIGGER tg_instituicao_update_upper
BEFORE UPDATE ON instituicao
FOR EACH ROW
BEGIN
  SET NEW.nome = UPPER(NEW.nome);
  SET NEW.razao_social = UPPER(NEW.razao_social);
END //

-- =========================
-- ALUNO
-- =========================
CREATE TRIGGER tg_aluno_insert_upper
BEFORE INSERT ON aluno
FOR EACH ROW
BEGIN
  SET NEW.nome = UPPER(NEW.nome);
END //

CREATE TRIGGER tg_aluno_update_upper
BEFORE UPDATE ON aluno
FOR EACH ROW
BEGIN
  SET NEW.nome = UPPER(NEW.nome);
END //

-- =========================
-- ENDERECO
-- =========================
CREATE TRIGGER tg_endereco_insert_upper
BEFORE INSERT ON endereco
FOR EACH ROW
BEGIN
  SET NEW.rua = UPPER(NEW.rua);
  SET NEW.bairro = UPPER(NEW.bairro);
  SET NEW.cidade = UPPER(NEW.cidade);
  SET NEW.estado = UPPER(NEW.estado);
END //

CREATE TRIGGER tg_endereco_update_upper
BEFORE UPDATE ON endereco
FOR EACH ROW
BEGIN
  SET NEW.rua = UPPER(NEW.rua);
  SET NEW.bairro = UPPER(NEW.bairro);
  SET NEW.cidade = UPPER(NEW.cidade);
  SET NEW.estado = UPPER(NEW.estado);
END //

-- =========================
-- CAMPUS
-- =========================
CREATE TRIGGER tg_campus_insert_upper
BEFORE INSERT ON campus
FOR EACH ROW
BEGIN
  SET NEW.nome = UPPER(NEW.nome);
  SET NEW.razao_social = UPPER(NEW.razao_social);
END //

CREATE TRIGGER tg_campus_update_upper
BEFORE UPDATE ON campus
FOR EACH ROW
BEGIN
  SET NEW.nome = UPPER(NEW.nome);
  SET NEW.razao_social = UPPER(NEW.razao_social);
END //

-- =========================
-- VEICULO
-- =========================
CREATE TRIGGER tg_veiculo_insert_upper
BEFORE INSERT ON veiculo
FOR EACH ROW
BEGIN
  SET NEW.placa = UPPER(NEW.placa);
  SET NEW.modelo = UPPER(NEW.modelo);
END //

CREATE TRIGGER tg_veiculo_update_upper
BEFORE UPDATE ON veiculo
FOR EACH ROW
BEGIN
  SET NEW.placa = UPPER(NEW.placa);
  SET NEW.modelo = UPPER(NEW.modelo);
END //

-- =========================
-- ITINERARIO
-- =========================
CREATE TRIGGER tg_itinerario_insert_upper
BEFORE INSERT ON itinerario
FOR EACH ROW
BEGIN
  SET NEW.ponto_partida = UPPER(NEW.ponto_partida);
  SET NEW.ponto_chegada = UPPER(NEW.ponto_chegada);
END //

CREATE TRIGGER tg_itinerario_update_upper
BEFORE UPDATE ON itinerario
FOR EACH ROW
BEGIN
  SET NEW.ponto_partida = UPPER(NEW.ponto_partida);
  SET NEW.ponto_chegada = UPPER(NEW.ponto_chegada);
END //

-- =========================
-- MOTORISTA
-- =========================
CREATE TRIGGER tg_motorista_insert_upper
BEFORE INSERT ON motorista
FOR EACH ROW
BEGIN
  SET NEW.nome = UPPER(NEW.nome);
END //

CREATE TRIGGER tg_motorista_update_upper
BEFORE UPDATE ON motorista
FOR EACH ROW
BEGIN
  SET NEW.nome = UPPER(NEW.nome);
END //

-- =========================
-- AGENDAMENTO
-- =========================
CREATE TRIGGER tg_agendamento_insert_upper
BEFORE INSERT ON agendamento
FOR EACH ROW
BEGIN
  SET NEW.chamada_ida = UPPER(NEW.chamada_ida);
  SET NEW.chamada_volta = UPPER(NEW.chamada_volta);  
END //

CREATE TRIGGER tg_agendamento_update_upper
BEFORE UPDATE ON agendamento
FOR EACH ROW
BEGIN
  SET NEW.chamada_ida = UPPER(NEW.chamada_ida);
  SET NEW.chamada_volta = UPPER(NEW.chamada_volta);  
END //

DELIMITER ;

