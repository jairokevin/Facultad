// Listar los clientes suscritos al plan PREMIUM en un determinado rango de fechas.

// Quiero consultan entre las siguientes fechas
//inicio = ISODate("2018-01-18")
//fin = ISODate("2018-11-18")

db.clients.find(
   {$and: [{"subscripcions" : "premium"},
        {"subscripcion_date" : {"$gte" : ISODate("2018-01-18") , "$lte" : ISODate("2018-11-18")}}
   ]},
   {
    "_id" : 0,
    "frist_name" : 1,
    "last_name" : 1
  }
).pretty()

/* Trabajando con fechas

    $gt: greater than (mayor que)
    $gte: greater than or equal (mayor o igual que)
    $lt: less than (menor que)
    $lte: less than or equal (menor o igual que)
    $ne: not equal (distinto de)
    $in: in (dentro de(un array)
    $nin: not in (no dentro de (un array))
*/