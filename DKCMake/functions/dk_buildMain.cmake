#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
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
	dk_assertPath($ENV{DKSCRIPT_DIR})
	
	while(1)
		if(NOT DEFINED ENV{UPDATE})
			dk_pickUpdate()
			continue()
		endif()
		if(NOT DEFINED Target_App)
			dk_target_app()
			continue()
		endif()
		if(NOT DEFINED Target_Tuple)
			dk_Target_Tuple()
			continue()
		endif()
		if(NOT DEFINED Target_Type)
			dk_Target_Type()
			continue()
		endif()
		
		dk_createCache()
		dk_generate()
		dk_buildApp()
		
		dk_unset(ENV{UPDATE})
		dk_unset(Target_App)
		dk_unset(Target_Tuple)
		dk_unset(Target_Type)
	endwhile()
endfunction()






function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc(0)
	
	dk_buildMain()
endfunction()