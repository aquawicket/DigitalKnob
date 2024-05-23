if ($DKINIT){return} else{ $global:DKINIT=1 }

# https://www.pdq.com/blog/change-powershell-colors/
function Set-ConsoleColor ($bc, $fc) {
    $Host.UI.RawUI.BackgroundColor = $bc
    $Host.UI.RawUI.ForegroundColor = $fc
    Clear-Host
}
Set-ConsoleColor 'black' 'white'


function Get-EntryPointAbsFilePath() {
    # NOTE 1: Do not use '$MyInvocation.PSScriptRoot' because it corresponds to the path of the calling script (not entry point script).
    # NOTE 2: '$global:PSScriptRoot' is not the same as '$PSScriptRoot' and seems to correspond to the entry point script directory,
    # but it is set only when the main script is invoked from powershell command like [PowerShell.exe -File "MainScript.ps1"] but not
    # when "MainScript.ps1" is invoked from a PowerShell session (prompt) like [PS C:\Temp>. MainScript.ps1].
    $CallStack = Get-PSCallStack
    # We take the last stack element (correponding to the first call).
    # The 'ScriptName' property of this first call can be null when the main script is invoked from a PowerShell session like [PS C:\Temp>. MainScript.ps1].
    # This is because PowerShell first evaluates the entered command.
    $FirstCall = $CallStack[$CallStack.Count - 1];
    if ($null -ne $FirstCall.ScriptName) { return $FirstCall.ScriptName; }
    # We take the second call (assuming that we are run under a PowerShell session).
    # To make sure this call is coming from the execution of a script file (and not from the execution a cmdlet in the interpreter, like a function in a module),
    # we check the 'FunctionName' property which equals "<ScriptBlock>" when a call is performed from a script block, like a ps1 file.
    # This test is not required for the first call, as a PowerShell module can't be run.
    $SecondCall = $CallStack[$CallStack.Count - 2];
    if ($null -ne $SecondCall.ScriptName -and $SecondCall.FunctionName -eq "<ScriptBlock>") { return $SecondCall.ScriptName; }
    throw "No PowerShell entry point script could be found. This cmdlet ""$($MyInvocation.MyCommand.Name)"" is intended to be called only via the execution of a script file.";
}
$DKSCRIPT_PATH = Get-EntryPointAbsFilePath
Write-Output "DKSCRIPT_PATH = $DKSCRIPT_PATH"
$global:DKSCRIPT_DIR = Split-Path -Parent $DKSCRIPT_PATH


#####################################################################
## dk_load()
##
##
function DK() {
	#dk_debugFunc

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
	
	#$global:DKHTTP = "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKPowershell/functions"
	#if (! (Test-Path "$DKPOWERSHELL_DIR\functions\dk_load.ps1")) { Invoke-WebRequest -URI "$DKHTTP/dk_load.ps1" -OutFile "$DKPOWERSHELL_DIR\functions\dk_load.ps1" }
	
	#. $DKPOWERSHELL_DIR\functions\dk_thisFunction
	. $DKPOWERSHELL_DIR\functions\__FILE__.ps1
	. $DKPOWERSHELL_DIR\functions\__LINE__.ps1
	. $DKPOWERSHELL_DIR\functions\__FUNCTION__.ps1
	. $DKPOWERSHELL_DIR\functions\__ARGC__.ps1
	. $DKPOWERSHELL_DIR\functions\__ARGV__.ps1
	. $DKPOWERSHELL_DIR\functions\__CALLER__.ps1
	. $DKPOWERSHELL_DIR\functions\dk_debugFunc.ps1
	. $DKPOWERSHELL_DIR\functions\dk_load.ps1
	
	
	###### DKTEST MODE ######
	if ("$DKSCRIPT_DIR" -eq "$DKPOWERSHELL_DIR\functions"){
		dk_load $DKSCRIPT_PATH
#		$global:ENABLE_dk_debugFunc = 1
#		$global:ENABLE_dk_printVar = 1
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

