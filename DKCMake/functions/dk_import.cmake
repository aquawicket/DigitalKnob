include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_import(url) #args
#
#	This is a flexable super function for importing just about anything into digitalknob
#	The idea is to provide a url or path and dk_import will do the rest. 
#
#	@url	- The online path the .git or file to import
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
	
	dk_importVariables(${url} plugin_var ${ARGN})
	#dk_set(plugin ${plugin})
	#dk_printVar(plugin)
	
	#dk_convertToCIdentifier(${plugin} plugin_alpha_numeric)
	#dk_toUpper(${plugin_alpha_numeric} plugin_var)	

	if(NOT DKOFFLINE)
		###### Import from Git Repository ######
		dk_getExtension(${url} extension)
		if("${extension}" STREQUAL ".git")
			
			dk_validate(GIT_EXE "dk_load(${DKIMPORTS_DIR}/git/DKMAKE.cmake)")
			
			if(NOT EXISTS ${${plugin_var}}/.git)
				dk_cd(${DK3RDPARTY_DIR})
				if(EXISTS ${${plugin_var}})
					dk_delete(${${plugin_var}})
				endif()
				if(NOT EXISTS ${${plugin_var}})
					dk_makeDirectory(${${plugin_var}})
				endif()
				dk_cd(${${plugin_var}})
				dk_command(${GIT_EXE} clone ${${plugin_var}_URL} ${${plugin_var}})
			endif()
			dk_cd(${${plugin_var}})
			dk_command(${GIT_EXE} checkout -- .)
			dk_command(${GIT_EXE} checkout ${${plugin_var}_BRANCH})
			dk_command(${GIT_EXE} pull)
			if(${plugin_var}_TAG)
				dk_command(${GIT_EXE} checkout ${${plugin_var}_TAG})
			endif()
			
		###### Import from Download File ######
		else()
			dk_verbose("dk_install(${plugin} ${ARGN})")
			#dk_install(${plugin} ${ARGN})
			dk_install(${plugin_var} ${ARGN})
		endif()
	endif()
	
	dk_getOption(PATCH ${ARGV})
	if(PATCH)
		dk_patch(${plugin} ${${plugin_var}})
	endif()
	
endfunction()
dk_createOsMacros("dk_import")






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()