
// Coleccion de clientes

db.clients.insertOne(
{
  "_id" : 1,
  "frist_name" : "Chingon",
  "last_name" : "Gonzales",
  "brith_date" : "01/09/1993",
  "email" : "chingon@mailmail.com",
  "phone" : "354232323",
  "username" : "chingonconzales",
  "password": "123456",
  "subscripcion_date" : "04/06/2018",
  "subscripcions" : "basico",
  "gender" : "trans"

}
)

db.clients.insertMany([
  {
    "_id" : 2,
    "frist_name" : "Daiana",
    "last_name" : "Coria",
    "brith_date" : "28/09/1993",
    "email" : "daidai@mailmail.com",
    "phone" : "32342323",
    "username" : "daianacoria",
    "password": "123456",
    "subscripcion_date" : "14/06/2018",
    "subscripcions" : "premium",
    "gender" : "mujer"
  },
  {
    "_id" : 3,
    "frist_name" : "Naira",
    "last_name" : "Garibay",
    "brith_date" : "13/10/1993",
    "email" : "naironman@mailmail.com",
    "phone" : "98776323",
    "username" : "naironman",
    "password": "123456",
    "subscripcion_date" : "11/07/2018",
    "subscripcions" : "premium",
    "gender" : "mujer"
  },
  {
    "_id" : 4,
    "frist_name" : "Maris",
    "last_name" : "Maris",
    "brith_date" : "03/05/1993",
    "email" : "marisi@mailmail.com",
    "phone" : "7832123",
    "username" : "marisMaris",
    "password": "123456",
    "subscripcion_date" : "11/12/2018",
    "subscripcions" : "premium",
    "gender" : "hombre"
  }
])