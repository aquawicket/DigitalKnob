# https://www.msys2.org
# https://github.com/msys2/msys2-installer/releases/download/2022-01-28/msys2-x86_64-20220128.exe

if(NOT WIN_HOST)
	dk_undepend(msys2)
	dk_return()
endif()

dk_set(MSYS2_VERSION base-x86_64-20220128)
dk_set(MSYS2_DL https://github.com/msys2/msys2-installer/releases/download/2022-01-28/msys2-base-x86_64-20220128.sfx.exe)
dk_set(MSYS2_NAME msys2-${MSYS2_VERSION})
dk_set(MSYS2 ${3RDPARTY}/${MSYS2_NAME})
if(NOT EXISTS ${MSYS2}/msys2.exe)
	dk_info("Installing ${MSYS2_NAME}")
	WIN_HOST_dk_download(${MSYS2_DL} ${DKDOWNLOAD})
	WIN_HOST_dk_command(${DKDOWNLOAD}/${MSYS2_NAME}.sfx.exe -o${3RDPARTY})
	dk_rename(${3RDPARTY}/msys64 ${MSYS2} OVERWRITE)
	#dk_command(${MSYS2}/usr/bin/bash -c "pacman-key --init")
	#dk_command(${MSYS2}/msys2.exe)
	dk_command(${MSYS2}/usr/bin/bash.exe -c "pacman -Syu --noconfirm")
	dk_command(${MSYS2}/usr/bin/bash.exe -c "pacman -Sy --noconfirm")
	dk_command(${MSYS2}/usr/bin/bash.exe -c "pacman -S --noconfirm --needed base-devel mingw-w64-x86_64-make")
	dk_command(${MSYS2}/usr/bin/bash.exe -c "pacman -S --noconfirm --needed base-devel mingw-w64-x86_64-diffutils")
endif()
