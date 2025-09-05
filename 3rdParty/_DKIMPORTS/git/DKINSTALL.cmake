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

#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
#dk_validate(Host_Tuple "dk_Host_Tuple()")
#set(git_Import "${git_${Host_Tuple}_Import}")
#dk_assertVar(git_Import)


### git variables ###
#dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
#dk_importVariables(${git_Import} IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR} INSTALL_ROOT $ENV{DKTOOLS_DIR})
dk_import(APP)

### First Check ###
if(Windows_Host)
	dk_assertVar(git)
	dk_findProgram(git_exe git.exe ${git}/bin)
elseif(Android_Host)
	dk_findProgram(git_exe git $ENV{PREFIX}/bin)
else()
	dk_findProgram(git_exe git /usr/bin)
endif()

### INSTALL ###
if(NOT git_exe)
	dk_debug(" Installing git . . . . ")
	if(Windows_Host)
		dk_download(${git_Import})			
		#dk_nativePath("${dk_download}" GIT_INSTALL_FILE)
		#dk_nativePath("${git}" GIT_INSTALL_PATH)
		dk_exec(${dk_download} -y -o ${git})
	elseif(Android_Host)
		dk_installPackage(git)
	elseif(Linux_Host)
		# https://stackoverflow.com/a/27469489z
		#dk_exec(${sudo_exe} apt-get -y install git)
		#dk_exec(${sudo_exe} apt-get install apt-rdepends)
		#dk_exec(${bash_exe} c- "cd $ENV{DKDOWNLOAD_DIR} & apt-get download $(apt-rdepends git|grep -v '^ ' |grep -v '^debconf-2.0$')" WORKING_DIRECTORY $ENV{DKDOWNLOAD_DIR})
		dk_installPackage(git)
	endif()
endif()

## Second Check ###
if(Windows_Host)
	dk_findProgram(git_exe git ${git}/bin)
elseif(Android_Host)
	dk_findProgram(git_exe git $ENV{PREFIX}/bin)
else()
	dk_findProgram(git_exe git /usr/bin)
endif()

dk_assertPath(git_exe)

dk_exec(${git_exe} --version OUTPUT_VARIABLE git_Version)

set(git_Version ${git_Version})
dk_info("###### git ######")
dk_info("${git_exe}")
dk_info("${git_Version}")
dk_printVar(git)
dk_return()


#if(MSYSTEM)
#	dk_validate(msys2 "dk_depend(msys2)")
#	if(NOT EXISTS ${msys2})
#		dk_fatal("MSYS2:${msys2} does not exist")
#	endif()
#	
#	dk_exec(command -v git.exe OUTPUT_VARIABLE git_exe NO_HALT) # BASH_ENV)
#	if(git_exe)
#	dk_exec(cygpath -m ${git_exe} OUTPUT_VARIABLE git_exe)
#	endif()
#	
#	if(NOT EXISTS ${git_exe})
#		dk_exec(${pacman_exe} -S git --needed --noconfirm --cachedir ${msys2_CacheDir})
#	endif()
#	
#	dk_exec(command -v git.exe OUTPUT_VARIABLE git_exe) # BASH_ENV)
#	if(git_exe)
#		dk_exec(cygpath -m ${git_exe} OUTPUT_VARIABLE git_exe)
#	endif()
#
#else()


#	if(Windows_Host)
#		dk_set(git_exe ${git}/bin/git.exe)
#		if(NOT EXISTS ${git_exe})
#			### INSTALL ###
#			dk_info("Installing Git . . .")
#			dk_download(${git_Import} $ENV{DKDOWNLOAD_DIR})			
#			dk_nativePath("$ENV{DKDOWNLOAD_DIR}/${GIT_IMPORT_FILE}" GIT_INSTALL_FILE)
#			dk_nativePath("${git}" GIT_INSTALL_PATH)
#			#dk_exec(${GIT_INSTALL_FILE} /DIR=${GIT_INSTALL_PATH})
#			#execute_process(COMMAND ${GIT_INSTALL_FILE} /DIR=${GIT_INSTALL_PATH})
#			execute_process(COMMAND ${GIT_INSTALL_FILE} -y -o ${GIT_INSTALL_PATH})
#		endif()
#	else()
#		#dk_exec(command -v git OUTPUT_VARIABLE git_exe) # BASH_ENV)
#		dk_depend(bash)
#		dk_exec(${bash_exe} -c "command -v git" OUTPUT_VARIABLE git_exe)
#		if(NOT EXISTS ${git_exe})
#			dk_install(git)
#			dk_depend(bash)
#			dk_exec(${bash_exe} -c "command -v git" OUTPUT_VARIABLE git_exe)
#		endif()
#	endif()
	
	
#endif()

### validate GIT variables ###
#if(NOT git_exe)
#	dk_fatal("git_exe:${git_exe} is empty")
#endif()
#if(NOT EXISTS ${git_exe})
#	dk_fatal("git_exe:${git_exe} does not exist")
#endif()
#
#dk_set(git_exe ${git_exe}) # make the variable persistent
#
#### print GIT info ###
#dk_debug(git_exe)
#dk_exec(${git_exe} --version OUTPUT_VARIABLE git_Version)
#dk_debug(git_Version)
