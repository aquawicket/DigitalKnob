include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_appendEnvPath(<inputPath>)
#
#	<inputPath>	- The CMake / style full path to append the the Environment Path variable
#
function(dk_appendEnvPath inputPath)
	dk_debugFunc(${ARGV})
	
	if(NOT inputPath)
		dk_error("dk_appendEnvPath(): inputPath is invalid!")
		return()
	endif()
	if(NOT EXISTS ${inputPath})
		dk_warning("dk_appendEnvPath(): ${inputPath}: path does not exist")
		return()
	endif()
	if(WIN32)
		dk_debug("Converting value to NATIVE_PATH")
		#file(TO_NATIVE_PATH "${inputPath}" nativePath)
		cmake_path(NATIVE_PATH inputPath NORMALIZE nativePath)
		#set(path_printable "${nativePath}" CACHE FILEPATH "")
		#dk_replaceAll("${path_printable}"  "/"  "\\"  path_printable)
		#dk_replaceAll("${inputPath}"  "/"  "\\"  inputPath)
	#else()
	#	set(path_printable "${nativePath}")
	endif()
	
	#dk_printVar(ENV{PATH})
	string(FIND "$ENV{PATH}" "${nativePath}" hasPath)
	if(${hasPath} GREATER -1)
		dk_notice("${nativePath} is already in the PATH environment list\n")
	else()
		if(WIN_HOST)
			set(ENV{PATH} "$ENV{PATH};${nativePath}")
		else()
			set(ENV{PATH} "$ENV{PATH}:${nativePath}")
		endif()
		dk_info("appended \${nativePath} to the PATH environment list\n")
	endif()
	dk_printVar(ENV{PATH})
endfunction()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)
