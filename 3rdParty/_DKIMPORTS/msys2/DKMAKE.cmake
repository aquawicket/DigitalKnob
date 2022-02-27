# https://github.com/msys2/msys2-installer/releases/download/2022-01-28/msys2-x86_64-20220128.exe
if(NOT WIN_HOST)
	return()
endif()

#DKSET(MSYS2_VERSION 20111123)
#DKSET(MSYS2_DL https://sourceforge.net/projects/mingw-w64/files/External%20binary%20packages%20%28Win64%20hosted%29/MSYS%20%2832-bit%29/MSYS-20111123.zip)
#DKSET(MSYS2_NAME msys2-${MSYS2_VERSION})
#DKSET(MSYS2 ${3RDPARTY}/${MSYS2_NAME})
#DKINSTALL(${MSYS2_DL} msys2 ${MSYS2})

DKSET(MSYS2_VERSION base-x86_64-20220128)
DKSET(MSYS2_DL https://github.com/msys2/msys2-installer/releases/download/2022-01-28/msys2-base-x86_64-20220128.sfx.exe)
DKSET(MSYS2_NAME msys2-${MSYS2_VERSION})
DKSET(MSYS2 ${3RDPARTY}/${MSYS2_NAME})
if(NOT EXISTS ${MSYS2}/msys2.exe)
	DKINFO("Installing ${MSYS2_NAME}")
	WIN_HOST_DOWNLOAD(${MSYS2_DL} ${DKDOWNLOAD})
	WIN_HOST_DKCOMMAND(${DKDOWNLOAD}/${MSYS2_NAME}.sfx.exe -o${3RDPARTY})
	DKRENAME(${3RDPARTY}/msys64 ${MSYS2} TRUE)
	
	#DKCOMMAND(${MSYS2}/usr/bin/bash -c "pacman-key --init")
	#DKCOMMAND(${MSYS2}/msys2.exe)
	DKCOMMAND(${MSYS2}/usr/bin/bash.exe -c "pacman -Syu --noconfirm")
	DKCOMMAND(${MSYS2}/usr/bin/bash.exe -c "pacman -Sy --noconfirm")
	DKCOMMAND(${MSYS2}/usr/bin/bash.exe -c "pacman -S --noconfirm --needed base-devel mingw-w64-x86_64-toolchain") # choose 15 mingw-w64-x86_64-make
	Wait()
endif()