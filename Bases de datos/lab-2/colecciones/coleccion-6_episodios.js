use mongo_g9
// Coleccion de episodios
db.episodes.drop()
db.episodes.insertMany([
    {
    "_id" : 1,
    "title" : "Saludos a todos",
    "description" : "Nada por aca",
    "duracion" : 20,
    "relase_date" : ISODate("1999-04-09"),
    "season" : 1,
    "year" : 1992,
    "episode_number": 1,
    "tvshow" : 1,
    "artist": [ 
        {"artis_id" :1, "first_name" : "Nai", "rol" : "pricipal"},
        {"artis_id" :3, "first_name" : "Histeria", "rol" : "secundario"},
        {"artis_id" :6, "first_name" : "Lai", "rol" : "director"}],
    "produces" : "Nada-Records"
    },
    {
    "_id" : 2,
    "title" : "Chau a todos",
    "description" : "Nada por aca",
    "duracion" : 20,
    "relase_date" : ISODate("1999-04-10"),
    "season" : 1,
    "year" : 1992,
    "episode_number": 2,
    "tvshow" : 1,
    "artist": [ 
        {"artis_id" :1, "first_name" : "Nai", "rol" : "principal"},
        {"artis_id" :4, "first_name" : "Fede", "rol" : "secundario"},
        {"artis_id" :6, "first_name" : "Lai", "rol" : "director"}],
    "produces" : "Nada-Records"
    },
    {
        "_id" : 3,
        "title" : "Hola mundo de nuevo",
        "description" : "no se",
        "duracion" : 20,
        "relase_date" : ISODate("2000-05-02"),
        "season" : 1,
        "year" : 1992,
        "episode_number": 2,
        "tvshow" : 1,
        "artist": [ 
            {"artis_id" :1, "first_name" : "Nai", "rol" : "principal"},
            {"artis_id" :6, "first_name" : "Lai", "rol" : "director"}],
        "produces" : "Nada-Records"
        }
])
