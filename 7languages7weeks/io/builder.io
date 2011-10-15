Builder := Object clone
Builder forward := method(
        buf := "" asMutable
        args := call message arguments
        buf appendSeq("<", call message name)
        if(args size > 0 and doMessage(args at(0)) type == "Map", 
                h := doMessage(args removeFirst)
                h keys foreach(k,
                  buf appendSeq(" ", k, "=\"", h at(k), "\"")))
        buf appendSeq(">\n")
        args foreach(
             arg,
             content := self doMessage(arg);
             if(content isMutable, buf appendSeq("  ",content replaceSeq("\n", "\n  "), "\n"), buf appendSeq("  ", content, "\n")))
        buf appendSeq("</", call message name, ">")
        buf)

squareBrackets := method(
     l := List clone
     call message arguments foreach(arg,
          l append(arg)
     )
     l
)

OperatorTable addAssignOperator(":", "atPutNumber")

curlyBrackets := method(
              r := Map clone
              call message arguments foreach(arg,
                   r doMessage(arg)
              )
              r
)

Map atPutNumber := method(
    self atPut(
         call evalArgAt(0) asMutable removePrefix("\"") removeSuffix("\""), 
         call evalArgAt(1))
) 



#Builder ul({"author": "Tate"}, li("Io"), li("Lua"), li("JavaScript"))