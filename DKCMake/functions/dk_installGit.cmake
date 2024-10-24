#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

# https://git-scm.com
# https://github.com/git-for-windows/git


###############################################################################
# dk_installGit()
#
function(dk_installGit)
	dk_debugFunc()

	### DOWNLOAD ###
	dk_validate(host_triple "dk_host_triple()")
	dk_validate(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
	dk_getFileParam("${DKIMPORTS_DIR}/git/git.txt" GIT_DL_VERSION)
	
	### DOWNLOAD ###
	if(WIN_X86_HOST)
		set	(GIT_DL https://github.com/git-for-windows/git/releases/download/v${GIT_DL_VERSION}.windows.1/PortableGit-${GIT_DL_VERSION}-32-bit.7z.exe)
	endif()
	if(WIN_X86_64_HOST)
		set	(GIT_DL https://github.com/git-for-windows/git/releases/download/v${GIT_DL_VERSION}.windows.1/PortableGit-${GIT_DL_VERSION}-64-bit.7z.exe)
	endif()
	if(WIN_HOST AND NOT GIT_DL)
		dk_fatal("GIT_DL is invalid!")
		return()
	endif()

	### Get GIT variables ###
	if(GIT_DL)
		dk_validate(DKTOOLS_DIR "dk_DIGITALKNOB_DIR()")
		dk_importVariables(${GIT_DL} ROOT ${DKTOOLS_DIR})
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
			dk_download(${GIT_DL} ${DKDOWNLOAD_DIR})			
			dk_getNativePath("${DKDOWNLOAD_DIR}/${GIT_DL_FILE}" GIT_INSTALL_FILE)
			dk_getNativePath("${GIT}" GIT_INSTALL_PATH)
			execute_process(COMMAND ${GIT_INSTALL_FILE} -y -o ${GIT_INSTALL_PATH} COMMAND_ECHO STDOUT)
			# setx PATH
		elseif(ANDROID_HOST)
			#dk_command(apt -y install git)
			dk_installPackage(git)
		elseif(LINUX_HOST)
			# https://stackoverflow.com/a/27469489
			#dk_depend(sudo)
			#dk_command(${SUDO_EXE} apt-get -y install git)
			#dk_command(${SUDO_EXE} apt-get install apt-rdepends)
			#dk_command(${BASH_EXE} c- "cd ${DKDOWNLOAD_DIR} & apt-get download $(apt-rdepends git|grep -v '^ ' |grep -v '^debconf-2.0$')" WORKING_DIRECTORY ${DKDOWNLOAD_DIR})
			dk_installPackage(git)
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

	dk_assertPath(GIT_EXE)

	dk_command(${GIT_EXE} --version OUTPUT_VARIABLE GIT_VERSION)
	set(GIT_VERSION ${GIT_VERSION})
	dk_info("###### git ######")
	dk_info("${GIT_EXE}")
	dk_info("${GIT_VERSION}")
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_installGit()
endfunction()