#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################



####################################################################
# DKINSTALL()
#
#
function(DKINSTALL)
	dk_debugFunc(0 1)

	### Test if already valid
#	if(EXISTS "${System32}")
#		if(NOT ${exit_code})
#			return()
#		endif()
#	endif()

	########### from $ENV{windir}/System32 #############
	if(NOT EXISTS "${System32}")
		file(TO_CMAKE_PATH "$ENV{windir}\\System32" System32)
	endif()

	### Test exists
	if(NOT EXISTS "${System32}") 
		dk_notice("System32:${System32} NOT FOUND")
		return()
	endif()

	#dk_debug("System32 = ${System32}")
	dk_set(System32 "${System32}")
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_envList(PLUGIN POP)
	dk_unset(System32)
	
	dk_validate(System32 "dk_depend(System32)")
	dk_echo("System32 = ${System32}")
	
	dk_validate(System32 "dk_depend(System32)")
	dk_echo("System32 = ${System32}")
endfunction()	