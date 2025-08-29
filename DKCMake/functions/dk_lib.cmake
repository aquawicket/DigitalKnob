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
# dk_lib(lib_path)
#
#	TODO
#
#	@lib_path	- TODO
#
function(dk_lib lib_path)
	dk_debugFunc(1 2)
	
	if(lib_path IN_LIST LIBLIST)
		return() # The library is already in the list
	endif()	
	
	#foreach(lib_path ${ARGV})
	#	dk_includes(LIBS "${lib_path}")
	#	if(dk_includes)
	#		continue() # lib_path is already in the list
	#	endif()
		
		if(Linux OR Raspberry OR Android OR Emscripten OR MINGW)
			dk_prepend(LIBLIST ${lib_path})
			dk_prepend(LIBS ${lib_path})
			dk_prepend(${CURRENT_PLUGIN}_LIBS ${lib_path})
		else()
			dk_append(LIBLIST ${lib_path})
			dk_append(LIBS ${lib_path})
			dk_append(${CURRENT_PLUGIN}_LIBS ${lib_path})
		endif()
		dk_set(LIBLIST "${LIBLIST}")
		dk_set(LIBS "${LIBS}")
		dk_set(${CURRENT_PLUGIN}_LIBS "${${CURRENT_PLUGIN}_LIBS}")
		
		if(INSTALL_DKLIBS)
			if(EXISTS ${lib_path})
				#dk_assertVar($ENV{CURRENT_PLUGIN}_Import_Name)
				#set(LIB_NAME ${$ENV{CURRENT_PLUGIN}_Import_Name}) # get the import folder name of the plugin
				#file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/${LIB_NAME}/${Target_Tuple})
				file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib//${Target_Tuple})
			else()
				dk_warning("DKINSTALL: Could not locate ${lib_path}")
			endif()
		endif()	
		
		if(ARGV1)
			dk_set(${ARGV1} ${lib_path}) # add the lib_path to the supplied variable
		endif()
	#endforeach()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_lib(zlib ${ZLIB_Debug_Dir}/zd.lib)
endfunction()