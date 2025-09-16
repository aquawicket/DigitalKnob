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


#dk_disable(java)
#dk_return() ################ disabled for now

############ java ############
# https://www.java.com/en/download
# https://javadl.oracle.com/webapps/download/AutoDL?BundleId=245479_4d5417147a92418ea8b615e228bb6935
# http://deb.sambaedu.org/wpkg/files/jre/jre-8u311-windows-x64.exe
dk_validate(Host_Tuple "dk_Host_Tuple()")
dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_importVariables("${java_${Host_Tuple}_Import}" IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR})

dk_set(JAVA_EXE ${JAVA}/bin/java.exe)

### INSTALL ###
dk_info("looking for java at ${JAVA_EXE}")
if(NOT EXISTS "${JAVA_EXE}")
	dk_download(${JAVA_Url})
	dk_info("Installing ${JAVA_Url_Filename} . . . please wait")
	#dk_delete(${JAVA})
	#dk_mkdir(${JAVA})
	dk_replaceAll(${JAVA} "/" "\\" JAVA_WIN)
	if(Windows_Host)
		dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
		dk_exec(${dk_download} INSTALLDIR=${JAVA_WIN} /L "${DK3RDPARTY_DIR}/java_install.log") # /s  = silent install (not working)
	endif()
else()
	dk_info("Found java at ${JAVA_EXE}")
endif()

if(NOT EXISTS "${JAVA_EXE}")
	dk_fatal("JAVA IS NOT FOUND OR INVALID")
endif()

dk_setEnv("JAVA_HOME" ${JAVA})
