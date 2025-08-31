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
	dk_debug("dk_import(${ARGV})")
	
	if("$ENV{DKSCRIPT_NAME}" STREQUAL "DKINSTALL")					########### PLUGIN_variables ###########	##### EXAMPLE #####
		dk_call(dk_set PLUGIN_Import_Path "$ENV{DKSCRIPT_DIR}")		# PLUGIN_Import_Path						${DKIMPORTS_DIR}/zlib
	elseif($ENV{CURRENT_PLUGIN}_Import_Path)
		dk_call(dk_set PLUGIN_Import_Path "${$ENV{CURRENT_PLUGIN}_Import_Path}")
	elseif(${CURRENT_PLUGIN}_Import_Path)
		dk_call(dk_set PLUGIN_Import_Path "${${CURRENT_PLUGIN}_Import_Path}")
	endif()
	dk_assertPath("${PLUGIN_Import_Path}")
	dk_debug("PLUGIN_Import_Path = ${PLUGIN_Import_Path}")	
			
	dk_basename("${PLUGIN_Import_Path}")
	dk_set(PLUGIN_Import_Name "${dk_basename}")						# PLUGIN_Import_Name						zlib
	dk_debug("PLUGIN_Import_Name = ${PLUGIN_Import_Name}")
	dk_toUpper("${dk_basename}" PLUGIN)
	dk_convertToCIdentifier(${PLUGIN} PLUGIN)
	dk_set(PLUGIN "${PLUGIN}")										# PLUGIN									ZLIB
	dk_debug("PLUGIN = ${PLUGIN}")
	dk_set(PLUGIN_Id "${PLUGIN}")									# PLUGIN_Id									ZLIB
	dk_debug("PLUGIN_Id = ${PLUGIN_Id}")
																	########## ${PLUGIN}_variables ##########
	dk_set(${PLUGIN} "${PLUGIN_Install_Path}")						# <PLUGIN>_Id								ZLIB
	dk_debug("${PLUGIN} = ${${PLUGIN}}")
	dk_set(${PLUGIN}_Id "${PLUGIN_Id}")								# <PLUGIN>_Id								ZLIB
	dk_debug("${PLUGIN}_Id = ${${PLUGIN}_Id}")
	dk_set(${PLUGIN}_Import_Path "${PLUGIN_Import_Path}")			# <PLUGIN>_Import_Path						${DKIMPORTS_DIR}/zlib
	dk_debug("${PLUGIN}_Import_Path = ${${PLUGIN}_Import_Path}")
	dk_set(${PLUGIN}_Import_Name "${PLUGIN_Import_Name}")			# <PLUGIN>_Import_Name						zlib	
	dk_debug("${PLUGIN}_Import_Name = ${${PLUGIN}_Import_Name}")
	
	if(EXISTS "${PLUGIN_Import_Path}/dkconfig.txt")
		dk_getFileParams("${PLUGIN_Import_Path}/dkconfig.txt")
		
		dk_getParameter(APP)
		if("${${PLUGIN_Import_Name}_Type}" STREQUAL "APP")
			set(APP 1)
		endif()
		if(APP)
			dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
			set(PLUGIN_Install_Root INSTALL_ROOT ${DKTOOLS_DIR})
		endif()
																					###### EXAMPLE ######
		dk_validate(Host_Tuple "dk_Host_Tuple()")									#      Windows_X86_64
		if(${PLUGIN_Import_Name}_${Host_Tuple}_Import)								# zlib_Windows_X86_64_Import
			dk_set(PLUGIN_Import "${PLUGIN_Import_Name}_${Host_Tuple}_Import")
		elseif(${PLUGIN}_${Host_Tuple}_Import)										# ZLIB_Windows_X86_64_Import
			dk_set(PLUGIN_Import "${PLUGIN}_${Host_Tuple}_Import")
		elseif(${PLUGIN_Import_Name}_${Host_Os}_Import)								# zlib_Windows_Import
			dk_set(PLUGIN_Import "${PLUGIN_Import_Name}_${Host_Os}_Import")
		elseif(${PLUGIN}_${Host_Os}_Import)											# ZLIB_Windows_Import
			dk_set(PLUGIN_Import "${PLUGIN}_${Host_Os}_Import")
		elseif(Unix_Host AND ${PLUGIN_Import_Name}_Unix_Import)						# zlib_Unix_Import
			dk_set(PLUGIN_Import "${PLUGIN_Import_Name}_Unix_Import")
		elseif(Unix_Host AND ${PLUGIN}_Unix_Import)									# ZLIB_Unix_Import
			dk_set(PLUGIN_Import "${PLUGIN}_Unix_Import")
		elseif(Apple_Host AND ${PLUGIN_Import_Name}_Apple_Import)					# zlib_Apple_Import
			dk_set(PLUGIN_Import "${PLUGIN_Import_Name}_Apple_Import")
		elseif(Apple_Host AND ${PLUGIN}_Apple_Import)								# ZLIB_Apple_Import
			dk_set(PLUGIN_Import "${PLUGIN}_Apple_Import")
		elseif(${PLUGIN_Import_Name}_Import)										# zlib_Import
			dk_set(PLUGIN_Import "${PLUGIN_Import_Name}_Import")
		elseif(${PLUGIN}_Import)													# ZLIB_Import
			dk_set(PLUGIN_Import "${PLUGIN}_Import")
		else()
			dk_assertVar(${PLUGIN}_Import)
		endif()
		dk_importVariables(${${PLUGIN_Import}} ${PLUGIN_Install_Root})
	else()
		dk_importVariables(IMPORT_PATH "${PLUGIN_Import_Path}")
	endif()
	
	if(EXISTS "${PLUGIN_Install_Path}")
		dk_notice("${PLUGIN_Install_Name} already installed")
		return()
	endif()
	
#	if(PLUGIN_Url)
#		dk_install(${PLUGIN})
#		return()
#	endif()
	
	if(PLUGIN_Url)
	
			# NOTE: Let's not forget that we rename some download files to better identify them. These are also the renamed files that 
			# will be on a backup server. So when we look for the download using the original url, we will check the alternate server
			# for the file. BUT. That file is renamed, so we need to check for the new name (${${PLUGIN}_Download_Basename}).
			dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
			dk_download("${PLUGIN_Url}" "${DKDOWNLOAD_DIR}/${PLUGIN_Download_Basename}")
			
			
			
			if("${PLUGIN_Url_Extension}" STREQUAL ".7z")
			set(FileType "Archive")
		elseif("${PLUGIN_Url_Extension}" STREQUAL ".bz")		
			set(FileType "Archive")
		elseif("${PLUGIN_Url_Extension}" STREQUAL ".bz2")		
			set(FileType "Archive")
		elseif("${PLUGIN_Url_Extension}" STREQUAL ".gz")		
			set(FileType "Archive")
		elseif("${PLUGIN_Url_Extension}" STREQUAL ".rar")		
			set(FileType "Archive")
		elseif("${PLUGIN_Url_Extension}" STREQUAL ".sfx.exe")	
			set(FileType "Archive")
		elseif("${PLUGIN_Url_Extension}" STREQUAL ".tar")		
			set(FileType "Archive")
		elseif("${PLUGIN_Url_Extension}" STREQUAL ".tar.gz")	
			set(FileType "Archive")
		elseif("${PLUGIN_Url_Extension}" STREQUAL ".tar.xz")	
			set(FileType "Archive")
		elseif("${PLUGIN_Url_Extension}" STREQUAL ".tgz")		
			set(FileType "Archive")
		elseif("${PLUGIN_Url_Extension}" STREQUAL ".xz")		
			set(FileType "Archive")
		elseif("${PLUGIN_Url_Extension}" STREQUAL ".zip")		
			set(FileType "Archive")
		endif()
		
		if("${FileType}" STREQUAL "Archive")
			dk_smartExtract("${dk_download}" "${PLUGIN_Install_Path}")
		endif()
	endif()

	#dk_getParameter(PATCH)
	#if(PATCH)
		dk_patch("${PLUGIN_Import_Name}" "${PLUGIN_Install_Path}")
	#endif()

endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_depend(cmake)
	#dk_import("https://www.dependencywalker.com/depends22_x64.zip")
endfunction()