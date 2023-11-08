create table paises(
	codigo integer not null,
	descricao text not null,
	primary key(codigo));

create table estados(
	codigo integer not null,
	descricao text not null,
	pais integer not null,
	primary key (codigo),
	foreign key (pais) references paises (codigo));

create table cidades(
	codigo integer not null,
	descricao text not null,
	estado integer not null,
	primary key (codigo),
	foreign key (estado) references estados (codigo));

create table organizacoes(
	codigo integer not null,
	descricao text not null,
	primary key (codigo));

create table estacoes(
	codigo integer not null,
	descricao text not null,
	latitude double precision not null,
	longitude double precision not null,
	cidade integer not null,
	organizacao integer not null,
	primary key (codigo),
	foreign key (cidade) references cidades (codigo),
	foreign key (organizacao) references organizacoes (codigo));

create table variaveis(
codigo integer not null,
descricao text not null,
tipo_dados integer not null,
primary key(codigo));

create table dados(
	codigo bigint not null,
	data date not null,
	hora time not null,
	estacao integer not null,
	variavel integer not null,
	valor text not null,
	primary key (codigo),
	foreign key (estacao) references estacoes (codigo),
	foreign key (variavel) references variaveis (codigo));
	
-- POPULANDO AS TABELAS
insert into paises values (1,'Brasil');
insert into estados values (1,'RS',1);
insert into cidades values (1,'Passo Fundo',1),(2,'Marau',1);
insert into organizacoes values (1,'INPE'),(2,'EMBRAPA');
insert into estacoes values (1,'A0067',-58.7908,-28.6759,1,1),
								(2,'A0089',-60.7896,-29.7894,2,2);
insert into variaveis values (1,'Temperatura',1),(2,'Chuva',1),(3,'Direcao Vento',2),
								(4,'Umidade',3),(5,'Pressao',3);

insert into dados values 
(1,'2021-12-02','01:00:00',1,1,25),
(2,'2021-12-02','01:00:00',1,2,0),
(3,'2021-12-02','01:00:00',1,3,'Norte'),
(4,'2021-12-02','01:00:00',1,4,70),
(5,'2021-12-02','01:00:00',1,5,40),
(6,'2021-12-02','02:00:00',1,1,26),
(7,'2021-12-02','02:00:00',1,2,0),
(8,'2021-12-02','02:00:00',1,3,'Norte'),
(9,'2021-12-02','02:00:00',1,4,65),
(10,'2021-12-02','02:00:00',1,5,45);

-- CONSULTA COM OS DADOS

select e.descricao as estacao, d.data,d.hora, c.descricao as municipio, es.descricao as estado,
		p.descricao as pais, latitude, longitude, o.descricao as organizacao,
		 v.descricao as DesVariavel, d.valor
from estacoes e, dados d, cidades c, estados es, paises p, organizacoes o, variaveis v
where p.codigo = es.pais and
	  es.codigo = c.estado and
	  e.cidade = c.codigo and
	  e.organizacao = o.codigo and
	  d.estacao = e.codigo and
	  d.variavel=v.codigo
order by data,hora,variavel;


(49,'2012-01-01',15.05,24.6,0),
(49,'2012-01-02',15.65,24.9,0),
(49,'2012-01-03',13.8,27.75,0),
(49,'2012-01-04',16.5,28.05,0),
(49,'2012-01-05',15.7,29.05,0),
(49,'2012-01-06',17.85,30,0.8),
(49,'2012-01-07',17.25,28.75,0),
(49,'2012-01-08',19.15,30.25,0),
(49,'2012-01-09',18.5,29.25,0),
(49,'2012-01-10',17,29.8,0),
(49,'2012-01-11',18.05,29.3,1.6),
(49,'2012-01-12',18.05,29.25,0),
(49,'2012-01-13',18.95,21.35,35),
(49,'2012-01-14',17.5,22.1,25.4),
(49,'2012-01-15',14.4,25.05,2.2),
(49,'2012-01-16',16.2,27.45,0),
(49,'2012-01-17',17.6,29.25,0),
(49,'2012-01-18',17.55,27.5,0),
(49,'2012-01-19',16.35,28.6,0),
(49,'2012-01-20',18.8,28.3,1.6),
(49,'2012-01-21',17.7,26.75,1.2),
(49,'2012-01-22',17.75,28.4,0),
(49,'2012-01-23',19.4,28.6,0.8),
(49,'2012-01-24',19.8,28.35,8.8),
(49,'2012-01-25',19.5,25,1.6),
(49,'2012-01-26',15.15,23.7,0),
(49,'2012-01-27',14.6,25.1,0),
(49,'2012-01-28',14.5,26.2,0),
(49,'2012-01-29',15.65,27.9,1.2),
(49,'2012-01-30',16.8,29.65,0),
(49,'2012-01-31',18.7,31.1,0),
(213,'2012-01-01',28.55,26.270773,0),
(213,'2012-01-02',29.85,29.830955,0),
(213,'2012-01-03',32.8,31.965634,0),
(213,'2012-01-04',30.5,30.941824,0),
(213,'2012-01-05',31.65,31.306049,0),
(213,'2012-01-06',33.7,27.111455,0),
(213,'2012-01-07',32.9,32.407917,0),
(213,'2012-01-08',34.1,23.578913,0),
(213,'2012-01-09',34.2,26.965766,0.4),
(213,'2012-01-10',33.4,28.050347,0),
(213,'2012-01-11',34.6,26.603263,0),
(213,'2012-01-12',32.05,20.401432,0.2),
(213,'2012-01-13',24.3,9.507912,1.8),
(213,'2012-01-14',25.55,16.589866,0),
(213,'2012-01-15',28.8,25.372107,0),
(213,'2012-01-16',32.35,29.155547,0),
(213,'2012-01-17',34.4,32.014099,0),
(213,'2012-01-18',33.3,27.764021,0),
(213,'2012-01-19',34.15,23.427851,0),
(213,'2012-01-20',33.35,18.742081,0.6),
(213,'2012-01-21',32,17.964403,3.2),
(213,'2012-01-22',30.8,16.992877,25),
(213,'2012-01-23',33.15,29.283236,0.2),
(213,'2012-01-24',30.15,17.203915,15.8),
(213,'2012-01-25',29.3,27.971243,0.2),
(213,'2012-01-26',26.45,30.425879,0),
(213,'2012-01-27',27.7,28.677777,0),
(213,'2012-01-28',29.6,22.712165,0),
(213,'2012-01-29',32.3,26.953513,0),
(213,'2012-01-30',32.85,25.111141,0),
(213,'2012-01-31',33.95,23.956798,0);