# https://www.java.com/en/download/
#
# jre-8u311-windows-x64.exe
# https://javadl.oracle.com/webapps/download/AutoDL?BundleId=245479_4d5417147a92418ea8b615e228bb6935
# http://deb.sambaedu.org/wpkg/files/jre/jre-8u311-windows-x64.exe

### VERSION ###
# jre1.8.0_311
WIN_HOST_DKSET(JAVA_VERSION 8u311)
WIN_HOST_DKSET(JAVA_NAME jre-${JAVA_VERSION}-windows-x64)
WIN_HOST_DKSET(JAVA_DL http://deb.sambaedu.org/wpkg/files/jre/jre-8u311-windows-x64.exe)
#WIN_HOST_DKSET(JAVA "C:/Program Files/Java/bin/jre1.8.0_311")
WIN_HOST_DKSET(JAVA ${3RDPARTY}/${JAVA_NAME})
#dk_getShortPath(${JAVA} JAVA)
#DKSET(JAVA "${JAVA}")
WIN_HOST_DKSET(JAVA_EXE ${JAVA}/bin/java.exe)


### INSTALL ###
DKINFO("looking for java at ${JAVA_EXE}")
if(NOT EXISTS "${JAVA_EXE}")
	DKINFO("java NOT FOUND")
	get_filename_component(filename ${JAVA_DL} NAME)
	WIN_HOST_dk_download(${JAVA_DL} ${DKDOWNLOAD}/${filename})
	DKINFO("Installing ${filename} . . . please wait")
	dk_makeDirectory(${JAVA})
	WIN_HOST_DKCOMMAND(${DKDOWNLOAD}/${filename} INSTALLDIR=${JAVA} /L ${3RDPARTY}/java/install.log) # /s  = silent install (not working)
else()
	DKINFO("Found cmake at ${JAVA_EXE}")
endif()

if(NOT EXISTS "${JAVA_EXE}")
	DKERROR("JAVA IS NOT FOUND OR INVALID")
endif()

DKSETENV("JAVA_HOME" ${JAVA})