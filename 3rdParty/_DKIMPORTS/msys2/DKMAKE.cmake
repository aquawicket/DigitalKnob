# https://www.msys2.org
# https://silentinstallhq.com/msys2-silent-install-how-to-guide

if(NOT WIN)
	dk_undepend(msys2)
	dk_return()
endif()


### INSTALL ###
dk_set(MSYS2_DL https://github.com/msys2/msys2-installer/releases/download/2023-10-26/msys2-x86_64-20231026.exe)

get_filename_component(MSYS2_DL_FILE ${MSYS2_DL} NAME)
dk_removeExtension(${MSYS2_DL_FILE} MSYS2_FOLDER)
dk_set(MSYS2 ${3RDPARTY}/${MSYS2_FOLDER})

if(NOT EXISTS ${MSYS2}/msys2.exe)
	dk_info("Installing ${MSYS2_FOLDER}")
	dk_download(${MSYS2_DL} ${DKDOWNLOAD})
	dk_command(${DKDOWNLOAD}/${MSYS2_DL_FILE} install --root ${MSYS2} --confirm-command)
endif()	


### ADD msys2 bin directory to path environment variable
#dk_setEnv("PATH" "${MSYS2}/usr/bin")

if(MSYS)
	set(MSYSTEM "$ENV{MSYSTEM}")
	dk_debug("MSYSTEM = ${MSYSTEM}")
endif()

if(NOT MSYSTEM)
	return()
endif()
	
if(${MSYSTEM} STREQUAL "CLANG32")							
	dk_msys2(pacman -S mingw-w64-clang-i686-toolchain --noconfirm)			# toolchain
elseif(${MSYSTEM} STREQUAL "CLANG64")
	dk_msys2(pacman -S mingw-w64-clang-x86_64-toolchain --noconfirm)		# toolchain
elseif(${MSYSTEM} STREQUAL "CLANGARM64")
	dk_msys2(pacman -S mingw-w64-clang-aarch64-toolchain --noconfirm)		# toolchain
elseif(${MSYSTEM} STREQUAL "MINGW32")
	dk_msys2(pacman -S mingw-w64-i686-toolchain --noconfirm)				# toolchain
elseif(${MSYSTEM} STREQUAL "MINGW64")
	dk_msys2(pacman -S mingw-w64-x86_64-toolchain --noconfirm)				# toolchain
elseif(${MSYSTEM} STREQUAL "UCRT64")
	dk_msys2(pacman -S mingw-w64-ucrt-x86_64-toolchain --noconfirm)			# toolchain
else()
	dk_error("MSYSTEM is invalid")
endif()

### Install other utilities ###
#if(NOT EXISTS ${MSYS2}/usr/bin/make.exe)
	#dk_command(bash -c "pacman -S make --noconfirm")						# make
#	dk_msys2("pacman -S make --noconfirm")									# make
#endif()

#if(NOT EXISTS ${MSYS2}/usr/bin/diff.exe)
	#dk_command(bash -c "pacman -S diffutils --noconfirm")					# diffutils
#	dk_msys2("pacman -S diffutils --noconfirm")								# diffutils
#endif()

#if(NOT EXISTS ${MSYS2}/usr/bin/yasm.exe)
	#dk_command(bash -c "pacman -S yasm --noconfirm")						# yasm
#	dk_msys2("pacman -S yasm --noconfirm")									# yasm
#endif()

