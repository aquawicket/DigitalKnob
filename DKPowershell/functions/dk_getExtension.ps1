if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_getExtension_ps1){ $dk_getExtension_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_getExtension(path) -> rtn_var
#
#   Reference: https://stackoverflow.com/a/9788998/688352
#   		   https://learn.microsoft.com/en-us/dotnet/api/system.io.path?view=netstandard-2.1
#
function Global:dk_getExtension() {
	dk_debugFunc 1 2;

	${global:dk_getExtension} = [System.IO.Path]::GetExtension($args[0]);
	
	if($args[1]) {
		dk_call dk_set $args[1] ${dk_getExtension};
	} else {
		return ${dk_getExtension};
	}
}













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	### Result as global variable
	dk_call dk_echo;
	dk_call dk_getExtension "C:/test/test2/xfile.version.3.3.extC";
	dk_call dk_echo "dk_getExtension = ${dk_getExtension}";
	
	### Result as return value
	dk_call dk_echo;
	$resultA = dk_call dk_getExtension "C:/test/test1/xfile.version.1.1.extA";
	dk_call dk_echo "resultA = ${resultA}";
	dk_call dk_echo "dk_getExtension = ${dk_getExtension}";
	
	### Result as parameter
	dk_call dk_echo;
	dk_call dk_getExtension "C:/test/test2/xfile.version.2.2.extB" resultB;
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_getExtension = ${dk_getExtension}";
}
