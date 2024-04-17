# https://www.msys2.org
# https://silentinstallhq.com/msys2-silent-install-how-to-guide

#if(NOT WIN_HOST)
#	dk_undepend(msys2)
#	dk_return()
#endif()


### INSTALL ###
dk_set(MSYS2_DL https://github.com/msys2/msys2-installer/releases/download/2023-10-26/msys2-x86_64-20231026.exe)

if(NOT MSYS2_DL_FILE)
	get_filename_component(MSYS2_DL_FILE ${MSYS2_DL} NAME)
endif()
if(MSYS2_DL_FILE)
	dk_removeExtension(${MSYS2_DL_FILE} MSYS2_FOLDER)
endif()
if(MSYS2_FOLDER)
	dk_set(MSYS2 "${DK3RDPARTY_DIR}/${MSYS2_FOLDER}")
endif()
dk_debug(MSYS2_DL_FILE)
dk_debug(MSYS2_FOLDER)
dk_debug(MSYS2)

dk_set(MSYS2_GENERATOR 		"MSYS Makefiles")	# if in Shell
#dk_set(MSYS2_GENERATOR		"MinGW Makefiles")	# if in cmd


if(NOT EXISTS ${MSYS2}/msys2.exe)
	dk_info("Installing ${MSYS2_FOLDER}")
	dk_download(${MSYS2_DL} ${DKDOWNLOAD_DIR})
	dk_command("${DKDOWNLOAD_DIR}/${MSYS2_DL_FILE}" install --root "${MSYS2}" --confirm-command)
endif()	


if(WIN_HOST AND (MSYSTEM OR ANDROID OR EMSCRIPTEN))
	dk_prependEnvPath("${MSYS2}/usr/bin")
	dk_remove("${MSYS2}/var/lib/pacman/db.lck" NOERROR)

	dk_find_program(BASH_EXE bash "${MSYS2}/usr/bin")
	dk_debug(BASH_EXE)
	dk_find_program(CYGPATH_EXE cygpath "${MSYS2}/usr/bin")
	dk_debug(CYGPATH_EXE)
	dk_find_program(PACMAN_EXE pacman "${MSYS2}/usr/bin")
	dk_debug(PACMAN_EXE)
	#dk_addFirewallAllow("pacman" "${PACMAN_EXE}")
	
	if(MSYSTEM)
		# Set PATH environment  variables
		dk_setEnv("MSYSTEM"  	"${MSYSTEM}")
		dk_setEnv("${MSYSTEM}"	ON)
		string(TOLOWER ${MSYSTEM} msystem)
		dk_prependEnvPath("${MSYS2}/${msystem}/bin")
	
		if(CLANG32)						
			dk_command(${PACMAN_EXE} -S mingw-w64-clang-i686-toolchain --needed --noconfirm)
		elseif(CLANG64)
			dk_command(${PACMAN_EXE} -S mingw-w64-clang-x86_64-toolchain --needed --noconfirm)
		elseif(CLANGARM64)
			dk_command(${PACMAN_EXE} -S mingw-w64-clang-aarch64-toolchain --needed --noconfirm)
		elseif(MINGW32)
			dk_command(${PACMAN_EXE} -S mingw-w64-i686-toolchain --needed --noconfirm)
		elseif(MINGW64)
			dk_command(${PACMAN_EXE} -S mingw-w64-x86_64-toolchain --needed --noconfirm)
		elseif(UCRT64)
			dk_command(${PACMAN_EXE} -S mingw-w64-ucrt-x86_64-toolchain --needed --noconfirm)
		endif()
	else()
		dk_set(MSYS2_BASH_EXPORTS		"export PATH=${MSYS2}/usr/bin:$PATH")
	endif()
	
	dk_command(${CYGPATH_EXE} -m "${MSYS2}" OUTPUT_VARIABLE MSYS2_CYGPATH)
	
	dk_set(CLANG32_BASH_EXPORTS		"export PATH=${MSYS2_CYGPATH}/clang32/bin:$PATH")
	dk_set(CLANG64_BASH_EXPORTS		"export PATH=${MSYS2_CYGPATH}/clang64/bin:$PATH")
	dk_set(CLANGARM64_BASH_EXPORTS	"export PATH=${MSYS2_CYGPATH}/clangarm64/bin:$PATH")
	dk_set(MINGW32_BASH_EXPORTS		"export PATH=${MSYS2_CYGPATH}/mingw32/bin:$PATH")
	dk_set(MINGW64_BASH_EXPORTS		"export PATH=${MSYS2_CYGPATH}/mingw64/bin:$PATH")
	dk_set(UCRT64_BASH_EXPORTS		"export PATH=${MSYS2_CYGPATH}/ucrt64/bin:$PATH")
	dk_set(MSYS2_BASH_EXPORTS		"export PATH=${MSYS2_CYGPATH}/usr/bin:$PATH")
endif()



