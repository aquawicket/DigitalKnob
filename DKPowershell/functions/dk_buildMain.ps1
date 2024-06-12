if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_buildMain){ $dk_buildMain = 1 } else{ return }

dk_load dk_debugFunc
dk_load dk_printVar
dk_load dk_warning
dk_load dk_getHostTriple
dk_load dk_getDKPaths
dk_load dk_validateGit
dk_load dk_validateBranch
dk_load dk_warning
dk_load dk_pickUpdate
dk_load dk_pickApp
dk_load dk_pickOs
dk_load dk_pickType
dk_load dk_createCache
dk_load dk_generate
dk_load dk_build
dk_load dk_unset
dk_load dk_stacktrace
####################################################################
# dk_buildMain()
#
#
function Global:dk_buildMain() {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }


	trap {
		"Error found: $_"
		dk_stacktrace
	}

# 	dk_validateSudo
	
#	if dk_defined WSLENV; then 
#		dk_info "WSLENV is on"
#		dk_info "calling sudo chown -R ${LOGNAME} ${HOME} to allow windows write access to \\\wsl.localhost\DISTRO\home\\${LOGNAME}"
#		sudo chown -R "${LOGNAME}" "${HOME}"
#	fi

	dk_printVar SHLVL		# https://stackoverflow.com/a/4511483/688352
	dk_printVar MSYSTEM
	#dk_printVar DKSCRIPT_PATH
	#dk_printVar DKSCRIPT_DIR
	#dk_printVar DKSCRIPT_NAME
	
	### Get the HOST_TRIPLE and other HOST variables
	dk_getHostTriple
	dk_getDKPaths
	dk_validateGit
	dk_validateBranch
	
	if("${DKSCRIPT_DIR}" -ne "${DKBRANCH_DIR}"){
		dk_warning "${DKSCRIPT_NAME} is not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!"
		dk_warning "${DKSCRIPT_NAME} path = ${DKSCRIPT_DIR}"
		dk_warning "DKBRANCH_DIR path = ${DKBRANCH_DIR}"
	}
	
	$running=1
	while($running){  
		if(!${UPDATE})    { dk_pickUpdate;  continue; }
		if(!${APP})       { dk_pickApp;     continue; }
		if(!${TARGET_OS}) { dk_pickOs;      continue; }
		if(!${TYPE})      { dk_pickType;    continue; }
		
		dk_createCache
		dk_generate	
		dk_build
		
		dk_unset UPDATE
		dk_unset APP
		dk_unset TARGET_OS
		dk_unset TYPE
	}  
}

