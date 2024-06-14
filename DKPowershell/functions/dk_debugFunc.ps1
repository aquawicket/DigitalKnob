if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_debugFunc){ $dk_debugFunc = 1 } else{ return }

if(!$ENABLE_dk_debugFunc)	{ $global:ENABLE_dk_debugFunc = 1 }
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
	
	Write-Host -NoNewline "${cyan}$(__FILE__ 2)`:$(__LINE__ 2)".PadLeft(25); Write-Host "${blue}   $(__FUNCTION__ 2)($(__ARGV__ 2))";
}