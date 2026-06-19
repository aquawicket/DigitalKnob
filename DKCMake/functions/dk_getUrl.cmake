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
# dk_getUrl(<url> <ret:optional>)
#
function(dk_getUrl)
	dk_debugFunc(1 2)

	dk_validate(curl.exe "dk_depend(curl.exe)")
	
	#dk_set(dk_exec_ECHO_OUTPUT 0)
	set(command ${curl.exe} --silent --show-error --head --output nul --write-out %{redirect_url} ${ARGV0})
	dk_exec(${command})
	if(dk_exec)
		set(dk_getUrl "${dk_exec}")
	else()
		set(dk_getUrl "${ARGV0}")
	endif()
	
	###### return ######
	set(dk_getUrl ${dk_getUrl} PARENT_SCOPE)
	if(ARGV1)
		set(${ARGV1} ${dk_getUrl} PARENT_SCOPE)
	else()
		message("${dk_getUrl}") 
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

#	set(url "http://www.google.com/index.html")
#	dk_getUrl("${url}")
#	dk_echo("url:'${url}' dk_getUrl = ${dk_getUrl}")
	
#	set(url "http://www.nonexisting.com/nofile.no")
#	dk_getUrl("${url}")
#	dk_echo("url:'${url}' dk_getUrl = ${dk_getUrl}")
	
#	set(url "https://aka.ms/vs/16/release/VC_redist.x86.exe")
#	dk_getUrl("${url}")
#	dk_echo("url:'${url}' dk_getUrl = ${dk_getUrl}")
	
#	set(url "https://aka.ms/vs/16/release/VC_redist.x64.exe")
#	dk_getUrl("${url}")
#	dk_echo("url:'${url}' dk_getUrl = ${dk_getUrl}")

	dk_inputBox()
	dk_download(${dk_inputBox})
endfunction()
