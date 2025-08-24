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
	dk_debugFunc(0 99)
	
	dk_assertPath("${CURRENT_IMPORT}")
	set(Import_Path "${CURRENT_IMPORT}")
	dk_validate(Host_Tuple "dk_Host_Tuple()")
	dk_basename(${Import_Path} Import_Name)
	
	if(EXISTS "${Import_Path}/dkconfig.txt")
		dk_getFileParams("${Import_Path}/dkconfig.txt")
		
		dk_getParameter(APP)
		if(APP)
			dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
			set(INSTALL_ROOT INSTALL_ROOT ${DKTOOLS_DIR})
		endif()
		#dk_assertVar(${Import_Name}_${Host_Tuple}_Import)
		if(${Import_Name}_${Host_Tuple}_Import)
			set(PLUGIN_IMPORT "${Import_Name}_${Host_Tuple}_Import")
		elseif(${Import_Name}_Import)
			set(PLUGIN_IMPORT "${Import_Name}_Import")
		else()
			dk_assertVar(${Import_Name}_Import)
		endif()
		dk_importVariables(${${PLUGIN_IMPORT}} ${INSTALL_ROOT})
	else()
		dk_assertPath("${Import_Path}")
		dk_importVariables(IMPORT_PATH "${Import_Path}")
	endif()
	
	dk_assertVar(ENV{CURRENT_PLUGIN})
	
#	if(NOT EXISTS "${PLUGIN}")
#		dk_envList(PLUGIN PUSH "${PLUGIN}")			###### Push Plugin to the PLUGIN_STACK ######
#	else()
#		dk_notice("dk_import(): ${PLUGIN} is already loaded")
#	endif()
	
	if(EXISTS "${PLUGIN.Install.Path}")
		dk_echo("${PLUGIN.Install.Name} already installed")
		return()
	endif()
	
	if(PLUGIN.Url)
		dk_download("${PLUGIN.Url}")
		if("${PLUGIN.Url.Extension}" STREQUAL ".7z")
			set(FileType "Archive")
		elseif("${PLUGIN.Url.Extension}" STREQUAL ".bz")		
			set(FileType "Archive")
		elseif("${PLUGIN.Url.Extension}" STREQUAL ".bz2")		
			set(FileType "Archive")
		elseif("${PLUGIN.Url.Extension}" STREQUAL ".gz")		
			set(FileType "Archive")
		elseif("${PLUGIN.Url.Extension}" STREQUAL ".rar")		
			set(FileType "Archive")
		elseif("${PLUGIN.Url.Extension}" STREQUAL ".sfx.exe")	
			set(FileType "Archive")
		elseif("${PLUGIN.Url.Extension}" STREQUAL ".tar")		
			set(FileType "Archive")
		elseif("${PLUGIN.Url.Extension}" STREQUAL ".tar.gz")	
			set(FileType "Archive")
		elseif("${PLUGIN.Url.Extension}" STREQUAL ".tar.xz")	
			set(FileType "Archive")
		elseif("${PLUGIN.Url.Extension}" STREQUAL ".tgz")		
			set(FileType "Archive")
		elseif("${PLUGIN.Url.Extension}" STREQUAL ".xz")		
			set(FileType "Archive")
		elseif("${PLUGIN.Url.Extension}" STREQUAL ".zip")		
			set(FileType "Archive")
		endif()
		
		if("${FileType}" STREQUAL "Archive")
			dk_smartExtract("${dk_download}" "${PLUGIN.Install.Path}")
		endif()
	endif()

	dk_getParameter(PATCH)
	if(PATCH)
		dk_patch(${${CURRENT_PLUGIN}.IMPORT_NAME} ${${CURRENT_PLUGIN}})
	endif()

endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_depend(cmake)
	#dk_import("https://www.dependencywalker.com/depends22_x64.zip")
endfunction()