package models

object Provider extends ModelCompanion[Provider] {
  protected def dbTable: DatabaseTable[Provider] = Database.providers

   def apply(username: String, locationId: Int, storeName: String, 
	 					 maxDeliveryDistance: Int): Provider =
     new Provider(username, locationId, storeName, maxDeliveryDistance)

   private[models] def apply(jsonValue: JValue): Provider = {
     val value = jsonValue.extract[Provider]
     value._id = (jsonValue \ "id").extract[Int]
     value.save()
     value
   }
 }

class Provider(val username: String, val locationId: Int, val storeName: String, 
							 val maxDeliveryDistance: Int) extends Model[Provider] {
  protected def dbTable: DatabaseTable[Provider] = Provider.dbTable

  override def toMap: Map[String, Any] = super.toMap + ("username" -> username,
																												"locationId"->locationId,
																											  "storeName"->storeName,
																												"maxDeliveryDistance"->maxDeliveryDistance)

  override def toString: String = s"Provider: $username"
}
