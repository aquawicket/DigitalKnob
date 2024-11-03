executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()

'##################################################################################
'# dk_echo(<message>)
'#
Public Function dk_echo(message)
	WScript.Echo message
End Function









'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
If DKSCRIPT_FILE = "dk_echo.vbs" Then
	dk_echo("test dk_echo()")
End If