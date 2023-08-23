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
