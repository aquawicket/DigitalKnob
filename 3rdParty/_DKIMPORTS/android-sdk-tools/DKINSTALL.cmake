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


###### android-sdk-tools ######
dk_depend(android-sdk)

dk_validate(Host_Tuple "dk_Host_Tuple()")
dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
if(Windows_Host)
	dk_import(${android-sdk-tools_Windows_Import} 	INSTALL_PATH "${android-sdk}/tools") # PATCH)
elseif(Mac_Host)
	dk_import(${android-sdk-tools_Mac_Import} 		INSTALL_PATH "${android-sdk}/tools") # PATCH)
elseif(Linux_Host)
	dk_import(${android-sdk-tools_Linux_Import} 	INSTALL_PATH "${android-sdk}/tools") # PATCH)
endif()

# TODO
#In tools/bin/sdkmanager.bat
#replace this ...
#%DEFAULT_JVM_OPTS%
#with this
#%DEFAULT_JVM_OPTS% --add-modules java.xml.bind %JAVA_OPTS%
