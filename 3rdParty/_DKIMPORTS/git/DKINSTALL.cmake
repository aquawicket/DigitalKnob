#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ git ############
# https://git-scm.com
# https://github.com/git-for-windows/git


### git variables ###
#dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
#dk_importVariables(${git_Import} IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR} INSTALL_ROOT ${DKTOOLS_DIR})
dk_import()
#dk_assertVar(git)

### First Check ###
dk_validate(Host_Os "dk_Host_Os()")
if(Windows_Host)
	dk_set(git_exe 		"${git}/bin/git.exe")
	dk_set(git_ssh_exe  "${git}/bin/ssh.exe")
elseif(Android_Host)
	dk_findProgram(git_exe git $ENV{PREFIX}/bin)
else()
	dk_findProgram(git_exe git /usr/bin)
endif()

### INSTALL ###
if(NOT EXISTS "${git_exe}")
	dk_debug(" Installing git . . . . ")
	if(Windows_Host)
		if(NOT EXISTS "${git_Download}")
			dk_download("${git_Url}")
			dk_set(git_Download "${dk_download}")
		endif()
		#dk_pathToNative("${dk_download}" GIT_INSTALL_FILE)
		#dk_pathToNative("${git}" GIT_INSTALL_PATH)
		message("git_Download = ${git_Download}")
		dk_exec(${git_Download} -y -o ${git})
	elseif(Android_Host)
		dk_installPackage(git)
	elseif(Linux_Host)
		# https://stackoverflow.com/a/27469489z
		#dk_validate(sudo_exe "dk_depend(sudo_exe)")
		#dk_exec(${sudo_exe} apt-get -y install git)
		#dk_exec(${bash_exe} c- "cd ${DKDOWNLOAD_DIR} & apt-get download $(apt-rdepends git|grep -v '^ ' |grep -v '^debconf-2.0$')" WORKING_DIRECTORY ${DKDOWNLOAD_DIR})
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

#dk_assertPath("${git_exe}")

dk_exec(${git_exe} --version OUTPUT_VARIABLE git_Version)

dk_firewallAllow("${git_ssh_exe}")

set(git_Version ${git_Version})
dk_info("###### git ######")
dk_info("${git_exe}")
dk_info("${git_Version}")
dk_debug("git = ${git}")
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
#			dk_download(${git_Import} ${DKDOWNLOAD_DIR})			
#			dk_pathToNative("${DKDOWNLOAD_DIR}/${git_Import_File}" GIT_INSTALL_FILE)
#			dk_pathToNative("${git}" GIT_INSTALL_PATH)
#			#dk_exec(${GIT_INSTALL_FILE} /DIR=${GIT_INSTALL_PATH})
#			#execute_process(COMMAND ${GIT_INSTALL_FILE} /DIR=${GIT_INSTALL_PATH})
#			execute_process(COMMAND ${GIT_INSTALL_FILE} -y -o ${GIT_INSTALL_PATH})
#		endif()
#	else()
#		#dk_exec(command -v git OUTPUT_VARIABLE git_exe) # BASH_ENV)
#		dk_validate(bash_exe "dk_depend(bash_exe)")
#		dk_exec(${bash_exe} -c "command -v git" OUTPUT_VARIABLE git_exe)
#		if(NOT EXISTS ${git_exe})
#			dk_install(git)
#			dk_validate(bash_exe "dk_depend(bash_exe)")
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
