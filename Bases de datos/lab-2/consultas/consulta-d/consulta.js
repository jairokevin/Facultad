// Listar los reviews hechos por un cliente X dentro de un rango de fechas.

db.reviews.find(
  { $and : [ {"client": 1},
    {"review_date" : {"$gte" : ISODate("2018-01-18") , "$lte" : ISODate("2018-10-02")}}
  ]
  },
  { "_id" : 0,
  "type": 1,
  "title": 1,
  "description" : 1,
  "rating" : 1,
  "review_date" :1}
).pretty()