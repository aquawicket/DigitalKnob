<<<<<<< HEAD
executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()
ForceConsole()
=======
if(NOT DK_VBS = 1) then
	executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()
	ForceConsole()
end if

>>>>>>> Development

'##################################################################################
'# dk_echo(<message>)
'#
public function dk_echo(message)
	WScript.Echo message
end function









<<<<<<< HEAD
'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if DKSCRIPT_FILE = "dk_echo.vbs" then
	dk_echo("test dk_echo()")
=======



'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(ENV("DKSCRIPT_PATH") = WScript.ScriptFullName) then
public function DKTEST()	

	dk_echo("test dk_echo()")

end function	
>>>>>>> Development
end if