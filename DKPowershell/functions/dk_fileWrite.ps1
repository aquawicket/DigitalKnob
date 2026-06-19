if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_fileWrite_ps1){ $dk_fileWrite_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_fileWrite(filepath, str)
#
#
function Global:dk_fileWrite($filepath, $str) {
	dk_debugFunc 2;
	
	echo "$str" > "$filepath" 
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;

	dk_call dk_fileWrite "dk_fileWrite_TEST.txt" "string written by dk_fileWrite"
}
