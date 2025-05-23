#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ java ############
# https://www.java.com/en/download
# https://javadl.oracle.com/webapps/download/AutoDL?BundleId=245479_4d5417147a92418ea8b615e228bb6935
# http://deb.sambaedu.org/wpkg/files/jre/jre-8u311-windows-x64.exe
dk_load(dk_builder)
dk_undepend(java)
dk_return() ################ disabled for now

### VERSION ###
# jre1.8.0_311
WIN_HOST_dk_set(JAVA_VERSION 8u311)
WIN_HOST_dk_set(JAVA_NAME jre-8u311-windows-x64)
WIN_HOST_dk_set(JAVA_DL http://deb.sambaedu.org/wpkg/files/jre/jre-8u311-windows-x64.exe)
#WIN_HOST_dk_set(JAVA "${ProgramFiles}/Java/bin/jre1.8.0_311")
dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR()")
WIN_HOST_dk_set(JAVA $ENV{DK3RDPARTY_DIR}/${JAVA_NAME})
#dk_getShortPath(${JAVA} JAVA)
#dk_set(JAVA "${JAVA}")
WIN_HOST_dk_set(JAVA_EXE ${JAVA}/bin/java.exe)

### INSTALL ###
dk_info("looking for java at ${JAVA_EXE}")
if(NOT EXISTS "${JAVA_EXE}")
	dk_debug("${JAVA_EXE} NOT FOUND")
	dk_basename(${JAVA_DL} filename)
	WIN_HOST_dk_download(${JAVA_DL} $ENV{DKDOWNLOAD_DIR}/${filename})
	dk_info("Installing ${filename} . . . please wait")
	dk_debug(JAVA)
	dk_mkdir(${JAVA})
	WIN_HOST_dk_command($ENV{DKDOWNLOAD_DIR}/${filename} INSTALLDIR=${JAVA} /L $ENV{DK3RDPARTY_DIR}/java/install.log) # /s  = silent install (not working)
else()
	dk_info("Found cmake at ${JAVA_EXE}")
endif()

if(NOT EXISTS "${JAVA_EXE}")
	dk_fatal("JAVA IS NOT FOUND OR INVALID")
endif()

dk_setEnv("JAVA_HOME" ${JAVA})
