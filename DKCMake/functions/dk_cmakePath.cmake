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
# dk_cmakePath(<input> <output>)
#
#
function(dk_cmakePath input output)
	dk_debugFunc(2)
	
	set(input "${ARGV0}")
	#set(output "${ARGV1}")
	
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.20")
		cmake_path(CONVERT ${input} TO_CMAKE_PATH_LIST dk_cmakePath NORMALIZE)
	else()
		file(TO_CMAKE_PATH input dk_cmakePath)
	endif()
	dk_debug("Converted '${input}' to NATIVE_PATH:'${dk_cmakePath}'")

	
	###### return ######
	set(dk_cmakePath ${dk_cmakePath} PARENT_SCOPE)
	if(ARGV1)
		if("${ARGV1}" MATCHES "ENV{") 
			string(REPLACE "ENV{" "" ARGV1 "${ARGV1}")
			string(REPLACE "}" "" ARGV1 "${ARGV1}")
			set(ENV{${ARGV1}} "${dk_cmakePath}")						# ENV variable
		elseif("${ARGV1}" MATCHES "CACHE{")
			string(REPLACE "CACHE{" "" ARGV1 "${ARGV1}")
			string(REPLACE "}" "" ARGV1 "${ARGV1}")
			set(${ARGV1} "${dk_cmakePath}" CACHE INTERNAL "" FORCE)		# CACHE variable
			unset(${ARGV1} PARENT_SCOPE) # Remove the local variable
		else()
			set(${ARGV1} "${dk_cmakePath}" PARENT_SCOPE)				# LOCAL variable
		endif()
	else()
		# dk_debug("dk_cmakePath = ${dk_cmakePath}") 
	endif()
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc()
	
	dk_unset(cmakePath)
	
	dk_echo()
	dk_cmakePath("C:\\Windows\\System32" cmakePath)
	dk_debug("cmakePath = '${cmakePath}'")
	dk_debug("CACHE{cmakePath} = '$CACHE{cmakePath}'")
	dk_debug("ENV{cmakePath} = '$ENV{cmakePath}'")
	dk_unset(cmakePath)
	
	dk_echo()
	set(cmakePath "LOCAL")
	dk_cmakePath("C:\\Windows\\System32" CACHE{cmakePath})
	dk_debug("cmakePath = '${cmakePath}'")
	dk_debug("CACHE{cmakePath} = '$CACHE{cmakePath}'")
	dk_debug("ENV{cmakePath} = '$ENV{cmakePath}'")
	dk_unset(cmakePath)
	
	dk_echo()
	dk_cmakePath("C:\\Windows\\System32" ENV{cmakePath})
	dk_debug("cmakePath = '${cmakePath}'")
	dk_debug("CACHE{cmakePath} = '$CACHE{cmakePath}'")
	dk_debug("ENV{cmakePath} = '$ENV{cmakePath}'")
	
endfunction()