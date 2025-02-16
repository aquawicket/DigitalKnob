if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_DKBRANCH_DIR){ $dk_DKBRANCH_DIR = 1 } else{ return } #include guard

##################################################################################
# dk_DKBRANCH_DIR()
#
#
function Global:dk_DKBRANCH_DIR() {
	dk_debugFunc 0 1
	
	############ SET ############
	if($($args[0])){  
		$global:DKBRANCH_DIR = "$($args[0])" 
		return 0
	}
	
	############ GET ############
	# If the current folder matches the current branch set DKBRANCH, default to Development
	$FOLDER = dk_call dk_basename "$(pwd)"
	$global:DKBRANCH="Development"
	
	dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR"
	if(dk_call dk_pathExists "${DIGITALKNOB_DIR}/${FOLDER}/.git"){
		$global:BRANCH=$("${GIT_EXE} rev-parse --abbrev-ref HEAD")
		if("${BRANCH}" -eq "${FOLDER}"){
			$global:DKBRANCH="${FOLDER}"
		}
	}
	
	$global:DKBRANCH_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}"
	dk_call dk_assertPath DKBRANCH_DIR
	
		$global:DK3RDPARTY_DIR="${DKBRANCH_DIR}/3rdParty"
		dk_call dk_assertPath DK3RDPARTY_DIR
		
			$global:DKIMPORTS_DIR="${DK3RDPARTY_DIR}/_DKIMPORTS"
			dk_call dk_assertPath DKIMPORTS_DIR
		
		$global:DKCPP_APPS_DIR="${DKBRANCH_DIR}/DKCpp/apps"
		dk_call dk_assertPath DKCPP_APPS_DIR
		
		$global:DKBASH_DIR="${DKBRANCH_DIR}/DKBash"
		dk_call dk_assertPath DKBASH_DIR
			$global:DKBASH_FUNCTIONS_DIR="${DKBASH_DIR}/functions"
			dk_call dk_assertPath DKBASH_FUNCTIONS_DIR
			$global:DKBASH_FUNCTIONS_DIR_="${DKBASH_FUNCTIONS_DIR}/"
			dk_call dk_assertPath DKBASH_FUNCTIONS_DIR_
			
		$global:DKBATCH_DIR="${DKBRANCH_DIR}/DKBatch"
		dk_call dk_assertPath DKBATCH_DIR
			$global:DKBATCH_FUNCTIONS_DIR="${DKBATCH_DIR}/functions"
			dk_call dk_assertPath DKBATCH_FUNCTIONS_DIR
			$global:DKBATCH_FUNCTIONS_DIR_="${DKBATCH_FUNCTIONS_DIR}/"
			dk_call dk_assertPath DKBATCH_FUNCTIONS_DIR_
			
		$global:DKC_DIR="${DKBRANCH_DIR}/DKC"
		dk_call dk_assertPath DKC_DIR
			$global:DKC_FUNCTIONS_DIR="${DKC_DIR}/functions"
			dk_call dk_assertPath DKC_FUNCTIONS_DIR
			$global:DKC_FUNCTIONS_DIR_="${DKC_FUNCTIONS_DIR}/"
			dk_call dk_assertPath DKC_FUNCTIONS_DIR_
		
		$global:DKCMAKE_DIR="${DKBRANCH_DIR}/DKCMake"
		dk_call dk_assertPath DKCMAKE_DIR
			$global:DKCMAKE_FUNCTIONS_DIR="${DKCMAKE_DIR}/functions"
			dk_call dk_assertPath DKCMAKE_FUNCTIONS_DIR
			$global:DKCMAKE_FUNCTIONS_DIR_="${DKCMAKE_FUNCTIONS_DIR}/"
			dk_call dk_assertPath DKCMAKE_FUNCTIONS_DIR_
			
		$global:DKCPP_DIR="${DKBRANCH_DIR}/DKCpp"
		dk_call dk_assertPath DKCPP_DIR
			$global:DKCPP_APPS_DIR="${DKCPP_DIR}/apps"
			dk_call dk_assertPath DKCPP_APPS_DIR
			$global:DKCPP_FUNCTIONS_DIR="${DKCPP_DIR}/functions"
			dk_call dk_assertPath DKCPP_FUNCTIONS_DIR
			$global:DKCPP_FUNCTIONS_DIR_="${DKCPP_FUNCTIONS_DIR}/"
			dk_call dk_assertPath DKCPP_FUNCTIONS_DIR_
			
		$global:DKCSHARP_DIR="${DKBRANCH_DIR}/DKCSharp"
		dk_call dk_assertPath DKCSHARP_DIR
			$global:DKCSHARP_FUNCTIONS_DIR="${DKCSHARP_DIR}/functions"
			dk_call dk_assertPath DKCSHARP_FUNCTIONS_DIR
			$global:DKCSHARP_FUNCTIONS_DIR_="${DKCSHARP_FUNCTIONS_DIR}/"
			dk_call dk_assertPath DKCSHARP_FUNCTIONS_DIR_
			
		$global:DKHTA_DIR="${DKBRANCH_DIR}/DKHta"
		dk_call dk_assertPath DKHTA_DIR
			$global:DKHTA_FUNCTIONS_DIR="${DKHTA_DIR}/functions"
			#dk_call dk_assertPath DKHTA_FUNCTIONS_DIR
			$global:DKHTA_FUNCTIONS_DIR_="${DKHTA_FUNCTIONS_DIR}/"
			#dk_call dk_assertPath DKHTA_FUNCTIONS_DIR_
		
		$global:DKJAVA_DIR="${DKBRANCH_DIR}/DKJava"
		dk_call dk_assertPath DKJAVA_DIR
			$global:DKJAVA_FUNCTIONS_DIR="${DKJAVA_DIR}/functions"
			dk_call dk_assertPath DKJAVA_FUNCTIONS_DIR
			$global:DKJAVA_FUNCTIONS_DIR_="${DKJAVA_FUNCTIONS_DIR}/"
			dk_call dk_assertPath DKJAVA_FUNCTIONS_DIR_
		
		$global:DKJAVASCRIPT_DIR="${DKBRANCH_DIR}/DKJavascript"
		dk_call dk_assertPath DKJAVASCRIPT_DIR
			$global:DKJAVASCRIPT_FUNCTIONS_DIR="${DKJAVASCRIPT_DIR}/functions"
			dk_call dk_assertPath DKJAVASCRIPT_FUNCTIONS_DIR
			$global:DKJAVASCRIPT_FUNCTIONS_DIR_="${DKJAVASCRIPT_FUNCTIONS_DIR}/"
			dk_call dk_assertPath DKJAVASCRIPT_FUNCTIONS_DIR_
		
		$global:DKPHP_DIR="${DKBRANCH_DIR}/DKPhp"
		dk_call dk_assertPath DKPHP_DIR
			$global:DKPHP_FUNCTIONS_DIR="${DKPHP_DIR}/functions"
			dk_call dk_assertPath DKPHP_FUNCTIONS_DIR
			$global:DKPHP_FUNCTIONS_DIR_="${DKPHP_FUNCTIONS_DIR}/"
			dk_call dk_assertPath DKPHP_FUNCTIONS_DIR_
		
		$global:DKPLUGINS_DIR="${DKBRANCH_DIR}/DKPlugins"
		dk_call dk_assertPath DKPLUGINS_DIR
		
		$global:DKPOWERSHELL_DIR="${DKBRANCH_DIR}/DKPowershell"
		dk_call dk_assertPath DKPOWERSHELL_DIR
			$global:DKPOWERSHELL_FUNCTIONS_DIR="${DKPOWERSHELL_DIR}/functions"
			dk_call dk_assertPath DKPOWERSHELL_FUNCTIONS_DIR
			$global:DKPOWERSHELL_FUNCTIONS_DIR_="${DKPOWERSHELL_FUNCTIONS_DIR}/"
			dk_call dk_assertPath DKPOWERSHELL_FUNCTIONS_DIR_
		
		$global:DKPYTHON_DIR="${DKBRANCH_DIR}/DKPython"
		dk_call dk_assertPath DKPYTHON_DIR
			$global:DKPYTHON_FUNCTIONS_DIR="${DKPYTHON_DIR}/functions"
			dk_call dk_assertPath DKPYTHON_FUNCTIONS_DIR
			$global:DKPYTHON_FUNCTIONS_DIR_="${DKPYTHON_FUNCTIONS_DIR}/"
			dk_call dk_assertPath DKPYTHON_FUNCTIONS_DIR_
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKBRANCH_DIR . . ."
    dk_call dk_DKBRANCH_DIR
    dk_call dk_printVar DKBRANCH_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKBRANCH_DIR . . ."
	dk_call dk_DKBRANCH_DIR "C:/DK/Development"
	dk_call dk_printVar DKBRANCH_DIR 
}
