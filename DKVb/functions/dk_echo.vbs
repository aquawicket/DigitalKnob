executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()

Public Function dk_echo(message)
	WScript.Echo message
End Function

Call dk_echo("test dk_echo()")


