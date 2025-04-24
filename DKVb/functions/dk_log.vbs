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
<<<<<<< HEAD
if DKSCRIPT_FILE = "dk_log.vbs" then
	dk_log("test dk_log()")
=======
if(ENV("DKSCRIPT_PATH") = WScript.ScriptFullName) then
public function DKTEST()

	dk_log("test dk_log()")

end function	
>>>>>>> Development
end if