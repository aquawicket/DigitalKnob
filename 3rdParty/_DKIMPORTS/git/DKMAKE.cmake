# https://github.com/git-for-windows/git/releases/download/v2.31.1.windows.1/Git-2.31.1-32-bit.exe
# TODO: get version https://stackoverflow.com/a/47084079/688352

### VERSION ###
dk_set(GIT_VERSION 2.31.1)
dk_set(GIT_NAME Git-${GIT_VERSION}-32-bit)
WIN_HOST_dk_set(GIT_DL https://github.com/git-for-windows/git/releases/download/v${GIT_VERSION}.windows.1/${GIT_NAME}.exe)
WIN_HOST_dk_set(GIT "C:/Program Files (x86)/Git")
MAC_HOST_dk_set(GIT /usr/bin)
#LINUX_HOST_dk_set(GIT /usr/bin)
LINUX_HOST_dk_set(GIT /usr/local/bin)
WIN_HOST_dk_set(GIT_EXE ${GIT}/bin/git.exe)
MAC_HOST_dk_set(GIT_EXE ${GIT}/git)
LINUX_HOST_dk_set(GIT_EXE ${GIT}/git)


### INSTALL ###
#dk_info("looking for git at ${GIT_EXE}")
if(NOT EXISTS ${GIT_EXE})
	dk_debug("git NOT FOUND")
	dk_info("Installing git ${CMAKE_VERSION}")
	if(WIN_HOST)
		WIN_dk_setPath(${DKDOWNLOAD})
		dk_download(${GIT_DL} ${DKDOWNLOAD}/${GIT_NAME}.exe)
		dk_command(${DKDOWNLOAD}/${GIT_NAME}.exe)
	endif()
	if(MAC_HOST)
		dk_command(brew install git)
	endif()
	if(LINUX_HOST)
		dk_command(sudo apt-get -y install git)
	endif()
endif()

if(NOT EXISTS "${GIT_EXE}")
	dk_assert("GIT IS NOT FOUND OR INVALID")
endif()
