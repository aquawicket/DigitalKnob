if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_pinToQuickAccess){ $dk_pinToQuickAccess = 1 } else{ return }

################################################################################
# dk_pinToQuickAccess(path)
#
#
function Global:dk_pinToQuickAccess($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$o = new-object -com shell.application
	$o.Namespace("$path").Self.InvokeVerb("pintohome")
}




function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	dk_pinToQuickAccess("C:\Users\Administrator\digitalknob")
}
