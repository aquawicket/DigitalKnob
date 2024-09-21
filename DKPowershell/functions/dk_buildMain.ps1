if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_buildMain){ $dk_buildMain = 1 } else{ return }

####################################################################
# dk_buildMain()
#
#
function Global:dk_buildMain() {
	dk_debugFunc 0

	trap {
		"Error found: $_"
		dk_call dk_stacktrace
	}

# 	dk_call dk _validateSudo
	
#	if dk _defined WSLENV; then 
#		dk_call dk_info "WSLENV is on"
#		dk_call dk_info "calling sudo chown -R ${LOGNAME} ${HOME} to allow windows write access to \\\wsl.localhost\DISTRO\home\\${LOGNAME}"
#		sudo chown -R "${LOGNAME}" "${HOME}"
#	fi

	dk_call dk_printVar SHLVL
	dk_call dk_printVar MSYSTEM
	#dk_call dk_printVar DKSCRIPT_PATH
	#dk_call dk_printVar DKSCRIPT_DIR
	#dk_call dk_printVar DKSCRIPT_NAME
	
	### Get the HOST_TRIPLE and other HOST variables
	dk_call dk_getHostTriple
	dk_call dk_getDKPaths
	dk_call dk_installGit
	dk_call dk_validateBranch
	
	if("${DKSCRIPT_DIR}" -ne "${DKBRANCH_DIR}"){
		dk_call dk_warning "${DKSCRIPT_NAME} is not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!"
		dk_call dk_warning "${DKSCRIPT_NAME} path = ${DKSCRIPT_DIR}"
		dk_call dk_warning "DKBRANCH_DIR path = ${DKBRANCH_DIR}"
	}
	
	$running=1
	while($running){  
		if(!${UPDATE})    { dk_call dk_pickUpdate;  continue; }
		if(!${APP})       { dk_call dk_pickApp;     continue; }
		if(!${TARGET_OS}) { dk_call dk_pickOs;      continue; }
		if(!${TYPE})      { dk_call dk_pickType;    continue; }
		
		dk_call dk_createCache
		dk_call dk_generate	
		dk_call dk_buildApp
		
		dk_call dk_unset UPDATE
		dk_call dk_unset APP
		dk_call dk_unset TARGET_OS
		dk_call dk_unset TYPE
	}  
}

