create table medalha (
id serial,
nome varchar(255) not null,
descricao varchar(255) not null,
req_nivel int not null,
imagem text,
primary key(id));

create table medalha_usuario(
user_id int not null,
medalha_id int not null,
foreign key(user_id) references usuario(id),
foreign key(medalha_id) references medalha(id),
primary key(user_id,medalha_id));

CREATE OR REPLACE FUNCTION public.registra_medalha()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $function$
declare 
	medalha_id record;
BEGIN
    FOR medalha_id IN
        SELECT m.id
        FROM medalha m
        WHERE m.req_nivel <= NEW.nivel
          AND NOT EXISTS (
              SELECT 1
              FROM medalha_usuario mu
              WHERE mu.medalha_id = m.id
                AND mu.user_id = NEW.id
          )
    LOOP
        INSERT INTO medalha_usuario (user_id, medalha_id)
        VALUES (NEW.id, medalha_id.id);
    END LOOP;

    RETURN NEW;
END;
$function$;

CREATE TRIGGER reg_medalha
AFTER UPDATE ON public.usuario
FOR EACH ROW
WHEN (NEW.nivel > OLD.nivel)
EXECUTE FUNCTION registra_medalha();