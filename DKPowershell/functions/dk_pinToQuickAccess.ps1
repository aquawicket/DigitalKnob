if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_pinToQuickAccess){ $dk_pinToQuickAccess = 1 } else{ return }

################################################################################
# dk_pinToQuickAccess(path)
#
#
function Global:dk_pinToQuickAccess() {
	dk_debugFunc
	#if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$path = $args[0];
	$o = New-object -com shell.application;
	$o.Namespace("$path").Self.InvokeVerb("pintohome");
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_pinToQuickAccess("C:\Users\Administrator\digitalknob")
}
