#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

##################################################################################
# dk_buildMain()
#
#
function(dk_buildMain)
<<<<<<< HEAD
	dk_debugFunc()
	if(NOT ${ARGC} EQUAL 0)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
=======
	dk_debugFunc(0)
>>>>>>> Development

	# log to stdout and file
	# exec > >(tee DKBuilder.log)
	
#	dk_validateSudo
	
#	if(DEFINED ENV{WSL_DISTRO_NAME})
#		dk_info "WSLENV is on"
#		dk_info "calling sudo chown -R ${LOGNAME} ${HOME} to allow windows write access to \\\wsl.localhost\DISTRO\home\\${LOGNAME}"
#		sudo chown -R "${LOGNAME}" "${HOME}"
#	endif()

#	dk_printVar SHLVL		# https://stackoverflow.com/a/4511483/688352
<<<<<<< HEAD
#	dk_printVar MSYSTEM
#	#dk_printVar DKSCRIPT_PATH
#	#dk_printVar DKSCRIPT_DIR
#	#dk_printVar DKSCRIPT_NAME
	
	### Get the host_triple and other HOST variables
	dk_host_triple()
	
	dk_DIGITALKNOB_DIR()
	
	#dk_installGit()
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	dk_validate(GIT_EXE "dk_load('${DKIMPORTS_DIR}/git/DKMAKE.cmake')")
	
	dk_DKBRANCH_DIR()

	dk_assertPath(DKSCRIPT_DIR)
	dk_assertPath(DKBRANCH_DIR)
	
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
=======
	dk_assertPath($ENV{DKSCRIPT_DIR})
	
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
>>>>>>> Development
			continue()
		endif()
		
		dk_createCache()
		dk_generate()
		dk_buildApp()
		
<<<<<<< HEAD
		dk_unset(UPDATE)
		dk_unset(APP)
		dk_unset(target_triple)
		dk_unset(TYPE)
=======
		dk_unset(ENV{UPDATE})
		dk_unset(target_app)
		dk_unset(target_triple)
		dk_unset(target_type)
>>>>>>> Development
	endwhile()
endfunction()






function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_buildMain()
endfunction()