use mongo_g9
// Coleccion de clientes
db.clients.drop()

db.clients.insertOne(
{
  "_id" : 1,
  "frist_name" : "Chingon",
  "last_name" : "Gonzales",
  "brith_date" : ISODate("1993-02-23"),
  "email" : "chingon@mailmail.com",
  "phone" : "354232323",
  "username" : "chingonconzales",
  "password": "123456",
  "subscripcion_date" : ISODate("2018-06-04"),
  "subscripcions" : "basico",
  "gender" : "trans"
}
)

db.clients.insertMany([
  {
    "_id" : 2,
    "frist_name" : "Daiana",
    "last_name" : "Coria",
    "brith_date" : ISODate("1993-09-28"),
    "email" : "daidai@mailmail.com",
    "phone" : "32342323",
    "username" : "daianacoria",
    "password": "123456",
    "subscripcion_date" : ISODate("2018-06-16"),
    "subscripcions" : "premium",
    "gender" : "mujer"
  },
  {
    "_id" : 3,
    "frist_name" : "Naira",
    "last_name" : "Garibay",
    "brith_date" : ISODate("1993-10-13"),
    "email" : "naironman@mailmail.com",
    "phone" : "98776323",
    "username" : "naironman",
    "password": "123456",
    "subscripcion_date" : ISODate("2018-07-11"),
    "subscripcions" : "premium",
    "gender" : "mujer"
  },
  {
    "_id" : 4,
    "frist_name" : "Maris",
    "last_name" : "Maris",
    "brith_date" : ISODate("1993-05-03"),
    "email" : "marisi@mailmail.com",
    "phone" : "7832123",
    "username" : "marisMaris",
    "password": "123456",
    "subscripcion_date" : ISODate("2018-12-11"),
    "subscripcions" : "premium",
    "gender" : "hombre"
  }
])