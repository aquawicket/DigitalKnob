executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()
ForceConsole()

'##################################################################################
'# dk_log(<message>)
'#
Public Function dk_log(message)
	dk_source("dk_echo")
	dk_echo(message)
End Function







'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
If DKSCRIPT_FILE = "dk_log.vbs" Then
	dk_log("test dk_log()")
End If