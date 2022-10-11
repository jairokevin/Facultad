-- ---------------------------------------------------------------------
-- CONSULTA:Listar los actores que hayan actuado en todos los programas
-- de televisión en donde actuó un actor X.
-- ---------------------------------------------------------------------

select concat(e1.nombre, ' ' , e1.apellido) "actor",ep_es1.programa_tv "En_programa"
from contenido c1, episodios ep1, participantes_en pen1, elenco e1,
     episodio_es_de ep_es1, (select ep_es.programa_tv "programas"
                             from contenido c, episodios ep,
                                  participantes_en pen, elenco e,
                                  episodio_es_de ep_es
                             where c.id_contenido = ep.episodios_id
                               and c.id_contenido = pen.contenido
                               and pen.id_elenco = e.id_elenco
                               and ep_es.episodio = ep.episodios_id
                               and e.nombre = "Mercedes" and e.apellido = "Ven") atv
where c1.id_contenido = ep1.episodios_id
  and c1.id_contenido = pen1.contenido
  and pen1.id_elenco = e1.id_elenco
  and ep_es1.episodio = ep1.episodios_id
  and pen1.rol != "derector"
  and atv.programas = ep_es1.programa_tv
group by actor, En_programa
;
