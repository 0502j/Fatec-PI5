CREATE TABLE evento (
	id serial NOT NULL,
	titulo varchar(30) NOT NULL,
	descricao varchar(255) NOT NULL,
	local varchar(255) NOT NULL,
	data date NOT NULL,
	hora time NOT NULL,
	tipo varchar(100) NOT NULL,
	id_organizador integer NOT NULL,
	CONSTRAINT evento_pkey PRIMARY KEY (id),
	CONSTRAINT evento_organizador_id_fkey FOREIGN KEY (id_organizador) REFERENCES usuario(id) ON DELETE CASCADE
);