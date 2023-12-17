create table cupom(
    id serial,
    titulo varchar(255) not null,
    descricao varchar(255) not null,
    validade date not null,
    primary key(id)
);

alter table evento add column cupom_id integer;