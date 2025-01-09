if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_debugFunc){ $dk_debugFunc = 1 } else{ return } #include guard

if(!$ENABLE_dk_debugFunc)	{ $global:ENABLE_dk_debugFunc = 0 }
if(!$MAX_STACK_LINES)		{ $global:MAX_STACK_LINES = 200 }
#if(!$DKSTACK[0].FILE)	    { $global:DKSTACK[0].FILE = $0 }
#if(!$DKSTACK[0].FUNCTION)  { $global:DKSTACK[0].FUNCTION = main }
#if(!$DKSTACK[0].ARGS)	    { $global:DKSTACK[0].ARGS = 0 }
if(!$DKSTACK_length)		{ $global:DKSTACK_length = 1 }
if(!$DKSTACK_marker)		{ $global:DKSTACK_marker = 1 }
################################################################################
# dk_debugFunc()
#
#
function Global:dk_debugFunc() {
	$_MIN_ = $args[0]
	$_MAX_ = $args[1]
	$FRAME = 2	
	$_TIME_     = "$(__TIME__)"
	$_FILE_     = "$(__FILE__     $FRAME)"
	$_LINE_     = "$(__LINE__     $FRAME)"
	$_FUNCTION_ = "$(__FUNCTION__ $FRAME)"
	$_ARGC_     = "$(__ARGC__     $FRAME)"
	$_ARGV_     = "$(__ARGV__     $FRAME)"
	if($_MIN_){ 
		if(${_ARGC_} -lt ${_MIN_}){ Write-Host "${_FUNCTION_}(${_ARGV_}): not enough arguments. Minimum is ${_MIN_}, got ${_ARGC_}" }
	}
	if($_MAX_){
		if(${_ARGC_} -gt ${_MAX_}){ Write-Host "${_FUNCTION_}(${_ARGV_}): too many arguments. Maximum is ${_MAX_}, got ${_ARGC_}" }
	} else {
		if(${_ARGC_} -gt ${_MIN_}){ Write-Host "error" }
		if(${_ARGC_} -gt ${_MIN_}){ Write-Host "${_FUNCTION_}(${_ARGV_}): too many arguments. Maximum is ${_MIN_}, got ${_ARGC_}" }
	}
	
	if($ENABLE_dk_debugFunc -ne 1){ return }
	if($(__FUNCTION__ 2) -eq "dk_echo"){ return }
	if($(__FUNCTION__ 2) -eq "dk_info"){ return }
	if($(__FUNCTION__ 2) -eq "dk_debug"){ return }
	if($(__FUNCTION__ 2) -eq "dk_warning"){ return }
	if($(__FUNCTION__ 2) -eq "dk_verbose"){ return }
	if($(__FUNCTION__ 2) -eq "dk_error"){ return }
	if($(__FUNCTION__ 2) -eq "dk_todo"){ return }
	if($(__FUNCTION__ 2) -eq "dk_fixme"){ return }
	if($(__FUNCTION__ 2) -eq "dk_printVar"){ return }
	
	$indent="${indent} "
	#$indent="${indent} L "
	
	$global:ESC = "$([char]27)"
	$global:cyan = "${ESC}[36m"
	$global:blue = "${ESC}[34m"
	$global:clr = "${ESC}[0m"
	
	Write-Host -NoNewline "${cyan}[${_TIME_}]${indent}${_FILE_}`:${_LINE_}".PadLeft(25); Write-Host "    ${blue}${_FUNCTION_}(${_ARGV_})${clr}";
#####################################################################################################################################
}

