include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://www.msys2.org

### We only accesp windows hosts
dk_validate(HOST_TRIPLE "dk_HOST_TRIPLE()")
if(NOT WIN_HOST)
	dk_undepend(msys2)
	dk_return()
endif()

### Return if MSYS2_EXE is already set
#if(EXISTS ${MSYS2_EXE})
#	dk_return()
#endif()


dk_validate(TARGET_TRIPLE "dk_TARGET_TRIPLE()")
if(WIN_HOST AND (MSYSTEM OR ANDROID OR EMSCRIPTEN))
	dk_prependEnvPath("${MSYS2_DIR}/usr/bin")
	
	### Install toolchain ###
	if(MSYSTEM)
		# Set PATH environment  variables
		dk_setEnv("MSYSTEM"  	"${MSYSTEM}")
		dk_setEnv("${MSYSTEM}"	ON)
		dk_toLower(${MSYSTEM} msystem)
		dk_prependEnvPath("${MSYS2_DIR}/${msystem}/bin")
		
		dk_validate(PACMAN_EXE  "dk_depend(pacman)")
		dk_delete("${MSYS2_DIR}/var/lib/pacman/db.lck" NO_HALT)
		if(win_x86_clang)					
			dk_command(${PACMAN_EXE} -S mingw-w64-clang-i686-toolchain --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})
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
		dk_set(MSYS2_BASH_EXPORTS		"export PATH=${MSYS2_DIR}/usr/bin:$PATH")
	endif()
	
	### Create Bash Exports ###
	dk_validate(CYGPATH_EXE  "dk_depend(cygpath)")
	dk_command(${CYGPATH_EXE} -m "${MSYS2_DIR}" OUTPUT_VARIABLE MSYS2_CYGPATH)
	
	dk_set(CLANG32_BASH_EXPORTS		"export PATH=${MSYS2_CYGPATH}/clang32/bin:$PATH")
	dk_set(CLANG64_BASH_EXPORTS		"export PATH=${MSYS2_CYGPATH}/clang64/bin:$PATH")
	dk_set(CLANGARM64_BASH_EXPORTS	"export PATH=${MSYS2_CYGPATH}/clangarm64/bin:$PATH")
	dk_set(MINGW32_BASH_EXPORTS		"export PATH=${MSYS2_CYGPATH}/mingw32/bin:$PATH")
	dk_set(MINGW64_BASH_EXPORTS		"export PATH=${MSYS2_CYGPATH}/mingw64/bin:$PATH")
	dk_set(UCRT64_BASH_EXPORTS		"export PATH=${MSYS2_CYGPATH}/ucrt64/bin:$PATH")
	dk_set(MSYS2_BASH_EXPORTS		"export PATH=${MSYS2_CYGPATH}/usr/bin:$PATH")
	
	dk_set(CLANG64_EXE ${MSYS2_DIR}/clang64.exe)
endif()
