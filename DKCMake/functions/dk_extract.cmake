#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_extract(src dest)
#
#	Extract an archive file
#
#	@src	- The full path of the archive file
#	@dest	- The folder path to extract the archive to
#
function(dk_extract src dest)
	dk_debugFunc()
	
	dk_getOption(NO_HALT  ${ARGV} REMOVE)
	
	if(NOT EXISTS ${dest})
		dk_makeDirectory(${dest})
	endif()
	
	if(CMAKE_VERSION VERSION_GREATER "3.18")
		file(ARCHIVE_EXTRACT INPUT ${src} DESTINATION ${dest} VERBOSE)
	else()
		if(NOT EXISTS ${CMAKE_COMMAND})
			dk_fatal("CMAKE_COMMAND not found: \${CMAKE_COMMAND} = ${CMAKE_COMMAND}")
		endif()
		#dk_getExtension(${src} EXTENSION)
		#if("${EXTENSION}" STREQUAL ".zip")
		#	dk_executeProcess(unzip ${src} -d ${dest} ${NO_HALT})
		#else
		dk_executeProcess(${CMAKE_COMMAND} -E tar xvf ${src} WORKING_DIRECTORY ${dest} ${NO_HALT})
		#endif
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_validate(DKDOWNLOAD_DIR "dk_DIGITALKNOB_DIR()")
	dk_extract("${DKDOWNLOAD_DIR}/android-ndk-r23c-aarch64.zip" "${DKDOWNLOAD_DIR}/android-ndk-r23c-aarch64")
endfunction()
