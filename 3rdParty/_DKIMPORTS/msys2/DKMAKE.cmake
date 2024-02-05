# https://www.msys2.org
# https://silentinstallhq.com/msys2-silent-install-how-to-guide

if(NOT WIN_HOST)
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

dk_addFirewallAllow("pacman" "${MSYS2}/usr/bin/pacman.exe")

message(STATUS "msys: MSYSTEM = ${MSYSTEM}")
if(MSYSTEM)
	dk_remove(${MSYS2}/var/lib/pacman/db.lck NOERROR)
	
	if(CLANG32)						
		dk_msys2(pacman -S mingw-w64-clang-i686-toolchain --needed --noconfirm)			# toolchain
	elseif(CLANG64)
		dk_msys2(pacman -S mingw-w64-clang-x86_64-toolchain --needed --noconfirm)		# toolchain
	elseif(CLANGARM64)
		dk_msys2(pacman -S mingw-w64-clang-aarch64-toolchain --needed --noconfirm)		# toolchain
	elseif(MINGW32)
		dk_msys2(pacman -S mingw-w64-i686-toolchain --needed --noconfirm)				# toolchain
	elseif(MINGW64)
		dk_msys2(pacman -S mingw-w64-x86_64-toolchain --needed --noconfirm)				# toolchain
	elseif(UCRT64)
		dk_msys2(pacman -S mingw-w64-ucrt-x86_64-toolchain --needed --noconfirm)		# toolchain
	endif()
endif()

dk_set(MSYS2_GENERATOR "MSYS Makefiles")

