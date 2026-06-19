Function CmdOut( pCmd )
  REM@description
  ' Run a command prompt command and get its output.
  REM@params
  ' pCmd <string> - A command prompt command.
  REM@returns
  ' CmdOut <string> - The output of the command.
  REM@author
  ' Jeremy England, http://codeartery.com/
  REM@mini
  ' Function CmdOut(p):Dim w,e,r,o:Set w=CreateObject("WScript.Shell"):Set e=w.Exec("Cmd.exe"):e.StdIn.WriteLine p&" 2>&1":e.StdIn.Close:While(InStr(e.StdOut.ReadLine,">"&p)=0)::Wend:Do:o=e.StdOut.ReadLine:If(e.StdOut.AtEndOfStream)Then:Exit Do:Else:r=r&o&vbLf:End If:Loop:CmdOut=r:End Function
  Dim oWss, oExe, Return, Output
  Set oWss = CreateObject( "WScript.Shell" )
  Set oExe = oWss.Exec( "Cmd.exe" )
  Call oExe.StdIn.WriteLine( pCmd & " 2>&1" )
  Call oExe.StdIn.Close()
  While( InStr( oExe.StdOut.ReadLine, ">" & pCmd ) = 0 ) :: Wend
  Do : Output = oExe.StdOut.ReadLine()
    If( oExe.StdOut.AtEndOfStream )Then
      Exit Do
    Else 
      Return = Return & Output & vbLf
    End If
  Loop
  CmdOut = Return
End Function
