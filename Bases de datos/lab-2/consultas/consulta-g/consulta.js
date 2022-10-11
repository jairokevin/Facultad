// Dada una película X, calcular su “calificación promedio”.

// Usando la pelicula con id 3
// primero consulto cuantos vostos de hicieron para ese contenido
// Usando la regla de promedio de estrellas como en el lab 1
votos_totales = db.reviews.find(
	{content_id : 3}
).count();

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
        "Promedio" :{ 
            $divide: [ {$multiply: ["$estrella" , "$_id"]}, votos_totales ] 
        } 
      }
    }
  ]).pretty()

  // Promedio total
db.reviews.aggregate(
    {
        $match : {"type" : "movie"}
    },
    { 
        $group: {
          _id : "_id",
          "Promedio_total" : { $avg: "$rating" }
        }
    },
    {
        $project : {
          _id : 0,
          "Promedio_total" : 1
        }
    }
  )