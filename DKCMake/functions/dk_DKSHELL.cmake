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
## We are looking for a good way to determin the path type we should use at any given moment in CMake.
## Say for example we are on a Windows box, using cmd, calling wsl.  Cmake will need /mnt/c/ type paths
## Or if Wsl invokes cmd.exe /c, that instance will require C:\ type paths. 
## The path type should corrolate to the current shell type. And when we are in CMake, we will 
## need to test the default shell type of execute_process to get the CMake subshell type.
## Another path problem then needs to be delt with is, when we are in a bash shell, how to translate 
## the home path properly at any location, and or be able to convert sais path to the desired type.
##
##    I.E. 
##
##		      Unix =                          ${HOME}
##		   WINDOWS =					%USERPROFILE%
##			   cmd =				C:\Users\username 
##		  git bash =				/c/Users/username
##		msys2 bash =				/c/Users/username
##		  wsl bash =			/mnt/c/Users/username
##	   	linux bash =				   /home/username
##		MacOS bash =				  /Users/username
##	   termux bash = /data/data/com.termux/files/home
## 
## TEST: lets make a quick test the can be called from any shell, at any subshell level, and gets the correct path.
## Eventually we can expand on this class and add support for url's, xpaths, php, etc.
## Side note: maybe we can expand on dk_realpath to additionally meet these requirements.

#########################################################################
# dk_DKSHELL()
#
#
function(dk_DKSHELL)
	dk_debugFunc(0)
	
	#execute_process(COMMAND dk_polyglot OUTPUT_VARIABLE RAW_ECHO)
	#message(STATUS "RAW_ECHO = ${RAW_ECHO}")
	
	dk_unset(DKSHELL)
	dk_unset(DKSHELL_PATH)
	
	###### SET ######
	if(ARGV)
		dk_set(DKSHELL_PATH "${ARGV0}")

	###### GET ######
	else()
		if("$ENV{PROMPT}" STREQUAL "\$P\$G")
			dk_validate(cmd_exe "dk_depend(cmd_exe)")
			set(DKSHELL_PATH "${cmd_exe}")
		elseif("$ENV{PATHEXT}" MATCHES ";.CPL")
			dk_validate(powershell_exe "dk_depend(powershell_exe)")
			set(DKSHELL_PATH "${powershell_exe}")
		elseif(DEFINED ENV{BASH})
			dk_validate(bash_exe "dk_depend(bash_exe)")
			set(DKSHELL_PATH "${bash_exe}")
		elseif(DEFINED ENV{SHELL})
			if("$ENV{SHELL}" MATCHES "/bash")
				dk_validate(bash_exe "dk_depend(bash_exe)")
				set(DKSHELL_PATH "${bash_exe}")
			elseif("$ENV{SHELL}" MATCHES "/sh")
				dk_validate(sh_exe "dk_depend(sh_exe)")
				set(DKSHELL_PATH "${sh_exe}")
			else()
				message("UNKNOWN")
			endif()
		else()
			dk_fatal("dk_DKSHELL(): Could not determine shell type")
		endif()
	endif()
	
	###### FINALIZE ######
	dk_assertPath("${DKSHELL_PATH}")
	dk_basename("${DKSHELL_PATH}" DKShell_Basename)
	dk_removeExtension("${DKShell_Basename}" DKShell_Name)
	
	set(DKSHELL "${DKShell_Name}")
	set(DKSHELL "${DKSHELL}" PARENT_SCOPE)
	set(${DKSHELL}_SHELL 1 PARENT_SCOPE)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	### Run in CMD terminal ###
# 	C:/Users/Administrator/DigitalKnob/DKTools/cmake-3.29.5-windows-x86_64/bin/cmake.exe -P C:/Users/Administrator/DigitalKnob/Development/DKCMake/functions/dk_DKSHELL.cmake
	
	### Run in POWERSHELL terminal ###
# 	C:/Users/Administrator/DigitalKnob/DKTools/cmake-3.29.5-windows-x86_64/bin/cmake.exe -P C:/Users/Administrator/DigitalKnob/Development/DKCMake/functions/dk_DKSHELL.cmake
	
	### Run in SH terminal ###
# 	cd /c/Users/Administrator/DigitalKnob/Development/DKCMake/functions && ./dk_DKSHELL.cmake
	
	### Run in BASH terminal ###
# 	cd /c/Users/Administrator/DigitalKnob/Development/DKCMake/functions && ./dk_DKSHELL.cmake
	
	dk_DKSHELL()
	message("DKSHELL = ${DKSHELL}")
	
	dk_echo()
	dk_echo("Test Getting DKSHELL_PATH . . .")
	dk_DKSHELL()
	if(EXISTS "${DKSHELL_PATH}")
		dk_success("DKSHELL = ${DKSHELL}")
		dk_success("DKSHELL_PATH = ${DKSHELL_PATH}")
	else()
		dk_error("DKSHELL_PATH:'${DKSHELL_PATH}' not found")
	endif()

	dk_echo()
	dk_echo("Test Setting DKSHELL_PATH . . .")
	dk_DKSHELL("C:/cmd.exe")
	if(EXISTS "${DKSHELL_PATH}")
		dk_success("DKSHELL = ${DKSHELL}")
		dk_success("DKSHELL_PATH = ${DKSHELL_PATH}")
	else()
		dk_error("DKSHELL_PATH:'${DKSHELL_PATH}' not found")
	endif()
	
endfunction()
