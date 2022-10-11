// Listar las películas mejor calificadas en los últimos 6 meses. Usar la
// “calificación promedio”.

db.reviews.aggregate([
    {
        $match : {"type" : "movie"}
    },
    {
        $addFields : {"estrella" : { $avg: "rating" }}
    },
    {
        $match : 
            { $and : [{"rating" : {$gte : estrella, $lte : 5}},
            {"review_date": {"$gte" : ISODate("2018-02-00")}}
            ]}
    },
    {
        $project : {
            _id : 0,
            "title": 1,
            "rating" : 1
        }
    }
]).pretty()