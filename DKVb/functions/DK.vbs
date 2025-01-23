' TODO:  each DK.ext file displays the context it's in the version and path to the shell and the DKSCRIPT_PATH

if DKINIT = 1 then
	'WScript.Echo "DK.vbs already loaded"
else
	'WScript.Echo "Loading DK.vbs"
	DKINIT = 1
	
	Set WSHELL = CreateObject("WScript.Shell")
	
	function ForceConsole()	
		If InStr(LCase(WScript.FullName), "cscript.exe") = 0 Then
			WSHELL.Run "cmd.exe /k cscript.exe" & " //NoLogo " & Chr(34) & WScript.ScriptFullName & Chr(34)
			WScript.Quit
		End If
	end function
	ForceConsole()
	
	ESC=""
	DKSHELL="VBScript"
	DKSHELL_VERSION=WScript.Version
	WScript.Echo ESC+"[44m"+ESC+"[10m "+DKSHELL+" Version "+DKSHELL_VERSION+" "+ESC+"[0m"
	executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("dk_source.vbs").readAll()

	DKSCRIPT_PATH 		= WScript.ScriptFullName
	DKSCRIPT_DIR 		= CreateObject("Scripting.FileSystemObject").GetParentFolderName(DKSCRIPT_PATH)
	DKSCRIPT_FILE 		= CreateObject("Scripting.FileSystemObject").GetFileName(DKSCRIPT_PATH)
	DKSCRIPT_NAME 		= CreateObject("Scripting.FileSystemObject").GetBaseName(DKSCRIPT_PATH)
	DKSCRIPT_EXT 		= "."+CreateObject("Scripting.FileSystemObject").GetExtensionName(DKSCRIPT_PATH)
	DKHOME_DIR			= WSHELL.ExpandEnvironmentStrings("%USERPROFILE%")
	DKCACHE_DIR			= DKHOME_DIR+"\.dk"
	DKDESKTOP_DIR		= DKHOME_DIR+"\Desktop"
	DIGITALKNOB			= "DigitalKnob"
	DIGITALKNOB_DIR		= DKHOME_DIR+"\"+DIGITALKNOB
	DKDOWNLOAD_DIR		= DIGITALKNOB_DIR+"\downloads"
	DKTOOLS_DIR			= DIGITALKNOB_DIR+"\DKTools"
	DKBRANCH			= "Development"
	DKBRANCH_DIR		= DIGITALKNOB_DIR+"\"+DKBRANCH
	DK3RDPARTY_DIR		= DKBRANCH_DIR+"\3rdParty"
    DKAPPS_DIR			= DKBRANCH_DIR+"\DKApps"
    DKVB_DIR			= DKBRANCH_DIR+"\DKVb"
    DKVB_FUNCTIONS_DIR	= DKVB_DIR+"\functions"
    DKVB_FUNCTIONS_DIR_	= DKVB_FUNCTIONS_DIR+"\"
end if