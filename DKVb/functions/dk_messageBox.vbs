if(NOT DK_VBS = 1) then
	executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()
	'ForceConsole()
end if


'##################################################################################
'# dk_messageBox(<message>)
'#
public function dk_messageBox(message)
	MsgBox(message)
end function









'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(ENV("DKSCRIPT_PATH") = WScript.ScriptFullName) then
public function DKTEST()
	
	dk_messageBox("test dk_messageBox()")
	
end function
end if
