if(${DKINIT}){return} else{ $global:DKINIT=1 }	# include_guard

### Print Version Info ###
Write-Host ""
$DKSHELL = (Get-Process -Id $pid).Name
$DKSHELL_VERSION = $PSVersionTable.PSVersion.ToString()
$DKSHELL_PATH = (get-command $DKSHELL).Path
$global:ESC = "$([char]27)" 				# escape character
Write-Host "${ESC}[44m ${ESC}[30m $DKSHELL Version $DKSHELL_VERSION ${ESC}[0m"
Write-Host " $DKSHELL_PATH"
Write-Host ""


#####################################################################
# DKINIT()
#
#	# Reference: https://ss64.com/ps
#
function DK() {

	###### Initialize Language specifics ######
	dk_init
	
	###### Reload Main Script with powershell ######
	# dk_reloadWithPowershell
	
	############ Get DKPOWERSHELL variables ############
	dk_DKPOWERSHELL_VARS
	
	############ Get DKHTTP variables ############
	dk_DKHTTP_VARS

	############ get dk_source and dk_call ######
	dk_initFiles
	
	############ Setup dk_callStack ############
	#dk_setupCallstack
	#call dk_callStack
	#:dk_callStackReturn
	
	############ Get DKSCRIPT variables ############
	dk_DKSCRIPT_VARS
	
	##### CD into the DKSCRIPT_DIR directory #####
	#cd "${DKSCRIPT_DIR}"
	
	############ Set Options ############
	#dk_setOptions
	
	
	############ LOAD FUNCTION FILES ############
	dk_source __TIME__
	dk_source __FILE__
	dk_source __LINE__
	dk_source __FUNCTION__
	dk_source __ARGC__
	dk_source __ARGV__
	dk_source __CALLER__
	dk_source dk_debugFunc
	dk_call dk_color 1
	dk_call dk_logo
	
	#dk_source ${DKSCRIPT_PATH}
	
	#Write-Output "env:PATH = $env:PATH"
	#$env:PATH += ";${DKPOWERSHELL_FUNCTIONS_DIR}"
	
	#. DKPOWERSHELL_FUNCTIONS_DIR/dk_thisFunction
	
	###### DKTEST MODE ######
	if(!("${DKSCRIPT_DIR}" -eq "${DKPOWERSHELL_FUNCTIONS_DIR}")){ return }
	if(!("${DKSCRIPT_EXT}" -eq ".ps1")){ return }
		Write-Output "DKSCRIPT_EXT = ${DKSCRIPT_EXT}"
		Write-Output ""
		Write-Output "${bg_magenta}${white}###### DKTEST MODE ###### $DKSCRIPT_NAME ###### DKTEST MODE ########${clr}"
		Write-Output ""
		#$include_guard = $DKSCRIPT_NAME.Substring(0, $DKSCRIPT_NAME.lastIndexOf('.'))
		#dk_unset $include_guard
		. ${DKSCRIPT_PATH}
		DKTEST
		Write-Output ""
		Write-Output "${bg_magenta}${white}######## END TEST ####### $DKSCRIPT_NAME ######## END TEST #########${clr}"
		Write-Output ""
		Read-Host -Prompt "Press Enter to exit" 
		exit
}




##################################################################################
# dk_echo()
#
function dk_echo(){
	$allArgs = $PsBoundParameters.Values + ${args} 
	Write-Host $allArgs
}

##################################################################################
# dk_init()
#
function dk_init(){
	Write-Host "Loading DKPowershell DigitalKnob . . ."
}

##################################################################################
# dk_DKPOWERSHELL_VARS()
#
function dk_DKPOWERSHELL_VARS(){
	$env:DKPOWERSHELL_FUNCTIONS_DIR = Split-Path -Parent $PSCommandPath
	$global:DKPOWERSHELL_FUNCTIONS_DIR = Split-Path -Parent $PSCommandPath
	$global:DKPOWERSHELL_FUNCTIONS_DIR = ${DKPOWERSHELL_FUNCTIONS_DIR} -replace '\\', '/';
	$global:DKPOWERSHELL_DIR = Split-Path -Parent ${DKPOWERSHELL_FUNCTIONS_DIR}
	$global:DKPOWERSHELL_FUNCTIONS_DIR_ = "${DKPOWERSHELL_FUNCTIONS_DIR}/"
}

##################################################################################
# dk_DKHTTP_VARS()
#
function dk_DKHTTP_VARS(){
	$global:DKHTTP_DIGITALKNOB_DIR = "https://raw.githubusercontent.com/aquawicket/DigitalKnob"
	$global:DKHTTP_DKBRANCH_DIR = "$DKHTTP_DIGITALKNOB_DIR/Development"
	$global:DKHTTP_DKPOWERSHELL_DIR = "$DKHTTP_DKBRANCH_DIR/DKPowershell"
	$global:DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR = "$DKHTTP_DKPOWERSHELL_DIR/functions"
}

##################################################################################
# dk_initFiles
#
function dk_initFiles(){
	if(!(Test-Path "${DKPOWERSHELL_FUNCTIONS_DIR}/dk_source.ps1")){ Invoke-WebRequest -URI "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/dk_source.ps1" -OutFile "${DKPOWERSHELL_FUNCTIONS_DIR}/dk_source.ps1" }
	. ${DKPOWERSHELL_FUNCTIONS_DIR}/dk_source.ps1
	if(!(Test-Path "${DKPOWERSHELL_FUNCTIONS_DIR}/dk_call.ps1")){ Invoke-WebRequest -URI "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/dk_call.ps1" -OutFile "${DKPOWERSHELL_FUNCTIONS_DIR}/dk_call.ps1" }
	. ${DKPOWERSHELL_FUNCTIONS_DIR}/dk_call.ps1
}

##################################################################################
# dk_setupCallstack()
#
function dk_setupCallstack(){
	if(!(Test-Path "${DKPOWERSHELL_FUNCTIONS_DIR}/dk_callStack.ps1")){ Invoke-WebRequest -URI "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/dk_callStack.ps1" -OutFile "${DKPOWERSHELL_FUNCTIONS_DIR}/dk_callStack.ps1" }
}

##################################################################################
# dk_DKSCRIPT_VARS()
#
function dk_DKSCRIPT_VARS(){
	if(!${DKSCRIPT_PATH}){ $global:DKSCRIPT_PATH = Get-EntryPointAbsFilePath }
	$global:DKSCRIPT_PATH = ${DKSCRIPT_PATH} -replace '\\', '/';
	if(!(Test-Path ${DKSCRIPT_PATH})){ dk_call dk_echo "DKSCRIPT_PATH not found!"; exit } 
	$global:DKSCRIPT_ARGS = ${args}
	$global:DKSCRIPT_DIR = Split-Path -Parent ${DKSCRIPT_PATH}
	$global:DKSCRIPT_DIR = ${DKSCRIPT_DIR} -replace '\\', '/';
	if(!(Test-Path ${DKSCRIPT_DIR})){ dk_call dk_echo "DKSCRIPT_DIR not found!"; exit } 
	$global:DKSCRIPT_NAME = Split-Path -Leaf ${DKSCRIPT_PATH}
	if(!${DKSCRIPT_EXT}){ $global:DKSCRIPT_EXT = [System.IO.Path]::GetExtension("$DKSCRIPT_PATH") }
}

##################################################################################
# Get-EntryPointAbsFilePath()
#
function Get-EntryPointAbsFilePath() {
    # NOTE 1: Do not use '$MyInvocation.PSScriptRoot' because it corresponds to the path of the calling script (not entry point script).
    # NOTE 2: '$global:PSScriptRoot' is not the same as '$PSScriptRoot' and seems to correspond to the entry point script directory,
    # but it is set only when the main script is invoked from powershell command like [PowerShell.exe -File "MainScript.ps1"] but not
    # when "MainScript.ps1" is invoked from a PowerShell session (prompt) like [PS C:/Temp>. MainScript.ps1].
    $CallStack = Get-PSCallStack
    # We take the last stack element (correponding to the first call).
    # The 'ScriptName' property of this first call can be null when the main script is invoked from a PowerShell session like [PS C:/Temp>. MainScript.ps1].
    # This is because PowerShell first evaluates the entered command.
    $FirstCall = $CallStack[$CallStack.Count - 1];
    if($null -ne $FirstCall.ScriptName){ return $FirstCall.ScriptName; }
    # We take the second call (assuming that we are run under a PowerShell session).
    # To make sure this call is coming from the execution of a script file (and not from the execution a cmdlet in the interpreter, like a function in a module),
    # we check the 'FunctionName' property which equals "<ScriptBlock>" when a call is performed from a script block, like a ps1 file.
    # This test is not required for the first call, as a PowerShell module can't be run.
    $SecondCall = $CallStack[$CallStack.Count - 2];
    if($null -ne $SecondCall.ScriptName -and $SecondCall.FunctionName -eq "<ScriptBlock>") { return $SecondCall.ScriptName; }
    throw "No PowerShell entry point script could be found. This cmdlet ""$($MyInvocation.MyCommand.Name)"" is intended to be called only via the execution of a script file.";
}

# https://ss64.com/ps
# https://www.pdq.com/blog/change-powershell-colors/
function Set-ConsoleColor ($bc, $fc) {
    $Host.UI.RawUI.BackgroundColor = $bc
    $Host.UI.RawUI.ForegroundColor = $fc
    #Clear-Host
}

Set-ConsoleColor 'black' 'white'
DK

