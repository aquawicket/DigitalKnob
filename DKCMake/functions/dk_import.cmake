include_guard()

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
	DKDEBUGFUNC(${ARGV})
	dk_importVariables(${url} plugin ${ARGN})
	
	string(MAKE_C_IDENTIFIER ${plugin} plugin_alpha_numeric)
	string(TOUPPER ${plugin_alpha_numeric} plugin_var)	
	
	#dk_debug(${plugin_var} 					PRINTVAR)
	#dk_debug(${plugin_var}_URL			PRINTVAR)
	#dk_debug(${plugin_var}_VERSION	PRINTVAR)
	#dk_debug(${plugin_var}_FOLDER		PRINTVAR)
	#dk_debug(${plugin_var}_BRANCH	PRINTVAR)
	#dk_debug(${plugin_var}_TAG			PRINTVAR)
	
	if(NOT DKOFFLINE)
		### .git
		dk_getExtension(${url} extension)
		if("${extension}" STREQUAL ".git")
			
			include(${DKIMPORTS_DIR}/git/DKMAKE.cmake)
			DKASSERT(GIT_EXE)
			
			if(NOT EXISTS ${${plugin_var}}/.git)
				dk_set(CURRENT_DIR ${DIGITALKNOB_DIR}/${DK3RDPARTY_DIR})
				if(EXISTS ${${plugin_var}})
					dk_remove(${${plugin_var}})
				endif()
				if(NOT EXISTS ${${plugin_var}})
					dk_makeDirectory(${${plugin_var}})
				endif()
				dk_set(CURRENT_DIR ${${plugin_var}})
				dk_command(${GIT_EXE} clone ${${plugin_var}_URL} ${${plugin_var}})
			endif()
			dk_set(CURRENT_DIR ${${plugin_var}})
			dk_command(${GIT_EXE} checkout -- .)
			dk_command(${GIT_EXE} checkout ${${plugin_var}_BRANCH})
			dk_command(${GIT_EXE} pull)
			if(${plugin_var}_TAG)
				dk_command(${GIT_EXE} checkout ${${plugin_var}_TAG})
			endif()
		### download
		else()
			dk_verbose("dk_install(${plugin} ${ARGN})")
			dk_install(${plugin} ${ARGN})
		endif()
	endif()
	
	dk_get_option(PATCH ${ARGV})
	if(PATCH)
		#dk_debug("dk_patch(${plugin} ${${plugin_var}})")
		dk_patch(${plugin} ${${plugin_var}})
	endif()
	
	# Set the current build output directory
	dk_verbose("setting current build directory to ${${plugin_var}}/${BUILD_DIR}")
	dk_setPath(${${plugin_var}}/${BUILD_DIR})
	
endfunction()
dk_createOsMacros("dk_import")