// Listar los actores que hayan actuado en todos los programas de
// televisión en donde actuó un actor X.

// Todos los actores que actuaron el todos los programas de tv
db.content.aggregate([
    {
        "$match": {
            "type" : "tvshow"
        }
    },
    {
        $unwind: "$episodes",
    },
    {
        $lookup:
        {
          from: "episodes",
          localField: "episodes.episodes_id",
          foreignField: "_id",
          as: "episodios_tv"
        }
    },
    {
        $unwind: "$episodios_tv"
    },
    {
        $unwind: "$episodios_tv.artist"
    },
    {
        $match:{
            "$or" : [ 
                { "episodios_tv.artist.rol" : "principal"},
                { "episodios_tv.artist.rol" : "secundario"}
            ]
        }
    },
    {
        $replaceRoot:{newRoot: "$episodios_tv.artist"}
    },
    {
        $project:{
            _id:0, 
            first_name : 1
        }
    },
    {
       $sort : {"first_name": 1}
    }
]).pretty()

/*
    {
        $match : //{"episodios_tv.artist.artis_id" : { $in: [1] }} 
        { $elemMatch: { "episodios_tv.artist.artis_id"  : 1}}
        // { $exists: true, $in: [1] } }
        //{ $elemMatch: { <query1>, <query2>, ... } }
    },
*/