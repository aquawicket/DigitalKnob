# https://www.msys2.org
# https://silentinstallhq.com/msys2-silent-install-how-to-guide

if(NOT WIN_HOST)
	dk_undepend(msys2)
	dk_return()
endif()


### INSTALL ###
dk_set(MSYS2_VERSION x86_64-20221216)
dk_set(MSYS2_DL https://github.com/msys2/msys2-installer/releases/download/2022-12-16/msys2-x86_64-20221216.exe)
dk_set(MSYS2_FOLDER msys2-${MSYS2_VERSION})
dk_set(MSYS2 ${3RDPARTY}/${MSYS2_FOLDER})

if(NOT EXISTS ${MSYS2}/msys2.exe)
	dk_info("Installing ${MSYS2_FOLDER}")
	dk_download(${MSYS2_DL} ${DKDOWNLOAD})
	dk_command(${DKDOWNLOAD}/msys2-x86_64-20221216.exe install --root ${MSYS2} --confirm-command)
	
	### ADD msys2 bin directory to path environment variable
	dk_setEnv("PATH" "${MSYS2}/usr/bin")
	
	# install needed packages
	dk_command(bash -c "pacman -S make --noconfirm")						# make
	dk_command(bash -c "pacman -S diffutils --noconfirm")					# diffutils
	dk_command(bash -c "pacman -S yasm --noconfirm")						# yasm
	dk_command(bash -c "pacman -S mingw-w64-x86_64-gcc --noconfirm")		# WIN64 builds
	dk_command(bash -c "pacman -S mingw-w64-i686-gcc --noconfirm")			# WIN32 builds
	dk_command(bash -c "pacman -S mingw-w64-x86_64-autotools --noconfirm")	# used by giflib
endif()

