#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################

####################################################################
# dk_BASH_EXE()
#
#
function(dk_BASH_EXE)
	dk_debugFunc()

	###### SET ######
	if(ARGV)
		dk_set(BASH_EXE "${ARGV0}")
		
	###### GET ######
	elseif(DEFINED ENV{BASH_EXE})	
		dk_set(BASH_EXE "$ENV{BASH_EXE}")
	
	else()
		### Already found ###
		if(EXISTS "${BASH_EXE}")
			dk_debug("BASH_EXE:${BASH_EXE} already set")
			return()
		endif()

		### from BASH_EXE environment variable ###
		if(NOT EXISTS "${BASH_EXE}")
			dk_set(CMD_EXE "$ENV{BASH_EXE}")
		endif()
		
		### from BASH environment variable ###
		if(NOT EXISTS "${BASH_EXE}")
			if("$ENV{BASH}" MATCHES "/bash")
				set(BASH_EXE "$ENV{BASH}")
			endif()
		endif()
		
		### from SHELL environment variable ###
		if(NOT EXISTS "${BASH_EXE}")
			if("$ENV{SHELL}" MATCHES "/bash")
				set(BASH_EXE "$ENV{SHELL}")
			endif()
		endif()
		
		### From command -v ###
		if(NOT EXISTS "${BASH_EXE}")
			execute_process(COMMAND command -v bash OUTPUT_VARIABLE BASH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
		endif()

		### from dk_findProgram in Msys2 ###
		if(NOT EXISTS "${BASH_EXE}")
			dk_validate(MSYS2 "dk_depend(msys2)")
			dk_findProgram(MSYS2_BASH_EXE bash "${msys2}/usr/bin")
			set(BASH_EXE ${msys2_BASH_EXE})
		endif()
	endif()
	
	### FINALIZE ###
	#file(TO_CMAKE_PATH "${BASH_EXE}" BASH_EXE)
	if(NOT EXISTS "${BASH_EXE}")
		dk_warning("BASH_EXE:${BASH_EXE} not found")
	else()
		dk_set(BASH_EXE "${BASH_EXE}") # Globalize the variable
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_echo()
	dk_echo("Test Getting BASH_EXE . . .")
	dk_BASH_EXE()
	if(EXISTS "${BASH_EXE}")
		dk_success("BASH_EXE = ${BASH_EXE}")
	else()
		dk_error("BASH_EXE = ${BASH_EXE}")
	endif()
	
	dk_echo()
	dk_echo("Test Setting BASH_EXE . . .")
	dk_BASH_EXE("C:/bash.exe")
	if(EXISTS "${BASH_EXE}")
		dk_success("BASH_EXE = ${BASH_EXE}")
	else()
		dk_error("BASH_EXE = ${BASH_EXE}")
	endif()
endfunction()
