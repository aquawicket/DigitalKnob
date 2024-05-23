if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_test){ $dk_test = 1 } else{ return }

dk_load dk_info
dk_load dk_debug
dk_load dk_error
dk_load dk_pause
##################################################################################
# dk_test()
#
#
function GLOBAL:dk_test($str, $num) {
	dk_debugFunc
	#if ( $(__ARGC__) -lt 2 ){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	dk_info "test from dk_info"
	dk_debug "test from dk_debug"
	
	echo "__FILE__     = $(__FILE__)"
	echo "__LINE__     = $(__LINE__)"
	echo "__FUNCTION__ = $(__FUNCTION__)"
	echo "__ARGC__     = $(__ARGC__)"
	echo "__ARGV__     = $(__ARGV__)"
	echo "__CALLER__   = $(__CALLER__)"

	
	dk_pause
}




function Global:DKTEST() { ###########################################################################################
	dk_debugFunc
	
	dk_test string1 123
}