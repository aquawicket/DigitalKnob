# https://github.com/git-for-windows/git/releases/download/v2.31.1.windows.1/Git-2.31.1-32-bit.exe

### VERSION ###
DKSET(GIT_VERSION 2.31.1)
DKSET(GIT_NAME Git-${GIT_VERSION}-32-bit)
WIN_DKSET(GIT_DL https://github.com/git-for-windows/git/releases/download/v${GIT_VERSION}.windows.1/${GIT_NAME}.exe)
WIN_DKSET(GIT "C:/Program Files (x86)/Git")
MAC_DKSET(GIT /usr/bin)
LINUX_DKSET(GIT /usr/bin)

WIN_DKSET(GIT_EXE ${GIT}/bin/git.exe)
MAC_DKSET(GIT_EXE ${GIT}/git)
LINUX_DKSET(GIT_EXE ${GIT}/git)

### INSTALL ###
if(NOT EXISTS ${GIT_EXE})
	if(CMAKE_HOST_WIN32)	
		WIN_PATH(${DKDOWNLOAD})
		DOWNLOAD(${GIT_DL} ${DKDOWNLOAD}/${GIT_NAME}.exe)
		DKCOMMAND(${DKDOWNLOAD}/${GIT_NAME}.exe)
	endif()
	if(CMAKE_HOST_APPLE)
		DKCOMMAND("brew install git")
	endif()
	if(CMAKE_HOST_LINUX)
		DKCOMMAND("sudo apt-get -y install git")
	endif()
endif()