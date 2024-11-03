executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()

'##################################################################################
'# dk_source(<message>)
'#
Public Function dk_source(file)
	executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile(file+".vbs").readAll()
End Function









'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
If DKSCRIPT_FILE = "dk_source.vbs" Then
	dk_source("dk_messageBox")
	dk_messageBox("test dk_source() successful")
End If