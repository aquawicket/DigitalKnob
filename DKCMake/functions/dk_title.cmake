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
# dk_title(string)
#
#	Set the title of the console window
#
function(dk_title)
    dk_debugFunc(0 99)
 
	############ SET ############
	if(ARGV0)
		set(dk_title "${ARGV0}")
		
		#dk_validate(cmd.exe "dk_depend(cmd.exe)")
		#dk_validate(cmd.exe "include(\"${DKIMPORTS_DIR}/cmd.exe/DKINSTALL.cmake\")")
		if(EXISTS "${cmd.exe}")
			execute_process(COMMAND ${cmd.exe} /c title ${dk_title})
		elseif(EXISTS "$ENV{ComSpec}")
			execute_process(COMMAND $ENV{ComSpec} /c title ${dk_title})
		endif()
	
	############ GET ############
	else()
		# TODO
		message("${dk_title}") 
	endif()
	
	###### return ######
	set(dk_title ${dk_title} PARENT_SCOPE)

endfunction()











###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)

	### SET ###
	dk_title("------------DKCMake: dk_title TEST 1 ..............")
	
	### GET ###
	dk_title()
	dk_echo("dk_title = ${dk_title}")
	dk_pause()
	
	
	### SET ###
    dk_title("------------DKCMake: dk_title TEST 2 ..............")
	
	### GET ###
	dk_title()
	dk_echo("dk_title = ${dk_title}")
	dk_pause()
	
	
	### SET ###
	dk_title("------------DKCMake: dk_title TEST 3 ..............")
	
	### GET ###
	dk_title()
	dk_echo("dk_title = ${dk_title}")
	dk_pause()
endfunction()
