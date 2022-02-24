#     dk.filesystem.js - %DIGITALKNOB%/DK/Api/filesystem/filesystem.js
#    dk.filesystem.cpp - %DIGITALKNOB%/DK/Api/filesystem/filesystem.cpp
#      javascript FSAA - https://developer.mozilla.org/en-US/docs/Web/API/filesystem
#       Php filesystem - https://www.php.net/manual/en/book.filesystem.php
#    NodeJS filesystem - https://nodejs.org/api/fs.html
#      std::filesystem - https://en.cppreference.com/w/cpp/filesystem
#    boost::filesystem - https://www.boost.org/doc/libs/1_34_1/libs/filesystem/doc/index.htm#:~:text=The%20Boost%20filesystem%20Library%20provides,operations%20from%20within%20C%2B%2B%20programs
#       Win 32 FileApi - https://docs.microsoft.com/en-us/windows/win32/api/fileapi/
#   Android filesystem - https://developer.android.com/reference/java/nio/file/filesystem
#    Apple File System - https://developer.apple.com/documentation/foundation/file_system
#   Apple NSfilesystem - https://developer.apple.com/documentation/foundation/nsfilemanager
# Liunx GNU filesystem - https://www.gnu.org/software/libc/manual/html_node/File-System-Interface.html
#           CMake File - https://cmake.org/cmake/help/latest/command/file.html
#   DKBatch filesystem - %DIGITALKNOB%/DKBatch/filesysten
#    DKBash filesystem - %DIGITALKNOB%/DKBash/filesysten
#   DKCMake filesystem - %DIGITALKNOB%/DKCMake/filesystem/filesystem.cmake


###################################################################
# dk_FunctionName( ${arg0} ${arg1} rtn-var )
#  
# Description
#
#  ${arg0}: Description
#  rtn-var: Description
#          
# Reference: https://website.com
###################################################################
function(dk_file_getDigitalknobPath result)
	get_filename_component(DIGITALKNOB ${CMAKE_SOURCE_DIR} ABSOLUTE)
	get_filename_component(FOLDER_NAME ${DIGITALKNOB} NAME)
	while(NOT FOLDER_NAME STREQUAL "digitalknob")
		get_filename_component(DIGITALKNOB ${DIGITALKNOB} DIRECTORY)
		get_filename_component(FOLDER_NAME ${DIGITALKNOB} NAME)
		if(NOT FOLDER_NAME)
			DKASSERT("Could not locate digitalknob root path")
		endif()
	endwhile()
	set(${result} ${DIGITALKNOB} PARENT_SCOPE)
endfunction()
dk_file_getDigitalknobPath(DIGITALKNOB)