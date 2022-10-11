//Listar los datos de las películas donde el actor ‘X’ fue protagonista.

// mi actor X se llama Nai
db.content.find(
  { $and : [{"type": "Movie"},
    {"artist": {"$elemMatch" :{"first_name" : "Nai", "rol" : "principal"}}}
  ]},
  {"_id" : 0,
  "type": 1,
  "title": 1,
  "description": 1,
  "duration": 1,
  "release_date": 1,
  "gender": 1,
  "subtitles": 1,
  "artist": 1,
  "produces" : 1
  }
).pretty()