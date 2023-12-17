CREATE OR REPLACE FUNCTION public.aumenta_nivel_usuario()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
 begin
	 if new.status = 'CONCLUIDO' then 
	 	update usuario set nivel = nivel+1 where id in (select participante_id from evento_participante where evento_id = new.id);
	 end if;
	return new;
end;
$function$
;

create trigger atualiza_nivel before
update
    on
    public.evento for each row
    when (((new.status)::text = 'CONCLUIDO'::text)) execute function aumenta_nivel_usuario();
