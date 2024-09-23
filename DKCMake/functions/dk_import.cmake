include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_import(url) #args
#
#	This is a flexable super function for importing just about anything into digitalknob
#	The idea is to provide a url or path and dk_import will do the rest. 
#
#	@url	- The online path of the .git or file to import
#
#	github GIT:	https://github.com/orginization/library.git		dk_importGit(url) #branch/tag #PATCH
#	github DL:	https://github.com/orginization/library			dk_importGit(url) #branch/tag #PATCH
#	lib url DL:	https://website.com/library.zip					dk_importDownload(url) #PATCH
#	exe url DL:	https://website.com/executable.exe 				dk_importDownload(url) #PATCH
#
#	TODO: https://cmake.org/cmake/help/latest/module/FetchContent.html 
#
function(dk_import url)
	dk_debugFunc("\${ARGV}")
	
	dk_importVariables(${url} PLUGIN_VAR_PREFIX ${ARGN})

	if(NOT DKOFFLINE)
		###### Import from Git Repository ######
		dk_getExtension(${url} extension)
		if("${extension}" STREQUAL ".git")
			
			dk_validate(GIT_EXE "dk_load(${DKIMPORTS_DIR}/git/DKMAKE.cmake)")
			
			if(NOT EXISTS ${${PLUGIN_VAR_PREFIX}_DIR}/.git)
				dk_cd(${DK3RDPARTY_DIR})
				if(EXISTS ${${PLUGIN_VAR_PREFIX}_DIR})
					dk_delete(${${PLUGIN_VAR_PREFIX}_DIR})
				endif()
				if(NOT EXISTS ${${PLUGIN_VAR_PREFIX}_DIR})
					dk_makeDirectory(${${PLUGIN_VAR_PREFIX}_DIR})
				endif()
				dk_cd(${${PLUGIN_VAR_PREFIX}_DIR})
				dk_command(${GIT_EXE} clone ${${PLUGIN_VAR_PREFIX}_URL} ${${PLUGIN_VAR_PREFIX}_DIR})
			endif()
			dk_cd(${${PLUGIN_VAR_PREFIX}_DIR})
			dk_command(${GIT_EXE} checkout -- .)
			dk_command(${GIT_EXE} checkout ${${PLUGIN_VAR_PREFIX}_BRANCH})
			dk_command(${GIT_EXE} pull)
			if(${PLUGIN_VAR_PREFIX}_TAG)
				dk_command(${GIT_EXE} checkout ${${PLUGIN_VAR_PREFIX}_TAG})
			endif()
			
		###### Import from Download File ######
		else()
			#dk_verbose("dk_install(${plugin} ${ARGN})")
			dk_verbose("dk_install(${${PLUGIN_VAR_PREFIX}_IMPORT_NAME} ${ARGN})")
			
			#dk_install(${plugin} ${ARGN})
			dk_install(${PLUGIN_VAR_PREFIX} ${ARGN})
		endif()
	endif()
	
	dk_getOption(PATCH ${ARGV})
	if(PATCH)
		#dk_patch(${plugin} ${${PLUGIN_VAR_PREFIX}_DIR})
		dk_patch(${${PLUGIN_VAR_PREFIX}_IMPORT_NAME} ${${PLUGIN_VAR_PREFIX}_DIR})
	endif()
	
endfunction()
dk_createOsMacros("dk_import")






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()