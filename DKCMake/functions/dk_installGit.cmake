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

# https://git-scm.com
# https://github.com/git-for-windows/git


#########################################################################
# dk_installGit()
#
function(dk_installGit)
	dk_debugFunc()

	### DOWNLOAD ###
	dk_validate(Host_Tuple "dk_Host_Tuple()")
	dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
	dk_getFileParams("$ENV{DKIMPORTS_DIR}/git/dkconfig.txt")
	
	### DOWNLOAD ###
	if(Windows_Arm64_Host)
		set(GIT_Import "${GIT_WIN_ARM64_IMPORT}")
	elseif(Windows_X86_Host)
		set(GIT_Import "${GIT_WIN_X86_IMPORT}")
	elseif(Windows_X86_64_Host)
		set(GIT_Import "${GIT_WIN_X86_64_IMPORT}")
	endif()
	if(Windows_Host)
		dk_assertVar(GIT_Import)
	endif()

	### Get GIT variables ###
	if(GIT_Import)
		dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
		dk_importVariables(${GIT_Import} NAME git ROOT $ENV{DKTOOLS_DIR})
	endif()

	### First Check ###
	if(Windows_Host)
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
			#dk_download(${GIT_Import} $ENV{DKDOWNLOAD_DIR})
			dk_download(${GIT_Import})			
			dk_nativePath("$ENV{DKDOWNLOAD_DIR}/${GIT_Import_FILE}" GIT_Import_FILE_NATIVE)
			dk_nativePath("${GIT}" GIT_NATIVE)
			execute_process(COMMAND ${GIT_Import_FILE_NATIVE} -y -o ${GIT_NATIVE} COMMAND_ECHO STDOUT)
			# setx PATH
		else()
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
	dk_printVar(GIT_EXE)

	dk_exec(${GIT_EXE} --version OUTPUT_VARIABLE GIT_VERSION)
	dk_set(GIT_VERSION ${GIT_VERSION})
	dk_info(GIT_VERSION)
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_installGit()
endfunction()