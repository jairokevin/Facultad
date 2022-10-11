use mongo_g9
// Coleccion de contenidos
db.content.drop()
db.content.insertMany([
{
  "_id" : 2,
  "type": "Movie",
  "title": "Halloween",
  "description": "Trata en la noche de halloween en que Michael Myers es un asesino serial",
  "duration": 90,
  "release_date": ISODate("1978-02-03"),
  "gender": ["Terror", "Suspenso"],
  "subtitles": ["Español", "Frances", "Italiano"],
  "artist": [ 
    {"artis_id" :1, "first_name" : "Nai", "rol" : "principal"},
    {"artis_id" :6, "first_name" : "Lai", "rol" : "director"},
    {"artis_id" :3, "first_name" : "Histeria", "rol" : "director"}],
  "produces" : "Nada-Records"
},
{
  "_id" : 1,
  "type": "tvshow",
  "title": "Holandas",
  "description" : "La vida es una description",
  "gender" : ["accion", "ficcion"],
  "episodes" : [
    { "episodes_id" : 1, "title" : "Saludos a todos"},
    { "episodes_id" : 2, "title" : "Chau a todos"} ]
},
{
  "_id" : 3,
  "type": "Movie",
  "title": "Navidad",
  "description": "Trata en la noche de halloween en que Michael Myers es un asesino serial",
  "duration": 90,
  "release_date": ISODate("1978-02-03"),
  "gender": ["Terror", "Suspenso"],
  "subtitles": ["Español", "Frances", "Italiano"],
  "artist": [ 
    {"artis_id" :2, "first_name" : "Hilario", "rol" : "principal"},
    {"artis_id" :1, "first_name" : "Nai", "rol" : "principal"},
    {"artis_id" :6, "first_name" : "Lai", "rol" : "director"}],
  "produces" : "Nada-Records"
},
{
  "_id" : 4,
  "type": "Movie",
  "title": "Clases de verano",
  "description": "No quiero mas clases",
  "duration": 60,
  "release_date": ISODate("2018-01-03"),
  "gender": ["drama"],
  "subtitles": ["Español", "Frances", "Italiano"],
  "artist": [ 
    {"artis_id" :2, "first_name" : "Hilario", "rol" : "principal"},
    {"artis_id" :1, "first_name" : "Nai", "rol" : "principal"},
    {"artis_id" :1, "first_name" : "Histeria", "rol" : "secundario"},
    {"artis_id" :6, "first_name" : "Lai", "rol" : "director"}],
  "produces" : "Nada-Records"
},
{
  "_id" : 5,
  "type": "Movie",
  "title": "Llega fin de año",
  "description": "Un proximo año",
  "duration": 60,
  "release_date": ISODate("2018-10-03"),
  "gender": ["comedia"],
  "subtitles": ["Español", "Frances", "Italiano"],
  "artist": [ 
    {"artis_id" :2, "first_name" : "Hilario", "rol" : "director"},
    {"artis_id" :1, "first_name" : "Nai", "rol" : "principal"},
    {"artis_id" :1, "first_name" : "Histeria", "rol" : "secundario"},
    {"artis_id" :6, "first_name" : "Lai", "rol" : "secundario"}],
  "produces" : "Nada-Records"
}
])
