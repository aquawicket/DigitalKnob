#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	file(REAL_PATH "~/digitalknob/Development/DKCMake/functions" DKCMAKE_FUNCTIONS_DIR EXPAND_TILDE)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "$ENV{DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()


############ git ############
# https://git-scm.com
# https://github.com/git-for-windows/git
dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParam("$ENV{DKIMPORTS_DIR}/git/dkconfig.txt" GIT_DL_WIN_X86)
dk_getFileParam("$ENV{DKIMPORTS_DIR}/git/dkconfig.txt" GIT_DL_WIN_X86_64)

### DOWNLOAD ###
dk_validate(host_triple "dk_host_triple()")
if(WIN_X86_HOST)
	set(GIT_DL "${GIT_DL_WIN_X86}")
endif()
if(WIN_X86_64_HOST)
	set(GIT_DL "${GIT_DL_WIN_X86_64}")
endif()
if(WIN_HOST AND NOT GIT_DL)
	dk_fatal("GIT_DL is invalid!")
endif()

### GIT variables ###
if(GIT_DL)
	dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
	dk_importVariables(${GIT_DL} ROOT $ENV{DKTOOLS_DIR})
endif()

### First Check ###
if(WIN_HOST)
	dk_debug("dk_findProgram(GIT_EXE git.exe ${GIT}/bin)")
	dk_findProgram(GIT_EXE git.exe ${GIT}/bin)
elseif(ANDROID_HOST)
	dk_findProgram(GIT_EXE git $ENV{PREFIX}/bin)
else()
	dk_findProgram(GIT_EXE git /usr/bin)
endif()

### INSTALL ###
if(NOT GIT_EXE)
	dk_debug(" Installing git . . . . ")
	if(WIN_HOST)
		dk_download(${GIT_DL} $ENV{DKDOWNLOAD_DIR})			
		dk_nativePath("$ENV{DKDOWNLOAD_DIR}/${GIT_DL_FILE}" GIT_INSTALL_FILE)
		dk_nativePath("${GIT}" GIT_INSTALL_PATH)
		execute_process(COMMAND ${GIT_INSTALL_FILE} -y -o ${GIT_INSTALL_PATH} COMMAND_ECHO STDOUT)
		# setx PATH
	elseif(ANDROID_HOST)
		dk_installPackage(git)
	elseif(LINUX_HOST)
		# https://stackoverflow.com/a/27469489z
		#dk_command(${SUDO_EXE} apt-get -y install git)
		#dk_command(${SUDO_EXE} apt-get install apt-rdepends)
		#dk_command(${BASH_EXE} c- "cd $ENV{DKDOWNLOAD_DIR} & apt-get download $(apt-rdepends git|grep -v '^ ' |grep -v '^debconf-2.0$')" WORKING_DIRECTORY $ENV{DKDOWNLOAD_DIR})
		dk_installPackage(git)
	endif()
endif()

## Second Check ###
if(WIN_HOST)
	dk_findProgram(GIT_EXE git ${GIT}/bin)
elseif(ANDROID_HOST)
	dk_findProgram(GIT_EXE git $ENV{PREFIX}/bin)
else()
	dk_findProgram(GIT_EXE git /usr/bin)
endif()

dk_assertPath(GIT_EXE)

dk_command(${GIT_EXE} --version OUTPUT_VARIABLE GIT_VERSION)

set(GIT_VERSION ${GIT_VERSION})
dk_info("###### git ######")
dk_info("${GIT_EXE}")
dk_info("${GIT_VERSION}")
dk_return()


#if(MSYSTEM)
#	dk_validate(MSYS2 "dk_depend(msys2)")
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
#		dk_command(${PACMAN_EXE} -S git --needed --noconfirm --cachedir ${MSYS2_CacheDir})
#	endif()
#	
#	dk_command(command -v git.exe OUTPUT_VARIABLE GIT_EXE) # BASH_ENV)
#	if(GIT_EXE)
#		dk_command(cygpath -m ${GIT_EXE} OUTPUT_VARIABLE GIT_EXE)
#	endif()
#
#else()


#	if(WIN_HOST)
#		dk_set(GIT_EXE ${GIT}/bin/git.exe)
#		if(NOT EXISTS ${GIT_EXE})
#			### INSTALL ###
#			dk_info("Installing Git . . .")
#			dk_download(${GIT_DL} $ENV{DKDOWNLOAD_DIR})			
#			dk_nativePath("$ENV{DKDOWNLOAD_DIR}/${GIT_DL_FILE}" GIT_INSTALL_FILE)
#			dk_nativePath("${GIT}" GIT_INSTALL_PATH)
#			#dk_command(${GIT_INSTALL_FILE} /DIR=${GIT_INSTALL_PATH})
#			#execute_process(COMMAND ${GIT_INSTALL_FILE} /DIR=${GIT_INSTALL_PATH})
#			execute_process(COMMAND ${GIT_INSTALL_FILE} -y -o ${GIT_INSTALL_PATH})
#		endif()
#	else()
#		#dk_command(command -v git OUTPUT_VARIABLE GIT_EXE) # BASH_ENV)
#		dk_depend(bash)
#		dk_command(${BASH_EXE} -c "command -v git" OUTPUT_VARIABLE GIT_EXE)
#		if(NOT EXISTS ${GIT_EXE})
#			dk_install(git)
#			dk_depend(bash)
#			dk_command(${BASH_EXE} -c "command -v git" OUTPUT_VARIABLE GIT_EXE)
#		endif()
#	endif()
	
	
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
