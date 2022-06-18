# http://miniweb.sourceforge.net/
#
# https://sourceforge.net/projects/miniweb/files/miniweb/0.8/miniweb-win32-20130309.zip (binary)
# https://sourceforge.net/code-snapshots/svn/m/mi/miniweb/code/miniweb-code-r208.zip    (source code)

### DEPENDS ###
#DKDEPEND(depend_name)

### VERSION ###
dk_set(MINIWEB_VERSION 20130309)
dk_set(MINIWEB_NAME "miniweb-win32-${MINIWEB_VERSION}.exe")
dk_set(MINIWEB_DL https://sourceforge.net/projects/miniweb/files/miniweb/0.8/miniweb-win32-20130309.zip)
dk_set(MINIWEB "${3RDPARTY}/${MINIWEB_NAME}")
dk_set(MINIWEB_EXE "${MINIWEB}/miniweb.exe")

### INSTALL ###
IF(NOT EXISTS "${MINIWEB_EXE}")
	MESSAGE(STATUS "Installing ${MINIWEB_NAME}")
	dk_download(${MINIWEB_DL} ${DKDOWNLOAD}/${MINIWEB_NAME})
	DKCOMMAND(${DKDOWNLOAD}/${MINIWEB_NAME})
ENDIF()
