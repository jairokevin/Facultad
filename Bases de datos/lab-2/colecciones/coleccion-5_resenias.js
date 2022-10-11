use mongo_g9
// Coleccionn de resenias
db.reviews.drop()
db.reviews.insertMany([
{
  "_id" : 1,
  "type": "tvshow",
  "client": 1,
  "title": "Holandas",
  "content_id" : 1,
  "description" : "La vida es una description",
  "rating" : 4,
  "review_date" : ISODate("2018-10-01")
},
{
  "_id" : 2,
  "type": "tvshow",
  "client" : 1,
  "title" : "mirando esto",
  "content_id" : 1,
  "description" : "Bueno pero falla en los efectos especiales",
  "rating" : 4,
  "review_date" : ISODate("2018-10-01")
},
{
  "_id" : 3,
  "type": "tvshow",
  "client" : 1,
  "title" : "holis",
  "content_id" : 2,
  "description" : "Me encanto",
  "rating" : 5,
  "review_date" : ISODate("2018-10-12")
},
{
  "_id" : 4,
  "type": "movie",
  "client": 1,
  "title": "Buena",
  "content_id" : 3,
  "description": "Un poco exagerada la actuacion de algunos",
  "rating": 3,
  "review_date": ISODate("2018-10-06")
},
{
  "_id" : 5,
  "type": "movie",
  "client": 1,
  "title": "Buena",
  "content_id" : 3,
  "description": "Un poco exagerada la actuacion de algunos",
  "rating": 2,
  "review_date": ISODate("2018-10-06")
},
{
  "_id" : 6,
  "type": "movie",
  "client": 1,
  "title": "Buena",
  "content_id" : 3,
  "description": "Un poco exagerada la actuacion de algunos",
  "rating": 3,
  "review_date": ISODate("2018-10-06")
},
{
  "_id" : 7,
  "type": "movie",
  "client": 1,
  "title": "Buena",
  "content_id" : 3,
  "description": "Un poco exagerada la actuacion de algunos",
  "rating": 5,
  "review_date": ISODate("2018-10-06")
}
])
