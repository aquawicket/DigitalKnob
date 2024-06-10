if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_debugFunc){ $dk_debugFunc = 1 } else{ return }



if(!$ENABLE_dk_debugFunc)	{ $ENABLE_dk_debugFunc = 0 }
if(!$MAX_STACK_LINES)		{ $MAX_STACK_LINES = 200 }
#if(!$DKSTACK[0].FILE)	    { $DKSTACK[0].FILE = %0 }
#if(!$DKSTACK[0].FUNCTION) { $DKSTACK[0].FUNCTION = main }
#if(!$DKSTACK[0].ARGS)	    { $DKSTACK[0].ARGS = 0 }
if(!$DKSTACK_length)		{ $DKSTACK_length = 1 }
if(!$DKSTACK_marker)		{ $DKSTACK_marker = 1 }
################################################################################
# dk_debugFunc()
#
#
function Global:dk_debugFunc() {
	$_FRAME_ = 1
	$_FILE_     = $(__FILE__     $($_FRAME_+2))
	$_LINE_     = $(__LINE__     $($_FRAME_+2))
	$_FUNCTION_ = $(__FUNCTION__ $($_FRAME_+1))
	$_ARGC_     = $(__ARGC__     $($_FRAME_+1))
	$_ARGV_     = $(__ARGV__     $($_FRAME_+1))
	#$ARGS = $PsBoundParameters.Values + $args
	
	if($ENABLE_dk_debugFunc -ne 1){ return }
	Write-Host -Fore cyan -NoNewline "${_FILE_}`:${_LINE_}".PadLeft(20); Write-Host -Fore blue "   ${_FUNCTION_}(${_ARGV_})";
}