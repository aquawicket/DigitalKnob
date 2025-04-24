#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

####################################################################
# dk_DKHOME_DIR()
#
#
function(dk_DKHOME_DIR)
<<<<<<< HEAD
    dk_debugFunc()

	if(EXISTS "${DKHOME_DIR}")
		dk_debug("DKHOME_DIR:${DKHOME_DIR} already set")
		return()
	endif()
    
#	###### CMD_EXE ######
#	if(NOT EXISTS "${CMD_EXE}")
#		dk_findProgram(CMD_EXE cmd.exe)
#	endif()
=======
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		set(ENV{DKHOME_DIR} "${ARGV}")
		return()
	endif()


	###### GET ######
	if(EXISTS "$ENV{DKHOME_DIR}")
		dk_debug("ENV{DKHOME_DIR}:$ENV{DKHOME_DIR} already set")
		return()
	endif()

#	###### CMD_EXE ######
#	dk_validate(CMD_EXE "dk_CMD_EXE()")
>>>>>>> Development
#	if(NOT EXISTS "${CMD_EXE}")
#		dk_set(CMD_EXE "/mnt/c/Windows/System32/cmd.exe")
#	endif()
#	if(NOT EXISTS "${CMD_EXE}")
#		dk_warning("CMD_EXE:${CMD_EXE} not found")
#	else()
#		dk_set(CMD_EXE "${CMD_EXE}")				# Globalize the variable
#		dk_printVar(CMD_EXE)
#		set(ENV{CMD_EXE} "${CMD_EXE}")				# Set Environment Varible
#		dk_printVar(ENV{CMD_EXE})
#	endif()
<<<<<<< HEAD
	
=======

>>>>>>> Development
#	###### CYGPATH_EXE ######
#	if(NOT EXISTS "${CYGPATH_EXE}")
#		if(CMD_EXE)
#			execute_process(COMMAND where /R C:\\Users\\Administrator cygpath.exe OUTPUT_VARIABLE CYGPATH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
#		endif()
#	endif()
#	if(NOT EXISTS "${CYGPATH_EXE}")
#		execute_process(COMMAND $ENV{DKSHELL} -c "command -v cygpath" OUTPUT_VARIABLE CYGPATH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
#	endif()
#	if(NOT EXISTS "${CYGPATH_EXE}")
#		dk_findProgram(CYGPATH_EXE cygpath.exe)
#	endif()
#	if(NOT EXISTS "${CYGPATH_EXE}")
#		dk_warning("CYGPATH_EXE:${CYGPATH_EXE} not found")
#	else()
#		dk_set(CYGPATH_EXE "${CYGPATH_EXE}")		# Globalize the variable
#		dk_printVar(CYGPATH_EXE)
#		set(ENV{CYGPATH_EXE} "${CYGPATH_EXE}")		# Set Environment Varible
#		dk_printVar(ENV{CYGPATH_EXE})
#	endif()
<<<<<<< HEAD
	
=======

>>>>>>> Development
#	###### WSLPATH_EXE ######
#	if(NOT EXISTS "${WSLPATH_EXE}")
#		dk_findProgram(WSLPATH_EXE wslpath)
#	endif()
#	if(NOT EXISTS "${WSLPATH_EXE}")
#		dk_warning("WSLPATH_EXE:${WSLPATH_EXE} not found")
#	else()
#		dk_set(WSLPATH_EXE "${WSLPATH_EXE}")		# Globalize the variable
#		dk_printVar(WSLPATH_EXE)
#		set(ENV{WSLPATH_EXE} "${WSLPATH_EXE}")		# Set Environment Varible
#		dk_printVar(ENV{WSLPATH_EXE})
#	endif()
<<<<<<< HEAD
	
	dk_validate(CMD_EXE "dk_CMD_EXE()")
	
	###### DKHOME_DIR ######
	if(NOT EXISTS "${DKHOME_DIR}")
		dk_debug("setting DKHOME_DIR from environment variable DKHOME_DIR:$ENV{DKHOME_DIR}")
		set(DKHOME_DIR "$ENV{DKHOME_DIR}")
	endif()
	if(NOT EXISTS "${DKHOME_DIR}")
		if(CMD_EXE)
			
			execute_process(COMMAND ${CMD_EXE} /c "echo %USERPROFILE%" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
			dk_printVar(DKHOME_DIR)
		endif()
#		if(CYGPATH_EXE)
#			dk_debug("setting DKHOME_DIR from CYGPATH of %USERPROFILE%")
#			execute_process(COMMAND ${CYGPATH_EXE} -u "${DKHOME_DIR}" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
#		elseif(WSLPATH_EXE)
#			dk_debug("setting DKHOME_DIR from WSLPATH of %USERPROFILE%")
#			execute_process(COMMAND ${WSLPATH_EXE} -u "${DKHOME_DIR}" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
#		else()
#			dk_debug("setting DKHOME_DIR from CMAKE NATIVE PATH of %USERPROFILE%")
#			cmake_path(NATIVE_PATH DKHOME_DIR NORMALIZE DKHOME_DIR)
#		endif()
	endif()
	if(NOT EXISTS "${DKHOME_DIR}")
		dk_debug("setting DKHOME_DIR from environment variable ENV{USERPROFILE}:$ENV{USERPROFILE}")
		set(DKHOME_DIR "$ENV{USERPROFILE}")
	endif()
	if(NOT EXISTS "${DKHOME_DIR}")
		dk_debug("setting DKHOME_DIR from environment variable ENV{HOME}:$ENV{HOME}")
		set(DKHOME_DIR "$ENV{HOME}")
	endif()
    if(NOT EXISTS "${DKHOME_DIR}")
		dk_fatal("DKHOME_DIR:${DKHOME_DIR} not found")
	else()
		dk_debug("setting DKHOME_DIR with TO_CMAKE_PATH of ${DKHOME_DIR}")
		file(TO_CMAKE_PATH "${DKHOME_DIR}" DKHOME_DIR)
		
		dk_set(DKHOME_DIR "${DKHOME_DIR}")				# Globalize the variable
		dk_printVar(DKHOME_DIR)
		set(ENV{DKHOME_DIR} "${DKHOME_DIR}")			# Set Environment Varible
		dk_printVar(ENV{DKHOME_DIR})
	endif()
	
	###### DKCACHE_DIR ######
	if(NOT EXISTS "${DKCACHE_DIR}")
		set(DKCACHE_DIR "${DKHOME_DIR}/.dk")
	endif()
	if(NOT EXISTS "${DKCACHE_DIR}")
		dk_makeDirectory("${DKCACHE_DIR}")
	endif()
	if(NOT EXISTS "${DKCACHE_DIR}")
		dk_fatal("DKCACHE_DIR:${DKCACHE_DIR} not found")
	else()
		dk_set(DKCACHE_DIR "${DKCACHE_DIR}")			# Globalize the variable
		dk_printVar(DKCACHE_DIR)
		set(ENV{DKCACHE_DIR} "${DKCACHE_DIR}")			# Set Environment Varible
		dk_printVar(ENV{DKCACHE_DIR})
	endif()
	
	###### DKDESKTOP_DIR ######
	if(NOT EXISTS "${DKDESKTOP_DIR}") 
		set(DKDESKTOP_DIR "${DKHOME_DIR}/Desktop")
	endif()
	if(NOT EXISTS "${DKDESKTOP_DIR}") 
		dk_warning("DKDESKTOP_DIR:${DKDESKTOP_DIR} not found")
	else()
		dk_set(DKDESKTOP_DIR "${DKDESKTOP_DIR}")		# Globalize the variable
		dk_printVar(DKDESKTOP_DIR)
		set(ENV{DKDESKTOP_DIR} "${DKDESKTOP_DIR}")		# Set Environment Varible
		dk_printVar(ENV{DKDESKTOP_DIR})
=======

#	dk_validate(CMD_EXE "dk_CMD_EXE()")

	###### DKHOME_DIR ######
#	if(NOT EXISTS "$ENV{DKHOME_DIR}")
#		dk_debug("setting DKHOME_DIR from environment variable ENV{DKHOME_DIR}:$ENV{DKHOME_DIR}")
#		set(DKHOME_DIR "$ENV{DKHOME_DIR}")
#	endif()

#	if(NOT EXISTS "$ENV{DKHOME_DIR}")
#		if(CYGPATH_EXE)
#			dk_debug("setting DKHOME_DIR from CYGPATH of %USERPROFILE%")
#			execute_process(COMMAND ${CYGPATH_EXE} -u "$ENV{DKHOME_DIR}" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
#		elseif(WSLPATH_EXE)
#			dk_debug("setting DKHOME_DIR from WSLPATH of %USERPROFILE%")
#			execute_process(COMMAND ${WSLPATH_EXE} -u "$ENV{DKHOME_DIR}" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
#		elseif(CMD_EXE)
#			dk_nativePath("${CMD_EXE}" CMD_EXE)	
#			dk_debug("setting DKHOME_DIR from CMD_EXE of %USERPROFILE%")
#			execute_process(COMMAND ${CMD_EXE} /c "echo %USERPROFILE%" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
#		else()
#			dk_debug("setting DKHOME_DIR from CMAKE NATIVE PATH of %USERPROFILE%")
#			execute_process(COMMAND ${CMD_EXE} /c "echo %USERPROFILE%" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
#			#cmake_path(NATIVE_PATH DKHOME_DIR NORMALIZE DKHOME_DIR)
#			dk_nativePath("$ENV{DKHOME_DIR}" DKHOME_DIR)
#			set(ENV{DKHOME_DIR} $ENV{DKHOME_DIR})
#		endif()
#	endif()

	if(NOT EXISTS "$ENV{DKHOME_DIR}")
		file(REAL_PATH "~" DKHOME_DIR EXPAND_TILDE) # EXPAND_TILDE - Added in version 3.21.
		set(ENV{DKHOME_DIR} ${DKHOME_DIR})
	endif()
#	if(NOT EXISTS "$ENV{DKHOME_DIR}")
#		set(ENV{DKHOME_DIR} "$ENV{USERPROFILE}")
#	endif()
#	if(NOT EXISTS "$ENV{DKHOME_DIR}")
#		set(ENV{DKHOME_DIR} "$ENV{HOME}")
#	endif()
	
	if(NOT EXISTS "$ENV{DKHOME_DIR}")
		dk_fatal("ENV{DKHOME_DIR}:$ENV{DKHOME_DIR} not found")
#	else()
#		file(TO_CMAKE_PATH "$ENV{DKHOME_DIR}" DKHOME_DIR)
#		set(ENV{DKHOME_DIR} "$ENV{DKHOME_DIR}")
>>>>>>> Development
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
    dk_debugFunc()
 
    dk_DKHOME_DIR()
    dk_printVar(DKHOME_DIR)
	dk_printVar(DKCACHE_DIR)
	dk_printVar(DKDESKTOP_DIR)
=======
	dk_debugFunc(0)
 
	dk_echo()
	dk_echo("Test Getting DKHOME_DIR . . .")
	dk_validate(ENV{DKHOME_DIR} "dk_DKHOME_DIR()")
	dk_echo("ENV{DKHOME_DIR} = $ENV{DKHOME_DIR}")
	
	dk_echo()
	dk_echo("Test Setting DKHOME_DIR . . .")
	dk_DKHOME_DIR("C:/")
	dk_echo("ENV{DKHOME_DIR} = $ENV{DKHOME_DIR}")
>>>>>>> Development
endfunction()
