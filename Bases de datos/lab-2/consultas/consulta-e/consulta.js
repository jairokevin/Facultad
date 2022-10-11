// Listar los actores que hayan actuado en películas que pertenecen a
// géneros de drama o comedia, ordenados por orden alfabético.

db.content.aggregate([
    {
        "$match": {
            "type" : "Movie",
            "$or" : [ 
                { "gender" : "drama"},
                { "gender" : "comedia"}
                ] 
                 
        }
    },
    {
        $unwind: "$artist"
    },
    {
        $match:{
            "$or" : [ 
                { "artist.rol" : "principal"},
                { "artist.rol" : "secundario"}
                ]
        }
    },
    {
        $replaceRoot:{newRoot: "$artist"}
    },
    {
        $project:{_id:0, first_name : 1}
    },
    {
        $sort : {"first_name": 1}
    }
]).pretty()
