# https://github.com/git-for-windows/git/releases/download/v2.31.1.windows.1/Git-2.31.1-32-bit.exe
# TODO: get version https://stackoverflow.com/a/47084079/688352

### VERSION ###
DKSET(GIT_VERSION 2.31.1)
DKSET(GIT_NAME Git-${GIT_VERSION}-32-bit)
WIN_HOST_DKSET(GIT_DL https://github.com/git-for-windows/git/releases/download/v${GIT_VERSION}.windows.1/${GIT_NAME}.exe)
WIN_HOST_DKSET(GIT "C:/Program Files (x86)/Git")
MAC_HOST_DKSET(GIT /usr/bin)
LINUX_HOST_DKSET(GIT /usr/bin)
WIN_HOST_DKSET(GIT_EXE ${GIT}/bin/git.exe)
MAC_HOST_DKSET(GIT_EXE ${GIT}/git)
LINUX_HOST_DKSET(GIT_EXE ${GIT}/git)


### INSTALL ###
DKINFO("looking for git at ${GIT_EXE}")
if(NOT EXISTS ${GIT_EXE})
	DKINFO("git NOT FOUND")
	DKINFO("Installing git ${CMAKE_VERSION}")
	if(WIN_HOST)	
		WIN_DKSETPATH(${DKDOWNLOAD})
		DOWNLOAD(${GIT_DL} ${DKDOWNLOAD}/${GIT_NAME}.exe)
		DKCOMMAND(${DKDOWNLOAD}/${GIT_NAME}.exe)
	endif()
	if(MAC_HOST)
		DKCOMMAND(brew install git)
	endif()
	if(LINUX_HOST)
		DKCOMMAND(sudo apt-get -y install git)
	endif()
else()
	DKINFO("Found git at ${GIT_EXE}")
endif()