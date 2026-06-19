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
# dk_pathToWindows(<input> <output>)
#
#
function(dk_pathToWindows input output)
	dk_debugFunc(2)
	
	set(input "${ARGV0}")
	#set(output "${ARGV1}")
	
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.20")
		cmake_path(NATIVE_PATH input NORMALIZE dk_pathToNative)
	else()
		file(TO_NATIVE_PATH input dk_pathToNative)
	endif()
	message("Converted '${input}' to NATIVE_PATH:'${dk_pathToNative}'")

	
	###### return ######
	set(dk_pathToNative ${dk_pathToNative} PARENT_SCOPE)
	if(ARGV1)
		if("${ARGV1}" MATCHES "ENV{") 
			string(REPLACE "ENV{" "" ARGV1 "${ARGV1}")
			string(REPLACE "}" "" ARGV1 "${ARGV1}")
			set(ENV{${ARGV1}} "${dk_pathToNative}")						# ENV variable
		elseif("${ARGV1}" MATCHES "CACHE{")
			string(REPLACE "CACHE{" "" ARGV1 "${ARGV1}")
			string(REPLACE "}" "" ARGV1 "${ARGV1}")
			set(${ARGV1} "${dk_pathToNative}" CACHE INTERNAL "" FORCE)	# CACHE variable
			unset(${ARGV1} PARENT_SCOPE) # Remove the local variable
		else()
			set(${ARGV1} "${dk_pathToNative}" PARENT_SCOPE)				# LOCAL variable
		endif()
	else()
		# dk_debug("dk_pathToNative = ${dk_pathToNative}") 
	endif()
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc()
	
	dk_unset(native_path)
	
	dk_echo()
	dk_pathToWindows("C:/Windows/System32" native_path)
	dk_debug("native_path = '${native_path}'")
	dk_debug("CACHE{native_path} = '$CACHE{native_path}'")
	dk_debug("ENV{native_path} = '$ENV{native_path}'")
	dk_unset(native_path)
	
	dk_echo()
	set(native_path "LOCAL")
	dk_pathToWindows("C:/Windows/System32" CACHE{native_path})
	dk_debug("native_path = '${native_path}'")
	dk_debug("CACHE{native_path} = '$CACHE{native_path}'")
	dk_debug("ENV{native_path} = '$ENV{native_path}'")
	dk_unset(native_path)
	
	dk_echo()
	dk_pathToWindows("C:/Windows/System32" ENV{native_path})
	dk_debug("native_path = '${native_path}'")
	dk_debug("CACHE{native_path} = '$CACHE{native_path}'")
	dk_debug("ENV{native_path} = '$ENV{native_path}'")
	
endfunction()