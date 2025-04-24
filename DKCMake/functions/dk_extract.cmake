#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

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
	
<<<<<<< HEAD
	dk_getOption(NO_HALT  ${ARGV} REMOVE)
	
	if(NOT EXISTS ${dest})
		dk_makeDirectory(${dest})
	endif()
	
	if(CMAKE_VERSION VERSION_GREATER "3.18")
=======
	dk_getOption(NO_HALT  REMOVE)
	
	if(NOT EXISTS ${dest})
		dk_mkdir(${dest})
	endif()
	
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.18")
>>>>>>> Development
		file(ARCHIVE_EXTRACT INPUT ${src} DESTINATION ${dest} VERBOSE)
	else()
		if(NOT EXISTS ${CMAKE_COMMAND})
			dk_fatal("CMAKE_COMMAND not found: \${CMAKE_COMMAND} = ${CMAKE_COMMAND}")
		endif()
		#dk_getExtension(${src} EXTENSION)
		#if("${EXTENSION}" STREQUAL ".zip")
<<<<<<< HEAD
		#	dk_executeProcess(unzip ${src} -d ${dest} ${NO_HALT})
		#else
		dk_executeProcess(${CMAKE_COMMAND} -E tar xvf ${src} WORKING_DIRECTORY ${dest} ${NO_HALT})
=======
		#	dk_exec(unzip ${src} -d ${dest} ${NO_HALT})
		#else
		dk_exec(${CMAKE_COMMAND} -E tar xvf ${src} WORKING_DIRECTORY ${dest} ${NO_HALT})
>>>>>>> Development
		#endif
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_validate(DKDOWNLOAD_DIR "dk_DIGITALKNOB_DIR()")
	dk_extract("${DKDOWNLOAD_DIR}/android-ndk-r23c-aarch64.zip" "${DKDOWNLOAD_DIR}/android-ndk-r23c-aarch64")
=======
	dk_debugFunc(0)
	
	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	dk_extract("$ENV{DKDOWNLOAD_DIR}/android-ndk-r23c-aarch64.zip" "$ENV{DKDOWNLOAD_DIR}/android-ndk-r23c-aarch64")
>>>>>>> Development
endfunction()
