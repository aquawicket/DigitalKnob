# https://github.com/git-for-windows/git/releases/download/v2.31.1.windows.1/Git-2.31.1-32-bit.exe

### VERSION ###
DKSET(GIT_VERSION 2.31.1)
DKSET(GIT_NAME Git-${GIT_VERSION}-32-bit)
WIN_DKSET(GIT_DL https://github.com/git-for-windows/git/releases/download/v${GIT_VERSION}.windows.1/${GIT_NAME}.exe)
WIN_DKSET(GIT "C:/Program Files/Git")
WIN_DKSET(GIT_EXE ${GIT}/bin/git.exe)

### INSTALL ###
if(NOT EXISTS ${GIT_EXE})
if(CMAKE_HOST_WIN32)	
	WIN_PATH(${DIGITALKNOB}/Download)
	DOWNLOAD(${GIT_DL})
	DKCOMMAND(${DIGITALKNOB}/Download/${GIT_NAME}.exe})
endif()
endif()