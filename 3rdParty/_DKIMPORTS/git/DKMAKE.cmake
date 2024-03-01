# https://git-scm.com
# https://github.com/git-for-windows/git/releases/download/v2.31.1.windows.1/Git-2.31.1-32-bit.exe

if(EXISTS ${GIT_EXE})
	dk_debug("GIT_EXE already set to: ${GIT_EXE}")
	return()
endif()


### DOWNLOAD ###
WIN_X86_HOST_dk_set		(GIT_DL https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-32-bit.exe)
WIN_X86_64_HOST_dk_set	(GIT_DL https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe)
if(GIT_DL)
	get_filename_component(GIT_DL_FILE ${GIT_DL} NAME)
	dk_removeExtension(${GIT_DL_FILE} GIT_FOLDER)
	string(MAKE_C_IDENTIFIER ${GIT_FOLDER} GIT_FOLDER)
	string(TOLOWER ${GIT_FOLDER} GIT_FOLDER)
endif()


if(MSYSTEM)
	dk_depend(msys2)
	if(NOT EXISTS ${MSYS2})
		dk_error("MSYS2:${MSYS2} does not exist")
	endif()
	
	dk_command(command -v git.exe OUTPUT_VARIABLE GIT_EXE NOASSERT)
	if(GIT_EXE)
	dk_command(cygpath -m ${GIT_EXE} OUTPUT_VARIABLE GIT_EXE)
	endif()
	
	if(NOT EXISTS ${GIT_EXE})
		dk_remove(${MSYS2}/var/lib/pacman/db.lck NOERROR)
		dk_command(pacman -S git --needed --noconfirm)
	endif()
	
	dk_command(command -v git.exe OUTPUT_VARIABLE GIT_EXE)
	dk_command(cygpath -m ${GIT_EXE} OUTPUT_VARIABLE GIT_EXE)

else()
	if(WIN_HOST)
		dk_set(GIT_EXE ${DKTOOLS_DIR}/${GIT_FOLDER}/bin/git.exe)
		message(STATUS "GIT_EXE = ${GIT_EXE}")
		if(NOT EXISTS ${GIT_EXE})
			### INSTALL ###
			dk_info("Installing Git . . .")
			dk_download(${GIT_DL} ${DKDOWNLOAD})			
			file(TO_NATIVE_PATH "${DKDOWNLOAD}/${GIT_DL_FILE}" GIT_INSTALL_FILE)
			file(TO_NATIVE_PATH "${DKTOOLS_DIR}/${GIT_FOLDER}" GIT_INSTALL_PATH)
			message(STATUS "${GIT_INSTALL_FILE} /DIR=${GIT_INSTALL_PATH}")
			#dk_command(${GIT_INSTALL_FILE} /DIR=${GIT_INSTALL_PATH})
			execute_process(COMMAND ${GIT_INSTALL_FILE} /DIR=${GIT_INSTALL_PATH})
		endif()
	else()
		dk_command(sh -c "command -v git" OUTPUT_VARIABLE GIT_EXE)
		if(NOT EXISTS ${GIT_EXE})
			MAC_HOST_dk_command(brew install git)
			ANDROID_HOST_dk_command(apt -y install git)
			LINUX_HOST_dk_command(sudo apt-get -y install git)
			dk_command(sh -c "command -v git" OUTPUT_VARIABLE GIT_EXE)
		endif()
	endif()
endif()

### validate GIT variables ###
if(NOT GIT_EXE)
	dk_error("GIT_EXE:${GIT_EXE} is empty")
endif()
if(NOT EXISTS ${GIT_EXE})
	dk_error("GIT_EXE:${GIT_EXE} does not exist")
endif()


### print GIT info ###
dk_debug("GIT_EXE = ${GIT_EXE}")
dk_command(${GIT_EXE} --version OUTPUT_VARIABLE GIT_VERSION)
dk_debug("GIT_VERSION = ${GIT_VERSION}")
