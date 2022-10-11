// Dada una película X, calcular para cada estrella el porcentaje de
// calificaciones recibidas en sus reviews.

// para la pelicula con id 3
// primero consulto cuantos vostos de hicieron para ese contenido
votos_totales = db.reviews.find(
	{content_id : 3}
).count();

// Consulto los votos y calculo el porsentaje
db.reviews.aggregate([ 
  {
    $match : { content_id : 3}
  },
  { 
    $group: {
      _id : "$rating",
      "estrella" : {$sum: 1}
    }
  },
  {
    $project : {
      "_id" : 1,
      "Porcentaje" :{ 
        $concat: [
          { $substr: [ { $divide: [ {$multiply: ["$estrella" , 100]}, votos_totales ] }, 0, 4 ] }
           , "%"
        ] 
      } 
    }
  }
]).pretty()

// se uso 
// { $substr: [ <string>, <start>, <length> ] }
// { $concat: [ <expression1>, <expression2>, ... ] }
// { $divide: [ <expression1>, <expression2> ] }
// { $multiply: [ <expression1>, <expression2>, ... ] }