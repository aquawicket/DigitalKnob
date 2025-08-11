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


#########################################################################
# dk_import(url) #args
#
#	This is a flexable super function for importing just about anything into DigitalKnob
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
function(dk_import)
	dk_debugFunc()
	
	###### Args ######
	dk_getParameter(NO_HALT REMOVE)
	dk_getParameter(PATCH)
	
	dk_importVariables(${ARGV})
	
	
	dk_assertVar(PLUGIN)
	dk_convertToCIdentifier(${PLUGIN} PLUGIN)
	set(${PLUGIN}_IMPORT_NAME ${plugin})
	if((NOT EXISTS "${PLUGIN}") OR (NOT EXISTS "${${PLUGIN}_DIR}"))	
		###### Push Plugin to the PLUGIN_STACK ######
		dk_envList(PLUGIN PUSH "${PLUGIN}")
		
		#dk_notice("dk_depend(): loading ${PLUGIN} . . .")
		#dk_dependB(${plugin})
	
		###### Pop Plugin from the PLUGIN_STACK ######
		#dk_envList(PLUGIN POP)
	else()
		dk_notice("dk_depend(): ${PLUGIN} is already loaded")
	endif()
	dk_assertVar(ENV{CURRENT_PLUGIN})
	


	if(NOT DKOFFLINE)
		###### Import from Git Repository ######
		dk_getExtension(${PLUGIN.URL} extension)
		if("${extension}" STREQUAL ".git")
			
			dk_depend(git)
			
			if(NOT EXISTS ${$ENV{CURRENT_PLUGIN}_DIR}/.git)
				dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR()")
				dk_chdir($ENV{DK3RDPARTY_DIR})
				if(EXISTS ${$ENV{CURRENT_PLUGIN}_DIR})
					dk_delete(${$ENV{CURRENT_PLUGIN}_DIR})
				endif()
				if(NOT EXISTS ${$ENV{CURRENT_PLUGIN}_DIR})
					dk_mkdir(${$ENV{CURRENT_PLUGIN}_DIR})
				endif()
				dk_chdir(${$ENV{CURRENT_PLUGIN}_DIR})
				dk_exec(${GIT_EXE} clone ${$ENV{CURRENT_PLUGIN}_URL} ${$ENV{CURRENT_PLUGIN}_DIR})
			endif()
			dk_chdir(${$ENV{CURRENT_PLUGIN}_DIR})
			dk_exec(${GIT_EXE} checkout -- .)
			dk_exec(${GIT_EXE} checkout ${$ENV{CURRENT_PLUGIN}_BRANCH})
			dk_exec(${GIT_EXE} pull)
			if(${CURRENT_PLUGIN}_TAG)
				dk_exec(${GIT_EXE} checkout ${$ENV{CURRENT_PLUGIN}_TAG})
			endif()
			
		###### Import from Download File ######
		else()
			dk_install($ENV{CURRENT_PLUGIN} ${ARGV} ${NO_HALT})
		endif()
	endif()
	
	if(PATCH)
		dk_patch(${$ENV{CURRENT_PLUGIN}_IMPORT_NAME} ${$ENV{CURRENT_PLUGIN}_DIR})
	endif()
	
	
	dk_envList(PLUGIN POP)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_import("https://www.dependencywalker.com/depends22_x64.zip")
endfunction()