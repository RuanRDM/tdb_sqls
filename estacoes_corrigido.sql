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
	estado integer not null references estados,
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

create table dados(
	codigo bigint not null,
	data date not null,
	hora time not null,
	estacao integer not null,
	temperatura double precision not null,
	chuva double precision not null,
	dirVento text not null,
	umidade integer not null,
	pressao integer not null,
	primary key (codigo),
	foreign key (estacao) references estacoes (codigo));
	
-- POPULANDO AS TABELAS
insert into paises values (1,'Brasil');
insert into estados values (1,'RS',1);
insert into cidades values (1,'Passo Fundo',1),(2,'Marau',1);
insert into organizacoes values (1,'INPE'),(2,'EMBRAPA');
insert into estacoes values (1,'A0067',-58.7908,-28.6759,1,1),
								(2,'A0089',-60.7896,-29.7894,2,2);
insert into dados values 
(1,'2021-12-02','01:00:00',1,25,0,'Norte',70,40),
(2,'2021-12-02','02:00:00',1,26,0,'Norte',65,45),
(3,'2021-12-02','03:00:00',1,26,0,'Sul',70,50),
(4,'2021-12-02','04:00:00',1,27,0,'Norte',60,60);


insert into dados values 
(5,'2021-12-02','01:00:00',2,25.9,0,'Norte',70,40),
(6,'2021-12-02','02:00:00',2,26.1,0,'Norte',65,45),
(7,'2021-12-02','03:00:00',2,26.1,0,'Sul',70,50),
(8,'2021-12-02','04:00:00',2,27.5,0,'Norte',60,60);

-- CONSULTA COM OS DADOS

select e.descricao as estacao, d.data, c.descricao as municipio, es.descricao as estado,
		p.descricao as pais, latitude, longitude, o.descricao as organizacao,
		d.hora, d.temperatura, d.chuva, d.dirvento, d.umidade, d.pressao
from estacoes e, dados d, cidades c, estados es, paises p, organizacoes o
where p.codigo = es.pais and
	  es.codigo = c.estado and
	  e.cidade = c.codigo and
	  e.organizacao = o.codigo and
	  d.estacao = e.codigo;