include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://www.msys2.org
# https://silentinstallhq.com/msys2-silent-install-how-to-guide

### We only accesp windows hosts
dk_validate(HOST_TRIPLE "dk_getHostTriple()")
if(NOT WIN_HOST)
	dk_undepend(msys2)
	dk_return()
endif()






### Set CMAKE_GENERATOR ###
dk_validate(CMD_EXE "dk_depend(cmd)")
if(CMD_EXE OR MINGW)
	dk_set(MSYS2_GENERATOR	"MinGW Makefiles")	# if in cmd
else()
	dk_set(MSYS2_GENERATOR 	"MSYS Makefiles")	# if in Shell
endif()
if(NOT CMAKE_GENERATOR AND MSYS2_GENERATOR)
	dk_set(CMAKE_GENERATOR ${MSYS2_GENERATOR})
endif()

### Return if MSYS2_EXE is already set
if(EXISTS ${MSYS2_EXE})
	dk_return()
endif()


### INSTALL ###
dk_set(MSYS2_DL https://github.com/msys2/msys2-installer/releases/download/2024-07-27/msys2-x86_64-20240727.exe)


### Get MSYS2 and MSYS2_EXE variables ###
dk_basename(${MSYS2_DL} MSYS2_DL_FILE)
dk_removeExtension(${MSYS2_DL_FILE} MSYS2_FOLDER)
dk_validate(DK3RDPARTY_DIR "dk_validateBranch()")
dk_set(MSYS2 "${DK3RDPARTY_DIR}/${MSYS2_FOLDER}")
dk_set(MSYS2_EXE "${MSYS2}/msys2.exe")


### Install Msys2 ###
if(NOT EXISTS ${MSYS2_EXE})
	dk_info("Installing ${MSYS2_FOLDER}")
	dk_download(${MSYS2_DL} ${DKDOWNLOAD_DIR})
	dk_command("${DKDOWNLOAD_DIR}/${MSYS2_DL_FILE}" install --root "${MSYS2}" --confirm-command)
endif()	









dk_validate(TARGET_TRIPLE  "dk_getTargetTriple()")
if(WIN_HOST AND (MSYSTEM OR ANDROID OR EMSCRIPTEN))
	dk_prependEnvPath("${MSYS2}/usr/bin")
	dk_delete("${MSYS2}/var/lib/pacman/db.lck" NO_HALT)
 
	### Install toolchain ###
	if(MSYSTEM)
		# Set PATH environment  variables
		dk_setEnv("MSYSTEM"  	"${MSYSTEM}")
		dk_setEnv("${MSYSTEM}"	ON)
		dk_toLower(${MSYSTEM} msystem)
		dk_prependEnvPath("${MSYS2}/${msystem}/bin")
		
		dk_validate(PACMAN_EXE  "dk_depend(pacman)")
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
		dk_set(MSYS2_BASH_EXPORTS		"export PATH=${MSYS2}/usr/bin:$PATH")
	endif()
	
	### Create Bash Exports ###
	dk_validate(CYGPATH_EXE  "dk_depend(cygpath)")
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


