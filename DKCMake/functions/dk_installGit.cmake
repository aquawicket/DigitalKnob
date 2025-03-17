#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

# https://git-scm.com
# https://github.com/git-for-windows/git


###############################################################################
# dk_installGit()
#
function(dk_installGit)
	dk_debugFunc()

	### DOWNLOAD ###
	dk_validate(host_triple "dk_host_triple()")
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
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
		dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
		dk_importVariables(${GIT_DL} NAME git ROOT ${DKTOOLS_DIR})
	endif()

	### First Check ###
	if(WIN_HOST)
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
			#dk_download(${GIT_DL} $ENV{DKDOWNLOAD_DIR})
			dk_download(${GIT_DL})			
			dk_nativePath("$ENV{DKDOWNLOAD_DIR}/${GIT_DL_FILE}" GIT_DL_FILE_NATIVE)
			dk_nativePath("${GIT}" GIT_NATIVE)
			execute_process(COMMAND ${GIT_DL_FILE_NATIVE} -y -o ${GIT_NATIVE} COMMAND_ECHO STDOUT)
			# setx PATH
		else()
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
	dk_printVar(GIT_EXE)

	dk_command(${GIT_EXE} --version OUTPUT_VARIABLE GIT_VERSION)
	dk_set(GIT_VERSION ${GIT_VERSION})
	dk_info(GIT_VERSION)
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_installGit()
endfunction()