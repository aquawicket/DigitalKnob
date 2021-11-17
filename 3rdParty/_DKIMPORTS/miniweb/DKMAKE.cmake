# http://miniweb.sourceforge.net/
#
# https://sourceforge.net/projects/miniweb/files/miniweb/0.8/miniweb-win32-20130309.zip (binary)
# https://sourceforge.net/code-snapshots/svn/m/mi/miniweb/code/miniweb-code-r208.zip    (source code)

### DEPENDS ###
#DKDEPEND(depend_name)

### VERSION ###
DKSET(MINIWEB_VERSION 20130309)
DKSET(MINIWEB_NAME "miniweb-win32-${MINIWEB_VERSION}.exe")
DKSET(MINIWEB_DL hhttps://sourceforge.net/projects/miniweb/files/miniweb/0.8/miniweb-win32-20130309.zip)
DKSET(MINIWEB "${3RDPARTY}/${MINIWEB_NAME}")
DKSET(MINIWEB_EXE "${MINIWEB}/miniweb.exe")

### INSTALL ###
IF(NOT EXISTS "${MINIWEB_EXE}")
	MESSAGE(STATUS "Installing ${MINIWEB_NAME}")
	DOWNLOAD(${MINIWEB_DL} ${DKDOWNLOAD}/${MINIWEB_NAME})
	DKCOMMAND(${DKDOWNLOAD}/${MINIWEB_NAME})
ENDIF()
