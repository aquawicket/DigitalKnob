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


############ java ############
# https://www.java.com/en/download
# https://javadl.oracle.com/webapps/download/AutoDL?BundleId=245479_4d5417147a92418ea8b615e228bb6935
# http://deb.sambaedu.org/wpkg/files/jre/jre-8u311-windows-x64.exe

dk_importVariables("${java_${Host_Tuple}_Import}" IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR})

dk_set(java_exe ${JAVA}/bin/java.exe)

### INSTALL ###
dk_info("looking for java at ${java_exe}")
if(NOT EXISTS "${java_exe}")
	dk_download(${java_Url})
	dk_info("Installing ${java_Url_Filename} . . . please wait")
	#dk_delete(${java})
	#dk_mkdir(${java})
	dk_replaceAll(${java} "/" "\\" java_WIN)
	if(Windows_Host)
		dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
		dk_exec(${dk_download} INSTALLDIR=${java_WIN} /L "${DK3RDPARTY_DIR}/java_install.log") # /s  = silent install (not working)
	endif()
else()
	dk_info("Found java at ${java_exe}")
endif()

if(NOT EXISTS "${java_exe}")
	dk_fatal("java_exe IS NOT FOUND OR INVALID")
endif()

dk_setEnv("JAVA_HOME" ${java})
