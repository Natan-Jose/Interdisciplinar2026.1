-- ===========================================
-- USUÁRIOS DO SISTEMA (ADM)
-- ===========================================
-- Usuários internos que gerenciam o sistema

INSERT INTO usuario_sistema (cod_usuario_sistema, email, keycloak_id, data_cadastro) VALUES
(1, 'admin.central@transporte.com', 'a1b2c3d4-e5f6-47a8-b9c0-123456789001', '2026-01-01'),
(2, 'operador.leste@transporte.com', 'b2c3d4e5-f6a7-48b9-c0d1-234567890002', '2026-01-01'),
(3, 'fiscal.norte@transporte.com', 'c3d4e5f6-a7b8-49c9-d0e1-345678901003', '2026-01-02'),
(4, 'gerente.frota@transporte.com', 'd4e5f6a7-b8c9-40d0-e1f2-456789012004', '2026-01-02');

-- ===========================================
-- INSTITUICOES
-- ===========================================
-- Faculdades/universidades vinculadas

INSERT INTO instituicao (cod_instituicao, nome, razao_social, data_cadastro) VALUES 
(1, 'Uninassau', 'Ser Educacional s.a', '2026-01-08'),
(2, 'Unibra', 'IBGM - Instituto Brasileiro de Gestão & Marketing Ltda', '2026-01-05'),
(3, 'Unicap', 'Universidade Católica de Pernambuco', '2026-05-04');

-- ===========================================
-- CAMPUS (Destinos dos Ônibus)
-- ===========================================
-- Unidades para onde o transporte se desloca

INSERT INTO campus (cod_campus,  nome, razao_social, data_cadastro) VALUES 
(1, 'Uninassau', 'Ser Educacional s.a', '2026-01-08'),
(2, 'Unibra', 'IBGM - Instituto Brasileiro de Gestão & Marketing Ltda', '2026-01-05'),
(3, 'Unicap', 'Universidade Católica de Pernambuco', '2026-05-04');

-- ===========================================
-- ALUNOS
-- ===========================================
-- Dados principais dos estudantes

INSERT INTO aluno (cod_aluno, nome, data_nascimento, telefone, email, keycloak_id, cod_instituicao, data_cadastro) VALUES
(1, 'Ana Beatriz Silva', '2005-05-15', '81988887777', 'ana.silva@email.com', '550e8400-e29b-41d4-a716-446655440001', 1, '2026-02-01'),
(2, 'Bruno Henrique Costa', '2004-03-20', '81977776666', 'bruno.costa@email.com', '550e8400-e29b-41d4-a716-446655440002', 2, '2026-02-02'),
(3, 'Carla Mendes Souza', '2006-11-02', '81966665555', 'carla.souza@email.com', '550e8400-e29b-41d4-a716-446655440003', 1, '2026-02-03'),
(4, 'Diego Alves Lima', '2003-08-12', '81955554444', 'diego.lima@email.com', '550e8400-e29b-41d4-a716-446655440004', 2, '2026-02-05'),
(5, 'Elena Cristina Martins', '2005-01-30', '81944443333', 'elena.martins@email.com', '550e8400-e29b-41d4-a716-446655440005', 1, '2026-02-06'),
(6, 'Fabio Ribeiro Gomes', '2002-12-10', '81933332222', 'fabio.gomes@email.com', '550e8400-e29b-41d4-a716-446655440006', 2, '2026-02-08'),
(7, 'Gisele Pereira Nunes', '2004-07-22', '81922221111', 'gisele.nunes@email.com', '550e8400-e29b-41d4-a716-446655440007', 1, '2026-02-09'),
(8, 'Helio Santos Oliveira', '2003-04-05', '81911110000', 'helio.oliveira@email.com', '550e8400-e29b-41d4-a716-446655440008', 2, '2026-02-10'),
(9, 'Igor Fernandes Oliveira', '2005-09-18', '81999998888', 'igor.fernandes@email.com', '550e8400-e29b-41d4-a716-446655440009', 1, '2026-02-11'),
(10, 'Julia Rodrigues Ferreira', '2006-02-25', '81900001111', 'julia.ferreira@email.com', '550e8400-e29b-41d4-a716-446655440010', 2, '2026-02-12');

-- ===========================================
-- ENDEREÇOS
-- ===========================================
-- Localização dos alunos (Região Recife/Olinda)

INSERT INTO endereco (cod_endereco, cep, rua, numero, bairro, cidade, estado, cod_aluno, data_cadastro) VALUES
(1, '50010000', 'Praca da Republica', 10, 'Santo Antonio', 'Recife', 'PE', 1, '2026-01-10'),
(2, '52060000', 'Avenida Norte Miguel Arraes de Alencar', 1500, 'Casa Amarela', 'Recife', 'PE', 2, '2026-01-11'),
(3, '50761000', 'Rua Benfica', 50, 'Madalena', 'Recife', 'PE', 3, '2026-01-12'),
(4, '54400000', 'Avenida Bernardo Vieira de Melo', 200, 'Piedade', 'Jaboatao dos Guararapes', 'PE', 4, '2026-01-13'),
(5, '53030000', 'Rua do Sol', 88, 'Centro', 'Olinda', 'PE', 5, '2026-01-14'),
(6, '53200000', 'Rua do Amparo', 12, 'Amparo', 'Olinda', 'PE', 6, '2026-01-15'),
(7, '54756000', 'Rua Dom Helder Camara', 900, 'Centro', 'Camaragibe', 'PE', 7, '2026-01-16'),
(8, '54759000', 'Rua Eliza Cabral de Souza', 33, 'Timbi', 'Camaragibe', 'PE', 8, '2026-01-17'),
(9, '54330000', 'Rua Barao de Souza Leao', 444, 'Boa Viagem', 'Recife', 'PE', 9, '2026-01-18'),
(10, '53300000', 'Avenida Presidente Kennedy', 55, 'Peixinhos', 'Olinda', 'PE', 10, '2026-01-19');

-- ===========================================
-- MOTORISTAS
-- ===========================================
-- Condutores responsáveis pelos veículos

INSERT INTO motorista (cod_motorista, nome, data_nascimento, telefone, data_cadastro) VALUES
(1, 'Joao Batista Pereira', '1975-04-20', '81912341234', '2026-01-01'),
(2, 'Marcos Antonio Rocha', '1982-08-15', '81923452345', '2026-01-01'),
(3, 'Ricardo Gomes Alves', '1970-12-01', '81934563456', '2026-01-01'),
(4, 'Sergio Luiz Mendes', '1988-06-10', '81945674567', '2026-01-02'),
(5, 'Antonio Carlos da Silva', '1965-01-25', '81956785678', '2026-01-02'),
(6, 'Luiz Fernando Ribeiro', '1990-03-12', '81967896789', '2026-01-02'),
(7, 'Claudio Roberto Santos', '1978-09-30', '81978907890', '2026-01-03'),
(8, 'Paulo Victor Oliveira', '1985-05-05', '81989018901', '2026-01-03'),
(9, 'Andre Luiz Fernandes', '1980-11-11', '81990129012', '2026-01-03'),
(10, 'Jose Mario Cavalcanti', '1973-07-07', '81901230123', '2026-01-03');

-- ===========================================
-- VEÍCULOS
-- ===========================================
-- Frota disponível para transporte

INSERT INTO veiculo (cod_veiculo, placa, modelo, vagas, cod_campus, data_cadastro) VALUES
(1, 'ABC1234', 'Mercedes-Benz Sprinter', 15, 1, '2026-01-01'),
(2, 'XYZ5678', 'Volare W9', 22, 1, '2026-01-03'),
(3, 'DBE9988', 'Renault Master', 12, 3, '2026-01-05'),
(4, 'KJA4455', 'Iveco Daily', 18, 2, '2026-01-07'),
(5, 'PLM2233', 'Volkswagen Ideale', 45, 2, '2026-01-09'),
(6, 'MNO1122', 'Mercedes-Benz Sprinter', 15, 1, '2026-01-11'),
(7, 'QWE3344', 'Ford Transit', 14, 2, '2026-01-13'),
(8, 'RTY5566', 'Volare V8', 20, 2, '2026-01-15'),
(9, 'UIO7788', 'Marcopolo Senior', 28, 3, '2026-01-17'),
(10, 'PAS9900', 'Mercedes-Benz Sprinter', 15, 3, '2026-01-19');

-- ===========================================
-- ITINERÁRIOS
-- ===========================================
-- Rotas dos veículos (ponto_partida -> ponto_chegada)

INSERT INTO itinerario (cod_itinerario, ponto_partida, ponto_chegada, data_cadastro) VALUES
(1, 'Casa Amarela', 'UNINASSAU Graças', '2026-01-01'),
(2, 'Ibura', 'UFPE Campus Recife', '2026-01-01'),
(3, 'Camaragibe Centro', 'UFRPE Dois Irmãos', '2026-01-01'),
(4, 'Olinda Centro', 'UNIBRA Boa Viagem', '2026-01-02'),
(5, 'Jaboatao Centro', 'IFPE Recife', '2026-01-02'),
(6, 'Boa Viagem', 'Faculdade Maurício de Nassau Derby', '2026-01-02'),
(7, 'Afogados', 'UNICAP', '2026-01-03'),
(8, 'Paulista Centro', 'UPE Campus Benfica', '2026-01-03'),
(9, 'Caxanga', 'UFPE Centro de Tecnologia', '2026-01-03'),
(10, 'Imbiribeira', 'Estacio Recife', '2026-01-03');

-- ===========================================
-- HORÁRIOS
-- ===========================================
-- Define os horários de saída e chegada dos veículos
-- Não permite horários duplicados (horario_partida + horario_chegada)

INSERT INTO horario (cod_horario, horario_partida, horario_chegada, data_cadastro) VALUES
(1, '06:00:00', '07:30:00', '2026-01-01'),
(2, '07:00:00', '08:30:00', '2026-01-01'),
(3, '12:00:00', '13:30:00', '2026-01-01'),
(4, '13:00:00', '14:30:00', '2026-01-01'),
(5, '17:30:00', '19:00:00', '2026-01-02'),
(6, '18:30:00', '20:00:00', '2026-01-02'),
(7, '22:00:00', '23:30:00', '2026-01-02'),
(8, '05:30:00', '06:45:00', '2026-01-03'),
(9, '11:15:00', '12:45:00', '2026-01-03'),
(10, '23:00:00', '00:15:00', '2026-01-03');

-- ===========================================
-- HISTÓRICO DE VEÍCULOS
-- ===========================================
-- Relaciona veículo + itinerário + horário
-- Representa uma "viagem configurada"

INSERT INTO historico_veiculo (cod_veiculo, cod_itinerario, cod_horario, data_cadastro) VALUES
(1, 1, 1, '2026-02-01'),
(2, 2, 2, '2026-02-02'),
(3, 3, 3, '2026-02-03'),
(4, 4, 4, '2026-02-04'),
(5, 5, 5, '2026-02-05'),
(6, 6, 6, '2026-02-06'),
(7, 7, 7, '2026-02-07'),
(8, 8, 8, '2026-02-08'),
(9, 9, 9, '2026-02-09'),
(10, 10, 10, '2026-02-10');

-- ===========================================
-- OCUPAÇÃO
-- ===========================================
-- Controla a quantidade de vagas disponíveis por viagem
-- Ligação entre veículo e motorista


INSERT INTO ocupacao (cod_ocupacao, vagas_reais, vagas_disponiveis, cod_historico_veiculo, cod_motorista, data_cadastro) VALUES
(1, 15, 8, 1, 1, '2026-01-10'),
(2, 22, 2, 2, 2, '2026-01-10'),
(3, 12, 3, 3, 3, '2026-01-10'),
(4, 18, 4, 4, 4, '2026-01-11'),
(5, 45, 5, 5, 5, '2026-01-11'),
(6, 15, 6, 6, 6, '2026-01-11'),
(7, 14, 7, 7, 7, '2026-01-12'),
(8, 20, 8, 8, 8, '2026-01-12'),
(9, 28, 9, 9, 9, '2026-01-12'),
(10, 15, 10, 10, 10, '2026-01-12');

-- ===========================================
-- AGENDAMENTOS
-- ===========================================
-- Reservas feitas pelos alunos (controla vagas)

INSERT INTO agendamento 
(cod_agendamento, data_reserva, hora_reserva, chamada_ida, chamada_volta, cod_ocupacao, cod_aluno, cod_usuario_sistema, data_cadastro, status) 
VALUES
-- =========================
-- DADOS RECENTES (NÃO APAGA)
-- =========================
(1, '2026-04-01', '10:00:00', NULL, NULL, 1, 1, NULL, '2026-03-28', 1),
(2, '2026-04-01', '10:05:00', NULL, NULL, 1, 2, NULL, '2026-03-28', 1),
(3, '2026-04-01', '10:10:00', NULL, NULL, 1, 3, 2, '2026-03-29', 1),
(4, '2026-04-01', '10:15:00', NULL, NULL, 1, 4, 1, '2026-03-29', 1),
(5, '2026-04-01', '10:20:00', NULL, NULL, 1, 5, 2, '2026-03-30', 1),

-- =========================
-- ANTIGOS MAS ATIVOS (NÃO APAGA)
-- =========================
(6, '2025-01-01', '08:00:00', NULL, NULL, 6, 6, 2, '2025-01-01', 1),

-- =========================
-- ANTIGOS E CANCELADOS (DEVE APAGAR)
-- =========================
(7, '2024-01-01', '10:00:00', NULL, NULL, 1, 1, NULL, '2024-01-01', 0),
(8, '2024-01-01', '08:30:00', NULL, NULL, 7, 7, 3, '2024-01-01', 0),
(9, '2024-02-01', '09:00:00', NULL, NULL, 8, 8, 3, '2024-02-01', 0),
(10, '2024-03-01', '09:15:00', NULL, NULL, 9, 9, 4, '2024-03-01', 0),
(11, '2024-04-01', '09:45:00', NULL, NULL, 10, 10, 4, '2024-04-01', 0);




