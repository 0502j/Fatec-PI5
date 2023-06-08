create table if not exists evento_participante(
	evento_id int,
	participante_id int,
	foreign key(evento_id) references evento(id),
	foreign key(participante_id) references usuario(id),
	primary key(evento_id,participante_id)
);
