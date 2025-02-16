#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

##################################################################################
# dk_buildMain()
#
#
function(dk_buildMain)
	dk_debugFunc(0)

	# log to stdout and file
	# exec > >(tee DKBuilder.log)
	
#	dk_validateSudo
	
#	if(DEFINED ENV{WSL_DISTRO_NAME})
#		dk_info "WSLENV is on"
#		dk_info "calling sudo chown -R ${LOGNAME} ${HOME} to allow windows write access to \\\wsl.localhost\DISTRO\home\\${LOGNAME}"
#		sudo chown -R "${LOGNAME}" "${HOME}"
#	endif()

#	dk_printVar SHLVL		# https://stackoverflow.com/a/4511483/688352
	dk_assertPath(DKSCRIPT_DIR)
	
	while(1)
		if(NOT DEFINED ENV{UPDATE})
			dk_pickUpdate()
			continue()
		endif()
		if(NOT DEFINED target_app)
			dk_target_app()
			continue()
		endif()
		if(NOT DEFINED target_triple)
			dk_target_triple_SET()
			continue()
		endif()
		if(NOT DEFINED target_type)
			dk_target_type()
			continue()
		endif()
		
		dk_createCache()
		dk_generate()
		dk_buildApp()
		
		dk_unset(ENV{UPDATE})
		dk_unset(target_app)
		dk_unset(target_triple)
		dk_unset(target_type)
	endwhile()
endfunction()






function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc(0)
	
	dk_buildMain()
endfunction()