if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_Target_Env_ps1){ $dk_Target_Env_ps1 = 1; } else{ return; } #include guard


${global:Target_Env_DEFAULT} = "Clang";
################################################################################
# dk_Target_Env()
#
#    Function description
#
#    @arg1	- arg1 description
#
function Global:dk_Target_Env() {
	dk_debugFunc 0 1;

	###### SET ######
	if( $($args[0]) ) {
		${Target_Env} = $($args[0]); 
	
	###### GET ######	
	} else {
		dk_call dk_echo;
		dk_call dk_echo  "0) ${Target_Env_Cache}";
		dk_call dk_echo;
		dk_call dk_echo  "1) ${Target_Env_DEFAULT}";
		dk_call dk_echo  "2) Gcc";
		dk_call dk_echo  "3) Msvc";
		dk_call dk_echo  "4) Gcc-Ucrt";
		dk_call dk_echo  "5) Go Back";
		dk_call dk_echo  "6) Exit";
		dk_call dk_echo;

		dk_call dk_keyboardInput;
		    if( ${dk_keyboardInput} -eq "0" )	{ ${global:Target_Env} = ${Target_Env_Cache}; }
		elseif( ${dk_keyboardInput} -eq "1" )	{ ${global:Target_Env} = ${Target_Env_DEFAULT}; }
		elseif( ${dk_keyboardInput} -eq "2" ) 	{ ${global:Target_Env} = "Gcc";	}
		elseif( ${dk_keyboardInput} -eq "3" ) 	{ ${global:Target_Env} = "Msvc"; }
		elseif( ${dk_keyboardInput} -eq "4" ) 	{ ${global:Target_Env} = "Ucrt"; }
		elseif( ${dk_keyboardInput} -eq "5" )	{ dk_call dk_unset Target_Arch;	}
		elseif( ${dk_keyboardInput} -eq "6" )	{ dk_call dk_exit 0; }
		else {
			dk_call dk_unset Target_Env; 
			dk_call dk_echo "${dk_keyboardInput}: invalid selection, please try again";
			return;
		}
		
		${global:$(Target_Env)} = 1;
		
		${env:Target_Env} = ${Target_Env};
		${env:$(Target_Env)} = 1;
	}
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	###### GET ######
    dk_call dk_Target_Env;
	dk_call dk_echo "Target_Env = ${Target_Env}";
	dk_call dk_echo "${Target_Env%} = ${$(Target_Env)}";
	
	###### SET ######
	dk_call dk_Target_Env "MyEnvironment";
	dk_call dk_echo "Target_Env = ${Target_Env}";
	dk_call dk_echo "${Target_Env%} = ${$(Target_Env)}";
}
