if(NOT DK_VBS = 1) then
	executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()
	ForceConsole()
end if


'##################################################################################
'# dk_echo(<message>)
'#
public function dk_echo(message)
	WScript.Echo message
end function












'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(ENV("DKSCRIPT_PATH") = WScript.ScriptFullName) then
public function DKTEST()	

	dk_echo("test dk_echo()")

end function	
end if