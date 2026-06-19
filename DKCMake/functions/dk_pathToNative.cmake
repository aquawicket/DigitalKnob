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
# dk_pathToNative(<input> <output>)
#
#
function(dk_pathToNative input output)
	dk_debugFunc(2)
	
	set(input "${ARGV0}")
	#set(output "${ARGV1}")
	
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.20")
		cmake_path(NATIVE_PATH input NORMALIZE dk_pathToNative)
	else()
		file(TO_NATIVE_PATH input dk_pathToNative)
	#else()
		# wslpath
	#else()
		# cygpath
	#else()
		# 
	#else()
		# dk_fatal("dk_pathToNative(): No available methods")
		# dk_return()
	endif()
	
	

	###### return ######
	set(dk_pathToNative ${dk_pathToNative} PARENT_SCOPE)
	message("dk_pathToNative(\"${ARGV}\") -> '${dk_pathToNative}'")
	if(ARGV1)
		if("${ARGV1}" MATCHES "ENV{") 
			string(REPLACE "ENV{" "" ARGV1 "${ARGV1}")
			string(REPLACE "}" "" ARGV1 "${ARGV1}")
			set(ENV{${ARGV1}} "${dk_pathToNative}")						# ENV variable
			message("dk_pathToNative(\"${ARGV}\") -> '\$ENV{${dk_pathToNative}}'")
		elseif("${ARGV1}" MATCHES "CACHE{")
			string(REPLACE "CACHE{" "" ARGV1 "${ARGV1}")
			string(REPLACE "}" "" ARGV1 "${ARGV1}")
			set(${ARGV1} "${dk_pathToNative}" CACHE INTERNAL "" FORCE)	# CACHE variable
			unset(${ARGV1} PARENT_SCOPE) # Remove the local variable
			message("dk_pathToNative(\"${ARGV}\") -> '\$CACHE{${dk_pathToNative}}'")
		else()
			set(${ARGV1} "${dk_pathToNative}" PARENT_SCOPE)				# LOCAL variable
			message("dk_pathToNative(\"${ARGV}\") -> '\${${dk_pathToNative}}'")
		endif()
	else()
		# dk_debug("dk_pathToNative = ${dk_pathToNative}") 
	endif()
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc()
	
	### LOCAL return variable
	dk_echo()
	dk_pathToNative("C:/Windows/System32" myNativePath)
	dk_info("dk_pathToNative     = '${dk_pathToNative}'")
	dk_debug("myNativePath        = '${myNativePath}'")
	dk_debug("CACHE{myNativePath} = '$CACHE{myNativePath}'")
	dk_debug("ENV{myNativePath}   = '$ENV{myNativePath}'")
	dk_unset(myNativePath)
	
	### CACHE return variable
	dk_echo()
	set(myNativePath "LOCAL")
	dk_pathToNative("C:/Windows/System32" CACHE{myNativePath})
	dk_debug("dk_pathToNative     = '${dk_pathToNative}'")
	dk_debug("myNativePath        = '${myNativePath}'")
	dk_debug("CACHE{myNativePath} = '$CACHE{myNativePath}'")
	dk_debug("ENV{myNativePath}   = '$ENV{myNativePath}'")
	dk_unset(myNativePath)
	
	### ENV return variable
	dk_echo()
	dk_pathToNative("C:/Windows/System32" ENV{myNativePath})
	dk_debug("dk_pathToNative     = '${dk_pathToNative}'")
	dk_debug("myNativePath        = '${myNativePath}'")
	dk_debug("CACHE{myNativePath} = '$CACHE{myNativePath}'")
	dk_debug("ENV{myNativePath}   = '$ENV{myNativePath}'")
	dk_unset(myNativePath)
endfunction()