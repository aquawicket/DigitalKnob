if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_DKBRANCH_DIR_ps1){ $dk_DKBRANCH_DIR_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_DKBRANCH_DIR()
#
#
function Global:dk_DKBRANCH_DIR() {
	dk_debugFunc 0 1;
	
	############ SET ############
	if($($args[0])){  
		${env:DKBRANCH_DIR} = $($args[0]);
	
	############ GET ############
	} else {
		if(!(${env:DKBRANCH})){
			# If the current folder matches the current branch set DKBRANCH, default to Development
			${folder} = dk_call dk_basename "$(pwd)";
			${env:DKBRANCH}="Development";
			
			if(dk_call dk_pathExists "$(dk_call dk_DIGITALKNOB_DIR)/${folder}/.git"){
				${branch} = $("${GIT_EXE} rev-parse --abbrev-ref HEAD");
				if("${branch}" -eq "${folder}") {
					${env:DKBRANCH}="${branch}";
				}
			}
		}
		
		if(!(${env:DKBRANCH_DIR})){
			${env:DKBRANCH_DIR}="$(dk_call dk_DIGITALKNOB_DIR)/${env:DKBRANCH}";
			dk_call dk_assertPath ${env:DKBRANCH_DIR};
		}
	}
		
	${env:DK3RDPARTY}="3rdParty";
	${env:DK3RDPARTY_DIR}="${env:DKBRANCH_DIR}/${env:DK3RDPARTY}";
	#dk_call dk_assertPath ${env:DK3RDPARTY_DIR};
			
		${env:DKIMPORTS}="_DKIMPORTS";
		${env:DKIMPORTS_DIR}="${env:DK3RDPARTY_DIR}/${env:DKIMPORTS}";
		#dk_call dk_assertPath ${env:DKIMPORTS_DIR};
			
	${env:DKBASH}="DKBash";
	${env:DKBASH_DIR}="${env:DKBRANCH_DIR}/${env:DKBASH}";
	#dk_call dk_assertPath ${env:DKBASH_DIR};
		${env:DKBASH_FUNCTIONS_DIR}="${env:DKBASH_DIR}/functions";
		#dk_call dk_assertPath ${env:DKBASH_FUNCTIONS_DIR};
		${env:DKBASH_FUNCTIONS_DIR_}="${env:DKBASH_FUNCTIONS_DIR}/";
		#dk_call dk_assertPath ${env:DKBASH_FUNCTIONS_DIR_};
			
	${env:DKBATCH}="DKBatch";
	${env:DKBATCH_DIR}="${env:DKBRANCH_DIR}/${env:DKBATCH}";
	#dk_call dk_assertPath ${env:DKBATCH_DIR};
		${env:DKBATCH_FUNCTIONS_DIR}="${env:DKBATCH_DIR}/functions";
		#dk_call dk_assertPath ${env:DKBATCH_FUNCTIONS_DIR};
		${env:DKBATCH_FUNCTIONS_DIR_}="${env:DKBATCH_FUNCTIONS_DIR}/";
		#dk_call dk_assertPath ${env:DKBATCH_FUNCTIONS_DIR_};
	
	${env:DKC}="DKC";
	${env:DKC_DIR}="${env:DKBRANCH_DIR}/${env:DKC}";
	#dk_call dk_assertPath ${env:DKC_DIR};
		${env:DKC_FUNCTIONS_DIR}="${env:DKC_DIR}/functions";
		#dk_call dk_assertPath ${env:DKC_FUNCTIONS_DIR};
		${env:DKC_FUNCTIONS_DIR_}="${env:DKC_FUNCTIONS_DIR}/";
		#dk_call dk_assertPath ${env:DKC_FUNCTIONS_DIR_};
		
	${env:DKCMAKE}="DKCMake";
	${env:DKCMAKE_DIR}="${env:DKBRANCH_DIR}/${env:DKCMAKE}";
	#dk_call dk_assertPath ${env:DKCMAKE_DIR};
		${env:DKCMAKE_FUNCTIONS_DIR}="${env:DKCMAKE_DIR}/functions";
		#dk_call dk_assertPath ${env:DKCMAKE_FUNCTIONS_DIR};
		${env:DKCMAKE_FUNCTIONS_DIR_}="${env:DKCMAKE_FUNCTIONS_DIR}/";
		#dk_call dk_assertPath ${env:DKCMAKE_FUNCTIONS_DIR_};

	${env:DKCPP}="DKCpp";
	${env:DKCPP_DIR}="${env:DKBRANCH_DIR}/${env:DKCPP}";
	#dk_call dk_assertPath ${env:DKCPP_DIR};
		${env:DKCPP_APPS_DIR}="${env:DKCPP_DIR}/apps";
		#dk_call dk_assertPath ${env:DKCPP_APPS_DIR};
		${env:DKCPP_FUNCTIONS_DIR}="${env:DKCPP_DIR}/functions";
		#dk_call dk_assertPath ${env:DKCPP_FUNCTIONS_DIR};
		${env:DKCPP_FUNCTIONS_DIR_}="${env:DKCPP_FUNCTIONS_DIR}/";
		#dk_call dk_assertPath ${env:DKCPP_FUNCTIONS_DIR_};
		${env:DKCPP_PLUGINS_DIR}="${env:DKCPP_DIR}/plugins";
		#dk_call dk_assertPath ${env:DKCPP_PLUGINS_DIR};
			
	${env:DKCSHARP}="DKCSharp";
	${env:DKCSHARP_DIR}="${env:DKBRANCH_DIR}/${env:DKCSHARP}";
	#dk_call dk_assertPath ${env:DKCSHARP_DIR};
		${env:DKCSHARP_FUNCTIONS_DIR}="${env:DKCSHARP_DIR}/functions";
		#dk_call dk_assertPath ${env:DKCSHARP_FUNCTIONS_DIR};
		${env:DKCSHARP_FUNCTIONS_DIR_}="${env:DKCSHARP_FUNCTIONS_DIR}/";
		#dk_call dk_assertPath ${env:DKCSHARP_FUNCTIONS_DIR_};
	
	${env:DKHTA}="DKHta";
	${env:DKHTA_DIR}="${env:DKBRANCH_DIR}/${env:DKHTA}";
	#dk_call dk_assertPath ${env:DKHTA_DIR};
		${env:DKHTA_FUNCTIONS_DIR}="${env:DKHTA_DIR}/functions";
		#dk_call dk_assertPath ${env:DKHTA_FUNCTIONS_DIR};
		${env:DKHTA_FUNCTIONS_DIR_}="${env:DKHTA_FUNCTIONS_DIR}/";
		#dk_call dk_assertPath ${env:DKHTA_FUNCTIONS_DIR_};
		
	${env:DKJAVA}="DKJava";
	${env:DKJAVA_DIR}="${env:DKBRANCH_DIR}/${env:DKJAVA}";
	#dk_call dk_assertPath ${env:DKJAVA_DIR};
		${env:DKJAVA_FUNCTIONS_DIR}="${env:DKJAVA_DIR}/functions";
		#dk_call dk_assertPath ${env:DKJAVA_FUNCTIONS_DIR};
		${env:DKJAVA_FUNCTIONS_DIR_}="${env:DKJAVA_FUNCTIONS_DIR}/";
		#dk_call dk_assertPath ${env:DKJAVA_FUNCTIONS_DIR_};
	
	${env:DKJAVASCRIPT}="DKJavascript";
	${env:DKJAVASCRIPT_DIR}="${env:DKBRANCH_DIR}/${env:DKJAVASCRIPT}";
	#dk_call dk_assertPath ${env:DKJAVASCRIPT_DIR};
		${env:DKJAVASCRIPT_FUNCTIONS_DIR}="${env:DKJAVASCRIPT_DIR}/functions";
		#dk_call dk_assertPath ${env:DKJAVASCRIPT_FUNCTIONS_DIR};
		${env:DKJAVASCRIPT_FUNCTIONS_DIR_}="${env:DKJAVASCRIPT_FUNCTIONS_DIR}/";
		#dk_call dk_assertPath ${env:DKJAVASCRIPT_FUNCTIONS_DIR_};
	
	${env:DKPHP}="DKPhp";
	${env:DKPHP_DIR}="${env:DKBRANCH_DIR}/${env:DKPHP}";
	#dk_call dk_assertPath ${env:DKPHP_DIR};
		${env:DKPHP_FUNCTIONS_DIR}="${env:DKPHP_DIR}/functions";
		#dk_call dk_assertPath ${env:DKPHP_FUNCTIONS_DIR};
		${env:DKPHP_FUNCTIONS_DIR_}="${env:DKPHP_FUNCTIONS_DIR}/";
		#dk_call dk_assertPath ${env:DKPHP_FUNCTIONS_DIR_};
		
	${env:DKPOWERSHELL}="DKPowershell";
	${env:DKPOWERSHELL_DIR}="${env:DKBRANCH_DIR}/${env:DKPOWERSHELL}";
	#dk_call dk_assertPath ${env:DKPOWERSHELL_DIR};
		${env:DKPOWERSHELL_FUNCTIONS_DIR}="${env:DKPOWERSHELL_DIR}/functions";
		#dk_call dk_assertPath ${env:DKPOWERSHELL_FUNCTIONS_DIR};
		${env:DKPOWERSHELL_FUNCTIONS_DIR_}="${env:DKPOWERSHELL_FUNCTIONS_DIR}/";
		#dk_call dk_assertPath ${env:DKPOWERSHELL_FUNCTIONS_DIR_};
	
	${env:DKPYTHON}="DKPython";
	${env:DKPYTHON_DIR}="${env:DKBRANCH_DIR}/${env:DKPYTHON}";
	#dk_call dk_assertPath ${env:DKPYTHON_DIR};
		${env:DKPYTHON_FUNCTIONS_DIR}="${env:DKPYTHON_DIR}/functions";
		#dk_call dk_assertPath ${env:DKPYTHON_FUNCTIONS_DIR};
		${env:DKPYTHON_FUNCTIONS_DIR_}="${env:DKPYTHON_FUNCTIONS_DIR}/";
		#dk_call dk_assertPath ${env:DKPYTHON_FUNCTIONS_DIR_};

	${env:DKVB}="DKVb";
	${env:DKVB_DIR}="${env:DKBRANCH_DIR}/${env:DKVB}";
	#dk_call dk_assertPath ${env:DKVB_DIR};
		${env:DKVB_FUNCTIONS_DIR}="${env:DKVB_DIR}/functions";
		#dk_call dk_assertPath ${env:DKVB_FUNCTIONS_DIR};
		${env:DKVB_FUNCTIONS_DIR_}="${env:DKVB_FUNCTIONS_DIR}/";
		#dk_call dk_assertPath ${env:DKVB_FUNCTIONS_DIR_};
		
	return ${env:DKBRANCH_DIR};
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	###### GET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Getting DKBRANCH_DIR . . .\n";
	dk_call dk_DKBRANCH_DIR
	dk_call dk_echo "env:DKBRANCH_DIR     = ${env:DKBRANCH_DIR}";
	dk_call dk_echo "env:DK3RDPARTY_DIR   = ${env:DK3RDPARTY_DIR}";
	dk_call dk_echo "env:DKIMPORTS_DIR    = ${env:DKIMPORTS_DIR}";
	dk_call dk_echo "env:DKBASH_DIR       = ${env:DKBASH_DIR}";
	dk_call dk_echo "env:DKBATCH_DIR      = ${env:DKBATCH_DIR}";
	dk_call dk_echo "env:DKC_DIR          = ${env:DKC_DIR}";
	dk_call dk_echo "env:DKCMAKE_DIR      = ${env:DKCMAKE_DIR}";
	dk_call dk_echo "env:DKCPP_DIR        = ${env:DKCPP_DIR}";
	dk_call dk_echo "env:DKCSHARP_DIR     = ${env:DKCSHARP_DIR}";
	dk_call dk_echo "env:DKHTA_DIR        = ${env:DKHTA_DIR}";
	dk_call dk_echo "env:DKJAVA_DIR       = ${env:DKJAVA_DIR}";
	dk_call dk_echo "env:DKJAVASCRIPT_DIR = ${env:DKJAVASCRIPT_DIR}";
	dk_call dk_echo "env:DKPHP_DIR        = ${env:DKPHP_DIR}";
	dk_call dk_echo "env:DKPOWERSHELL_DIR = ${env:DKPOWERSHELL_DIR}";
	dk_call dk_echo "env:DKPYTHON_DIR     = ${env:DKPYTHON_DIR}";
	dk_call dk_echo "env:DKVB_DIR         = ${env:DKVB_DIR}";	
    dk_call dk_echo "dk_DKBRANCH_DIR      = '$(dk_call dk_DKBRANCH_DIR)'\n";
	
	###### SET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Setting DKBRANCH_DIR . . .\n";
	dk_call dk_DKBRANCH_DIR "C:/Users/Administrator/DigitalKnob/Development"
	dk_call dk_echo "env:DKBRANCH_DIR = ${env:DKBRANCH_DIR}"
	dk_call dk_echo "dk_DKBRANCH_DIR = '$(dk_call dk_DKBRANCH_DIR 'C:/Users/Administrator/DigitalKnob/Development')'\n";
}
