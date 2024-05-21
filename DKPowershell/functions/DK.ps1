
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

	
	#Invoke-WebRequest -URI $URL -OutFile $Path
	#(New-Object System.Net.WebClient).DownloadFile($URL, $Path)
	#Start-BitsTransfer -Source $URL -Destination $Path
	
	$global:DKHTTP = "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKPowershell/functions"
	if (! (Test-Path "$DKPOWERSHELL_DIR\functions\dk_load.ps1")) { Invoke-WebRequest -URI "$DKHTTP/dk_load.ps1" -OutFile "$DKPOWERSHELL_DIR\functions\dk_load.ps1" }
	. $DKPOWERSHELL_DIR\functions\dk_load.ps1
	dk_load dk_debugFunc
	dk_load dk_getHostTriple
	dk_load dk_printVar
	dk_load dk_getDKPaths
	dk_load dk_makeDirectory
	dk_load dk_buildMain


	#Import-Module ./dk_download.ps1
	#$GIT_DL = "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe"
	#$DEST = "$CurrentDirectory\PortableGit-2.44.0-64-bit.7z.exe"
	#dk_download $GIT_DL $DEST
}


DK

