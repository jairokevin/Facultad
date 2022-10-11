// Listar los episodios correspondientes a un programa de televisión X y un
// número de temporada N. Listar ordenados por fecha de lanzamiento.

// quiero ver los episodios del programa de tv con id 1
db.episodes.find(
{  $and: [ {"tvshow" : 1}, {"season" : 1}]
},
{ "_id" : 0,
"title" : 1,
"description" : 1,
"relase_date" : 1,
"season" : 1
}
).sort({"relase_date" : 1}).pretty()

// sort({"relase_date" : 1}) ordenar por fecha asc 
// -1 seria de modo desc