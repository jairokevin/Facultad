package app

import cask._
import models._

object RestfulAPIServer extends MainRoutes  {
  override def host: String = "0.0.0.0"
  override def port: Int = 4000

  @get("/")
  def root(): Response = {
    JSONResponse("Ok")
  }

  @get("/api/locations")
  def locations(): Response = {
    JSONResponse(Location.all.map(location => location.toMap))
  }

  @postJson("/api/locations")
  def locations(name: String, coordX: Int, coordY: Int): Response = {
    /*if (Location.exists("name", name)) {
      return JSONResponse("Existing location", 409)
    }
*/
    val location = Location(name, coordX, coordY)
    location.save()
    JSONResponse(location.id)
  }

  @get("/api/providers")
  def providers(): Response = {
    JSONResponse(Provider.all.map(provider => provider.toMap))
  }

  @postJson("/api/providers")
  def locations(username: String, locationId: Int, storeName: String, 
	 					    maxDeliveryDistance: Int): Response = {
    /*if (Location.exists("name", name)) {
      return JSONResponse("Existing location", 409)
    }
*/
    val provider = Provider(username, locationId, storeName, maxDeliveryDistance)
    provider.save()
    JSONResponse(provider.id)
  }

  override def main(args: Array[String]): Unit = {
    System.err.println("\n " + "=" * 39)
    System.err.println(s"| Server running at http://$host:$port ")

    if (args.length > 0) {
      val databaseDir = args(0)
      Database.loadDatabase(databaseDir)
      System.err.println(s"| Using database directory $databaseDir ")
    } else {
      Database.loadDatabase()  // Use default location
    }
    System.err.println(" " + "=" * 39 + "\n")

    super.main(args)
  }

  initialize()
}
