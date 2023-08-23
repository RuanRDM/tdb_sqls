CREATE TABLE cursos (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255)
);

CREATE TABLE requisitos (
    CursoID INT,
    RequisitoID INT,
    PRIMARY KEY (CursoID, RequisitoID),
    FOREIGN KEY (CursoID) REFERENCES cursos(ID),
    FOREIGN KEY (RequisitoID) REFERENCES cursos(ID)
);

CREATE TABLE professores (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255)
);

CREATE TABLE locais (
    ID INT PRIMARY KEY,
    Capacidade INT
);

CREATE TABLE alunos (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255)
);

CREATE TABLE bolsas (
    ID INT PRIMARY KEY,
    Tipo VARCHAR(255),
    Valor DECIMAL(10, 2)
);

CREATE TABLE cursos_ofertados (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255),
    DataInicio DATE,
    DataTermino DATE,
    Vagas INT,
    ProfessorID INT,
    LocalID INT,
    CursoID INT,
    FOREIGN KEY (ProfessorID) REFERENCES professores(ID),
    FOREIGN KEY (LocalID) REFERENCES locais(ID),
    FOREIGN KEY (CursoID) REFERENCES cursos(ID)
);


CREATE TABLE matriculas (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255),
    AlunosID INT,
    BolsaID INT,
    CursoOfertadoID INT,
    FOREIGN KEY (AlunosID) REFERENCES alunos(ID),
    FOREIGN KEY (BolsaID) REFERENCES bolsas(ID),
    FOREIGN KEY (CursoOfertadoID) REFERENCES cursos_ofertados(ID)
);




-- Inserir o curso Ciência da Computação
INSERT INTO cursos (codigo, descricao) VALUES (1, 'Álgebra');

-- Inserir o curso Calculo I
INSERT INTO cursos (codigo, descricao) VALUES (2, 'Cálculo I');

-- Inserir o curso Calculo I
INSERT INTO cursos (codigo, descricao) VALUES (3, 'Cálculo II');

-- Inserir o pré-requisito Cálculo I para o curso Álgebra
INSERT INTO prerequisitos (curso, prerequisito) VALUES (1, 2);

-- Inserir o pré-requisito Cálculo II para o curso Álgebra
INSERT INTO prerequisitos (curso, prerequisito) VALUES (1, 3);

-- Inserir o pré-requisito Cálculo I para o curso Cálculo I
INSERT INTO prerequisitos (curso, prerequisito) VALUES (3, 2);

-- Retornar pré-requisitos
select cursos.descricao as curso, requisitos.descricao as prerequisito
from cursos, prerequisitos, cursos requisitos
where cursos.codigo=prerequisitos.curso and requisitos.codigo=prerequisitos.prerequisito