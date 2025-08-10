#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ git ############
# https://git-scm.com
# https://github.com/git-for-windows/git

dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_validate(Host_Tuple "dk_Host_Tuple()")
set(git_Import "${git_${Host_Tuple}_Import}")
dk_assertVar(git_Import)


### GIT variables ###
dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
dk_importVariables(${git_Import} IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR} INSTALL_ROOT $ENV{DKTOOLS_DIR})


### First Check ###
if(Windows_Host)
	dk_assertVar(GIT)
	dk_findProgram(GIT_EXE git.exe ${GIT}/bin)
elseif(Android_Host)
	dk_findProgram(GIT_EXE git $ENV{PREFIX}/bin)
else()
	dk_findProgram(GIT_EXE git /usr/bin)
endif()

### INSTALL ###
if(NOT GIT_EXE)
	dk_debug(" Installing git . . . . ")
	if(Windows_Host)
		dk_download(${git_Import})			
		#dk_nativePath("${dk_download}" GIT_INSTALL_FILE)
		#dk_nativePath("${GIT}" GIT_INSTALL_PATH)
		#execute_process(COMMAND ${GIT_INSTALL_FILE} -y -o ${GIT_INSTALL_PATH} COMMAND_ECHO STDOUT)
		dk_exec(${dk_download} -y -o ${GIT})
	elseif(Android_Host)
		dk_installPackage(git)
	elseif(Linux_Host)
		# https://stackoverflow.com/a/27469489z
		#dk_exec(${SUDO_EXE} apt-get -y install git)
		#dk_exec(${SUDO_EXE} apt-get install apt-rdepends)
		#dk_exec(${BASH_EXE} c- "cd $ENV{DKDOWNLOAD_DIR} & apt-get download $(apt-rdepends git|grep -v '^ ' |grep -v '^debconf-2.0$')" WORKING_DIRECTORY $ENV{DKDOWNLOAD_DIR})
		dk_installPackage(git)
	endif()
endif()

## Second Check ###
if(Windows_Host)
	dk_findProgram(GIT_EXE git ${GIT}/bin)
elseif(Android_Host)
	dk_findProgram(GIT_EXE git $ENV{PREFIX}/bin)
else()
	dk_findProgram(GIT_EXE git /usr/bin)
endif()

dk_assertPath(GIT_EXE)

dk_exec(${GIT_EXE} --version OUTPUT_VARIABLE GIT_VERSION)

set(GIT_VERSION ${GIT_VERSION})
dk_info("###### git ######")
dk_info("${GIT_EXE}")
dk_info("${GIT_VERSION}")
dk_printVar(GIT)
dk_return()


#if(MSYSTEM)
#	dk_validate(MSYS2 "dk_depend(msys2)")
#	if(NOT EXISTS ${MSYS2_DIR})
#		dk_fatal("MSYS2:${MSYS2_DIR} does not exist")
#	endif()
#	
#	dk_exec(command -v git.exe OUTPUT_VARIABLE GIT_EXE NO_HALT) # BASH_ENV)
#	if(GIT_EXE)
#	dk_exec(cygpath -m ${GIT_EXE} OUTPUT_VARIABLE GIT_EXE)
#	endif()
#	
#	if(NOT EXISTS ${GIT_EXE})
#		dk_exec(${PACMAN_EXE} -S git --needed --noconfirm --cachedir ${MSYS2_CacheDir})
#	endif()
#	
#	dk_exec(command -v git.exe OUTPUT_VARIABLE GIT_EXE) # BASH_ENV)
#	if(GIT_EXE)
#		dk_exec(cygpath -m ${GIT_EXE} OUTPUT_VARIABLE GIT_EXE)
#	endif()
#
#else()


#	if(Windows_Host)
#		dk_set(GIT_EXE ${GIT}/bin/git.exe)
#		if(NOT EXISTS ${GIT_EXE})
#			### INSTALL ###
#			dk_info("Installing Git . . .")
#			dk_download(${git_Import} $ENV{DKDOWNLOAD_DIR})			
#			dk_nativePath("$ENV{DKDOWNLOAD_DIR}/${GIT_IMPORT_FILE}" GIT_INSTALL_FILE)
#			dk_nativePath("${GIT}" GIT_INSTALL_PATH)
#			#dk_exec(${GIT_INSTALL_FILE} /DIR=${GIT_INSTALL_PATH})
#			#execute_process(COMMAND ${GIT_INSTALL_FILE} /DIR=${GIT_INSTALL_PATH})
#			execute_process(COMMAND ${GIT_INSTALL_FILE} -y -o ${GIT_INSTALL_PATH})
#		endif()
#	else()
#		#dk_exec(command -v git OUTPUT_VARIABLE GIT_EXE) # BASH_ENV)
#		dk_depend(bash)
#		dk_exec(${BASH_EXE} -c "command -v git" OUTPUT_VARIABLE GIT_EXE)
#		if(NOT EXISTS ${GIT_EXE})
#			dk_install(git)
#			dk_depend(bash)
#			dk_exec(${BASH_EXE} -c "command -v git" OUTPUT_VARIABLE GIT_EXE)
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
#dk_exec(${GIT_EXE} --version OUTPUT_VARIABLE GIT_VERSION)
#dk_debug(GIT_VERSION)
