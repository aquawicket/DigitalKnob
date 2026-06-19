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
# dk_include(path) variable
#
#	Add a directory to the compiler include paths
#
#	@path					- The path to add to the compiler include paths
#   @variable (optional)	- Create a variable to store the path in.
#
function(dk_include path)
	dk_debugFunc(1 3)
	
	### CURRENT_PLUGIN_Config_Dir ###
	dk_validate(${CURRENT_PLUGIN}_Config_Dir "dk_Target_Config()")
	
	if(INSTALL_DKLIBS)
		dk_assertVar(${CURRENT_PLUGIN}_Install_Name)
		set(${CURRENT_PLUGIN}_DKBIN "${CMAKE_INSTALL_PREFIX}/${${CURRENT_PLUGIN}_Install_Name}")
		if(EXISTS "${${CURRENT_PLUGIN}}")
			file(INSTALL DIRECTORY "${${CURRENT_PLUGIN}}/" DESTINATION "${${CURRENT_PLUGIN}_DKBIN}" FILES_MATCHING PATTERN "*.h")
			file(INSTALL DIRECTORY "${${CURRENT_PLUGIN}}/" DESTINATION "${${CURRENT_PLUGIN}_DKBIN}" FILES_MATCHING PATTERN "*.hpp")
			file(INSTALL DIRECTORY "${${CURRENT_PLUGIN}}/" DESTINATION "${${CURRENT_PLUGIN}_DKBIN}" FILES_MATCHING PATTERN "*.inl") # RmlUi
			#dk_deleteEmptyDirectories("${${CURRENT_PLUGIN}_DKBIN}")
		endif()
		string(REPLACE "${${CURRENT_PLUGIN}}" "${${CURRENT_PLUGIN}_DKBIN}" DKBIN_path "${path}")
		set(path "${DKBIN_path}")
	endif()
	
	if(NOT EXISTS "${path}")
		dk_warning("dk_include(): path:${path} NOT FOUND")
	endif()
	
	dk_verbose("path: ${path}")
	if(DKINCLUDES_LIST MATCHES "${path}")
		dk_return()	# includePath is already in the list
	endif()	
		
	dk_append(DKINCLUDES_LIST ${path})
	dk_set(DKINCLUDES_LIST "${DKINCLUDES_LIST}")
#	set(ENV{DKINCLUDES_LIST} "${DKINCLUDES_LIST}")  # Export an enviromnent variable so the App's CMakeLists.txt can import it
	
#	if(CMAKE_SCRIPT_MODE_FILE)
#		dk_warning("include_directories() not available in script mode")
#	else()
#		include_directories(${path})
#	endif()
		
	### add the includePath to the supplied variables	
	if(${ARGC} GREATER 1)
		dk_set(${ARGV1} ${path}) 
	endif()
	if(${ARGC} GREATER 2)
		dk_set(${ARGV2} ${path})
	endif()

endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_include("TODO")
endfunction()