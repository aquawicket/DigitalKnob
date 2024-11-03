executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()
ForceConsole()

'##################################################################################
'# dk_echo(<message>)
'#
public function dk_echo(message)
	WScript.Echo message
end function









'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if DKSCRIPT_FILE = "dk_echo.vbs" then
	dk_echo("test dk_echo()")
end if