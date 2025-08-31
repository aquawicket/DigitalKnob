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
# dk_importDKConfig(<path:optional>)
#
#
function(dk_import)
	dk_debugFunc(0 99)
	
	if(EXISTS "${ARGV0}")
		set(dkconfig "${ARGV0}")
	elseif(EXISTS "${ARGV0}/dkconfig.txt")
		set(dkconfig "${ARGV0}/dkconfig.txt")
	elseif(EXISTS "${{CURRENT_PLUGIN}_Import_Path}/dkconfig.txt")
		set(dkconfig "${{CURRENT_PLUGIN}_Import_Path}/dkconfig.txt")
	else()
		return()
	endif()
	
	dk_getFileParams("${PLUGIN_Import_Path}/dkconfig.txt")
	dk_getParameter(APP)
	if("${${PLUGIN}_Type}" STREQUAL "APP")
		set(APP 1)
	endif()
	if(APP)
		dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
		set(PLUGIN_Install_Root INSTALL_ROOT ${DKTOOLS_DIR})
	endif()
																		###### EXAMPLE ######
	dk_validate(Host_Tuple "dk_Host_Tuple()")						#      Windows_X86_64
	if(${PLUGIN}_${Host_Tuple}_Import)								# zlib_Windows_X86_64_Import
		dk_set(${PLUGIN}_Import "${PLUGIN}_${Host_Tuple}_Import")
	elseif(${PLUGIN}_${Host_Os}_Import)								# zlib_Windows_Import
		dk_set(${PLUGIN}_Import "${PLUGIN}_${Host_Os}_Import")
	elseif(Unix_Host AND ${PLUGIN}_Unix_Import)						# zlib_Unix_Import
		dk_set(${PLUGIN}_Import "${PLUGIN}_Unix_Import")
	elseif(Apple_Host AND ${PLUGIN}_Apple_Import)					# zlib_Apple_Import
		dk_set(${PLUGIN}_Import "${PLUGIN}_Apple_Import")
	elseif(${PLUGIN}_Import)										# zlib_Import
		dk_set(${PLUGIN}_Import "${PLUGIN}_Import")
	else()
		dk_notice("No import found for this build")
	endif()
	
	if(PLUGIN_Import AND PLUGIN_Install_Root)
		dk_importVariables(${${PLUGIN_Import}} ${PLUGIN_Install_Root})
	endif()
	
	if(EXISTS "${PLUGIN_Install_Path}")
		dk_notice("${PLUGIN_Install_Name} already installed")
		return()
	endif()
	
	if(PLUGIN_Url)
		dk_download("${PLUGIN_Url}")
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
		dk_patch("${PLUGIN}" "${PLUGIN_Install_Path}")
	#endif()

endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_depend(cmake)
	#dk_import("https://www.dependencywalker.com/depends22_x64.zip")
endfunction()