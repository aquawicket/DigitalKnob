#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)

############ tdm-gcc ############
# https://github.com/jmeubank/tdm-gcc

dk_validate(host_triple "dk_host_triple()")
dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam("${DKIMPORTS_DIR}/tdm-gcc/dkconfig.txt" VERSION)


### DOWNLOAD ###
if(WIN_X86_HOST)
	set(TDM_GCC_DL https://github.com/jmeubank/tdm-gcc/releases/download/v10.3.0-tdm-1/tdm-gcc-10.3.0.exe)
endif()
if(WIN_X86_64_HOST)
	set(TDM_GCC_DL https://github.com/jmeubank/tdm-gcc/releases/download/v10.3.0-tdm64-2/tdm64-gcc-10.3.0-2.exe)
endif()
if(WIN_HOST AND NOT TDM_GCC_DL)
	dk_fatal("TDM_GCC_DL is invalid!")
endif()


### TDM_GCC variables ###
if(GIT_DL)
	dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
	dk_importVariables(${TDM_GCC_DL} ROOT ${DKTOOLS_DIR})
endif()


### First Check ###
#if(WIN_HOST)
#	dk_debug("dk_findProgram(GIT_EXE git.exe ${GIT}/bin)")
#	dk_findProgram(GIT_EXE git.exe ${GIT}/bin)
#elseif(ANDROID_HOST)
#	dk_findProgram(GIT_EXE git $ENV{PREFIX}/bin)
#else()
#	dk_findProgram(GIT_EXE git /usr/bin)
#endif()

### INSTALL ###
#if(NOT GIT_EXE)
#	dk_debug(" Installing git . . . . ")
#	if(WIN_HOST)
#		dk_download(${GIT_DL} ${DKDOWNLOAD_DIR})			
#		dk_nativePath("${DKDOWNLOAD_DIR}/${GIT_DL_FILE}" GIT_INSTALL_FILE)
#		dk_nativePath("${GIT}" GIT_INSTALL_PATH)
#		execute_process(COMMAND ${GIT_INSTALL_FILE} -y -o ${GIT_INSTALL_PATH} COMMAND_ECHO STDOUT)
#		# setx PATH
#	elseif(ANDROID_HOST)
#		dk_installPackage(git)
#	elseif(LINUX_HOST)
#		# https://stackoverflow.com/a/27469489z
#		#dk_command(${SUDO_EXE} apt-get -y install git)
#		#dk_command(${SUDO_EXE} apt-get install apt-rdepends)
#		#dk_command(${BASH_EXE} c- "cd ${DKDOWNLOAD_DIR} & apt-get download $(apt-rdepends git|grep -v '^ ' |grep -v '^debconf-2.0$')" WORKING_DIRECTORY ${DKDOWNLOAD_DIR})
#		dk_installPackage(git)
#	endif()
#endif()


## Second Check ###
#if(WIN_HOST)
#	dk_findProgram(GIT_EXE git ${GIT}/bin)
#elseif(ANDROID_HOST)
#	dk_findProgram(GIT_EXE git $ENV{PREFIX}/bin)
#else()
#	dk_findProgram(GIT_EXE git /usr/bin)
#endif()
#
#dk_assertPath(GIT_EXE)
#
#dk_command(${GIT_EXE} --version OUTPUT_VARIABLE GIT_VERSION)
#
#set(GIT_VERSION ${GIT_VERSION})
#dk_info("###### git ######")
#dk_info("${GIT_EXE}")
#dk_info("${GIT_VERSION}")
#dk_return()
