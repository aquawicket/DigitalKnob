if ($DKINIT){return} else{ $global:DKINIT=1 }
#####################################################################
## dk_load()
##
##
function DK() {
	Write-Output "Loading DigitalKnob . . ."

	$global:CallStack = Get-PSCallStack
	#Write-Output "CallStack = $CallStack"

	$MainCall = $CallStack[$CallStack.Count - 2];
	$global:DKSCRIPT_PATH = $MainCall.ScriptName
	#Write-Output "DKSCRIPT_PATH = $DKSCRIPT_PATH"

	$global:DKSCRIPT_DIR = Split-Path -Parent $DKSCRIPT_PATH
	#Write-Output "DKSCRIPT_DIR = $DKSCRIPT_DIR"

	$global:DKSCRIPT_NAME = Split-Path -Leaf $DKSCRIPT_PATH
	#Write-Output "DKSCRIPT_NAME = $DKSCRIPT_NAME"

	$global:DKPOWERSHELL_FUNCTIONS_DIR = Split-Path -Parent $PSCommandPath
	#Write-Output "DKPOWERSHELL_FUNCTIONS_DIR = $DKPOWERSHELL_FUNCTIONS_DIR"

	#Write-Output "env:PATH = $env:PATH"
	#$env:PATH += ";C:\Users\aquawicket\digitalknob\Development\DKPowershell\functions"

	$global:DKPOWERSHELL_DIR = Split-Path -Parent $DKPOWERSHELL_FUNCTIONS_DIR
	#Write-Output "DKPOWERSHELL_DIR = $DKPOWERSHELL_DIR"
	
	$global:DKHTTP = "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKPowershell/functions"
	if (! (Test-Path "$DKPOWERSHELL_DIR\functions\dk_load.ps1")) { Invoke-WebRequest -URI "$DKHTTP/dk_load.ps1" -OutFile "$DKPOWERSHELL_DIR\functions\dk_load.ps1" }
	. $DKPOWERSHELL_DIR\functions\dk_load.ps1
	dk_load dk_debugFunc
	dk_load dk_getHostTriple
	dk_load dk_printVar
	dk_load dk_getDKPaths
	dk_load dk_makeDirectory
	dk_load dk_buildMain
	
	
	###### DKTEST MODE ######
	if ("$DKSCRIPT_DIR" -eq "$DKPOWERSHELL_DIR\functions"){
		dk_load $DKSCRIPT_PATH
		$global:ENABLE_dk_debugFunc = 1
		$global:ENABLE_dk_printVar = 1
		Write-Output ""
		Write-Output "###### DKTEST MODE ###### $DKSCRIPT_NAME ###### DKTEST MODE ######"
		Write-Output ""
		DKTEST
		Write-Output ""
		Write-Output "########################## END TEST ################################"
		Write-Output ""
		
		Read-Host -Prompt "Press Enter to exit" 
		Exit
	}
}
DK

