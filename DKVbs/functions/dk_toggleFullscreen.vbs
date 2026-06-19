' shebang

if(NOT DKINIT_vbs = 1) then
	executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()
	'ForceConsole()
end if


'##################################################################################
'# dk_toggleFullscreen()
'#
public function dk_toggleFullscreen()
	Set WshShell=CreateObject("WScript.Shell")
	WshShell.AppActivate "batchfs"
	WshShell.SendKeys "{F11}"
	close
end function









'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(ENV("DKSCRIPT_PATH") = WScript.ScriptFullName) then
public function DKTEST()
	
	dk_toggleFullscreen()
	
end function
end if



