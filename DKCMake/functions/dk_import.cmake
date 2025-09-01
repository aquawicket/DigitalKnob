#!/usr/bin/cmake -P
message("### dk_import.cmake ###")

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
	dk_debugFunc(0 99)
	dk_debug("dk_import(${ARGV})")

	#dk_assertVar(CURRENT_PLUGIN)
	if("$ENV{DKSCRIPT_NAME}" STREQUAL "DKINSTALL")					########### PLUGIN_variables ###########	##### EXAMPLE #####
		#dk_call(dk_set IMPORT_PATH "$ENV{DKSCRIPT_DIR}")			# PLUGIN_Import_Path						${DKIMPORTS_DIR}/zlib
		dk_set(IMPORT_PATH "$ENV{DKSCRIPT_DIR}")
	elseif($ENV{CURRENT_PLUGIN}_Import_Path)
		#dk_call(dk_set IMPORT_PATH "${$ENV{CURRENT_PLUGIN}_Import_Path}")
		dk_set(IMPORT_PATH "${$ENV{CURRENT_PLUGIN}_Import_Path}")
	elseif(${CURRENT_PLUGIN}_Import_Path)
		#dk_call(dk_set IMPORT_PATH "${${CURRENT_PLUGIN}_Import_Path}")
		dk_set(IMPORT_PATH "${${CURRENT_PLUGIN}_Import_Path}")
	endif()
	dk_importVariables(IMPORT_PATH "${IMPORT_PATH}")
	dk_assertPath("${${CURRENT_PLUGIN}_Import_Path}")

	
	
	dk_getParameter(APP)
	if("${${PLUGIN_Import_Name}_Type}" STREQUAL "APP")
		set(APP 1 CACHE INTERNAL "")
	endif()
	if(APP)
		dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
		dk_set(PLUGIN_Install_Root INSTALL_ROOT ${DKTOOLS_DIR})
	endif()	
	
	if(EXISTS "${${CURRENT_PLUGIN}_Install_Path}")
		dk_notice("${${CURRENT_PLUGIN}_Install_Name} already installed")
		return()
	endif()
	
	if(${CURRENT_PLUGIN}_Url)
	
			# NOTE: Let's not forget that we rename some download files to better identify them. These are also the renamed files that 
			# will be on a backup server. So when we look for the download using the original url, we will check the alternate server
			# for the file. BUT. That file is renamed, so we need to check for the new name (${${PLUGIN}_Download_Basename}).
			dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
			dk_download("${${CURRENT_PLUGIN}_Url}" "${DKDOWNLOAD_DIR}/${${CURRENT_PLUGIN}_Download_Basename}")
			
			if("${${CURRENT_PLUGIN}_Url_Extension}" STREQUAL ".7z")
			set(FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Url_Extension}" STREQUAL ".bz")		
			set(FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Url_Extension}" STREQUAL ".bz2")		
			set(FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Url_Extension}" STREQUAL ".gz")		
			set(FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Url_Extension}" STREQUAL ".rar")		
			set(FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Url_Extension}" STREQUAL ".sfx.exe")	
			set(FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Url_Extension}" STREQUAL ".tar")		
			set(FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Url_Extension}" STREQUAL ".tar.gz")	
			set(FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Url_Extension}" STREQUAL ".tar.xz")	
			set(FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Url_Extension}" STREQUAL ".tgz")		
			set(FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Url_Extension}" STREQUAL ".xz")		
			set(FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Url_Extension}" STREQUAL ".zip")		
			set(FileType "Archive")
		endif()
		
		if("${FileType}" STREQUAL "Archive")
			dk_smartExtract("${dk_download}" "${${CURRENT_PLUGIN}_Install_Path}")
		endif()
	endif()

	#dk_getParameter(PATCH)
	#if(PATCH)
	if(${CURRENT_PLUGIN}_Import_Name AND ${CURRENT_PLUGIN}_Install_Path)
		dk_patch("${${CURRENT_PLUGIN}_Import_Name}" "${${CURRENT_PLUGIN}_Install_Path}")
	endif()
	#endif()

endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_depend(cmake)
	#dk_import("https://www.dependencywalker.com/depends22_x64.zip")
endfunction()