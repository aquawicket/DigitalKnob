### VERSION ###
DKSET(GIT_VERSION 2.31.1)
DKSET(GIT "C:/Program Files/Git")
DKSET(GIT_EXE ${GIT}/bin/git.exe)

### INSTALL ###
if(CMAKE_HOST_WIN32)
	if(NOT EXISTS ${GIT_EXE})
		WIN32_PATH(${DIGITALKNOB}/Download)
		# https://github.com/git-for-windows/git/releases/download/v2.31.1.windows.1/Git-2.31.1-32-bit.exe
		DKDOWNLOAD(https://github.com/git-for-windows/git/releases/download/v${GIT_VERSION}.windows.1/Git-${GIT_VERSION}-32-bit.exe)
		DKSET(QUEUE_BUILD ON)
		WIN32_COMMAND(${DIGITALKNOB}/Download/Git-${GIT_VERSION}-32-bit.exe})
	endif()
endif()


