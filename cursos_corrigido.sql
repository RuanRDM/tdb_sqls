-- educacional

create table cursos (
codigo integer not null,
descricao varchar (100) not null,
primary key (codigo));

create table prerequisitos(
curso integer not null,
prerequisito integer not null,
primary key (curso, prerequisito),
foreign key (curso) references cursos (codigo),
foreign key (prerequisito) references cursos (codigo));

create table locais (
codigo integer not null,
descricao varchar (100) not null,
capacidade integer not null,
primary key (codigo),
check (codigo>0 and capacidade>0));

create table professores (
codigo integer not null,
nome varchar (100) not null,
primary key (codigo),
check(codigo>0));

create table cursos_oferecidos(
codigo bigint not null,
inicio date not null,
termino date not null,
vagas integer not null,
curso integer not null,
professor integer not null,
local integer not null,
primary key (codigo),
foreign key (curso) references cursos (codigo),
foreign key (professor) references professores (codigo),
foreign key (local) references locais (codigo),
check (codigo>0));

create table alunos (
codigo integer not null,
nome varchar (100) not null,
primary key (codigo),
check(codigo>0));

create table bolsas (
codigo integer not null,
descricao varchar (100) not null,
tipo char(1) not null,
valor numeric(10,2) not null default 0,
primary key (codigo),
check(codigo>0),
check (tipo='T' or tipo='P'));

create table matriculas(
codigo bigint not null,
curso_oferecido bigint not null,
aluno integer not null,
bolsa integer,
primary key (codigo),
foreign key (curso_oferecido) references cursos_oferecidos (codigo),
foreign key (aluno) references alunos (codigo),
foreign key (bolsa) references bolsas (codigo),
check(codigo>0));