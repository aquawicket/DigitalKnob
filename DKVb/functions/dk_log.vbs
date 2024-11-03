executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()

'##################################################################################
'# dk_log(<message>)
'#
executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("dk_echo.vbs").readAll()
Public Function dk_log(message)
	dk_echo(message)
End Function







'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
Call dk_log("test dk_log()")
