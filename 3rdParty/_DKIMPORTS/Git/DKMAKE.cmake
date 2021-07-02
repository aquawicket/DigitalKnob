### VERSION ###
DKSET(GIT_VERSION 2.31.1)

if(CMAKE_HOST_WIN32)
	DKSET(GIT "C:/Program Files/Git")
	DKSET(GIT_EXE ${GIT}/bin/git.exe)
	
	### INSTALL ###
	if(NOT EXISTS "C:/Program Files/Git")
		WIN32_PATH(${DIGITALKNOB}/Download)
		DKDOWNLOAD(https://github.com/git-for-windows/git/releases/download/v${GIT_VERSION}.windows.1/Git-${GIT_VERSION}-32-bit.exe)
		WIN32_PATH(C:/)
		DKSET(QUEUE_BUILD ON)
		WIN32_COMMAND(${DIGITALKNOB}/Download/Git-${GIT_VERSION}-32-bit.exe})
	endif()
endif()
