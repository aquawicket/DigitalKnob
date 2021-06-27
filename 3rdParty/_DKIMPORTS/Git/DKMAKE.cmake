if(NOT CMAKE_HOST_WIN32)
	return()
endif()


## VERSION ###
DKSET(GIT_VERSION 2.31.1)

### INSTALL ###
IF(NOT EXISTS "C:/Program Files/Git")
	DKSETPATH(${DIGITALKNOB}/Download)
	DKDOWNLOAD(https://github.com/git-for-windows/git/releases/download/v${GIT_VERSION}.windows.1/Git-${GIT_VERSION}-32-bit.exe)
	DKSETPATH(C:/)
	DKSET(QUEUE_BUILD ON)
	WIN32_COMMAND(${DIGITALKNOB}/Download/Git-${GIT_VERSION}-32-bit.exe})
ENDIF()

DKSET(GIT ${3RDPARTY}/${GIT_VERSION})
DKSET(GIT_EXE ${GIT}/bin/git.exe)