#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DKINIT_cmake)
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


###########################################################################################################################
# dk_importVariables(Url Rtn_Var) IMPORT_ROOT Import_Name IMPORT_PATH INSTALL_ROOT INSTALL_NAME INSTALL_PATH VERSION BRANCH 
#
#											###### EXAMPLES ######
#	Url										https://github.com/madler/zlib.git     							* github repository link
#											https://github.com/madler/zlib/archive/refs/heads/master.zip	* github sourcecode download
#											https://github.com/madler/zlib        							* github page
#											https://zlib.net/zlib-1.3.1.tar.gz								* library sourcecode download
#											https://website.com/executable.exe              				* executable file
#
#
#	IMPORT_ROOT	(optional)					C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
#
#
#	Import_Name (optional)					zlib
#
#
#	IMPORT_PATH (optional)					C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
#
#
#	INSTALL_ROOT (optional)					C:/Users/Administrator/DigitalKnob/Development/DKTools
#
#
#	INSTALL_NAME (optional)					zlib-8-5-2025
#											myZLIB
#
#	INSTALL_PATH (optional)					C:/Users/Administrator/DigitalKnob/Development/DKTools/zlib-8-5-2025
#											C:/Users/Administrator/DigitalKnob/Development/DKTools/myZLIB
#
#	VERSION (optional)						master
#
#
#	BRANCH (optional)						develop
#											master
#################################################################################
#	
#	PRINTVARS - specifying PRINTVARS will dump the current variable values of the current PLUGIN
#
function(dk_importVariables)
	#dk_debugFunc(1 9)
	
	dk_getParameter(PRINTVARS)
	if(PRINTVARS)
		PRINTVARS()
		return()
	endif()
	
	dk_unset(PLUGIN)
	#dk_unset(PLUGIN_Args)
	#dk_unset(PLUGIN_Build_Dir)
	#dk_unset(PLUGIN_Config_Dir)
	#dk_unset(PLUGIN_DKConfig)
	#dk_unset(PLUGIN_Debug_Dir)
	#dk_unset(PLUGIN_Download_Basename)
	#dk_unset(PLUGIN_Id)
	#dk_unset(PLUGIN_Import_Dirname)
	#dk_unset(PLUGIN_Import_Name)
	#dk_unset(PLUGIN_Import_Name_Lower)
	#dk_unset(PLUGIN_Import_Name_Upper)
	dk_unset(PLUGIN_Import_Path)
	#dk_unset(PLUGIN_Install_Dirname)
	#dk_unset(PLUGIN_Install_Name)
	#dk_unset(PLUGIN_Install_Path)
	#dk_unset(PLUGIN_Release_Dir)
	#dk_unset(PLUGIN_Tuple_Dir)
	#dk_unset(PLUGIN_Url)
	#dk_unset(PLUGIN_Url_Basename)
	#dk_unset(PLUGIN_Url_Extension)
	#dk_unset(PLUGIN_Url_Name)
	#dk_unset(PLUGIN_Url_Name_Lower)
	#dk_unset(PLUGIN_Version)	
																###### EXAMPLE ######
	### IMPORT_PATH (PLUGIN_Import_Path)						/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	dk_unset(IMPORT_PATH)
	dk_getParameterValue(IMPORT_PATH)
	set(PLUGIN_Import_Path "${IMPORT_PATH}" CACHE INTERNAL "" FORCE)
	#dk_debug("PLUGIN_Import_Path = '${PLUGIN_Import_Path}'")
	
	PLUGIN()
	set(${PLUGIN}_Import_Path ${PLUGIN_Import_Path} CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Import_Path = '${${PLUGIN}_Import_Path}'")
	
	### PLUGIN_Args												"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	set(${PLUGIN}_Args ${ARGV} CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Args = '${${PLUGIN}_Args}'")
	
	### IMPORT_ROOT (PLUGIN;Import_Dirname)						/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	dk_unset(IMPORT_ROOT)
	dk_getParameterValue(IMPORT_ROOT)
	set(${PLUGIN}_Import_Dirname "${IMPORT_ROOT}" CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Import_Dirname = '${${PLUGIN}_Import_Dirname}'")

	### IMPORT_NAME (PLUGIN_Import_Name)						zlib
	dk_unset(IMPORT_NAME)
	dk_getParameterValue(IMPORT_NAME)
	#dk_debug("IMPORT_NAME = '${IMPORT_NAME}'")
	set(${PLUGIN}_Import_Name "${IMPORT_NAME}" CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Import_Name = '${${PLUGIN}_Import_Name}'")
	
	### INSTALL_ROOT (PLUGIN_Install_Dirname)					/c/Users/Administrator/DigitalKnob/Development/3rdParty
	dk_unset(INSTALL_ROOT)
	dk_getParameterValue(INSTALL_ROOT)
	#dk_debug("INSTALL_ROOT = '${INSTALL_ROOT}'")
	set(${PLUGIN}_Install_Dirname "${INSTALL_ROOT}" CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Install_Dirname = '${${PLUGIN}_Install_Dirname}'")

	### INSTALL_NAME (PLUGIN_Install_Name)						zlib-master
	dk_unset(INSTALL_NAME)
	dk_getParameterValue(INSTALL_NAME)
	#dk_debug("INSTALL_NAME = '${INSTALL_NAME}'")
	set(${PLUGIN}_Install_Name "${INSTALL_NAME}" CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Install_Name = '${${PLUGIN}_Install_Name}'")

	### INSTALL_PATH (PLUGIN_Install_Path)						/c/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	dk_unset(INSTALL_PATH)
	dk_getParameterValue(INSTALL_PATH)
	#dk_debug("INSTALL_PATH = '${INSTALL_PATH}'")
	set(${PLUGIN}_Install_Path "${INSTALL_PATH}" CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Install_Path = '${${PLUGIN}_Install_Path}'")

	### VERSION (PLUGIN_Version)								v1.3.1
	dk_unset(VERSION)
	dk_getParameterValue(VERSION)
	#dk_debug("VERSION = '${VERSION}'")
	set(${PLUGIN}_Version "${VERSION}" CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Version = '${${PLUGIN}_Version}'")

	### BRANCH (PLUGIN_Branch)									master
	dk_unset(BRANCH)
	dk_getParameterValue(BRANCH)
	#dk_debug("BRANCH = '${BRANCH}'")
	set(${PLUGIN}_Branch "${BRANCH}" CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Branch = '${${PLUGIN}_Branch}'")
		
#	### PLUGIN_Url												"https://github.com/madler/zlib/archive/refs/heads/master.zip"
#	dk_isUrl("${ARGV0}")
#	if(dk_isUrl)
#		set(${PLUGIN}_Url "${ARGV0}" CACHE INTERNAL "" FORCE)
#		#dk_getUrl(${${PLUGIN}_Url} ${PLUGIN}_Url)	
#	endif()
#	#dk_debug("${PLUGIN}_Url = '${${PLUGIN}_Url}'")

	### PLUGIN_ vars
	PLUGIN_DKConfig()
	PLUGIN_Import_Name()
	PLUGIN_Import_Path()
	#PLUGIN_Id()
	#PLUGIN_Args()
	PLUGIN_Url()
	PLUGIN_Url_Basename()
	PLUGIN_Url_Name()
	PLUGIN_Url_Extension()
	PLUGIN_Import_Dirname()
	#PLUGIN_Tuple_Dir()
	#PLUGIN_Build_Dir()
	#PLUGIN_Config_Dir()
	#PLUGIN_Debug_Dir()
	#PLUGIN_Release_Dir()
	PLUGIN_Version()
	PLUGIN_Download()
	PLUGIN_Download_Basename()
	PLUGIN_Install_Dirname()
	PLUGIN_Install_Name()
	PLUGIN_Install_Path()
	
	### ${PLUGIN}
	dk_set(${PLUGIN} "${${PLUGIN}_Install_Path}")
	#dk_debug("${PLUGIN} = '${${PLUGIN}}'")
	
	#####################################################
	############# PLUGIN_Target_Directries ##############
	#####################################################
		
	### PLUGIN_Tuple_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	if(${PLUGIN}_Install_Path AND Target_Tuple)
		dk_set(${PLUGIN}_Tuple_Dir "${${PLUGIN}_Install_Path}/${Target_Tuple}")
		#dk_debug("${PLUGIN}_Tuple_Dir = '${${PLUGIN}_Tuple_Dir}'")
	endif()
	
	### PLUGIN_Config_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	if(${PLUGIN}_Install_Path AND Target_Config)
		#dk_validate(Target_Config "dk_Target_Config()")
		dk_set(${PLUGIN}_Config_Dir "${${PLUGIN}_Install_Path}/${Target_Config}")
		#dk_debug("${PLUGIN}_Config_Dir = '${${PLUGIN}_Config_Dir}'")
	endif()

	### PLUGIN_Build_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	if(${PLUGIN}_Install_Path AND Target_Build)
		dk_set(${PLUGIN}_Build_Dir "${${PLUGIN}_Install_Path}/${Target_Build}")
		#dk_debug("${PLUGIN}_Build_Dir = '${${PLUGIN}_Build_Dir}'")
	endif()
	
	### PLUGIN_Debug_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	if(${PLUGIN}_Tuple_Dir AND Debug_Dir)
		dk_set(${PLUGIN}_Debug_Dir "${${PLUGIN}_Tuple_Dir}/${Debug_Dir}")
		#dk_debug("${PLUGIN}_Debug_Dir = '${${PLUGIN}_Debug_Dir}'")
	endif()
	
	### PLUGIN_Release_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	if(${PLUGIN}_Tuple_Dir AND Release_Dir)
		dk_set(${PLUGIN}_Release_Dir "${${PLUGIN}_Tuple_Dir}/${Release_Dir}")
		#dk_debug("${PLUGIN}_Release_Dir = '${${PLUGIN}_Release_Dir}'")
	endif()
	
	#dk_copyVariables("PLUGIN_" "${PLUGIN}_")			### PLUGIN_ to ZLIB_
	#dk_copyVariables("PLUGIN_" "${PLUGIN_Id}_")		### PLUGIN_ ti zlib
	PRINTVARS()
endfunction()



##################################
function(PLUGIN_DKConfig)
	if(${PLUGIN}_DKConfig)
		return()
	endif()
	dk_assertVar(PLUGIN)
	
	PLUGIN_Import_Path()
	if(EXISTS "${${PLUGIN}_Import_Path}/dkconfig.txt")
		set(${PLUGIN}_DKConfig "${${PLUGIN}_Import_Path}/dkconfig.txt")
	endif()

	if(NOT ${PLUGIN}_DKConfig)
		dk_notice("${PLUGIN}_DKConfig is invalid")
	endif()
	
	set(${PLUGIN}_DKConfig ${${PLUGIN}_DKConfig} CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_DKConfig = '${${PLUGIN}_DKConfig}'")
endfunction()

##################################
function(PLUGIN_Type)
	if(${PLUGIN}_Type)
		return()
	endif()
	
	PLUGIN_DKConfig()
	if(${PLUGIN}_DKConfig)
		dk_fileVariables("${${PLUGIN}_DKConfig}")
	endif()	
		
	if(NOT ${PLUGIN}_Type)
		dk_notice("${PLUGIN}_Type is invalid")
	endif()
	
	set(${PLUGIN}_Type ${${PLUGIN}_Type} CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Type = '${${PLUGIN}_Type}'")	
endfunction()


##################################
function(PLUGIN_Import)
	if(${PLUGIN}_Import)
		return()
	endif()
	
	PLUGIN_DKConfig()
	if(${PLUGIN}_DKConfig)
		dk_fileVariables("${${PLUGIN}_DKConfig}")
		
		### ${PLUGIN}_Import ###                                    				###### EXAMPLE ######
		
		### <PLUGIN>_Import
		### <PLUGIN>_Host_Tuple_Import
		dk_validate(Host_Tuple "dk_Host_Tuple()")									#      Windows_X86_64
		if(${PLUGIN}_${Host_Tuple}_Import)											# zlib_Windows_X86_64_Import
			set(${PLUGIN}_Import "${PLUGIN}_${Host_Tuple}_Import")
		
		### <PLUGIN>_Host_Os_Import
		elseif(${PLUGIN}_${Host_Os}_Import)											# zlib_Windows_Import
			set(${PLUGIN}_Import "${PLUGIN}_${Host_Os}_Import")
		
		### <PLUGIN>_Host_Arch_Import
		elseif(${PLUGIN}_${Host_Arch}_Import)										# zlib_Windows_Import
			set(${PLUGIN}_Import "${PLUGIN}_${Host_Arch}_Import")
		
		### <PLUGIN>_Apple_Import
		elseif(Apple_Host AND ${PLUGIN}_Apple_Import)								# zlib_Apple_Import
			set(${PLUGIN}_Import "${PLUGIN}_Apple_Import")
			
		### <PLUGIN>_Linux_Import
		elseif(Linux_Host AND ${PLUGIN}_Linux_Import)								# zlib_Linux_Import
			set(${PLUGIN}_Import "${PLUGIN}_Linux_Import")
			
		### <PLUGIN>_Unix_Import
		elseif(Unix_Host AND ${PLUGIN}_Unix_Import)									# zlib_Unix_Import
			set(${PLUGIN}_Import "${PLUGIN}_Unix_Import")
		
		### <PLUGIN>_Windows_Import
		elseif(Windows_Host AND ${PLUGIN}_Windows_Import)							# zlib_Windows_Import
			set(${PLUGIN}_Import "${PLUGIN}_Windows_Import")
		
		### Default
		#elseif(${PLUGIN}_Import)													# zlib_Import
			#set(${PLUGIN}_Import "${PLUGIN}_Import")
		else()
			dk_notice("No Import found for ${PLUGIN}:${${PLUGIN}_Import_Path}")
		endif()
	endif()
	
	if(NOT ${PLUGIN}_Import)
		dk_notice("${PLUGIN}_Import is invalid")
	endif()
	
	set(${PLUGIN}_Import ${${PLUGIN}_Import} CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Import = '${${PLUGIN}_Import}'")
endfunction()



##################################
function(PLUGIN_Download)
	if(${PLUGIN}_Download)
		return()
	endif()
	
#	PLUGIN_Import_Name()
#	PLUGIN_Url_Name()
#	dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
#	if(NOT "${${PLUGIN}_Import_Name}" MATCHES "${${PLUGIN}_Url_Name}")
#		PLUGIN_Install_Name()
#		PLUGIN_Url_Extension()
#		dk_set(${PLUGIN}_Download "${DKDOWNLOAD_DIR}/${${PLUGIN}_Install_Name}${${PLUGIN}_Url_Extension}")
#	else()
	dk_DKDOWNLOAD_DIR()
	PLUGIN_Url_Basename()
	if(DKDOWNLOAD_DIR AND ${PLUGIN}_Url_Basename)
		dk_set(${PLUGIN}_Download "${DKDOWNLOAD_DIR}/${${PLUGIN}_Url_Basename}")
	endif()
	
	if(NOT ${PLUGIN}_Download)
		dk_notice("${PLUGIN}_Download is invalid")
	endif()
	
	set(${PLUGIN}_Download "${${PLUGIN}_Download}" CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Download = ${${PLUGIN}_Download}")
endfunction()

##################################
function(PLUGIN_Download_Basename)
	if(${PLUGIN}_Download_Basename)
		return()
	endif()
	
#	PLUGIN_Import_Name()
#	PLUGIN_Url_Name()
#	if(NOT "${${PLUGIN}_Import_Name}" MATCHES "${${PLUGIN}_Url_Name}")
#		PLUGIN_Install_Name()
#		PLUGIN_Url_Extension()
#		dk_set(${PLUGIN}_Download_Basename "${${PLUGIN}_Install_Name}${${PLUGIN}_Url_Extension}")
#	else()
#		PLUGIN_Url_Basename()
#		dk_set(${PLUGIN}_Download_Basename "${${PLUGIN}_Url_Basename}")
#	endif()

	PLUGIN_Download()
	if(${PLUGIN}_Download)
		dk_basename(${${PLUGIN}_Download} ${PLUGIN}_Download_Basename)
	endif()

	if(NOT ${PLUGIN}_Download_Basename)
		dk_notice("${PLUGIN}_Download_Basename is invalid")
	endif()
	
	set(${PLUGIN}_Download_Basename "${${PLUGIN}_Download_Basename}" CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Download_Basename = ${${PLUGIN}_Download_Basename}")
endfunction()

############################
function(PLUGIN_Import_Name)
	if(${PLUGIN}_Import_Name)
		return()
	endif()
		
	PLUGIN_Import_Path()
	if(${PLUGIN}_Import_Path)
		dk_basename("${${PLUGIN}_Import_Path}"	${PLUGIN}_Import_Name)
	else()
		PLUGIN_Url()
		dk_includes("${${PLUGIN}_Url}" "https://github.com" dk_includes)
		if(dk_includes)
			dk_replaceAll(${${PLUGIN}_Url}			"/" 	"" 	${PLUGIN}_Url_List)
			dk_replaceAll(${${PLUGIN}_Url_List} 	";;" 	";" ${PLUGIN}_Url_List)
			if(NOT ${PLUGIN}_Url_List)
				dk_error("${PLUGIN}_Url_List is invalid")
			endif()
			#dk_debug("${PLUGIN}_Url_List = '${${PLUGIN}_Url_List}'")
			
			#d_k_listToArray("${${PLUGIN}_Url_List}"  ${PLUGIN}_Url_Array)
			#dk_printVar(${PLUGIN}_Url_Array)
			#if(NOT ${PLUGIN}_Url_Array)
			#	dk_error("${PLUGIN}_Url_Array is invalid")
			#endif()
			##dk_debug("${PLUGIN}_Url_Array = '${${PLUGIN}_Url_Array}'")
			
			#dk_arrayAt(${PLUGIN}_Url_Array	3	${PLUGIN}_Import_Name)
			#if(NOT ${PLUGIN}_Import_Name)
			#	dk_error("${PLUGIN}_Import_Name is invalid")
			#endif()
		endif()
		#dk_debug("${PLUGIN}_Import_Name = '${${PLUGIN}_Import_Name}'")
	endif()
	
	if(NOT ${PLUGIN}_Import_Name)
		dk_notice("${PLUGIN}_Import_Name is invalid")
	endif()
	
	set(${PLUGIN}_Import_Name "${${PLUGIN}_Import_Name}" CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Import_Name = '${${PLUGIN}_Import_Name}'")
endfunction()

##################################
function(PLUGIN_Import_Name_Lower)
	if(${PLUGIN}_Import_Name_Lower)
		return()
	endif()
	
	PLUGIN_Import_Name()
	if(${PLUGIN}_Import_Name)
		dk_toLower("${${PLUGIN}_Import_Name}" 	${PLUGIN}_Import_Name_Lower)
	endif()
	
	if(NOT ${PLUGIN}_Import_Name_Lower)
		dk_error("${PLUGIN}_Import_Name_Lower is invalid")
	endif()
	
	set(${PLUGIN}_Import_Name_Lower "${${PLUGIN}_Import_Name_Lower}" CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Import_Name_Lower = '${${PLUGIN}_Import_Name_Lower}'")
endfunction()

##################################
function(PLUGIN_Import_Dirname)
	if(${PLUGIN}_Import_Dirname)
		return()
	endif()
	
	PLUGIN_Import_Path()
	if(${PLUGIN}_Import_Path)
		dk_dirname("${${PLUGIN}_Import_Path}" 	${PLUGIN}_Import_Dirname)
	endif()
	
	if(NOT ${PLUGIN}_Import_Dirname)
		dk_notice("${PLUGIN}_Import_Dirname is invalid")
	endif()
	
	set(${PLUGIN}_Import_Dirname "${${PLUGIN}_Import_Dirname}" CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Import_Dirname = '${${PLUGIN}_Import_Dirname}'")
endfunction()

################################
function(PLUGIN_Install_Dirname)
	if(${PLUGIN}_Install_Dirname)
		return()
	endif()
	
	PLUGIN_Type()
	if(${PLUGIN}_Type)
		if("${${PLUGIN}_Type}" STREQUAL "Tool")
			dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
			set(${PLUGIN}_Install_Dirname "${DKTOOLS_DIR}")
		endif()
	else()
		dk_DK3RDPARTY_DIR()
		if(DK3RDPARTY_DIR)
			set(${PLUGIN}_Install_Dirname "${DK3RDPARTY_DIR}")
		endif()
	endif()
	
	if(NOT ${PLUGIN}_Install_Dirname)
		dk_error("${PLUGIN}_Install_Dirname is invalid")
	endif()
	
	set(${PLUGIN}_Install_Dirname ${${PLUGIN}_Install_Dirname}  CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Install_Dirname = '${${PLUGIN}_Install_Dirname}'")
endfunction()

#############################
function(PLUGIN_Url_Basename)
	if(${PLUGIN}_Url_Basename)
		return()
	endif()
	
	PLUGIN_Url()
	if(${PLUGIN}_Url)
		dk_basename(${${PLUGIN}_Url})
		set(${PLUGIN}_Url_Basename ${dk_basename})
		string(REPLACE "?" "" ${PLUGIN}_Url_Basename ${${PLUGIN}_Url_Basename})
		string(REPLACE "=" "" ${PLUGIN}_Url_Basename ${${PLUGIN}_Url_Basename})
	endif()

	if(NOT ${PLUGIN}_Url_Basename)
		dk_notice("${PLUGIN}_Url_Basename is invalid")
	endif()
	
	set(${PLUGIN}_Url_Basename ${${PLUGIN}_Url_Basename} CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Url_Basename = '${${PLUGIN}_Url_Basename}'")
endfunction()

#############################
function(PLUGIN_Url_Dirname)
	if(${PLUGIN}_Url_Dirname)
		return()
	endif()
	
	PLUGIN_Url()
	if(${PLUGIN}_Url)
		dk_dirname("${${PLUGIN}_Url}" ${PLUGIN}_Url_Dirname)
	endif()
	
	if(NOT ${PLUGIN}_Url_Dirname)
		dk_notice("${PLUGIN}_Url_Dirname is invalid")
	endif()
	
	set(${PLUGIN}_Url_Dirname ${${PLUGIN}_Url_Dirname} CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Url_Dirname = '${${PLUGIN}_Url_Dirname}'")
endfunction()

##############################
function(PLUGIN_Url_Extension)
	if(${PLUGIN}_Url_Extension)
		return()
	endif()
	
	PLUGIN_Url_Basename()
	if(${PLUGIN}_Url_Basename)
		dk_getExtension("${${PLUGIN}_Url_Basename}" ${PLUGIN}_Url_Extension)
	endif()
	
	if(NOT ${PLUGIN}_Url_Extension)
		dk_notice("${PLUGIN}_Url_Extension is invalid")
	endif()
	
	set(${PLUGIN}_Url_Extension ${${PLUGIN}_Url_Extension} CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Url_Extension = '${${PLUGIN}_Url_Extension}'")
endfunction()

#########################
function(PLUGIN_Url_Name)
	if(${PLUGIN}_Url_Name)
		return()
	endif()
	
	PLUGIN_Url_Basename()
	if(${PLUGIN}_Url_Basename)
		dk_removeExtension("${${PLUGIN}_Url_Basename}" ${PLUGIN}_Url_Name)
	endif()
	
	if(NOT ${PLUGIN}_Url_Name)
		dk_notice("${PLUGIN}_Url_Name is invalid")
	endif()
	
	set(${PLUGIN}_Url_Name ${${PLUGIN}_Url_Name} CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Url_Name = '${${PLUGIN}_Url_Name}'")
endfunction()

###############################
function(PLUGIN_Url_Name_Lower)
	if(${PLUGIN}_Url_Name_Lower)
		return()
	endif()
	
	PLUGIN_Url_Name()
	if(${PLUGIN}_Url_Name)
		dk_toLower(${${PLUGIN}_Url_Name})
		set(${PLUGIN}_Url_Name_Lower ${dk_toLower})
	endif()
	
	if(NOT ${PLUGIN}_Url_Name_Lower)
		dk_notice("${PLUGIN}_Url_Name_Lower is invalid")
	endif()
	
	set(${PLUGIN}_Url_Name_Lower ${${PLUGIN}_Url_Name_Lower} CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Url_Name_Lower = '${${PLUGIN}_Url_Name_Lower}'")
endfunction()

####################
function(PLUGIN_Url)
	if(${PLUGIN}_Url)
		return()
	endif()
	
	PLUGIN_Import()
	if(${${PLUGIN}_Import})
		dk_set(${PLUGIN}_Url ${${${PLUGIN}_Import}})
	elseif(${PLUGIN}_Import)
		dk_set(${PLUGIN}_Url ${${PLUGIN}_Import})
	endif()
	
	if(NOT ${PLUGIN}_Url)
		dk_notice("${PLUGIN}_Url is invalid")
	endif()
	
	set(${PLUGIN}_Url ${${PLUGIN}_Url} CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Url = '${${PLUGIN}_Url}'")
endfunction()

#############################
function(PLUGIN_Install_Name)
	if(${PLUGIN}_Install_Name)
		return()
	endif()
	
	PLUGIN_Import_Name()
	PLUGIN_Version()
	if((${PLUGIN}_Import_Name) AND (${PLUGIN}_Version))
		set(${PLUGIN}_Install_Name "${${PLUGIN}_Import_Name}-${${PLUGIN}_Version}")
	elseif(NOT ${PLUGIN}_Install_Name)	
		set(${PLUGIN}_Install_Name "${${PLUGIN}_Import_Name}")
	endif()
	
	if(NOT ${PLUGIN}_Install_Name)
		dk_error("${PLUGIN}_Install_Name is invalid")
	endif()
	
	set(${PLUGIN}_Install_Name ${${PLUGIN}_Install_Name} CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Install_Name = '${${PLUGIN}_Install_Name}'")
endfunction()

#############################
function(PLUGIN_Install_Path)
	if(${PLUGIN}_Install_Path)
		return()
	endif()
	
	PLUGIN_Install_Dirname()	
	PLUGIN_Install_Name()
	if(${PLUGIN}_Install_Dirname AND ${PLUGIN}_Install_Name)
		set(${PLUGIN}_Install_Path "${${PLUGIN}_Install_Dirname}/${${PLUGIN}_Install_Name}")
	endif()
	
	if(NOT ${PLUGIN}_Install_Path)
		dk_error("${PLUGIN}_Install_Path is invalid")
	endif()
	
	set(${PLUGIN}_Install_Path ${${PLUGIN}_Install_Path} CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Install_Path = '${${PLUGIN}_Install_Path}'")
endfunction()

############################
function(PLUGIN_Import_Path)
	if(${PLUGIN}_Import_Path)
		return()
	endif()
	
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	if(PLUGIN AND DKIMPORTS_DIR)
		set(${PLUGIN}_Import_Path "${DKIMPORTS_DIR}/${PLUGIN}")
	elseif(${CURRENT_PLUGIN}_Import_Path)
		set(${PLUGIN}_Import_Path "${${CURRENT_PLUGIN}_Import_Path}")
	#elseif(CMAKE_CURRENT_FUNCTION_LIST_DIR)
		#dk_debug("CMAKE_CURRENT_FUNCTION_LIST_DIR = ${CMAKE_CURRENT_FUNCTION_LIST_DIR}")
	endif()
	
	if(NOT ${PLUGIN}_Import_Path)
		dk_notice("${PLUGIN}_Import_Path is invalid")
	endif()
		
	set(${PLUGIN}_Import_Path ${${PLUGIN}_Import_Path} CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Import_Path = '${${PLUGIN}_Import_Path}'")
endfunction()

########################
function(PLUGIN_Version)
	if(${PLUGIN}_Version)
		return()
	endif()
	
	PLUGIN_Url_Name_Lower()
	if(${PLUGIN}_Url_Name_Lower)
		PLUGIN_Import_Name_Lower()
		if(${PLUGIN}_Import_Name_Lower)
			dk_replaceAll("${${PLUGIN}_Url_Name_Lower}" 	"${${PLUGIN}_Import_Name_Lower}" 	""  ${PLUGIN}_Version)
		endif()
		if(NOT ${PLUGIN}_Version)
			#PLUGIN_Tag()
			set(${PLUGIN}_Version ${${PLUGIN}_TAG})
		endif()
		if(NOT ${PLUGIN}_Version)
			#PLUGIN_Branch()
			set(${PLUGIN}_Version ${${PLUGIN}_Branch})
		endif()
	endif()
	
	dk_trimNonAlphaNumeric("${${PLUGIN}_Version}" ${PLUGIN}_Version)
	
	if(NOT ${PLUGIN}_Version)
		dk_notice("${PLUGIN}_Version is invalid")
	endif()
	
	set(${PLUGIN}_Version "${${PLUGIN}_Version}" CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Version = '${${PLUGIN}_Version}'")
endfunction()

##################################
function(PLUGIN_Import_Name_Upper)
	if(${PLUGIN}_Import_Name_Upper)
		return()
	endif()
	
	PLUGIN_Import_Name()
	dk_toUpper("${${PLUGIN}_Import_Name}" ${PLUGIN}_Import_Name_Upper)
	
	if(NOT ${PLUGIN}_Import_Name_Upper)
		dk_error("${PLUGIN}_Import_Name_Upper is invalid")
	endif()
	
	set(${PLUGIN}_Import_Name_Upper ${${PLUGIN}_Import_Name_Upper} CACHE INTERNAL "" FORCE)
	#dk_debug("${PLUGIN}_Import_Name_Upper = '${${PLUGIN}_Import_Name_Upper}'")
endfunction()

###################
#function(PLUGIN_Id)
#	if(${${PLUGIN}_Id})
#		return()
#	endif()
#	
#	PLUGIN_Import_Name()
#
#	if(NOT ${PLUGIN}_Import_Name)
#		dk_error("${PLUGIN}_Import_Name is invalid")
#	endif()
#	#dk_debug("${PLUGIN}_Import_Name = '${${PLUGIN}_Import_Name}'")
#	
# 	set(${PLUGIN}_Id "${${PLUGIN}_Import_Name}" CACHE INTERNAL "" FORCE)
#	if(NOT ${PLUGIN}_Id)
#		dk_error("${PLUGIN}_Id is invalid")
#	endif()
#	#dk_debug("${PLUGIN}_Id = '${${PLUGIN}_Id}'")
#	
#	set(${PLUGIN}_Id ${${PLUGIN}_Id} CACHE INTERNAL "" FORCE)
#endfunction()
	
###################
function(PLUGIN)
	if(PLUGIN)
		return()
	endif()
	
	if(PLUGIN_Import_Name)
		dk_debug("PLUGIN_Import_Name = '${PLUGIN_Import_Name}'")
		set(PLUGIN ${PLUGIN_Import_Name})
	elseif(PLUGIN_Import_Path)
		dk_debug("PLUGIN_Import_Path = '${PLUGIN_Import_Path}'")
		dk_basename(${PLUGIN_Import_Path} PLUGIN)
	elseif(CURRENT_PLUGIN)
		dk_debug("CURRENT_PLUGIN = '${CURRENT_PLUGIN}'")
		set(PLUGIN ${CURRENT_PLUGIN})
	elseif(DKSCRIPT_DIR)
		dk_debug("DKSCRIPT_DIR = '${DKSCRIPT_DIR}'")
		dk_basename(${DKSCRIPT_DIR} PLUGIN)
	else()
		dk_error("Found no way to get the PLUGIN name")
	endif()
	
	if(NOT PLUGIN)
		PLUGIN_Import_Name()
		set(PLUGIN "${${PLUGIN}_Import_Name}")
	endif()
	
	if(NOT PLUGIN)
		dk_error("PLUGIN is invalid")
	endif()
	
	set(PLUGIN ${PLUGIN} CACHE INTERNAL "" FORCE)
	dk_debug("PLUGIN = '${PLUGIN}'")
endfunction()
	


	
	
	
	
		
	
	
	
	
	
	
	
	
	
###################
function(PRINTVARS)
	dk_debug()
	dk_debug("################## PLUGIN variables ##################")
	dk_printPrefixVars("PLUGIN")
	dk_debug()
	
	dk_debug()
	dk_debug("######################## ${PLUGIN} variables ########################")
	dk_printPrefixVars("${PLUGIN}")
	dk_debug()
endfunction()	



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	dk_importVariables(IMPORT_PATH "${DKIMPORTS_DIR}/git")
	dk_importVariables(PRINTVARS)
	
endfunction()
