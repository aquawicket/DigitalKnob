# https://www.java.com/en/download
# https://javadl.oracle.com/webapps/download/AutoDL?BundleId=245479_4d5417147a92418ea8b615e228bb6935
# http://deb.sambaedu.org/wpkg/files/jre/jre-8u311-windows-x64.exe

dk_return() # disabled for now


### VERSION ###
# jre1.8.0_311
WIN_HOST_dk_set(JAVA_VERSION 8u311)
WIN_HOST_dk_set(JAVA_NAME jre-8u311-windows-x64)
WIN_HOST_dk_set(JAVA_DL http://deb.sambaedu.org/wpkg/files/jre/jre-8u311-windows-x64.exe)
#WIN_HOST_dk_set(JAVA "C:/Program Files/Java/bin/jre1.8.0_311")
WIN_HOST_dk_set(JAVA ${3RDPARTY}/${JAVA_NAME})
#dk_getShortPath(${JAVA} JAVA)
#dk_set(JAVA "${JAVA}")
WIN_HOST_dk_set(JAVA_EXE ${JAVA}/bin/java.exe)


### INSTALL ###
dk_info("looking for java at ${JAVA_EXE}")
if(NOT EXISTS "${JAVA_EXE}")
	dk_debug("${JAVA_EXE} NOT FOUND")
	get_filename_component(filename ${JAVA_DL} NAME)
	WIN_HOST_dk_download(${JAVA_DL} ${DKDOWNLOAD}/${filename})
	dk_info("Installing ${filename} . . . please wait")
	dk_debug(JAVA)
	dk_makeDirectory(${JAVA})
	WIN_HOST_dk_command(${DKDOWNLOAD}/${filename} INSTALLDIR=${JAVA} /L ${3RDPARTY}/java/install.log) # /s  = silent install (not working)
else()
	dk_info("Found cmake at ${JAVA_EXE}")
endif()

if(NOT EXISTS "${JAVA_EXE}")
	dk_assert("JAVA IS NOT FOUND OR INVALID")
endif()

dk_setEnv("JAVA_HOME" ${JAVA})
