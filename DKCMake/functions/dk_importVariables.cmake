#!/usr/bin/cmake -P
### DK.cmake ####################################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
##################################################################################




###########################################################################################################################
# dk_importVariables(Url Rtn_Var) IMPORT_ROOT Import_Name IMPORT_PATH INSTALL_ROOT INSTALL_NAME INSTALL_PATH VERSION BRANCH 
#
#																	###### EXAMPLES ######
#	Url																https://github.com/madler/zlib.git     							* github repository link
#																	https://github.com/madler/zlib/archive/refs/heads/master.zip	* github sourcecode download
#																	https://github.com/madler/zlib        							* github page
#																	https://zlib.net/zlib-1.3.1.tar.gz								* library sourcecode download
#																	https://website.com/executable.exe              				* executable file
#
#
#	IMPORT_ROOT	(optional)											C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
#
#
#	Import_Name (optional)											zlib
#
#
#	IMPORT_PATH (optional)											C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
#
#
#	INSTALL_ROOT (optional)											C:/Users/Administrator/DigitalKnob/Development/DKTools
#
#
#	INSTALL_NAME (optional)											zlib-8-5-2025
#																	myZLIB
#
#	INSTALL_PATH (optional)											C:/Users/Administrator/DigitalKnob/Development/DKTools/zlib-8-5-2025
#																	C:/Users/Administrator/DigitalKnob/Development/DKTools/myZLIB
#
#	VERSION (optional)												master
#
#
#	BRANCH (optional)												develop
#																	master
#################################################################################
#	
#	PRINTVARS - specifying PRINTVARS will dump the current variable values of the current PLUGIN
#
function(dk_importVariables)
	#dk_debugFunc(1 9)
	dk_debug("dk_importVariables(${ARGV})")
	
	dk_debug("CURRENT_PLUGIN = ${CURRENT_PLUGIN}")
	dk_debug("CURRENT_IMPORT = ${CURRENT_IMPORT}")
	
	dk_getParameter(PRINTVARS)
	if(PRINTVARS)
		PRINTVARS()
		return()
	endif()
	
	dk_unset(PLUGIN)
	dk_unset(PLUGIN_Args)
	dk_unset(PLUGIN_Build_Dir)
	dk_unset(PLUGIN_Config_Dir)
	dk_unset(PLUGIN_Debug_Dir)
	dk_unset(PLUGIN_Id)
	dk_unset(PLUGIN_Import_Dirname)
	dk_unset(PLUGIN_Import_Name)
	dk_unset(PLUGIN_Import_Name_Lower)
	dk_unset(PLUGIN_Import_Name_Upper)
	dk_unset(PLUGIN_Import_Path)
	dk_unset(PLUGIN_Install_Dirname)
	dk_unset(PLUGIN_Install_Name)
	dk_unset(PLUGIN_Install_Path)
	dk_unset(PLUGIN_Release_Dir)
	dk_unset(PLUGIN_Tuple_Dir)
	dk_unset(PLUGIN_Url)
	dk_unset(PLUGIN_Url_Basename)
	dk_unset(PLUGIN_Url_Extension)
	dk_unset(PLUGIN_Url_Name)
	dk_unset(PLUGIN_Url_Name_Lower)
	dk_unset(PLUGIN_Version)
	
	#dk_debug("PLUGIN = ${PLUGIN}")
	#dk_debug("PLUGIN_Args = ${PLUGIN_Args}")
	#dk_debug("PLUGIN_Build_Dir = ${PLUGIN_Build_Dir}")
	#dk_debug("PLUGIN_Config_Dir = ${PLUGIN_Config_Dir}")
	#dk_debug("PLUGIN_Debug_Dir = ${PLUGIN_Debug_Dir}")
	#dk_debug("PLUGIN_Id = ${PLUGIN_Id}")
	#dk_debug("PLUGIN_Import_Dirname = ${PLUGIN_Import_Dirname}")
	#dk_debug("PLUGIN_Import_Name = ${PLUGIN_Import_Name}")
	#dk_debug("PLUGIN_Import_Name_Lower = ${PLUGIN_Import_Name_Lower}")
	#dk_debug("PLUGIN_Import_Name_Upper = ${PLUGIN_Import_Name_Upper}")
	#dk_debug("PLUGIN_Import_Path = ${PLUGIN_Import_Path}")
	#dk_debug("PLUGIN_Install_Dirname = ${PLUGIN_Install_Dirname}")
	#dk_debug("PLUGIN_Install_Name = ${PLUGIN_Install_Name}")
	#dk_debug("PLUGIN_Install_Path = ${PLUGIN_Install_Path}")
	#dk_debug("PLUGIN_Release_Dir = ${PLUGIN_Release_Dir}")
	#dk_debug("PLUGIN_Tuple_Dir = ${PLUGIN_Tuple_Dir}")
	#dk_debug("PLUGIN_Url = ${PLUGIN_Url}")
	#dk_debug("PLUGIN_Url_Basename = ${PLUGIN_Url_Basename}")
	#dk_debug("PLUGIN_Url_Extension = ${PLUGIN_Url_Extension}")
	#dk_debug("PLUGIN_Url_Name = ${PLUGIN_Url_Name}")
	#dk_debug("PLUGIN_Url_Name_Lower = ${PLUGIN_Url_Name_Lower}")
	#dk_debug("PLUGIN_Version = ${PLUGIN_Version}")

	### PLUGIN(hashtable) 
	##  TODO
	####################
	
	
																###### EXAMPLE ######
	### IMPORT_ROOT (PLUGIN;Import_Dirname)						/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	#dk_unset(IMPORT_ROOT)
	dk_getParameterValue(IMPORT_ROOT)
	dk_debug("IMPORT_ROOT = '${IMPORT_ROOT}'")
	set(PLUGIN_Import_Dirname "${IMPORT_ROOT}" CACHE INTERNAL "")

	### IMPORT_NAME (PLUGIN_Import_Name)						zlib
	#dk_unset(IMPORT_NAME)
	dk_getParameterValue(IMPORT_NAME)
	dk_debug("IMPORT_NAME = '${IMPORT_NAME}'")
	set(PLUGIN_Import_Name "${IMPORT_NAME}" CACHE INTERNAL "")

	### IMPORT_PATH (PLUGIN_Import_Path)						/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	#dk_unset(IMPORT_PATH)
	dk_getParameterValue(IMPORT_PATH)
	dk_debug("IMPORT_PATH = '${IMPORT_PATH}'")
	set(PLUGIN_Import_Path "${IMPORT_PATH}" CACHE INTERNAL "")

	### INSTALL_ROOT (PLUGIN_Install_Dirname)					/c/Users/Administrator/DigitalKnob/Development/3rdParty
	#dk_unset(INSTALL_ROOT)
	dk_getParameterValue(INSTALL_ROOT)
	dk_debug("INSTALL_ROOT = '${INSTALL_ROOT}'")
	set(PLUGIN_Install_Dirname "${INSTALL_ROOT}" CACHE INTERNAL "")

	### INSTALL_NAME (PLUGIN_Install_Name)						zlib-master
	#dk_unset(INSTALL_NAME)
	dk_getParameterValue(INSTALL_NAME)
	dk_debug("INSTALL_NAME = '${INSTALL_NAME}'")
	set(PLUGIN_Install_Name "${INSTALL_NAME}" CACHE INTERNAL "")

	### INSTALL_PATH (PLUGIN_Install_Path)						/c/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	#dk_unset(INSTALL_PATH)
	dk_getParameterValue(INSTALL_PATH)
	dk_debug("INSTALL_PATH = '${INSTALL_PATH}'")
	set(PLUGIN_Install_Path "${INSTALL_PATH}" CACHE INTERNAL "")

	### VERSION (PLUGIN_Version)								v1.3.1
	#dk_unset(VERSION)
	dk_getParameterValue(VERSION)
	dk_debug("VERSION = '${VERSION}'")
	set(PLUGIN_Version "${VERSION}" CACHE INTERNAL "")

	### BRANCH (PLUGIN_Branch)									master
	#dk_unset(BRANCH)
	dk_getParameterValue(BRANCH)
	dk_debug("BRANCH = '${BRANCH}'")
	set(PLUGIN_Branch "${BRANCH}" CACHE INTERNAL "")
	
	### PLUGIN_Args												"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	#dk_unset(PLUGIN_Args)
	set(PLUGIN_Args ${ARGV} CACHE INTERNAL "")
	dk_debug("PLUGIN_Args = '${PLUGIN_Args}'")
		
	### PLUGIN_Url												"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	#dk_unset(PLUGIN_Url)
	if(ARGV0)
		dk_isUrl("${ARGV0}")
		if(dk_isUrl)
			message("${ARGV0} is a valid URL")
		endif()
	endif()
	set(PLUGIN_Url "${ARGV0}" CACHE INTERNAL "")
	dk_debug("PLUGIN_Url = '${PLUGIN_Url}'")


	### PLUGIN_Id												ZLIB
	PLUGIN_Id()

	### PLUGIN_Install_Path										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	PLUGIN_Install_Path()

	### PLUGIN_Url_Extension									.zip
	PLUGIN_Url_Extension()
	
	### PLUGIN_Install_Dirname									C:/Users/Administrator/DigitalKnob/Development/3rdParty
	PLUGIN_Import_Dirname()
	#####################################################
	############# PLUGIN_Target_Directries ##############
	#####################################################
	### PLUGIN_Tuple_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	set(PLUGIN_Tuple_Dir "${PLUGIN_Install_Path}/${Target_Tuple}" 	CACHE INTERNAL "")
	dk_debug("PLUGIN_Tuple_Dir = '${PLUGIN_Tuple_Dir}'")
	
	### PLUGIN_Config_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	dk_validate(Target_Config "dk_Target_Config()")
	set(PLUGIN_Config_Dir "${PLUGIN_Install_Path}/${Target_Config}" CACHE INTERNAL "")
	dk_debug("PLUGIN_Config_Dir = '${PLUGIN_Config_Dir}'")

	### PLUGIN_Build_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set(PLUGIN_Build_Dir "${PLUGIN_Install_Path}/${Target_Build}" 	CACHE INTERNAL "")
	dk_debug("PLUGIN_Build_Dir = '${PLUGIN_Build_Dir}'")

	### PLUGIN_Debug_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set(PLUGIN_Debug_Dir "${PLUGIN_Tuple_Dir}/${Debug_Dir}" 		CACHE INTERNAL "")
	dk_debug("PLUGIN_Debug_Dir = '${PLUGIN_Debug_Dir}'")

	### PLUGIN_Release_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	set(PLUGIN_Release_Dir "${PLUGIN_Tuple_Dir}/${Release_Dir}" 	CACHE INTERNAL "")
	dk_debug("PLUGIN_Release_Dir = '${PLUGIN_Release_Dir}'")

	### PLUGIN
	set(PLUGIN "${PLUGIN_Id}" CACHE INTERNAL "")
	dk_debug("PLUGIN = '${PLUGIN}'")
	
	### ${PLUGIN}
	set(${PLUGIN} "${PLUGIN_Install_Path}" CACHE INTERNAL "")
	dk_debug("${PLUGIN} = '${${PLUGIN}}'")

	Copy_Variables()
	PRINTVARS()
endfunction()


############################
function(PLUGIN_Import_Name)
	if(PLUGIN_Import_Name)
		return()
	endif()
		
	PLUGIN_Import_Path()

	if(NOT PLUGIN_Import_Path)
		dk_error("PLUGIN_Import_Path is invalid")
	endif()
	dk_debug("PLUGIN_Import_Path = '${PLUGIN_Import_Path}'")

	if(PLUGIN_Import_Path)
		dk_basename("${PLUGIN_Import_Path}"	PLUGIN_Import_Name)
		if(NOT PLUGIN_Import_Name)
			dk_error("PLUGIN_Import_Name is invalid")
		endif()
		dk_debug("PLUGIN_Import_Name = '${PLUGIN_Import_Name}'")
		
	else()
		dk_includes("${PLUGIN_Url}" "https://github.com" dk_includes)
		if(dk_includes)
			dk_replaceAll(${PLUGIN_Url}			"/" 	"" 	PLUGIN_Url_List)
			dk_replaceAll(${PLUGIN_Url_List} 	";;" 	";" PLUGIN_Url_List)
			if(NOT PLUGIN_Url_List)
				dk_error("PLUGIN_Url_List is invalid")
			endif()
			dk_debug("PLUGIN_Url_List = '${PLUGIN_Url_List}'")
			
			#d_k_listToArray("${PLUGIN_Url_List}"  PLUGIN_Url_Array)
			#dk_printVar(PLUGIN_Url_Array)
			#if(NOT PLUGIN_Url_Array)
			#	dk_error("PLUGIN_Url_Array is invalid")
			#endif()
			#dk_debug("PLUGIN_Url_Array = '${PLUGIN_Url_Array}'")
			
			#dk_arrayAt(PLUGIN_Url_Array	3	PLUGIN_Import_Name)
			#if(NOT PLUGIN_Import_Name)
			#	dk_error("PLUGIN_Import_Name is invalid")
			#endif()
		endif()
		dk_debug("PLUGIN_Import_Name = '${PLUGIN_Import_Name}'")
	endif()
	
	set(PLUGIN_Import_Name ${PLUGIN_Import_Name} CACHE INTERNAL "")
endfunction()

##################################
function(PLUGIN_Import_Name_Lower)
	if(PLUGIN_Import_Name_Lower)
		return()
	endif()
	
	PLUGIN_Import_Name()

	if(NOT PLUGIN_Import_Name)
		dk_error("PLUGIN_Import_Name is invalid")
	endif()
	dk_debug("PLUGIN_Import_Name = '${PLUGIN_Import_Name}'")
	
	dk_toLower("${PLUGIN_Import_Name}" 	PLUGIN_Import_Name_Lower)
	if(NOT PLUGIN_Import_Name_Lower)
		dk_error("PLUGIN_Import_Name_Lower is invalid")
	endif()
	dk_debug("PLUGIN_Import_Name_Lower = '${PLUGIN_Import_Name_Lower}'")
	
	set(PLUGIN_Import_Name_Lower ${PLUGIN_Import_Name_Lower}  CACHE INTERNAL "")
endfunction()

##################################
function(PLUGIN_Import_Dirname)
	if(PLUGIN_Import_Dirname)
		return()
	endif()
	
	PLUGIN_Import_Path()

	if(NOT PLUGIN_Import_Path)
		dk_notice("PLUGIN_Import_Path is invalid")
	endif()
	dk_debug("PLUGIN_Import_Path = '${PLUGIN_Import_Path}'")
	
	dk_dirname("${PLUGIN_Import_Path}" 	PLUGIN_Import_Dirname)
	if(NOT PLUGIN_Import_Dirname)
		dk_notice("PLUGIN_Import_Dirname is invalid")
	endif()
	dk_debug("PLUGIN_Import_Dirname = '${PLUGIN_Import_Dirname}'")
	
	set(PLUGIN_Import_Dirname ${PLUGIN_Import_Dirname}  CACHE INTERNAL "")
endfunction()

################################
function(PLUGIN_Install_Dirname)
	if(PLUGIN_Install_Dirname)
		return()
	endif()
	
	dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
	set(PLUGIN_Install_Dirname "${DK3RDPARTY_DIR}" CACHE INTERNAL "")
	if(NOT PLUGIN_Install_Dirname)
		dk_error("PLUGIN_Install_Dirname is invalid")
	endif()
	dk_debug("PLUGIN_Install_Dirname = '${PLUGIN_Install_Dirname}'")
	
	set(PLUGIN_Install_Dirname ${PLUGIN_Install_Dirname}  CACHE INTERNAL "")
endfunction()

#############################
function(PLUGIN_Url_Basename)
	if(PLUGIN_Url_Basename)
		return()
	endif()
	if(NOT PLUGIN_Url)
		return()
	endif()
	dk_basename("${PLUGIN_Url}")
	set(PLUGIN_Url_Basename "${dk_basename}" CACHE INTERNAL "")				# basename, filename
	if(NOT PLUGIN_Url_Basename)
		dk_notice("PLUGIN_Url_Basename is invalid")
	endif()
	dk_debug("PLUGIN_Url_Basename = '${PLUGIN_Url_Basename}'")
	
	set(PLUGIN_Url_Basename ${PLUGIN_Url_Basename} CACHE INTERNAL "")
endfunction()

#############################
function(PLUGIN_Url_Dirname)
	if(PLUGIN_Url_Dirname)
		return()
	endif()
	if(NOT PLUGIN_Url)
		return()
	endif()
	dk_dirname("${PLUGIN_Url}" PLUGIN_Url_Dirname)
	if(NOT PLUGIN_Url_Dirname)
		dk_notice("PLUGIN_Url_Dirname is invalid")
	endif()
	dk_debug("PLUGIN_Url_Dirname = '${PLUGIN_Url_Dirname}'")
	
	set(PLUGIN_Url_Dirname ${PLUGIN_Url_Dirname} CACHE INTERNAL "")
endfunction()

##############################
function(PLUGIN_Url_Extension)
	if(PLUGIN_Url_Extension)
		return()
	endif()
	if(NOT PLUGIN_Url)
		return()
	endif()
	dk_getExtension("${PLUGIN_Url}" PLUGIN_Url_Extension)
	if(NOT PLUGIN_Url_Extension)
		dk_notice("PLUGIN_Url_Extension is invalid")
	endif()
	dk_debug("PLUGIN_Url_Extension = '${PLUGIN_Url_Extension}'")
	
	set(PLUGIN_Url_Extension ${PLUGIN_Url_Extension} CACHE INTERNAL "")
endfunction()

#########################
function(PLUGIN_Url_Name)
	if(PLUGIN_Url_Name)
		return()
	endif()
	if(NOT PLUGIN_Url)
		return()
	endif()
	PLUGIN_Url_Basename()

	if(NOT PLUGIN_Url_Basename)
		dk_notice("PLUGIN_Url_Basename is invalid")
	endif()
	dk_debug("PLUGIN_Url_Basename = '${PLUGIN_Url_Basename}'")
	
	dk_removeExtension("${PLUGIN_Url_Basename}" PLUGIN_Url_Name) # name, file  (no extension)
	if(NOT PLUGIN_Url_Name)
		dk_notice("PLUGIN_Url_Name is invalid")
		#return()
	endif()
	dk_debug("PLUGIN_Url_Name = '${PLUGIN_Url_Name}'")
	
	set(PLUGIN_Url_Name ${PLUGIN_Url_Name} CACHE INTERNAL "")
endfunction()

###############################
function(PLUGIN_Url_Name_Lower)
	if(PLUGIN_Url_Name_Lower)
		return()
	endif()
	if(NOT PLUGIN_Url)
		return()
	endif()
	PLUGIN_Url_Name()

	if(NOT PLUGIN_Url_Name)
		dk_notice("PLUGIN_Url_Name is invalid")
		return()
	endif()
	dk_debug("PLUGIN_Url_Name = '${PLUGIN_Url_Name}'")
	
	dk_toLower(${PLUGIN_Url_Name})
 	set(PLUGIN_Url_Name_Lower "${dk_toLower}" CACHE INTERNAL "")
	if(NOT PLUGIN_Url_Name_Lower)
		dk_notice("PLUGIN_Url_Name_Lower is invalid")
		#return()
	endif()
	dk_debug("PLUGIN_Url_Name_Lower = '${PLUGIN_Url_Name_Lower}'")
	
	set(PLUGIN_Url_Name_Lower ${PLUGIN_Url_Name_Lower} CACHE INTERNAL "")
endfunction()

#############################
function(PLUGIN_Install_Name)
	if(PLUGIN_Install_Name)
		return()
	endif()
	
	PLUGIN_Import_Name()

	if(NOT PLUGIN_Import_Name)
		dk_error("PLUGIN_Import_Name is invalid")
	endif()
	dk_debug("PLUGIN_Import_Name = '${PLUGIN_Import_Name}'")
	
	PLUGIN_Version()
	if(NOT PLUGIN_Version)
		dk_notice("PLUGIN_Version is invalid")
	endif()
	dk_debug("PLUGIN_Version = '${PLUGIN_Version}'")
	
	if((PLUGIN_Import_Name) AND (PLUGIN_Version))
		set(PLUGIN_Install_Name "${PLUGIN_Import_Name}-${PLUGIN_Version}"  CACHE INTERNAL "")
	elseif(NOT PLUGIN_Install_Name)	
		set(PLUGIN_Install_Name "${PLUGIN_Import_Name}")
	endif()
	if(NOT PLUGIN_Install_Name)
		dk_error("PLUGIN_Install_Name is invalid")
	endif()
	dk_debug("PLUGIN_Install_Name = '${PLUGIN_Install_Name}'")
	
	set(PLUGIN_Install_Name ${PLUGIN_Install_Name} CACHE INTERNAL "")
endfunction()

#############################
function(PLUGIN_Install_Path)
	if(PLUGIN_Install_Path)
		return()
	endif()
	
	PLUGIN_Install_Dirname()

	if(NOT PLUGIN_Install_Dirname)
		dk_error("PLUGIN_Install_Dirname is invalid")
	endif()
	dk_debug("PLUGIN_Install_Dirname = '${PLUGIN_Install_Dirname}'")
	
	PLUGIN_Install_Name()

	if(NOT PLUGIN_Install_Name)
		dk_error("PLUGIN_Install_Name is invalid")
	endif()
	dk_debug("PLUGIN_Install_Name = '${PLUGIN_Install_Name}'")
	
	set(PLUGIN_Install_Path "${PLUGIN_Install_Dirname}/${PLUGIN_Install_Name}"  CACHE INTERNAL "")
	if(NOT PLUGIN_Install_Path)
		dk_error("PLUGIN_Install_Path is invalid")
	endif()
	dk_debug("PLUGIN_Install_Path = '${PLUGIN_Install_Path}'")
	
	set(PLUGIN_Install_Path ${PLUGIN_Install_Path} CACHE INTERNAL "")
endfunction()

############################
function(PLUGIN_Import_Path)
	if(PLUGIN_Import_Path)
		return()
	endif()
	
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	if(PLUGIN_Import_Name)
		set(PLUGIN_Import_Path "${DKIMPORTS_DIR}/${PLUGIN_Import_Name}" CACHE INTERNAL "")
	elseif(${CURRENT_PLUGIN}_Import_Path)
		dk_debug("${CURRENT_PLUGIN}_Import_Path = ${${CURRENT_PLUGIN}_Import_Path}")
		set(PLUGIN_Import_Path "${${CURRENT_PLUGIN}_Import_Path}" CACHE INTERNAL "")
	elseif(CURRENT_IMPORT)
		dk_debug("CURRENT_IMPORT = ${CURRENT_IMPORT}")
		### /_DKIMPORTS/
		dk_includes("${CURRENT_IMPORT}" "${DKIMPORTS_DIR}" dk_includes)
		if(dk_includes)
			set(PLUGIN_Import_Path "${CURRENT_IMPORT}" CACHE INTERNAL "")
		endif()
		
		### DKCpp/plugins/
		dk_validate(DKCPP_PLUGINS_DIR "dk_DKBRANCH_DIR()")
		dk_debug("CURRENT_IMPORT = ${CURRENT_IMPORT}")
		dk_debug("DKCPP_PLUGINS_DIR = ${DKCPP_PLUGINS_DIR}")
		dk_includes("${CURRENT_IMPORT}" "${DKCPP_PLUGINS_DIR}" dk_includes)
		
		dk_debug("dk_includes = ${dk_includes}")
		if(dk_includes)
			dk_success("dk_includes is true")
			set(PLUGIN_Import_Path "${CURRENT_IMPORT}" CACHE INTERNAL "")
		endif()
	else()
		dk_debug("CMAKE_CURRENT_FUNCTION_LIST_DIR = ${CMAKE_CURRENT_FUNCTION_LIST_DIR}")
	endif()
	
	if(NOT PLUGIN_Import_Path)
		dk_notice("PLUGIN_Import_Path is invalid")
	endif()
	dk_debug("PLUGIN_Import_Path = '${PLUGIN_Import_Path}'")
	
	set(PLUGIN_Import_Path ${PLUGIN_Import_Path} CACHE INTERNAL "")
endfunction()

########################
function(PLUGIN_Version)
	if(PLUGIN_Version)
		#return()
	endif()
		
	PLUGIN_Url_Name_Lower()

	if(NOT PLUGIN_Url_Name_Lower)
		dk_notice("PLUGIN_Url_Name_Lower is invalid")
		return()
	endif()
	dk_debug("PLUGIN_Url_Name_Lower = '${PLUGIN_Url_Name_Lower}'")
	
	PLUGIN_Import_Name_Lower()

	if(NOT PLUGIN_Import_Name_Lower)
		dk_error("PLUGIN_Import_Name_Lower is invalid")
	endif()
	dk_debug("PLUGIN_Import_Name_Lower = '${PLUGIN_Import_Name_Lower}'")
	
	if(PLUGIN_Url_Name_Lower)
		if(PLUGIN_Import_Name_Lower)
			dk_replaceAll("${PLUGIN_Url_Name_Lower}" 	"${PLUGIN_Import_Name_Lower}" 	""  PLUGIN_Version)
		endif()
		if(NOT PLUGIN_Version)
			set(PLUGIN_Version ${PLUGIN_TAG} CACHE INTERNAL "")
		endif()
		if(NOT PLUGIN_Version)
			set(PLUGIN_Version ${PLUGIN_Branch} CACHE INTERNAL "")
		endif()
	endif()
	
	dk_trimNonAlphaNumeric("${PLUGIN_Version}" PLUGIN_Version)
	
	if(NOT PLUGIN_Version)
		dk_notice("PLUGIN_Version is invalid")
	endif()
	dk_debug("PLUGIN_Version = '${PLUGIN_Version}'")
	
	set(PLUGIN_Version "${PLUGIN_Version}" CACHE INTERNAL "")
endfunction()

##################################
function(PLUGIN_Import_Name_Upper)
	if(PLUGIN_Import_Name_Upper)
		return()
	endif()
	
	PLUGIN_Import_Name()

	if(NOT PLUGIN_Import_Name)
		dk_error("PLUGIN_Import_Name is invalid")
	endif()
	dk_debug("PLUGIN_Import_Name = '${PLUGIN_Import_Name}'")
	
	dk_toUpper("${PLUGIN_Import_Name}")
	set(PLUGIN_Import_Name_Upper "${dk_toUpper}" CACHE INTERNAL "")
	if(NOT PLUGIN_Import_Name_Upper)
		dk_error("PLUGIN_Import_Name_Upper is invalid")
	endif()
	dk_debug("PLUGIN_Import_Name_Upper = '${PLUGIN_Import_Name_Upper}'")
	
	set(PLUGIN_Import_Name_Upper ${PLUGIN_Import_Name_Upper} CACHE INTERNAL "")
endfunction()

###################
function(PLUGIN_Id)
	if(${PLUGIN_Id})
		return()
	endif()
	
	PLUGIN_Import_Name_Upper()

	if(NOT PLUGIN_Import_Name_Upper)
		dk_error("PLUGIN_Import_Name_Upper is invalid")
	endif()
	dk_debug("PLUGIN_Import_Name_Upper = '${PLUGIN_Import_Name_Upper}'")
	
	dk_convertToCIdentifier("${PLUGIN_Import_Name_Upper}")
 	set(PLUGIN_Id "${dk_convertToCIdentifier}" CACHE INTERNAL "")
	if(NOT PLUGIN_Id)
		dk_error("PLUGIN_Id is invalid")
	endif()
	dk_debug("PLUGIN_Id = '${PLUGIN_Id}'")
	
	set(PLUGIN_Id ${PLUGIN_Id} CACHE INTERNAL "")
	set(PLUGIN ${PLUGIN_Id} CACHE INTERNAL "")
endfunction()
	
	
	
########################
function(Copy_Variables)
	### Set the <PLUGIN_Id> variable to mirror %PLUGIN%
	### All %PLUGIN_variables will be mirrored to the Plugin Import Name.  I.E.   $ZLIB.variables
	
	set(_prefix "PLUGIN_")
	set(_newprefix "${PLUGIN}_")
	get_cmake_property(_vars VARIABLES)
    string(REGEX MATCHALL "(^|;)${_prefix}[A-Za-z0-9_]*" _matchedVars "${_vars}")
    foreach(_variable ${_matchedVars})
		if(${_variable})
			string(REPLACE "${_prefix}" "${_newprefix}" newVar "${_variable}")
			dk_set(${newVar} "${${_variable}}")
			#message("${newVar} = ${${newVar}}")
		endif()
    endforeach()
endfunction()

	
	
	
	
		
	
	
	
	
	
	
	
	
	
###################
function(PRINTVARS)
	dk_echo()
	dk_echo()
	dk_echo("################## PLUGIN_variables ##################")
	dk_echo("PLUGIN                               = '${PLUGIN}'")
	dk_echo("${PLUGIN}                            = '${${PLUGIN}}'")
	dk_echo("PLUGIN_Args                          = '${PLUGIN_Args}'")
	dk_echo("PLUGIN_Id                            = '${PLUGIN_Id}'")
	dk_echo("PLUGIN_Version                       = '${PLUGIN_Version}'")
	dk_echo("PLUGIN_Url                           = '${PLUGIN_Url}'")
	dk_echo("PLUGIN_Url_Basename                  = '${PLUGIN_Url_Basename}'")
	dk_echo("PLUGIN_Url_Name                      = '${PLUGIN_Url_Name}'")
	dk_echo("PLUGIN_Url_Extension                 = '${PLUGIN_Url_Extension}'")
	dk_echo("PLUGIN_Import_Dirname                = '${PLUGIN_Import_Dirname}'")
	dk_echo("PLUGIN_Import_Name                   = '${PLUGIN_Import_Name}'")
	dk_echo("PLUGIN_Import_Path                   = '${PLUGIN_Import_Path}'")
	dk_echo("PLUGIN_Install_Dirname               = '${PLUGIN_Install_Dirname}'")
	dk_echo("PLUGIN_Install_Name                  = '${PLUGIN_Install_Name}'")
	dk_echo("PLUGIN_Install_Path                  = '${PLUGIN_Install_Path}'")
	dk_echo("PLUGIN_Tuple_Dir                     = '${PLUGIN_Tuple_Dir}'")
	dk_echo("PLUGIN_Build_Dir                     = '${PLUGIN_Build_Dir}'")
	dk_echo("PLUGIN_Config_Dir                    = '${PLUGIN_Config_Dir}'")
	dk_echo("PLUGIN_Debug_Dir                     = '${PLUGIN_Debug_Dir}'")
	dk_echo("PLUGIN_Release_Dir                   = '${PLUGIN_Release_Dir}'")
	dk_echo()
	dk_echo()
	dk_echo("################## ${PLUGIN_Id}.variables ##################")
	dk_echo("${PLUGIN_Id}                          = '${${PLUGIN_Id}}'")
	dk_echo("${PLUGIN_Id}_Args                     = '${${PLUGIN_Id}_Args}'")
	dk_echo("${PLUGIN_Id}_Id                       = '${${PLUGIN_Id}_Id}'")
	dk_echo("${PLUGIN_Id}_Version                  = '${${PLUGIN_Id}_Version}'")
	dk_echo("${PLUGIN_Id}_Url                      = '${${PLUGIN_Id}_Url}'")
	dk_echo("${PLUGIN_Id}_Url_Basename             = '${${PLUGIN_Id}_Url_Basename}'")
	dk_echo("${PLUGIN_Id}_Url_Name                 = '${${PLUGIN_Id}_Url_Name}'")
	dk_echo("${PLUGIN_Id}_Url_Extension            = '${${PLUGIN_Id}_Url_Extension}'")
	dk_echo("${PLUGIN_Id}_Import_Dirname           = '${${PLUGIN_Id}_Import_Dirname}'")
	dk_echo("${PLUGIN_Id}_Import_Name              = '${${PLUGIN_Id}_Import_Name}'")
	dk_echo("${PLUGIN_Id}_Import_Path              = '${${PLUGIN_Id}_Import_Path}'")
	dk_echo("${PLUGIN_Id}_Install_Dirname          = '${${PLUGIN_Id}_Install_Dirname}'")
	dk_echo("${PLUGIN_Id}_Install_Name             = '${${PLUGIN_Id}_Install_Name}'")
	dk_echo("${PLUGIN_Id}_Install_Path             = '${${PLUGIN_Id}_Install_Path}'")
	dk_echo("${PLUGIN_Id}_Tuple_Dir                = '${${PLUGIN_Id}_Tuple_Dir}'")
	dk_echo("${PLUGIN_Id}_Build_Dir                = '${${PLUGIN_Id}_Build_Dir}'")
	dk_echo("${PLUGIN_Id}_Config_Dir               = '${${PLUGIN_Id}_Config_Dir}'")
	dk_echo("${PLUGIN_Id}_Debug_Dir                = '${${PLUGIN_Id}_Debug_Dir}'")
	dk_echo("${PLUGIN_Id}_Release_Dir              = '${${PLUGIN_Id}_Release_Dir}'")
	dk_echo()
endfunction()	



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
	
	set(CURRENT_IMPORT "${DKIMPORTS_DIR}/msys2")
	dk_importVariables("https://repo.msys2.org/distrib/x86_64/msys2-base-x86_64-20241208.tar.xz")
	dk_importVariables(PRINTVARS)
	
	set(CURRENT_IMPORT "${DKIMPORTS_DIR}/git")
	dk_importVariables("https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe" INSTALL_ROOT "${DKTOOLS_DIR}")
	dk_importVariables(PRINTVARS)
	
	set(CURRENT_IMPORT "${DKIMPORTS_DIR}/php-src")
	dk_importVariables("https://windows.php.net/downloads/releases/php-8.4.11-Win32-vs17-x64.zip")
	dk_importVariables(PRINTVARS)
endfunction()
