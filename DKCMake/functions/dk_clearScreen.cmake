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
# dk_clearScreen()
#
#	Clear the terminal
#
function(dk_clearScreen)
	dk_debugFunc()
	
#	### pwsh ###
#	dk_depend(pwsh)
#	if(pwsh_exe)
#		#dk_exec(${pwsh_exe} clear)
#		execute_process(COMMAND ${pwsh_exe} clear) # faster
#		return()
#	endif()
	
	### powershell ###
	find_program(powershell_exe powershell.exe)
	#dk_depend(powershell_exe)
	if(powershell_exe)
		#dk_exec(${powershell_exe} clear)
		execute_process(COMMAND ${powershell_exe} clear) # faster
		return()
	endif()
	
#	### cmd ###	
#	dk_validate(cmd_exe "dk_depend(cmd_exe)")
#	if(cmd_exe)
#		dk_exec(cls)  					# FIXME: only clears 1 line
#		execute_process(COMMAND cls)  	# FIXME: only clears 1 line
#		return()
#	endif()

#	### sh ###
#	dk_depend(sh)
#	if(sh_exe)
#		#dk_exec(clear)
#		execute_process(COMMAND clear) # faster
#		return()
#	endif()
	
	### bash ###
	dk_depend(bash)
	if(bash_exe)
		#dk_exec(clear)
		execute_process(COMMAND clear) # faster
		return()
	endif()
	
	dk_fatal("Could not find pwsh, powershell, cmd, sh or bash")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_clearScreen()
endfunction()
