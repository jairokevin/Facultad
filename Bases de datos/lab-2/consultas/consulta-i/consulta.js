// Listar las películas dirigidas por dos o más directores femeninos.

// lista las peliculcas que tengan  directores femenenios
db.content.aggregate([
    {
        "$match": {
            "type" : "Movie",
        }
    },
    {
        $unwind: "$artist"
    },
    {
        $match:{
          "artist.rol" : "director"
        }
    },
    {
        $lookup:
        {
          from: "artists",
          localField: "artist.artis_id",
          foreignField: "_id",
          as: "directores"
        }
    },
    {
        $unwind: "$directores"
    },
    {
        $match :  {"directores.gender" : "mujer"}
    },
    {
        $project:{_id:1, "title" : 1, "directores.frist_name" : 1 }
    }
]).pretty()