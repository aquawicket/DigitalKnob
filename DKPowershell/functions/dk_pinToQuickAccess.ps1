if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_pinToQuickAccess){ $dk_pinToQuickAccess = 1 } else{ return }

################################################################################
# dk_pinToQuickAccess(path)
#
#
function Global:dk_pinToQuickAccess() {
	dk_debugFunc 0 99
	
	$path = $args[0];
	dk_echo "dk_pinToQuickAccess($path)"
	
	$quickAccess = New-object -com shell.application;
	#$quickAccess.Namespace("$path").Self.InvokeVerb("pintohome");
	if(-not ($quickAccess.Namespace('shell:::{679f85cb-0220-4080-b29b-5540cc05aab6}').Items() | ? {$_.Path -eq $path})){
		$quickAccess.Namespace($path).Self.InvokeVerb('pintohome');
	}
}














###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_pinToQuickAccess("C:\Users\Administrator\digitalknob");
}
