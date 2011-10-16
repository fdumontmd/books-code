#doFile("./io/day-3/json_hash.io")

OperatorTable addAssignOperator(":", "atPutNumber")

Map atPutNumber := method(
    self atPut(
         call evalArgAt(0) asMutable removePrefix("\"") removeSuffix("\""), 
         call evalArgAt(1))
) 

curlyBrackets := method(
  r := Map clone
  call message arguments foreach(arg,
    r doMessage(arg)
    )
  r
)
asXmlAttributes := method(
      call target asList map(a, a at(0) asMutable appendSeq("=") appendSeq(a at(1))) join(", ")
      )

Builder := Object clone

Builder currentIndentation := 0

Builder xmlNode := method(nodeName, attributes, children,
      openXmlNode := method(
        currentIndentation repeat(write(" "))
        writeln("<", nodeName, " ", attributes asXmlAttributes, ">")
        currentIndentation = currentIndentation + 1
        )
      closeXmlNode := method(
        currentIndentation = currentIndentation - 1
        currentIndentation repeat(write(" "))
        writeln("</", nodeName, ">")
        )
      writeXmlText := method(
        (currentIndentation + 1) repeat(write(" "))
        writeln(content)
        )

      openXmlNode
      children foreach(
        arg,
        content := self doMessage(arg);
        if(content type == "Sequence", writeXmlText)
        )
      closeXmlNode
      )

  Builder forward := method(
      args := call message arguments
      if(doMessage(args at(0)) type == "Map",
        xmlNode(call message name, doMessage(args removeAt(0)), args),
        xmlNode(call message name, Map clone, args))
      )

