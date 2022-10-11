// Listar cantidad de peliculas por genero en orden descendente.

db.content.aggregate([
    {
        $match: {"type": "Movie"}
    },
    {
        $unwind: "$gender"
    },
    {
        $group:{
            _id:  "$gender",
            "cantidad": {$sum : 1}
        }
    },
    {
        $project: {
            "_id": 1,
            "cantidad" : 1
        }
    },
    {
        $sort : {"cantidad" : -1 }
    }
]).pretty()
