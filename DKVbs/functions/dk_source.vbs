' shebang
'###### DK.vbs #########################################################################################################################
Set fso = CreateObject("Scripting.FileSystemObject")
DKScript_Path = WScript.ScriptFullName
DKScript_Dir = fso.GetParentFolderName(DKScript_Path)

if(isEmpty(DKINIT_vbs)) then
	If(NOT fso.FileExists(DK_vbs)) Then
		Set ENV = CreateObject("Wscript.Shell").Environment("Process")
		DK_vbs = ENV("USERPROFILE")+"\Digital Knob\Development\DKVbs\functions\DK.vbs"
		'WScript.echo "DK_vbs = "+DK_vbs
	End If
	If(NOT fso.FileExists(DK_vbs)) Then
		'for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	End if
	If(NOT fso.FileExists(DK_vbs)) Then
		'start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	End if
	executeGlobal fso.openTextFile(DK_vbs).readAll()
	ForceConsole()
end if
'######################################################################################################################################

'##################################################################################
'# dk_source(<funcname>)
'#
public function dk_source(file)
	executeGlobal FileSystemObject.openTextFile(DKVbs_Functions_Dir+"\"+file+".vbs").readAll()
end function









'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(ENV("DKSCRIPT_PATH") = WScript.ScriptFullName) then
public function DKTEST()

	dk_source("dk_messageBox")
	dk_messageBox("test dk_source() successful")

end function
end if