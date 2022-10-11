use mongo_g9
// Coleccion de empleados
db.employees.drop()
db.employees.insertOne(
{
  "_id" : 1,
  "frist_name": "Hola",
  "last_name": "Adios",
  "email": "hola@adios",
  "username": "holaadios",
  "password": "123456",
  "phones" : [
    {
      "phone_id" : 1,
      "phone_type" :  "cel",
      "phone_number" : "3513333333"
    }
  ],
  "roles" : 
    [
      "admin",
      "empleado1"
    ]
  
}
)
db.employees.insertMany([
  {
    "_id" : 2,
    "frist_name": "Pablo",
    "last_name": "Rosas",
    "email": "pablo@arosas",
    "username": "pablorosas",
    "password": "123456",
    "phones" : [
      {
        "phone_id" : 1,
        "phone_type" :  "cel",
        "phone_number" : "011121212"
      }
    ],
    "roles" : 
      [
        "admin",
        "nada"
      ]
    
  },
  {
    "_id" : 3,
    "frist_name": "Jamas",
    "last_name": "Adios",
    "email": "jamaas@adios",
    "username": "jamasadios",
    "password": "123456",
    "phones" : [
      {
        "phone_id" : 1,
        "phone_type" :  "fijo",
        "phone_number" : "4252525"
      }
    ],
    "roles" : 
      [
        "empleado1"
      ]
    
  }
 
])