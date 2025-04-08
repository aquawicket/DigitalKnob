' TODO:  each DK.ext file displays the context it's in the version and path to the shell and the DKSCRIPT_PATH

if DK_VBS = 1 then
	'WScript.Echo "DK.vbs already loaded"
else

	
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
	
'	if(isEmpty(ENV("DKSCRIPT_PATH"))) Then
		ENV("DKSCRIPT_PATH") = WScript.ScriptFullName
'	end if
'	if(isEmpty(ENV("DKSCRIPT_DIR"))) Then
		ENV("DKSCRIPT_DIR") = FileSystemObject.GetParentFolderName(ENV("DKSCRIPT_PATH"))
'	end if
'	if(isEmpty(ENV("DKSCRIPT_FILE"))) Then
		ENV("DKSCRIPT_FILE") = FileSystemObject.GetFileName(ENV("DKSCRIPT_PATH"))
'	end if	
	ENV("DKSCRIPT_NAME")				= FileSystemObject.GetBaseName(ENV("DKSCRIPT_PATH"))
	ENV("DKSCRIPT_EXT")					= "."+FileSystemObject.GetExtensionName(ENV("DKSCRIPT_PATH"))
	ENV("DKHOME_DIR")					= WScript_Shell.ExpandEnvironmentStrings(ENV("USERPROFILE"))
	ENV("DKCACHE_DIR")					= ENV("DKHOME_DIR")+"\.dk"
	ENV("DKDESKTOP_DIR")				= ENV("DKHOME_DIR")+"\Desktop"
	ENV("DIGITALKNOB")					= "digitalknob"
	ENV("DIGITALKNOB_DIR")				= ENV("DKHOME_DIR")+"\"+ENV("DIGITALKNOB")
	ENV("DKDOWNLOAD_DIR")				= ENV("DIGITALKNOB_DIR")+"\downloads"
	ENV("DKTOOLS_DIR")					= ENV("DIGITALKNOB_DIR")+"\DKTools"
	ENV("DKBRANCH")						= "Development"
	ENV("DKBRANCH_DIR")					= ENV("DIGITALKNOB_DIR")+"\"+ENV("DKBRANCH")
	ENV("DK3RDPARTY_DIR")				= ENV("DKBRANCH_DIR")+"\3rdParty"
	ENV("DKCPP_APPS_DIR")				= ENV("DKBRANCH_DIR")+"\DKCpp\apps"
	ENV("DKBASH_DIR")					= ENV("DKBRANCH_DIR")+"\DKBash"
	ENV("DKBASH_FUNCTIONS_DIR")			= ENV("DKBASH_DIR")+"\functions"
	ENV("DKBASH_FUNCTIONS_DIR_")		= ENV("DKBASH_FUNCTIONS_DIR")+"\"
	ENV("DKBATCH_DIR")					= ENV("DKBRANCH_DIR")+"\DKBatch"
	ENV("DKBATCH_FUNCTIONS_DIR")		= ENV("DKBATCH_DIR")+"\functions"
	ENV("DKBATCH_FUNCTIONS_DIR_")		= ENV("DKBATCH_FUNCTIONS_DIR")+"\"
	ENV("DKC_DIR")						= ENV("DKBRANCH_DIR")+"\DKC"
	ENV("DKC_FUNCTIONS_DIR")			= ENV("DKC_DIR")+"\functions"
	ENV("DKC_FUNCTIONS_DIR_")			= ENV("DKC_FUNCTIONS_DIR")+"\"
	ENV("DKCMAKE_DIR")					= ENV("DKBRANCH_DIR")+"\DKCMake"
	ENV("DKCMAKE_FUNCTIONS_DIR")		= ENV("DKCMAKE_DIR")+"\functions"
	ENV("DKCMAKE_FUNCTIONS_DIR_")		= ENV("DKCMAKE_FUNCTIONS_DIR")+"\"
	ENV("DKCPP_DIR")					= ENV("DKBRANCH_DIR")+"\DKCpp"
	ENV("DKCPP_FUNCTIONS_DIR")			= ENV("DKCPP_DIR")+"\functions"
	ENV("DKCPP_FUNCTIONS_DIR_")			= ENV("DKCPP_FUNCTIONS_DIR")+"\"
	ENV("DKCSHARP_DIR")					= ENV("DKBRANCH_DIR")+"\DKCSharp"
	ENV("DKCSHARP_FUNCTIONS_DIR")		= ENV("DKCSHARP_DIR")+"\functions"
	ENV("DKCSHARP_FUNCTIONS_DIR_")		= ENV("DKCSHARP_FUNCTIONS_DIR")+"\"
	ENV("DKHTA_DIR")					= ENV("DKBRANCH_DIR")+"\DKHta"
	ENV("DKHTA_FUNCTIONS_DIR")			= ENV("DKHTA_DIR")+"\functions"
	ENV("DKHTA_FUNCTIONS_DIR_")			= ENV("DKHTA_FUNCTIONS_DIR")+"\"
	ENV("DKHTML_DIR")					= ENV("DKBRANCH_DIR")+"\DKHtml"
	ENV("DKHTML_FUNCTIONS_DIR")			= ENV("DKHTML_DIR")+"\functions"
	ENV("DKHTML_FUNCTIONS_DIR_")		= ENV("DKHTML_FUNCTIONS_DIR")+"\"
	ENV("DKJAVA_DIR")					= ENV("DKBRANCH_DIR")+"\DKJava"
	ENV("DKJAVA_FUNCTIONS_DIR")			= ENV("DKJAVA_DIR")+"\functions"
	ENV("DKJAVA_FUNCTIONS_DIR_")		= ENV("DKJAVA_FUNCTIONS_DIR")+"\"
	ENV("DKJAVASCRIPT_DIR")				= ENV("DKBRANCH_DIR")+"\DKJavascript"
	ENV("DKJAVASCRIPT_FUNCTIONS_DIR")	= ENV("DKJAVASCRIPT_DIR")+"\functions"
	ENV("DKJAVASCRIPT_FUNCTIONS_DIR_")	= ENV("DKJAVASCRIPT_FUNCTIONS_DIR")+"\"
	ENV("DKPHP_DIR")					= ENV("DKBRANCH_DIR")+"\DKPhp"
	ENV("DKPHP_FUNCTIONS_DIR")			= ENV("DKPHP_DIR")+"\functions"
	ENV("DKPHP_FUNCTIONS_DIR_")			= ENV("DKPHP_FUNCTIONS_DIR")+"\"
	ENV("DKPOWERSHELL_DIR")				= ENV("DKBRANCH_DIR")+"\DKPowershell"
	ENV("DKPOWERSHELL_FUNCTIONS_DIR")	= ENV("DKPOWERSHELL_DIR")+"\functions"
	ENV("DKPOWERSHELL_FUNCTIONS_DIR_")	= ENV("DKPOWERSHELL_FUNCTIONS_DIR")+"\"
	ENV("DKPYTHON_DIR")					= ENV("DKBRANCH_DIR")+"\DKPython"
	ENV("DKPYTHON_FUNCTIONS_DIR")		= ENV("DKPYTHON_DIR")+"\functions"
	ENV("DKPYTHON_FUNCTIONS_DIR_")		= ENV("DKPYTHON_FUNCTIONS_DIR")+"\"
	ENV("DKVB_DIR")						= ENV("DKBRANCH_DIR")+"\DKVb"
	ENV("DKVB_FUNCTIONS_DIR")			= ENV("DKVB_DIR")+"\functions"
	ENV("DKVB_FUNCTIONS_DIR_")			= ENV("DKVB_FUNCTIONS_DIR")+"\"
	
	clr = ESC+"[0m"
	bg_magenta = ESC+"[45m"
	white = ESC+"[37m"
	dk_echo("")
	dk_echo(bg_magenta+white+"###### DKTEST MODE ###### "+ENV("DKSCRIPT_FILE")+" ###### DKTEST MODE ######"+clr)
	executeGlobal FileSystemObject.openTextFile(ENV("DKSCRIPT_PATH")).readAll()
	DKTEST()
	dk_echo(bg_magenta+white+"################################ END TEST ##################################"+clr)
	dk_echo("")
end if














'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(ENV("DKSCRIPT_PATH") = WScript.ScriptFullName) then
public function DKTEST()

	DK()

end function	
end if