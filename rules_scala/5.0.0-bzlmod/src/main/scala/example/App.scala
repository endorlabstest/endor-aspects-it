package example

import example.lib.Parser
import scala.meta._

object App {
  def main(args: Array[String]): Unit = {
    val code = args.head

    // Direct use of scalameta (direct dep)
    val tree: Source = code.parse[Source].get

    // Direct use of pprint (direct dep)
    pprint.pprintln(tree.structure)

    // Use internal library
    println(s"Statements : ${Parser.statCount(code)}")
    println(s"Pretty     : ${Parser.prettyPrint(code)}")
  }
}
