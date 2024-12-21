#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_import(url) #args
#
#	This is a flexable super function for importing just about anything into digitalknob
#	The idea is to provide a url or path and dk_import will do the rest. 
#
#	@url	- The online path of the .git or file to import
#
#	github GIT:	https://github.com/orginization/library.git		dkimportGit(url) #branch/tag #PATCH
#	github DL:	https://github.com/orginization/library			dkimportGit(url) #branch/tag #PATCH
#	lib url DL:	https://website.com/library.zip					dkimportDownload(url) #PATCH
#	exe url DL:	https://website.com/executable.exe 				dkimportDownload(url) #PATCH
#
#	TODO: https://cmake.org/cmake/help/latest/module/FetchContent.html 
#
function(dk_import url)
	dk_debugFunc()
	
	dk_getOption(NO_HALT REMOVE)
	
	dk_importVariables(${url} ${ARGN})
	#dk_assertVar(CURRENT_PLUGIN)
	dk_assertVar(ENV{CURRENT_PLUGIN})

	if(NOT DKOFFLINE)
		###### Import from Git Repository ######
		dk_getExtension(${url} extension)
		if("${extension}" STREQUAL ".git")
			
			dk_depend(git)
			
			if(NOT EXISTS ${$ENV{CURRENT_PLUGIN}_DIR}/.git)
				dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
				dk_cd(${DK3RDPARTY_DIR})
				if(EXISTS ${$ENV{CURRENT_PLUGIN}_DIR})
					dk_delete(${$ENV{CURRENT_PLUGIN}_DIR})
				endif()
				if(NOT EXISTS ${$ENV{CURRENT_PLUGIN}_DIR})
					dk_makeDirectory(${$ENV{CURRENT_PLUGIN}_DIR})
				endif()
				dk_cd(${$ENV{CURRENT_PLUGIN}_DIR})
				dk_command(${GIT_EXE} clone ${$ENV{CURRENT_PLUGIN}_URL} ${$ENV{CURRENT_PLUGIN}_DIR})
			endif()
			dk_cd(${$ENV{CURRENT_PLUGIN}_DIR})
			dk_command(${GIT_EXE} checkout -- .)
			dk_command(${GIT_EXE} checkout ${$ENV{CURRENT_PLUGIN}_BRANCH})
			dk_command(${GIT_EXE} pull)
			if(${CURRENT_PLUGIN}_TAG)
				dk_command(${GIT_EXE} checkout ${$ENV{CURRENT_PLUGIN}_TAG})
			endif()
			
		###### Import from Download File ######
		else()
			dk_printVar(ENV{CURRENT_PLUGIN})
			dk_printVar($ENV{CURRENT_PLUGIN}_IMPORT_NAME)
			dk_verbose("dk_install(${$ENV{CURRENT_PLUGIN}_IMPORT_NAME} ${ARGN})")
			
			dk_install($ENV{CURRENT_PLUGIN} ${ARGN} ${NO_HALT})
		endif()
	endif()
	
	#dk_getOption(PATCH ${ARGV})
	dk_getOption(PATCH)
	if(PATCH)
		dk_patch(${$ENV{CURRENT_PLUGIN}_IMPORT_NAME} ${$ENV{CURRENT_PLUGIN}_DIR})
	endif()
	
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_import(https://github.com/madler/zlib/archive/d476828316d05d54c6fd6a068b121b30c147b5cd.zip)
endfunction()