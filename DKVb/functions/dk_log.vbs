executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()
ForceConsole()

'##################################################################################
'# dk_log(<message>)
'#
public function dk_log(message)
	dk_source("dk_echo")
	dk_echo(message)
end function







'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(ENV("DKSCRIPT_PATH") = WScript.ScriptFullName) then
public function DKTEST()

	dk_log("test dk_log()")

end function	
end if