#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
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
#	dk_assertVar(${CURRENT_PLUGIN}_Import_Path)
	
#	dk_getParameterValue(INSTALL_PATH)
#	dk_debug("INSTALL_PATH = ${INSTALL_PATH}")
	
#	if(APP)
#		dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
#		set(INSTALL_ROOT "${DKTOOLS_DIR}")
#	endif()
	
	dk_importVariables(${ARGV})
	
#	    if(INSTALL_ROOT)
#		dk_importVariables(IMPORT_PATH "${${CURRENT_PLUGIN}_Import_Path}" INSTALL_ROOT "${INSTALL_ROOT}")
#	elseif(INSTALL_PATH)
#		dk_importVariables(IMPORT_PATH "${${CURRENT_PLUGIN}_Import_Path}" INSTALL_PATH "${INSTALL_PATH}")
#	else()
#		dk_importVariables(IMPORT_PATH "${${CURRENT_PLUGIN}_Import_Path}")
#	endif()
	
	dk_debug("${CURRENT_PLUGIN}_Install_Path = ${${CURRENT_PLUGIN}_Install_Path}")
	if(EXISTS "${${CURRENT_PLUGIN}_Install_Path}")
		dk_notice("${${CURRENT_PLUGIN}_Install_Name} already installed")
		return()
	endif()
	
	if(${CURRENT_PLUGIN}_Url)
	
			# NOTE: Let's not forget that we rename some download files to better identify them. These are also the renamed files that 
			# will be on a backup server. So when we look for the download using the original url, we will check the alternate server
			# for the file. BUT. That file is renamed, so we need to check for the new name (${${PLUGIN}_Download_Basename}).
			dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
			dk_assertVar(${CURRENT_PLUGIN}_Url)
			dk_download("${${CURRENT_PLUGIN}_Url}")
			dk_set(${CURRENT_PLUGIN}_Download "${dk_download}")
			dk_getExtension(${${CURRENT_PLUGIN}_Download} ${CURRENT_PLUGIN}_Download_Extension)
			
			if("${${CURRENT_PLUGIN}_Download_Extension}" STREQUAL ".7z")
			set(${CURRENT_PLUGIN}_Download_FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Download_Extension}" STREQUAL ".bz")		
			set(${CURRENT_PLUGIN}_Download_FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Download_Extension}" STREQUAL ".bz2")		
			set(${CURRENT_PLUGIN}_Download_FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Download_Extension}" STREQUAL ".gz")		
			set(${CURRENT_PLUGIN}_Download_FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Download_Extension}" STREQUAL ".rar")		
			set(${CURRENT_PLUGIN}_Download_FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Download_Extension}" STREQUAL ".sfx.exe")	
			set(${CURRENT_PLUGIN}_Download_FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Download_Extension}" STREQUAL ".tar")		
			set(${CURRENT_PLUGIN}_Download_FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Download_Extension}" STREQUAL ".tar.gz")	
			set(${CURRENT_PLUGIN}_Download_FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Download_Extension}" STREQUAL ".tar.xz")	
			set(${CURRENT_PLUGIN}_Download_FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Download_Extension}" STREQUAL ".tgz")		
			set(${CURRENT_PLUGIN}_Download_FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Download_Extension}" STREQUAL ".xz")		
			set(${CURRENT_PLUGIN}_Download_FileType "Archive")
		elseif("${${CURRENT_PLUGIN}_Download_Extension}" STREQUAL ".zip")		
			set(${CURRENT_PLUGIN}_Download_FileType "Archive")
		endif()
		
		message("${CURRENT_PLUGIN}_Download_FileType = ${${CURRENT_PLUGIN}_Download_FileType}")
		
		if("${${CURRENT_PLUGIN}_Download_FileType}" STREQUAL "Archive")
			dk_smartExtract("${${CURRENT_PLUGIN}_Download}" "${${CURRENT_PLUGIN}_Install_Path}")
		endif()
	endif()

	#dk_getParameter(PATCH)
	#if(PATCH)
#		if((DEFINED ${CURRENT_PLUGIN}_Import_Name) AND (DEFINED ${CURRENT_PLUGIN}_Install_Path))
#			dk_patch("${${CURRENT_PLUGIN}_Import_Name}" "${${CURRENT_PLUGIN}_Install_Path}")
			dk_copy("${${CURRENT_PLUGIN}_Import_Path}" "${${CURRENT_PLUGIN}_Install_Path}") 
#		endif()
	#endif()

endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	#dk_depend(cmake)
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	dk_import(IMPORT_PATH "${DKIMPORTS_DIR}/git")
endfunction()