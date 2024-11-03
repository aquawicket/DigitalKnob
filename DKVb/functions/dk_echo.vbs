executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()

'##################################################################################
'# dk_echo(<message>)
'#
Public Function dk_echo(message)
	WScript.Echo message
End Function









'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
Call dk_echo("test dk_echo()")


