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


#########################################################################
# DKHOME_DIR()
#
#
function(DKHOME_DIR)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(DKHOME_DIR "${ARGV0}")

	###### GET ######
	elseif(DEFINED ENV{DKHOME_DIR})	
		dk_set(DKHOME_DIR "$ENV{DKHOME_DIR}")
	
	else()

		############ from ENV{DKHOME_DIR} ############
		if(NOT EXISTS "${DKHOME_DIR}")
			set(DKHOME_DIR "$ENV{DKHOME_DIR}")
		endif()

		########### from CMD #############
		if(NOT EXISTS "${DKHOME_DIR}")
			file(TO_CMAKE_PATH "$ENV{USERPROFILE}" DKHOME_DIR)
		endif()
	
		########### from MSYS ###########
		if(NOT EXISTS "${DKHOME_DIR}")
			set(cygpath_exe "/usr/bin/cygpath.exe")
			if(EXISTS "${cygpath_exe}")
				execute_process(COMMAND ${cygpath_exe} -u "$ENV{USERPROFILE}" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
			endif()
		endif()
		
		########### from WSL ###########
		if(NOT EXISTS "${DKHOME_DIR}")
			set(wslpath_exe "wsl.exe")
			if(EXISTS "${wslpath_exe}")
				execute_process(COMMAND ${wslpath_exe} -u "$ENV{USERPROFILE}" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
			endif()
		endif()

		########### from Unix ############
		if(NOT EXISTS "${DKHOME_DIR}")
			file(REAL_PATH "~" DKHOME_DIR EXPAND_TILDE) # EXPAND_TILDE - Added in version 3.21.
		endif()
	endif()	

	###### FINALIZE ######
	if(NOT EXISTS "${DKHOME_DIR}")
		dk_fatal("DKHOME_DIR:'${DKHOME_DIR}' not found")
	endif()
	
	dk_set(DKHOME_DIR "${DKHOME_DIR}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
 
	dk_echo()
	dk_echo("Test Getting DKHOME_DIR . . .")
	DKHOME_DIR()
	if(EXISTS "${DKHOME_DIR}")
		dk_success("DKHOME_DIR = ${DKHOME_DIR}")
	else()
		dk_error("DKHOME_DIR:'${DKHOME_DIR}' not found")
	endif()
	
	dk_echo()
	dk_echo("Test Setting DKHOME_DIR . . .")
	DKHOME_DIR("C:/")
	if(EXISTS "${DKHOME_DIR}")
		dk_success("DKHOME_DIR = ${DKHOME_DIR}")
	else()
		dk_error("DKHOME_DIR:'${DKHOME_DIR}' not found")
	endif()
endfunction()




#	###### cygpath_exe ######
#	if(NOT EXISTS "${cygpath_exe}")
#		if(EXISTS "/usr/bin/cygpath.exe")
#			dk_set(cygpath_exe "/usr/bin/cygpath.exe")
#		endif()
#	endif()
#	if(cmd_exe)
#			execute_process(COMMAND where /R C:\\Users\\Administrator cygpath.exe OUTPUT_VARIABLE cygpath_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
#			dk_printVar(cygpath_exe)
#		endif()
#	endif()
#	if(NOT EXISTS "${cygpath_exe}")
#		execute_process(COMMAND $ENV{DKSHELL} -c "command -v cygpath" OUTPUT_VARIABLE cygpath_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
#	endif()
#	if(NOT EXISTS "${cygpath_exe}")
#		dk_findProgram(cygpath_exe cygpath.exe)
#	endif()
#	if(NOT EXISTS "${cygpath_exe}")
#		dk_warning("cygpath_exe:${cygpath_exe} not found")
#	else()
#		dk_set(cygpath_exe "${cygpath_exe}")		# Globalize the variable
#		dk_printVar(cygpath_exe)
#		set(ENV{cygpath_exe} "${cygpath_exe}")		# Set Environment Varible
#		dk_printVar(ENV{cygpath_exe})
#	endif()

#	###### wslpath_exe ######
#	if(NOT EXISTS "${wslpath_exe}")
#		dk_findProgram(wslpath_exe wslpath)
#	endif()
#	if(NOT EXISTS "${wslpath_exe}")
#		dk_warning("wslpath_exe:${wslpath_exe} not found")
#	else()
#		dk_set(wslpath_exe "${wslpath_exe}")		# Globalize the variable
#		dk_printVar(wslpath_exe)
#		set(ENV{wslpath_exe} "${wslpath_exe}")		# Set Environment Varible
#		dk_printVar(ENV{wslpath_exe})
#	endif()