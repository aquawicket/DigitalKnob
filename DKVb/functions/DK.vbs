' TODO:  each DK.ext file displays the context it's in the version and path to the shell and the DKSCRIPT_PATH

if DK_VBS = 1 then
	'WScript.Echo "DK.vbs already loaded"
else
	'WScript.Echo "Loading DK.vbs"
	
	DK_VBS = 1
	
	'###### Global Objects ######
	set WScript_Shell = CreateObject("WScript.Shell")
	set FileSystemObject = CreateObject("Scripting.FileSystemObject")

	'###### ForceConsole() ######
	function ForceConsole()	
		if InStr(LCase(WScript.FullName), "cscript.exe") = 0 Then
			WScript_Shell.Run "cmd.exe /k cscript.exe" & " //NoLogo " & Chr(34) & WScript.ScriptFullName & Chr(34)
			WScript.Quit
		end if
	end function
	ForceConsole()
	
	'###### ENV() ######
	set ENV = WScript_Shell.Environment("PROCESS")
	
	ESC=""
	DKSHELL="VBScript"
	DKSHELL_VERSION=WScript.Version
	WScript.Echo(ESC+"[44m"+ESC+"[10m "+DKSHELL+" Version "+DKSHELL_VERSION+" "+ESC+"[0m")
	
	executeGlobal FileSystemObject.openTextFile("dk_source.vbs").readAll()
	dk_source("dk_echo")
	dk_echo("Test dk_echo")
	
	'if(isEmpty(ENV("DKSCRIPT_PATH"))) Then
		ENV("DKSCRIPT_PATH") = WScript.ScriptFullName
	'end if
	'if(isEmpty(ENV("DKSCRIPT_DIR"))) Then
		ENV("DKSCRIPT_DIR") = FileSystemObject.GetParentFolderName(ENV("DKSCRIPT_PATH"))
	'end if
	ENV("DKSCRIPT_FILE") 		= FileSystemObject.GetFileName(ENV("DKSCRIPT_PATH"))
	ENV("DKSCRIPT_NAME") 		= FileSystemObject.GetBaseName(ENV("DKSCRIPT_PATH"))
	ENV("DKSCRIPT_EXT") 		= "."+FileSystemObject.GetExtensionName(ENV("DKSCRIPT_PATH"))
	ENV("DKHOME_DIR")			= WScript_Shell.ExpandEnvironmentStrings(ENV("USERPROFILE"))
	ENV("DKCACHE_DIR")			= ENV("DKHOME_DIR")+"\.dk"
	ENV("DKDESKTOP_DIR")		= ENV("DKHOME_DIR")+"\Desktop"
	ENV("DIGITALKNOB")			= "digitalknob"
	ENV("DIGITALKNOB_DIR")		= ENV("DKHOME_DIR")+"\"+ENV("DIGITALKNOB")
	ENV("DKDOWNLOAD_DIR")		= ENV("DIGITALKNOB_DIR")+"\downloads"
	ENV("DKTOOLS_DIR")			= ENV("DIGITALKNOB_DIR")+"\DKTools"
	ENV("DKBRANCH")				= "Development"
	ENV("DKBRANCH_DIR")			= ENV("DIGITALKNOB_DIR")+"\"+ENV("DKBRANCH")
	ENV("DK3RDPARTY_DIR")		= ENV("DKBRANCH_DIR")+"\3rdParty"
	ENV("DKCPP_APPS_DIR")		= ENV("DKBRANCH_DIR")+"\DKCpp\apps"
	ENV("DKVB_DIR")				= ENV("DKBRANCH_DIR")+"\DKVb"
	ENV("DKVB_FUNCTIONS_DIR")	= ENV("DKVB_DIR")+"\functions"
	ENV("DKVB_FUNCTIONS_DIR_")	= ENV("DKVB_FUNCTIONS_DIR")+"\"
end if