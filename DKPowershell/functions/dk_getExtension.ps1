if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_getExtension_ps1){ $dk_getExtension_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_getExtension(path, rtn_var)
#
#   Reference: https://stackoverflow.com/a/9788998/688352
#   		   https://learn.microsoft.com/en-us/dotnet/api/system.io.path?view=netstandard-2.1
#
function Global:dk_getExtension() {
	dk_debugFunc 1 2;
	
	if($args[0].lastIndexOf(".tar.") -gt -1){
		${dk_getExtension} = $args[0].Substring($args[0].lastIndexOf(".tar."));
	}
	elseif($args[0].lastIndexOf(".7z.") -gt -1){
		${dk_getExtension} = $args[0].Substring($args[0].lastIndexOf(".7z."));
	}
	else{
		${dk_getExtension} = $args[0].Substring($args[0].lastIndexOf("."));
		#${dk_getExtension} = [System.IO.Path]::GetExtension($args[0]);
	}
	
	###### return ######
	${global:dk_getExtension} = ${dk_getExtension};
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
	dk_call dk_getExtension "A:/directoryA/filenameA.extA";
	dk_call dk_echo "dk_getExtension = ${dk_getExtension}";
	
	### Result as return value
	dk_call dk_echo;
	$resultB = dk_call dk_getExtension "B:/directoryB/filenameB.tar.gz";
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_getExtension = ${dk_getExtension}";
	
	### Result as variable parameter
	dk_call dk_echo;
	dk_call dk_getExtension "C:/directoryC/filenameC.7z.exe" resultC;
	dk_call dk_echo "resultC = ${resultC}";
	dk_call dk_echo "dk_getExtension = ${dk_getExtension}";
	
	### Result as hashtable parameter
	dk_call dk_echo;
	dk_call dk_getExtension "D:/directoryD/filenameD.target.gz" resultD.data;
	dk_call dk_echo "resultD.data = $($resultD.data)";
	dk_call dk_echo "dk_getExtension = ${dk_getExtension}";
}
