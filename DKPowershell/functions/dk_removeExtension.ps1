if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_removeExtension_ps1){ $dk_removeExtension_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_removeExtension(path, rtn_var)
#
#
function Global:dk_removeExtension() {
	dk_debugFunc 1 2;
	
	if($args[0].lastIndexOf(".tar.") -gt -1){
		${dk_removeExtension} = $args[0].Substring(0, $args[0].lastIndexOf(".tar."));
	}
	elseif($args[0].lastIndexOf(".7z.") -gt -1){
		${dk_removeExtension} = $args[0].Substring(0, $args[0].lastIndexOf(".7z."));
	}
	elseif($args[0].lastIndexOf(".") -gt -1){
		${dk_removeExtension} = $args[0].Substring(0, $args[0].lastIndexOf("."));
	}
	else{
		${dk_removeExtension} = $args[0];
	}
	
	###### return ######
	${global:dk_removeExtension} = ${dk_removeExtension};
	if($args[1]) {
		dk_call dk_set $args[1] ${dk_removeExtension};
	} else {
		return ${dk_removeExtension};
	}
}











###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	### Result as global variable
	dk_call dk_echo;
	dk_call dk_removeExtension "A:/directoryA/filenameA.extA";
	dk_call dk_echo "dk_removeExtension = ${dk_removeExtension}";
	
	### Result as return value
	dk_call dk_echo;
	$resultB = dk_call dk_removeExtension "B:/directoryB/filenameB.tar.gz";
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_removeExtension = ${dk_removeExtension}";
	
	### Result as variable parameter
	dk_call dk_echo;
	dk_call dk_removeExtension "C:/directoryC/filenameC.7z.exe" resultC;
	dk_call dk_echo "resultC = ${resultC}";
	dk_call dk_echo "dk_removeExtension = ${dk_removeExtension}";
	
	### Result as hashtable parameter
	dk_call dk_echo;
	dk_call dk_removeExtension "D:/directoryD/filenameD.target.gz" resultD.data;
	dk_call dk_echo "resultD.data = $($resultD.data)";
	dk_call dk_echo "dk_removeExtension = ${dk_removeExtension}";
}
