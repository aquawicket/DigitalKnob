if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_quickAccessPin){ $dk_quickAccessPin = 1 } else{ return } #include guard

################################################################################
# dk_quickAccessPin("$path")
#
#
function Global:dk_quickAccessPin() {
	dk_debugFunc 0 99
	
	$path = $args[0];
	$path = ${path} -replace '/', '\';
	
	$quickAccess = New-object -com shell.application;
	if(-not ($quickAccess.Namespace('shell:::{679f85cb-0220-4080-b29b-5540cc05aab6}').Items() | ? {$_.Path -eq $path})){
		$quickAccess.Namespace($path).Self.InvokeVerb('pintohome');
	}
}














###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_quickAccessPin("C:/Users/Administrator/digitalknob");
}
