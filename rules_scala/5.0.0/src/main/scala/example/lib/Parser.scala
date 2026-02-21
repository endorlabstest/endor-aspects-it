package example.lib

import scala.meta._

/** Wraps scala-meta parsing and pretty-printing utilities. */
object Parser {

  /** Parse a Scala source string into a syntax tree. */
  def parse(code: String): Source =
    code.parse[Source].get

  /** Return a pretty-printed string representation of the syntax tree. */
  def prettyPrint(code: String): String =
    pprint.tokenize(parse(code)).mkString

  /** Return the top-level statement count in the given source. */
  def statCount(code: String): Int =
    parse(code).stats.size
}
