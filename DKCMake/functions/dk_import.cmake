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
	
	dk_importVariables(${url} ${ARGN})
	dk_assertVar(CURRENT_PLUGIN)
	#dk_printVar(CURRENT_PLUGIN)

	if(NOT DKOFFLINE)
		###### Import from Git Repository ######
		dk_getExtension(${url} extension)
		if("${extension}" STREQUAL ".git")
			
			dk_validate(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
			dk_validate(GIT_EXE "dk_load('${DKIMPORTS_DIR}/git/DKMAKE.cmake')")
			
			if(NOT EXISTS ${${CURRENT_PLUGIN}_DIR}/.git)
				dk_validate(DK3RDPARTY_DIR "dk_DKBRANCH_DIR()")
				dk_cd(${DK3RDPARTY_DIR})
				if(EXISTS ${${CURRENT_PLUGIN}_DIR})
					dk_delete(${${CURRENT_PLUGIN}_DIR})
				endif()
				if(NOT EXISTS ${${CURRENT_PLUGIN}_DIR})
					dk_makeDirectory(${${CURRENT_PLUGIN}_DIR})
				endif()
				dk_cd(${${CURRENT_PLUGIN}_DIR})
				dk_command(${GIT_EXE} clone ${${CURRENT_PLUGIN}_URL} ${${CURRENT_PLUGIN}_DIR})
			endif()
			dk_cd(${${CURRENT_PLUGIN}_DIR})
			dk_command(${GIT_EXE} checkout -- .)
			dk_command(${GIT_EXE} checkout ${${CURRENT_PLUGIN}_BRANCH})
			dk_command(${GIT_EXE} pull)
			if(${CURRENT_PLUGIN}_TAG)
				dk_command(${GIT_EXE} checkout ${${CURRENT_PLUGIN}_TAG})
			endif()
			
		###### Import from Download File ######
		else()
			dk_printVar(CURRENT_PLUGIN)
			dk_printVar(${CURRENT_PLUGIN}_IMPORT_NAME)
			dk_verbose("dk_install(${${CURRENT_PLUGIN}_IMPORT_NAME} ${ARGN})")
			
			dk_install(${CURRENT_PLUGIN} ${ARGN})
		endif()
	endif()
	
	dk_getOption(PATCH ${ARGV})
	if(PATCH)
		dk_patch(${${CURRENT_PLUGIN}_IMPORT_NAME} ${${CURRENT_PLUGIN}_DIR})
	endif()
	
endfunction()
dk_createOsMacros("dk_import")






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_import(https://github.com/madler/zlib/archive/d476828316d05d54c6fd6a068b121b30c147b5cd.zip)
endfunction()