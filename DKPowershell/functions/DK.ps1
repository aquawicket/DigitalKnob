if(${env:DK_PS1}){return;} else{ ${env:DK_PS1}=1; }	# include_guard

### Print Version Info ###
Write-Host "";
${env:DKSHELL} = (Get-Process -Id $pid).Name;
${env:DKSHELL_VERSION} = $PSVersionTable.PSVersion.ToString();
${env:DKSHELL_PATH} = (get-command ${env:DKSHELL}).Path;
if(!${global:ESC}){ ${global:ESC} = "$([char]27)"; }				# escape character
Write-Host "${ESC}[44m ${ESC}[30m ${env:DKSHELL} Version ${env:DKSHELL_VERSION} ${ESC}[0m";
Write-Host "DKSHELL_PATH = ${env:DKSHELL_PATH}";
Write-Host "DKSCRIPT_PATH = ${env:DKSCRIPT_PATH}";


#####################################################################
# DK()
#
#	# Reference: https://ss64.com/ps
#
function DK() {

	# Error trap
	# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_trap?view=powershell-7.4&WT.mc_id=M365-MVP-5000284
	trap { 
		'DigitalKnob found an Error'; 
		#dk_call dk_stacktrace;
	}
	
	###### Initialize Language specifics ######
	dk_init;
	
	###### Reload Main Script with powershell ######
	# dk_reloadWithPowershell;
	
	############ Get DKPOWERSHELL variables ############
	dk_DKPOWERSHELL_VARS;
	
	############ Get DKHTTP variables ############
	dk_DKHTTP_VARS;

	############ get dk_source and dk_call ######
	dk_initFiles;
	
	############ Setup dk_callStack ############
	#dk_setupCallstack;
	#call dk_callStack;
	#:dk_callStackReturn;
	
	############ Get DKSCRIPT variables ############
	dk_DKSCRIPT_VARS;
	
	##### CD into the DKSCRIPT_DIR directory #####
	#cd "${DKSCRIPT_DIR}";
	
	############ Set Options ############
	#dk_setOptions;
	
	
	############ LOAD FUNCTION FILES ############
	dk_source __TIME__;
	dk_source __FILE__;
	dk_source __LINE__;
	dk_source __FUNCTION__;
	dk_source __ARGC__;
	dk_source __ARGV__;
	dk_source __CALLER__;
	dk_source dk_debugFunc;
	dk_call dk_color 1;
	dk_call dk_logo;
	
	if(Test-Path "${env:DKSCRIPT_DIR}/dkconfig.txt"){
		dk_call dk_getFileParams "${env:DKSCRIPT_DIR}/dkconfig.txt";
	} elseif(Test-Path "${env:DKBRANCH_DIR}/dkconfig.txt"){
		dk_call dk_getFileParams "${env:DKBRANCH_DIR}/dkconfig.txt";
	}
	#dk_source ${env:DKSCRIPT_PATH}
	
	#Write-Output "env:PATH = ${env:PATH}";
	#${env:PATH} += ";${env:DKPOWERSHELL_FUNCTIONS_DIR}";
	
	###### DKTEST MODE ######
	if("${env:DKSCRIPT_EXT}" -ne ".ps1"){ return; }
	#if(!(dk_call dk_fileContains "${DKSCRIPT_PATH}" "DKTEST()")){ return; }

	dk_call dk_echo "\n";
	dk_call dk_echo "${bg_magenta}${white}###### DKTEST MODE ###### $DKSCRIPT_NAME ###### DKTEST MODE ########${clr}\n";
	dk_call dk_echo  "\n";
	. ${DKSCRIPT_PATH};
	DKTEST;
	dk_call dk_echo "\n";
	dk_call dk_echo "${bg_magenta}${white}######## END TEST ####### $DKSCRIPT_NAME ######## END TEST #########${clr}\n";
	dk_call dk_echo "\n";
	dk_call dk_pause "Press Enter to exit";
	dk_call dk_exit
}




##################################################################################
# dk_echo()
#
function dk_echo(){
	if(!($args[0])){
		${message} = "\n";
	} else {
		${message} = "${args}";
	}
	if("${dk_echo_NONEWLINE}" -eq "1"){
		${message} = ${message} -replace "\\n", "`n";
		Write-Host -NoNewline "${message}";
	} else {
		${message} = ${message} -replace "\\n", "";
		Write-Host "${message}";
	}
}

##################################################################################
# dk_init()
#
function dk_init(){
	Write-Host "Loading DKPowershell DigitalKnob . . .";
}

##################################################################################
# dk_DKPOWERSHELL_VARS()
#
function dk_DKPOWERSHELL_VARS(){
	if(!${env:DKPOWERSHELL_FUNCTIONS_DIR}) 	{ ${env:DKPOWERSHELL_FUNCTIONS_DIR} 	= Split-Path -Parent ${PSCommandPath}; }
	if(!${env:DKPOWERSHELL_FUNCTIONS_DIR})	{ ${env:DKPOWERSHELL_FUNCTIONS_DIR} 	= ${env:DKPOWERSHELL_FUNCTIONS_DIR} -replace '\\', '/'; }
	if(!${env:DKPOWERSHELL_DIR})			{ ${env:DKPOWERSHELL_DIR} 				= Split-Path -Parent ${env:DKPOWERSHELL_FUNCTIONS_DIR}; }
	if(!${env:DKPOWERSHELL_FUNCTIONS_DIR_})	{ ${env:DKPOWERSHELL_FUNCTIONS_DIR_}  	= "${env:DKPOWERSHELL_FUNCTIONS_DIR}/";}
	
	${global:DKPOWERSHELL_DIR} 				= ${env:DKPOWERSHELL_DIR};
	${global:DKPOWERSHELL_FUNCTIONS_DIR} 	= ${env:DKPOWERSHELL_FUNCTIONS_DIR};
	${global:DKPOWERSHELL_FUNCTIONS_DIR_} 	= ${env:DKPOWERSHELL_FUNCTIONS_DIR_};
}

##################################################################################
# dk_DKHTTP_VARS()
#
function dk_DKHTTP_VARS(){
	if(!${env:DKHTTP_DIGITALKNOB_DIR})				{ ${env:DKHTTP_DIGITALKNOB_DIR} 			= "https://raw.githubusercontent.com/aquawicket/DigitalKnob"; }
	if(!${env:DKHTTP_DKBRANCH_DIR})					{ ${env:DKHTTP_DKBRANCH_DIR}				= "${env:DKHTTP_DIGITALKNOB_DIR}/Development"; }
	if(!${env:DKHTTP_DKPOWERSHELL_DIR})				{ ${env:DKHTTP_DKPOWERSHELL_DIR}			= "${env:DKHTTP_DKBRANCH_DIR}/DKPowershell"; }
	if(!${env:DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR})	{ ${env:DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR}	= "${env:DKHTTP_DKPOWERSHELL_DIR}/functions"; }
	
	${global:DKHTTP_DIGITALKNOB_DIR} 			= ${env:DKHTTP_DIGITALKNOB_DIR};
	${global:DKHTTP_DKBRANCH_DIR} 				= ${env:DKHTTP_DKBRANCH_DIR}; 
	${global:DKHTTP_DKPOWERSHELL_DIR} 			= ${env:DKHTTP_DKPOWERSHELL_DIR}; 
	${global:DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR} = ${env:DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR};
}

##################################################################################
# dk_initFiles
#
function dk_initFiles(){
	if(!(Test-Path "${env:DKPOWERSHELL_FUNCTIONS_DIR}/dk_source.ps1")){ Invoke-WebRequest -URI "${env:DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR}/dk_source.ps1" -OutFile "${env:DKPOWERSHELL_FUNCTIONS_DIR}/dk_source.ps1" }
	. "${env:DKPOWERSHELL_FUNCTIONS_DIR}/dk_source.ps1";
	if(!(Test-Path "${env:DKPOWERSHELL_FUNCTIONS_DIR}/dk_call.ps1")){ Invoke-WebRequest -URI "${env:DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR}/dk_call.ps1" -OutFile "${env:DKPOWERSHELL_FUNCTIONS_DIR}/dk_call.ps1" }
	. "${env:DKPOWERSHELL_FUNCTIONS_DIR}/dk_call.ps1";
}

##################################################################################
# dk_setupCallstack()
#
function dk_setupCallstack(){
	if(!(Test-Path "${env:DKPOWERSHELL_FUNCTIONS_DIR}/dk_callStack.ps1")){ Invoke-WebRequest -URI "${env:DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR}/dk_callStack.ps1" -OutFile "${env:DKPOWERSHELL_FUNCTIONS_DIR}/dk_callStack.ps1" }
}

##################################################################################
# dk_DKSCRIPT_VARS()
#
function dk_DKSCRIPT_VARS(){
	### DKSCRIPT_PATH ###
	if(!${env:DKSCRIPT_PATH}){ ${env:DKSCRIPT_PATH} = Get-EntryPointAbsFilePath; }
	${env:DKSCRIPT_PATH} = ${env:DKSCRIPT_PATH} -replace '\\', '/';
	if(!(Test-Path ${env:DKSCRIPT_PATH})){ dk_call dk_echo "DKSCRIPT_PATH:'${env:DKSCRIPT_PATH}' not found!\n"; exit -1; } 
	
	### DKSCRIPT_ARGS ###
	if(!${env:DKSCRIPT_ARGS}){ ${env:DKSCRIPT_ARGS} = ${args}; }
	
	### DKSCRIPT_DIR ###
	if(!${env:DKSCRIPT_DIR}){ ${env:DKSCRIPT_DIR} = Split-Path -Parent "${env:DKSCRIPT_PATH}"; }
	${env:DKSCRIPT_DIR} = ${env:DKSCRIPT_DIR} -replace '\\', '/';
	if(!(Test-Path ${env:DKSCRIPT_DIR})){ dk_call dk_echo "DKSCRIPT_DIR:'${env:DKSCRIPT_DIR}' not found!\n"; exit -1; } 
	
	### DKSCRIPT_NAME ###
	if(!${env:DKSCRIPT_NAME}){ ${env:DKSCRIPT_NAME} = Split-Path -Leaf "${env:DKSCRIPT_PATH}"; }
	
	### DKSCRIPT_EXT ###
	if(!${env:DKSCRIPT_EXT}){ ${env:DKSCRIPT_EXT} = [System.IO.Path]::GetExtension("${env:DKSCRIPT_PATH}"); }
	
	${global:DKSCRIPT_PATH} = ${env:DKSCRIPT_PATH};
	${global:DKSCRIPT_ARGS} = ${env:DKSCRIPT_ARGS};
	${global:DKSCRIPT_DIR}	= ${env:DKSCRIPT_DIR};
	${global:DKSCRIPT_NAME} = ${env:DKSCRIPT_NAME};
	${global:DKSCRIPT_EXT} 	= ${env:DKSCRIPT_EXT};
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

