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
#WIN_GetShortPath(${JAVA} JAVA)
#DKSET(JAVA "${JAVA}")
WIN_HOST_DKSET(JAVA_EXE ${JAVA}/bin/java.exe)


### INSTALL ###
DKINFO("looking for java at ${JAVA_EXE}")
if(NOT EXISTS "${JAVA_EXE}")
	DKINFO("java NOT FOUND")
	WIN_HOST_DOWNLOAD(${JAVA_DL} ${DKDOWNLOAD})
	DKINFO("Installing ${JAVA_NAME} . . . please wait")
	WIN_HOST_DKCOMMAND(${DKDOWNLOAD}/${JAVA_NAME}.exe /s INSTALLDIR=${JAVA})
else()
	DKINFO("Found cmake at ${JAVA_EXE}")
endif()

if(NOT EXISTS "${JAVA_EXE}")
	DKERROR("JAVA IS NOT FOUND OR INVALID")
endif()

DKSETENV("JAVA_HOME" ${JAVA})