create table if not exists usuario(
    id serial primary key,
    nome varchar(255) not null,
    idade int not null,
    sexo char(1) not null check(sexo in ('M','F','O')),
    email varchar(255) not null unique,
    senha varchar(255) not null
)