package models

trait ModelCompanion[M <: Model[M]] {
  protected def dbTable: DatabaseTable[M]

  private[models] def apply(jsonValue: JValue): M

  def all: List[M] = dbTable.instances.values.toList

  def find(id: Int): Option[M] = dbTable.instances.get(id)

//attr es el atributo y value es lo que quiero buscar
  def exists(attr: String, value: Any):  Boolean = ??? /*{
      m.toMap.toSet.contains(mapOfAttributes)
    }*/
  /*Boolean = {
     val l = all.filter(_.isInstanceOf[M])
     l.contains(attr == value)
  }
*/
  def delete(id: Int): Unit = { dbTable.delete(id) }

  def filter(mapOfAttributes: Map[String, Any]): List[M] = {
    def sats(m : M) : Boolean = {
      m.toMap.toSet.contains(mapOfAttributes)
    }
    all.filter(sats) 
  }
}

trait Model[M <: Model[M]] { self: M =>
  protected var _id: Int = 0

  def id: Int = _id

  protected def dbTable: DatabaseTable[M]

  def toMap: Map[String, Any] = Map("id" -> _id)

  def save(): Unit = {
    if (_id == 0) { _id = dbTable.getNextId }
    dbTable.save(this)
  }
}
