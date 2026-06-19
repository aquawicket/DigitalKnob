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
# dk_printUrlData(Url)
#
#	Print Url seperated into an array
#
#	@Url	- The Url to print
#
function(dk_printUrlData Url)
	dk_debugFunc()
	
	if(NOT Url)
		dk_fatal("Url invalid! ")
	endif()
	dk_verbose("*** Url Variables ***")
	dk_verbose(Url)
	dk_replaceAll(${Url} "/" ";" PLUGIN_Url_List) # seperate the Url nodes into a list 
	dk_verbose(PLUGIN_Url_List)
	list(LENGTH PLUGIN_Url_List PLUGIN_Url_Length)
	dk_verbose(PLUGIN_Url_Length)
	set(n -1)
	foreach(PLUGIN_Url_Item ${PLUGIN_Url_List})
		math(EXPR n "${n}+1")
		set(Url_${n} ${PLUGIN_Url_Item})
		dk_verbose(Url_${n})
		set(Url_last ${Url_${n}})
	endforeach()
	dk_verbose(Url_last)
	dk_getFileType(${Url} Url_filetype)
	dk_verbose(Url_filetype)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()