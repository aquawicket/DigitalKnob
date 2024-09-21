include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_buildMain()
#
#
function(dk_buildMain)
	dk_debugFunc("\${ARGV}")
	if(NOT ${ARGC} EQUAL 0)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()

	# log to stdout and file
	# exec > >(tee DKBuilder.log)
	
#	dk_validateSudo
	
#	if dk_defined WSLENV; then 
#		dk_info "WSLENV is on"
#		dk_info "calling sudo chown -R ${LOGNAME} ${HOME} to allow windows write access to \\\wsl.localhost\DISTRO\home\\${LOGNAME}"
#		sudo chown -R "${LOGNAME}" "${HOME}"
#	fi

#	dk_printVar SHLVL		# https://stackoverflow.com/a/4511483/688352
#	dk_printVar MSYSTEM
#	#dk_printVar DKSCRIPT_PATH
#	#dk_printVar DKSCRIPT_DIR
#	#dk_printVar DKSCRIPT_NAME
	
	### Get the HOST_TRIPLE and other HOST variables
	dk_HOST_TRIPLE()
	
	dk_getDKPaths()

	dk_installGit()
	dk_validateBranch()

	#dk_printVar DKBRANCH_DIR
	#dk_printVar DKAPPS_DIR
	#dk_printVar DKCMAKE_DIR
	#dk_printVar DK3RDPARTY_DIR
	#dk_printVar DKIMPORTS_DIR
	#dk_printVar DKPLUGINS_DIR

	if(NOT "${DKSCRIPT_DIR}" STREQUAL "${DKBRANCH_DIR}")
		dk_warning("${DKSCRIPT_NAME} is not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!")
		dk_warning("${DKSCRIPT_NAME} path = ${DKSCRIPT_DIR}")
		dk_warning("DKBRANCH_DIR path = ${DKBRANCH_DIR}")
	endif()
	
	while(1)
		if(NOT DEFINED UPDATE)
			dk_pickUpdate()
			continue()
		endif()
		if(NOT DEFINED APP)
			dk_pickApp()
			continue()
		endif()
		if(NOT DEFINED target_triple)
			dk_pickOs()
			continue()
		endif()
		if(NOT DEFINED TYPE)
			dk_pickType()
			continue()
		endif()
		
		dk_createCache()
		dk_generate()
		dk_build()
		
		dk_unset(UPDATE)
		dk_unset(APP)
		dk_unset(target_triple)
		dk_unset(TYPE)
	endwhile()
endfunction()






function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc("\${ARGV}")
	
	dk_buildMain()
endfunction()