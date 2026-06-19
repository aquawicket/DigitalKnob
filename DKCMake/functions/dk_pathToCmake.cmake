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
# dk_pathToCmake(<input> <output>)
#
#
function(dk_pathToCmake input output)
	dk_debugFunc(2)
	
	set(input "${ARGV0}")
	#set(output "${ARGV1}")
	
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.20")
		cmake_path(NATIVE_PATH input NORMALIZE dk_pathToCmake)
		 cmake_path(CONVERT "${ARGV0}" TO_CMAKE_PATH_LIST dk_pathToCmake NORMALIZE)
	else()
		file(TO_CMAKE_PATH input dk_pathToCmake)
	#else()
		# wslpath
	#else()
		# cygpath
	#else()
		# 
	#else()
		# dk_fatal("dk_pathToCmake(): No available methods")
		# dk_return()
	endif()
	
	

	###### return ######
	set(dk_pathToCmake ${dk_pathToCmake} PARENT_SCOPE)
	message("dk_pathToCmake(\"${ARGV}\") -> '${dk_pathToCmake}'")
	if(ARGV1)
		if("${ARGV1}" MATCHES "ENV{") 
			string(REPLACE "ENV{" "" ARGV1 "${ARGV1}")
			string(REPLACE "}" "" ARGV1 "${ARGV1}")
			set(ENV{${ARGV1}} "${dk_pathToCmake}")						# ENV variable
			message("dk_pathToCmake(\"${ARGV}\") -> '\$ENV{${dk_pathToCmake}}'")
		elseif("${ARGV1}" MATCHES "CACHE{")
			string(REPLACE "CACHE{" "" ARGV1 "${ARGV1}")
			string(REPLACE "}" "" ARGV1 "${ARGV1}")
			set(${ARGV1} "${dk_pathToCmake}" CACHE INTERNAL "" FORCE)	# CACHE variable
			unset(${ARGV1} PARENT_SCOPE) # Remove the local variable
			message("dk_pathToCmake(\"${ARGV}\") -> '\$CACHE{${dk_pathToCmake}}'")
		else()
			set(${ARGV1} "${dk_pathToCmake}" PARENT_SCOPE)				# LOCAL variable
			message("dk_pathToCmake(\"${ARGV}\") -> '\${${dk_pathToCmake}}'")
		endif()
	else()
		# dk_debug("dk_pathToCmake = ${dk_pathToCmake}") 
	endif()
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc(0)
	
	### LOCAL return variable
	dk_echo()
	dk_pathToCmake("C:/Windows/System32" myCmakePath)
	dk_info("dk_pathToCmake     = '${dk_pathToCmake}'")
	dk_debug("myCmakePath        = '${myCmakePath}'")
	dk_debug("CACHE{myCmakePath} = '$CACHE{myCmakePath}'")
	dk_debug("ENV{myCmakePath}   = '$ENV{myCmakePath}'")
	dk_unset(myCmakePath)
	
	### CACHE return variable
	dk_echo()
	set(myCmakePath "LOCAL")
	dk_pathToCmake("C:/Windows/System32" CACHE{myCmakePath})
	dk_debug("dk_pathToCmake     = '${dk_pathToCmake}'")
	dk_debug("myCmakePath        = '${myCmakePath}'")
	dk_debug("CACHE{myCmakePath} = '$CACHE{myCmakePath}'")
	dk_debug("ENV{myCmakePath}   = '$ENV{myCmakePath}'")
	dk_unset(myCmakePath)
	
	### ENV return variable
	dk_echo()
	dk_pathToCmake("C:/Windows/System32" ENV{myCmakePath})
	dk_debug("dk_pathToCmake     = '${dk_pathToCmake}'")
	dk_debug("myCmakePath        = '${myCmakePath}'")
	dk_debug("CACHE{myCmakePath} = '$CACHE{myCmakePath}'")
	dk_debug("ENV{myCmakePath}   = '$ENV{myCmakePath}'")
	dk_unset(myCmakePath)
endfunction()