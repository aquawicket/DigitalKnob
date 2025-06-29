if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_logo_ps1){ $dk_logo_ps1 = 1; } else{ return; } #include guard

################################################################################
# dk_logo()
#
function Global:dk_logo() {
	dk_debugFunc 0;

	dk_call dk_echo  "${lblue} ______  _____ _______ ______ ______ ______        _     __ _   _   _____  ______ \n";
	dk_call dk_echo  "${lblue} |     \   |   |  ____   |      |    |_____| |      |____/  | \  | |     | |_____]\n";
	dk_call dk_echo   "${blue} |_____/ __|__ |_____| __|__    |    |     | |_____ |    \_ |  \_| |_____| |_____]\n";
	dk_call dk_echo "${lgreen}                                                     __     __                    \n";
	dk_call dk_echo "${lgreen}                                                    |  \|_/|__)_     _ _ _|_  _|| \n";
	dk_call dk_echo  "${green}                                                    |__/| \|  (_)\//(-| _)| )(-|| \n";
	dk_call dk_echo  "${clr}\n";
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;

	dk_call dk_logo;
}
