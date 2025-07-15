if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_removeExtension_ps1){ $dk_removeExtension_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_removeExtension(filepath) -> rtn_var
#
#
function Global:dk_removeExtension() {
	dk_debugFunc 1;
	
	$filepath = $args[0];
	
	${global:dk_removeExtension} = $filepath.Substring(0, $filepath.lastIndexOf('.'));
	return $dk_removeExtension;
}











###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	$name = dk_call dk_removeExtension "C:/test/test1/xfile.version.1.1.ext";
	dk_call dk_info "name = ${name}";
	
	dk_call dk_removeExtension "C:/test/test2/xfile.version.2.2.ext";
	dk_call dk_info "dk_removeExtension = ${dk_removeExtension}";
}
