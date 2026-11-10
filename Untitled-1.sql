CREATE DATABASE Banco_AcademiaIsaLuque;

USE Banco_AcademiaIsaLuque; -- Selecionar banco de daodos Banco_Academia

--Comando para listar o banco de dados atual
Select name AS NomeDoBanco
from sys.databases
Order BY name;

--Comando para listar o banco de dados atual
Select DB_NAME() AS BancoAtual;

--Criando tabelas professores
Create table Professores (
    IdProfessor Int Primary key IDENTITY(1,1), -- auto incrementar o id professor
    Nome Varchar(100) not null,
    Email Varchar(100) not null unique, -- unique para nao permitir email duplicados
    Especialidade VARCHAR(100) NOT NULL,
);


CREATE TABLE Cursos (
    IdCurso INT PRIMARY KEY IDENTITY(1,1),
    NomeCurso VARCHAR(100) NOT NULL UNIQUE,
    CargaHoraria INT NOT NULL CHECK (CargaHoraria > 0 AND CargaHoraria <= 200),
    IdProfessor INT NOT NULL,
    Ativo BIT NOT NULL DEFAULT 1,

    CONSTRAINT FK_Cursos_Professores
    FOREIGN KEY (IdProfessor)
    REFERENCES Professores(IdProfessor)
);


Create Table Alunos (
    IdAluno int PRIMARY key IDENTITY(1,1),
    Nome VARCHAR(100) NOT NULL,
    Email varchar (100) not null unique,
    turma varchar(50) not null,
    DataNascimento Date not null,
    Ativo Bit not null Constraint DF_Alunos_Ativo Default 1,
);

Select * from Professores;
Select * from Cursos;
Select * from Alunos;


--visualizar todas as tabelas do banco de dados Banco-Academia
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;


CREATE TABLE Matriculas(
    IdMatricula INT PRIMARY KEY IDENTITY(1,1),
    IdAluno INT NOT NULL,
    IdCurso INT NOT NULL,
    DataMatricula DATE NOT NULL CONSTRAINT DF_Matriculas_Data DEFAULT (CONVERT(DATE, GETDATE())),
    NotaFinal DECIMAL(4,2) NULL CHECK (NotaFinal BETWEEN 0 AND 10),
    StatusMatricula VARCHAR(20) NOT NULL CONSTRAINT DF_Matriculas_Status DEFAULT 'Ativa',

    CONSTRAINT UQ_Matriculas_AlunoCurso UNIQUE (IdAluno, IdCurso),
    CONSTRAINT FK_Matriculas_Alunos
        FOREIGN KEY (IdAluno) REFERENCES Alunos(IdAluno),
    CONSTRAINT FK_Matriculas_Cursos
        FOREIGN KEY (IdCurso) REFERENCES Cursos(IdCurso)    
);
select name AS tabelas
FROM sys.tables
ORDER BY NAME;

INSERT INTO Professores (Nome, Email, Especialidade)
VALUES
('Ana Martins',     'ana.martins@academia.com',    'Banco de Dados'),
('Carlos Ribeiro',  'carlos.ribeiro@academia.com', 'Programação'),
('Fernanda Lima',   'fernanda.lima@academia.com',  'Desenvolvimento Web'),
('Rafael Souza',    'rafael.souza@academia.com',   'Redes de Computadores');

INSERT INTO Cursos (NomeCurso, CargaHoraria, IdProfessor)
VALUES
('Banco de Dados Inicial', 40, 1),
('SQL Server Essencial',   36, 1),
('Lógica de Programação',  40, 2),
('JavaScript para Jovens', 32, 2),
('HTML e CSS',             30, 3),
('Fundamentos de Redes',   24, 4);

INSERT INTO Alunos (Nome, Email, Turma, DataNascimento)
VALUES
('Alice Pereira',   'alice.pereira@escola.com',   '2INFO-A', '2008-03-14'),
('Bruno Alves',     'bruno.alves@escola.com',     '2INFO-A', '2008-07-22'),
('Camila Rocha',    'camila.rocha@escola.com',    '2INFO-A', '2008-01-30'),
('Diego Santos',    'diego.santos@escola.com',    '2INFO-B', '2007-11-09'),
('Elisa Nunes',     'elisa.nunes@escola.com',     '2INFO-B', '2008-05-18'),
('Felipe Costa',    'felipe.costa@escola.com',    '2INFO-B', '2008-09-02'),
('Gabriela Melo',   'gabriela.melo@escola.com',   '2INFO-C', '2007-12-12'),
('Henrique Luz',    'henrique.luz@escola.com',    '2INFO-C', '2008-06-28'),
('Isabela Torres',  'isabela.torres@escola.com',  '2INFO-C', '2008-02-06'),
('João Mendes',     'joao.mendes@escola.com',     '2INFO-C', '2007-08-25');

INSERT INTO Matriculas (IdAluno, IdCurso, DataMatricula, NotaFinal, StatusMatricula)
VALUES
    (1, 1, '2026-02-03', 8.50, 'Concluída'),
    (1, 5, '2026-02-03', 9.00, 'Concluída'),
    (2, 1, '2026-02-03', 7.00, 'Concluída'),
    (2, 3, '2026-02-04', 8.00, 'Ativa'),
    (3, 2, '2026-02-04', 9.50, 'Concluída'),
    (3, 4, '2026-02-04', NULL, 'Ativa'),
    (4, 3, '2026-02-05', 6.50, 'Concluída'),
    (5, 5, '2026-02-05', 8.50, 'Concluída'),
    (6, 6, '2026-02-06', NULL, 'Ativa'),
    (7, 1, '2026-02-06', 7.50, 'Concluída'),
    (8, 2, '2026-02-07', 10.00, 'Concluída'),
    (8, 6, '2026-02-07', 8.00, 'Concluída'),
    (9, 4, '2026-02-08', NULL, 'Ativa'),
    (9, 5, '2026-02-08', 9.00, 'Concluída'),
    (10, 3, '2026-02-09', 7.00, 'Concluída'),
    (10, 2, '2026-02-09', NULL, 'Ativa');

    -- CONSULTA POR ORDEM ALFABETICA
Select nome, Turma
From Alunos
Order by Nome ASC; --asc para ordem crescente e desc para decrescente

--OS ULTIMOS 5 REGISTROS DE ALUNOS CADASTRADOS
Select TOP 5 Nome, Turma, DataNascimento
From Alunos
Order by Nome;

SELECT * FROM Alunos;

-- Filtros com where
--Where filtra as linhas , leia a consulta como uma frase: "selecione os nomes e turmas dos alunos onde a turma seja igual 2info-a"

--Igual A
Select Nome, Turma
From Alunos
Where Turma = '2INFO-A';

--Diferente de
Select Nome, Turma
From Alunos
Where Turma <> '2INFO-A';

--AND = AS DUAS CONDICOES DEVEM SER VERDADEIRAS PARA QUE O REGISTRO SEJA RETORNADO NA CONSULTA
Select Nome, Turma, DataNascimento
FROM Alunos
Where Turma = '2INFO-A' AND DataNascimento > '2008-01-01'; -- ou seja selecione os nomes, turmas e datas de nascimento dos alunos onde a turma seja igual a '2INFO-A e 
-- data de nascimento seja maior que 2008-01-01

--Or Pelo Menos uma condição deve ser verdadeira
Select Nome, Turma
From Alunos
Where Turma = '2INFO-A' OR DataNascimento > '2008-01-01'-- Ou seja, selecione os nomes e turmas dos alunos onde a turma seja igual a 2INFO-A  ou a data de nascimento
-- seja maior que 2008-01-01

-- In : Versao mais curta para varios valores
Select Nome, Turma
From Alunos
Where Turma In ('2INFO-A', '2INFO-B'); -- OU SEJA SELECIONE OS NOMES E TURMAS DOS ALUNOS ONDE A TURMA SEJA IGUAL A 2INFO-A OU 2INFO-B

--LIKE: % SIGINFICA QUALQUER QUANTIDADE DE CARACTERES E SIGINFICA QULQUER CARACTERE
Select Nome, Email
From Alunos 
WHere Email like '%es' -- ou esja ,selecione os nomes e emails dos alunos onde o email termina com 'escola.com'