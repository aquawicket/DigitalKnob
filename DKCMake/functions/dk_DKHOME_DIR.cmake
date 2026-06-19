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


#########################################################################
# dk_DKHOME_DIR()
#
#
function(dk_DKHOME_DIR)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(DKHOME_DIR "${ARGV0}")


	###### GET ######
	else()
		############ from ENV{DKHOME_DIR} ############
		if(NOT EXISTS "${DKHOME_DIR}")
			if(DEFINED ENV{DKHOME_DIR})
				file(TO_CMAKE_PATH "$ENV{DKHOME_DIR}" DKHOME_DIR)
			endif()
		endif()

		########### from DKCMAKE_DIR ############
		if(NOT EXISTS "${DKHOME_DIR}")
			if(EXISTS "${DKCMAKE_DIR}")
				get_filename_component(DKBRANCH_DIR "${DKCMAKE_DIR}" DIRECTORY)
				if(EXISTS "${DKBRANCH_DIR}")
					get_filename_component(DIGITALKNOB_DIR "${DKBRANCH_DIR}" DIRECTORY)
					if(EXISTS "${DIGITALKNOB_DIR}")
						get_filename_component(DKHOME_DIR "${DIGITALKNOB_DIR}" DIRECTORY)
					endif()
				endif()
			endif()
		endif()
		
		########### from ENV{USERPROFILE} #############
		if(NOT EXISTS "${DKHOME_DIR}")
			if(DEFINED ENV{USERPROFILE})
				file(TO_CMAKE_PATH "$ENV{USERPROFILE}" DKHOME_DIR)
			endif()
		endif()
		
		########### from ENV{HOME} #############
		if(NOT EXISTS "${DKHOME_DIR}")
			if(DEFINED ENV{HOME})
				file(TO_CMAKE_PATH "$ENV{HOME}" DKHOME_DIR)
			endif()
		endif()
	
		########### from ENV{USERPROFILE} - cygpath_exe ###########
		if(NOT EXISTS "${DKHOME_DIR}")
			dk_validate(cygpath_exe "dk_depend(cygpath_exe)")
			execute_process(COMMAND "${cygpath_exe}" -u "$ENV{USERPROFILE}" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
		endif()
		
		########### from ENV{USERPROFILE} - wslpath_exe ###########
		if(NOT EXISTS "${DKHOME_DIR}")
			dk_validate(wslpath_exe "dk_depend(wslpath_exe)")
			execute_process(COMMAND "${wslpath_exe}" -u "$ENV{USERPROFILE}" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
		endif()

		########### from Unix ~ ############
		if(NOT EXISTS "${DKHOME_DIR}")
			if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.21")
				file(REAL_PATH "~" DKHOME_DIR EXPAND_TILDE) # EXPAND_TILDE - Added in version 3.21.
			else()
				dk_error("file(REAL_PATH) requires Cmake 3.21 or greater")
			endif()
		endif()
	endif()	
	
	

	###### FINALIZE ######
	if(NOT EXISTS "${DKHOME_DIR}")
		dk_fatal("DKHOME_DIR:'${DKHOME_DIR}' NOT FOUND")
		return()
	endif()
	
	#get_filename_component(DKHOME_DIR "${DKHOME_DIR}" REALPATH)
	dk_call( dk_set(DKHOME_DIR "${DKHOME_DIR}") )
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
 
	dk_echo()
	dk_echo("Test Getting DKHOME_DIR . . .")
	dk_DKHOME_DIR()
	if(EXISTS "${DKHOME_DIR}")
		dk_success("DKHOME_DIR = ${DKHOME_DIR}")
	else()
		dk_error("DKHOME_DIR:'${DKHOME_DIR}' NOT FOUND")
	endif()
	
#	dk_echo()
#	dk_echo("Test Setting DKHOME_DIR . . .")
#	dk_DKHOME_DIR("C:/")
#	if(EXISTS "${DKHOME_DIR}")
#		dk_success("DKHOME_DIR = ${DKHOME_DIR}")
#	else()
#		dk_error("DKHOME_DIR:'${DKHOME_DIR}' NOT FOUND")
#	endif()
endfunction()




#	###### cmd.exe ######
#	dk_validate(cmd.exe "dk_depend(cmd.exe)")
#	if(NOT EXISTS "${cmd.exe}")
#		dk_set(cmd.exe "/mnt/c/Windows/System32/cmd.exe")
#	endif()
	
#	if(NOT EXISTS "${cmd.exe}")
#		dk_warning("cmd.exe:${cmd.exe} NOT FOUND")
#	else()
#		dk_set(cmd.exe "${cmd.exe}")
#		dk_printVar(cmd.exe)
#	endif()

#	###### cygpath_exe ######
#	if(NOT EXISTS "${cygpath_exe}")
#		if(EXISTS "/usr/bin/cygpath.exe")
#			dk_set(cygpath_exe "/usr/bin/cygpath.exe")
#		endif()
#	endif()
#	if(cmd.exe)
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
#		dk_warning("cygpath_exe:${cygpath_exe} NOT FOUND")
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
#		dk_warning("wslpath_exe:${wslpath_exe} NOT FOUND")
#	else()
#		dk_set(wslpath_exe "${wslpath_exe}")		# Globalize the variable
#		dk_printVar(wslpath_exe)
#		set(ENV{wslpath_exe} "${wslpath_exe}")		# Set Environment Varible
#		dk_printVar(ENV{wslpath_exe})
#	endif()