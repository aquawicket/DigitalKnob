#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)

# https://git-scm.com
# https://github.com/git-for-windows/git


### DOWNLOAD ###
WIN_X86_HOST_dk_set		(GIT_DL https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-32-bit.7z.exe)
WIN_X86_64_HOST_dk_set	(GIT_DL https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe)
if(WIN_HOST AND NOT GIT_DL)
	dk_fatal("GIT_DL is invalid!")
endif()


### Get GIT variables ###
if(GIT_DL)
	dk_importVariables(${GIT_DL} rtn_var)
	dk_removeExtension(${GIT_DIR} GIT_FOLDER)
	dk_set(GIT ${DKTOOLS_DIR}/${GIT_FOLDER})
endif()


### First Check ###
if(WIN_HOST)
	dk_findProgram(GIT_EXE git ${GIT}/bin)
elseif(ANDROID_HOST)
	dk_findProgram(GIT_EXE git $ENV{PREFIX}/bin)
else()
	dk_findProgram(GIT_EXE git /usr/bin)
endif()


### INSTALL ###
if(NOT GIT_EXE)
	dk_debug(" Installing git . . . . ")
	if(WIN_HOST)
		dk_download(${GIT_DL} ${DKDOWNLOAD_DIR})			
		dk_getNativePath("${DKDOWNLOAD_DIR}/${GIT_DL_FILE}" GIT_INSTALL_FILE)
		dk_getNativePath("${DKTOOLS_DIR}/${GIT_FOLDER}" GIT_INSTALL_PATH)
		execute_process(COMMAND ${GIT_INSTALL_FILE} -y -o ${GIT_INSTALL_PATH})
		# setx PATH
	elseif(ANDROID_HOST)
		dk_command(apt -y install git)
	elseif(LINUX_HOST)
		# https://stackoverflow.com/a/27469489
		dk_depend(sudo)
		dk_command(${SUDO_EXE} apt-get -y install git)
		#dk_command(${SUDO_EXE} apt-get install apt-rdepends)
		#dk_depend(bash)
		#dk_command(${BASH_EXE} c- "cd ${DKDOWNLOAD_DIR} & apt-get download $(apt-rdepends git|grep -v '^ ' |grep -v '^debconf-2.0$')" WORKING_DIRECTORY ${DKDOWNLOAD_DIR})
	endif()
endif()


## Second Check ###
if(WIN_HOST)
	dk_findProgram(GIT_EXE git ${GIT}/bin)
	#dk_findProgram(BASH_EXE bash ${GIT}/bin)  # moved to /_DKIMPORTS/bash/DKMAKE.cmake
elseif(ANDROID_HOST)
	dk_findProgram(GIT_EXE git $ENV{PREFIX}/bin)
else()
	dk_findProgram(GIT_EXE git /usr/bin)
endif()

if(NOT GIT_EXE)
	dk_fatal("COULD NOT FIND GIT_EXE")
	return()
endif()

dk_command(${GIT_EXE} --version OUTPUT_VARIABLE GIT_VERSION)

dk_set(GIT_VERSION ${GIT_VERSION})
dk_info("###### git ######")
dk_info("${GIT_EXE}")
dk_info("${GIT_VERSION}")
return()


#if(MSYSTEM)
#	dk_depend(msys2)
#	if(NOT EXISTS ${MSYS2_DIR})
#		dk_fatal("MSYS2:${MSYS2_DIR} does not exist")
#	endif()
#	
#	dk_command(command -v git.exe OUTPUT_VARIABLE GIT_EXE NO_HALT) # BASH_ENV)
#	if(GIT_EXE)
#	dk_command(cygpath -m ${GIT_EXE} OUTPUT_VARIABLE GIT_EXE)
#	endif()
#	
#	if(NOT EXISTS ${GIT_EXE})
#		dk_delete(${MSYS2_DIR}/var/lib/pacman/db.lck NO_HALT)
#		dk_command(${PACMAN_EXE} -S git --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})
#	endif()
#	
#	dk_command(command -v git.exe OUTPUT_VARIABLE GIT_EXE) # BASH_ENV)
#	if(GIT_EXE)
#		dk_command(cygpath -m ${GIT_EXE} OUTPUT_VARIABLE GIT_EXE)
#	endif()
#
#else()
	if(WIN_HOST)
		dk_set(GIT_EXE ${DKTOOLS_DIR}/${GIT_FOLDER}/bin/git.exe)
		if(NOT EXISTS ${GIT_EXE})
			### INSTALL ###
			dk_info("Installing Git . . .")
			dk_download(${GIT_DL} ${DKDOWNLOAD_DIR})			
			dk_getNativePath("${DKDOWNLOAD_DIR}/${GIT_DL_FILE}" GIT_INSTALL_FILE)
			dk_getNativePath("${DKTOOLS_DIR}/${GIT_FOLDER}" GIT_INSTALL_PATH)
			#dk_command(${GIT_INSTALL_FILE} /DIR=${GIT_INSTALL_PATH})
			#execute_process(COMMAND ${GIT_INSTALL_FILE} /DIR=${GIT_INSTALL_PATH})
			execute_process(COMMAND ${GIT_INSTALL_FILE} -y -o ${GIT_INSTALL_PATH})
		endif()
	else()
		#dk_command(command -v git OUTPUT_VARIABLE GIT_EXE) # BASH_ENV)
		dk_depend(bash)
		dk_command(${BASH_EXE} -c "command -v git" OUTPUT_VARIABLE GIT_EXE)
		if(NOT EXISTS ${GIT_EXE})
			if(MAC_HOST)
				dk_command(brew install git)
			elseif(ANDROID_HOST)
				dk_command(apt -y install git)
			elseif(LINUX_HOST)
				dk_depend(sudo)
				dk_command(${SUDO_EXE} apt-get -y install git)
			endif()
			dk_depend(bash)
			dk_command(${BASH_EXE} -c "command -v git" OUTPUT_VARIABLE GIT_EXE)
		endif()
	endif()
#endif()

### validate GIT variables ###
#if(NOT GIT_EXE)
#	dk_fatal("GIT_EXE:${GIT_EXE} is empty")
#endif()
#if(NOT EXISTS ${GIT_EXE})
#	dk_fatal("GIT_EXE:${GIT_EXE} does not exist")
#endif()
#
#dk_set(GIT_EXE ${GIT_EXE}) # make the variable persistent
#
#### print GIT info ###
#dk_debug(GIT_EXE)
#dk_command(${GIT_EXE} --version OUTPUT_VARIABLE GIT_VERSION)
#dk_debug(GIT_VERSION)
