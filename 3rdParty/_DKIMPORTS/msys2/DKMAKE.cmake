include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_validate(DK_HOST_TRIPLE "dk_getHostTriple()")
dk_validate(DK_TARGET_TRIPLE  "dk_setTargetTriple()")
# https://www.msys2.org
# https://silentinstallhq.com/msys2-silent-install-how-to-guide


#if(NOT WIN_HOST)
#	dk_undepend(msys2)
#	dk_return()
#endif()


### INSTALL ###
#dk_set(MSYS2_DL https://github.com/msys2/msys2-installer/releases/download/2023-10-26/msys2-x86_64-20231026.exe)
dk_set(MSYS2_DL https://github.com/msys2/msys2-installer/releases/download/2024-07-27/msys2-x86_64-20240727.exe)
dk_assert(MSYS2_DL)

dk_basename(${MSYS2_DL} MSYS2_DL_FILE)
dk_removeExtension(${MSYS2_DL_FILE} MSYS2_FOLDER)

dk_validate(DK3RDPARTY_DIR "dk_getDKPaths()")
dk_set(MSYS2 "${DK3RDPARTY_DIR}/${MSYS2_FOLDER}")

dk_printVar(MSYS2_DL_FILE)
dk_printVar(MSYS2_FOLDER)
dk_printVar(MSYS2)

if(WIN_HOST)
	dk_findProgram(CMD_EXE cmd.exe)
endif()
if(CMD_EXE OR MINGW)
	dk_set(MSYS2_GENERATOR		"MinGW Makefiles")	# if in cmd
else()
	dk_set(MSYS2_GENERATOR 		"MSYS Makefiles")	# if in Shell
endif()


if(NOT EXISTS ${MSYS2}/msys2.exe)
	dk_info("Installing ${MSYS2_FOLDER}")
	dk_download(${MSYS2_DL} ${DKDOWNLOAD_DIR})
	dk_command("${DKDOWNLOAD_DIR}/${MSYS2_DL_FILE}" install --root "${MSYS2}" --confirm-command)
endif()	


if(WIN_HOST AND (MSYSTEM OR ANDROID OR EMSCRIPTEN))
	dk_prependEnvPath("${MSYS2}/usr/bin")
	dk_delete("${MSYS2}/var/lib/pacman/db.lck" NO_HALT)

	
	dk_findProgram(CYGPATH_EXE cygpath "${MSYS2}/usr/bin")
	dk_debug(CYGPATH_EXE)
	dk_findProgram(PACMAN_EXE pacman "${MSYS2}/usr/bin")
	dk_debug(PACMAN_EXE)
	#dk_firewallAllow("pacman" "${PACMAN_EXE}")
	
	if(MSYSTEM)
		# Set PATH environment  variables
		dk_setEnv("MSYSTEM"  	"${MSYSTEM}")
		dk_setEnv("${MSYSTEM}"	ON)
		dk_toLower(${MSYSTEM} msystem)
		dk_prependEnvPath("${MSYS2}/${msystem}/bin")
	
		if(win_x86_clang)					
			dk_command(${PACMAN_EXE} -S mingw-w64-clang-i686-toolchain --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})
			#mingw-w64-clang-i686-clang
			#mingw-w64-clang-i686-clang-analyzer
			#mingw-w64-clang-i686-clang-libs
			#mingw-w64-clang-i686-clang-tools-extra
			#mingw-w64-clang-i686-compiler-rt
			#mingw-w64-clang-i686-lld
			#mingw-w64-clang-i686-llvm
			#mingw-w64-clang-i686-llvm-libs
			#mingw-w64-clang-i686-crt-git
			#mingw-w64-clang-i686-headers-git
			#mingw-w64-clang-i686-libc++
			#mingw-w64-clang-i686-libunwind
			#mingw-w64-clang-i686-libmangle-git
			#mingw-w64-clang-i686-libwinpthread-git
			#mingw-w64-clang-i686-winpthreads-git
			#mingw-w64-clang-i686-lldb
			#mingw-w64-clang-i686-make
			#mingw-w64-clang-i686-pkgconf
			#mingw-w64-clang-i686-tools-git
			#mingw-w64-clang-i686-winstorecompat-git
			#mingw-w64-clang-i686-llvm-openmp
		elseif(win_x86_64_clang)	
			dk_command(${PACMAN_EXE} -S mingw-w64-clang-x86_64-toolchain --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})
		elseif(win_arm64_clang)
			dk_command(${PACMAN_EXE} -S mingw-w64-clang-aarch64-toolchain --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})
		elseif(win_x86_mingw)
			dk_command(${PACMAN_EXE} -S mingw-w64-i686-toolchain --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})
		elseif(win_x86_64_mingw)
			dk_command(${PACMAN_EXE} -S mingw-w64-x86_64-toolchain --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})
		elseif(win_x86_64_ucrt)
			dk_command(${PACMAN_EXE} -S mingw-w64-ucrt-x86_64-toolchain --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})
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
	
	dk_set(CLANG64_EXE ${MSYS2}/clang64.exe)
endif()
