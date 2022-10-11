use mongo_g9
// Coleccion de Artistas
db.artists.drop()

db.artists.insertOne(
{
  "_id" : 1,
  "frist_name" : "Nai",
  "last_name" : "Nai",
  "brith_date" : ISODate("1997-11-11"),
  "gender" : "mujer",
  "website" : "www.nainai.com.ar"
}
)
db.artists.insertMany([
  {
    "_id" : 2,
    "frist_name" : "Hilario",
    "last_name" : "Mendez",
    "brith_date" : ISODate("1995-11-23"),
    "gender" : "hombre",
    "website" : "www.hilas.com.ar"
  },
  {
    "_id" : 3,
    "frist_name" : "Histeria",
    "last_name" : "Andante",
    "brith_date" : ISODate("2011-11-11"),
    "gender" : "mujer",
    "website" : "www.la-histeria.com.ar"
  },
  {
    "_id" : 4,
    "frist_name" : "Fede",
    "last_name" : "Fede",
    "brith_date" : ISODate("1997-01-31"),
    "gender" : "hombrer",
    "website" : "www.fede.com.ar"
  },
  {
    "_id" : 5,
    "frist_name" : "Lucas",
    "last_name" : "Licas",
    "brith_date" : ISODate("1996-07-12"),
    "gender" : "hombre",
    "website" : "www.lucas.com.ar"
  },
  {
    "_id" : 6,
    "frist_name" : "Lai",
    "last_name" : "Lai",
    "brith_date" : ISODate("1997-11-11"),
    "gender" : "mujer",
    "website" : "www.Lai.com.ar"
  }
])