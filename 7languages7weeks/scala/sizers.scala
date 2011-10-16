import scala.io._
import scala.actors._
import Actor._
import scala.util.matching.Regex

val linkPattern = new Regex("""<a +href=\"([^\"]+)\"[^>]*>""", "link")

object PageLoader {
  def getPageSize(url : String, withLinks : Boolean): Int = { 
    val text = Source.fromURL(url).mkString
    var size = text.length
    if (withLinks) {
      val links = linkPattern.findAllIn(text)

      size = (size /: links.matchData) { (sum, m) => 
        try {
          sum + PageLoader.getPageSize(m.group("link"), false) 
        } catch {
          case e: Exception => sum
        }
      }
    }

    size
  }
}

val urls = List("http://www.amazon.com",
                "http://www.twitter.com",
                "http://www.google.com",
                "http://www.cnn.com" )

def timeMethod(method : () => Unit) = {
  val start = System.nanoTime
  method()
  val end = System.nanoTime

  println("Method took " + (end - start) / 1000000000.0 + " seconds.")
}

def getPageSizeSequentially() = {
  for(url <- urls) {
    println("Size for " + url + ": " + PageLoader.getPageSize(url, true))
  }
}

def getPageSizeConcurrently() {
  val caller = self

  for(url <- urls) {
    actor { caller ! (url, PageLoader.getPageSize(url, true)) }
  }

  for (i <- 1 to urls.size) {
    receive {
      case(url, size) =>
        println("Size for " + url + ": " + size)
    }
  }
}

println("Sequential run:")
timeMethod { getPageSizeSequentially }

println("Concurrent run:")
timeMethod { getPageSizeConcurrently }


