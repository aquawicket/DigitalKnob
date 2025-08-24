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
	dk_unset(PLUGIN.Args)
	dk_unset(PLUGIN.Build_Dir)
	dk_unset(PLUGIN.Config_Dir)
	dk_unset(PLUGIN.Debug_Dir)
	dk_unset(PLUGIN.Id)
	dk_unset(PLUGIN.Import_Dirname)
	dk_unset(PLUGIN.Import_Name)
	dk_unset(PLUGIN.Import_Name_Lower)
	dk_unset(PLUGIN.Import_Name_Upper)
	dk_unset(PLUGIN.Import_Path)
	dk_unset(PLUGIN.Install_Dirname)
	dk_unset(PLUGIN.Install_Name)
	dk_unset(PLUGIN.Install_Path)
	dk_unset(PLUGIN.Release_Dir)
	dk_unset(PLUGIN.Tuple_Dir)
	dk_unset(PLUGIN.Url)
	dk_unset(PLUGIN.Url_Basename)
	dk_unset(PLUGIN.Url_Extension)
	dk_unset(PLUGIN.Url_Name)
	dk_unset(PLUGIN.Url_Name_Lower)
	dk_unset(PLUGIN.Version)
	
	#dk_debug("PLUGIN = ${PLUGIN}")
	#dk_debug("PLUGIN.Args = ${PLUGIN.Args}")
	#dk_debug("PLUGIN.Build_Dir = ${PLUGIN.Build_Dir}")
	#dk_debug("PLUGIN.Config_Dir = ${PLUGIN.Config_Dir}")
	#dk_debug("PLUGIN.Debug_Dir = ${PLUGIN.Debug_Dir}")
	#dk_debug("PLUGIN.Id = ${PLUGIN.Id}")
	#dk_debug("PLUGIN.Import_Dirname = ${PLUGIN.Import_Dirname}")
	#dk_debug("PLUGIN.Import_Name = ${PLUGIN.Import_Name}")
	#dk_debug("PLUGIN.Import_Name_Lower = ${PLUGIN.Import_Name_Lower}")
	#dk_debug("PLUGIN.Import_Name_Upper = ${PLUGIN.Import_Name_Upper}")
	#dk_debug("PLUGIN.Import_Path = ${PLUGIN.Import_Path}")
	#dk_debug("PLUGIN.Install_Dirname = ${PLUGIN.Install_Dirname}")
	#dk_debug("PLUGIN.Install_Name = ${PLUGIN.Install_Name}")
	#dk_debug("PLUGIN.Install_Path = ${PLUGIN.Install_Path}")
	#dk_debug("PLUGIN.Release_Dir = ${PLUGIN.Release_Dir}")
	#dk_debug("PLUGIN.Tuple_Dir = ${PLUGIN.Tuple_Dir}")
	#dk_debug("PLUGIN.Url = ${PLUGIN.Url}")
	#dk_debug("PLUGIN.Url_Basename = ${PLUGIN.Url_Basename}")
	#dk_debug("PLUGIN.Url_Extension = ${PLUGIN.Url_Extension}")
	#dk_debug("PLUGIN.Url_Name = ${PLUGIN.Url_Name}")
	#dk_debug("PLUGIN.Url_Name_Lower = ${PLUGIN.Url_Name_Lower}")
	#dk_debug("PLUGIN.Version = ${PLUGIN.Version}")

	### PLUGIN(hashtable) 
	##  TODO
	####################
	
	
																###### EXAMPLE ######
	### IMPORT_ROOT (PLUGIN;Import_Dirname)						/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	#dk_unset(IMPORT_ROOT)
	dk_getParameterValue(IMPORT_ROOT)
	dk_debug("IMPORT_ROOT = '${IMPORT_ROOT}'")
	set(PLUGIN.Import_Dirname "${IMPORT_ROOT}" CACHE INTERNAL "")

	### IMPORT_NAME (PLUGIN.Import_Name)						zlib
	#dk_unset(IMPORT_NAME)
	dk_getParameterValue(IMPORT_NAME)
	dk_debug("IMPORT_NAME = '${IMPORT_NAME}'")
	set(PLUGIN.Import_Name "${IMPORT_NAME}" CACHE INTERNAL "")

	### IMPORT_PATH (PLUGIN.Import_Path)						/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	#dk_unset(IMPORT_PATH)
	dk_getParameterValue(IMPORT_PATH)
	dk_debug("IMPORT_PATH = '${IMPORT_PATH}'")
	set(PLUGIN.Import_Path "${IMPORT_PATH}" CACHE INTERNAL "")

	### INSTALL_ROOT (PLUGIN.Install_Dirname)					/c/Users/Administrator/DigitalKnob/Development/3rdParty
	#dk_unset(INSTALL_ROOT)
	dk_getParameterValue(INSTALL_ROOT)
	dk_debug("INSTALL_ROOT = '${INSTALL_ROOT}'")
	set(PLUGIN.Install_Dirname "${INSTALL_ROOT}" CACHE INTERNAL "")

	### INSTALL_NAME (PLUGIN.Install_Name)						zlib-master
	#dk_unset(INSTALL_NAME)
	dk_getParameterValue(INSTALL_NAME)
	dk_debug("INSTALL_NAME = '${INSTALL_NAME}'")
	set(PLUGIN.Install_Name "${INSTALL_NAME}" CACHE INTERNAL "")

	### INSTALL_PATH (PLUGIN.Install_Path)						/c/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	#dk_unset(INSTALL_PATH)
	dk_getParameterValue(INSTALL_PATH)
	dk_debug("INSTALL_PATH = '${INSTALL_PATH}'")
	set(PLUGIN.Install_Path "${INSTALL_PATH}" CACHE INTERNAL "")

	### VERSION (PLUGIN.Version)								v1.3.1
	#dk_unset(VERSION)
	dk_getParameterValue(VERSION)
	dk_debug("VERSION = '${VERSION}'")
	set(PLUGIN.Version "${VERSION}" CACHE INTERNAL "")

	### BRANCH (PLUGIN.Branch)									master
	#dk_unset(BRANCH)
	dk_getParameterValue(BRANCH)
	dk_debug("BRANCH = '${BRANCH}'")
	set(PLUGIN.Branch "${BRANCH}" CACHE INTERNAL "")
	
	### PLUGIN.Args												"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	#dk_unset(PLUGIN.Args)
	set(PLUGIN.Args ${ARGV} CACHE INTERNAL "")
	dk_debug("PLUGIN.Args = '${PLUGIN.Args}'")
		
	### PLUGIN.Url												"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	#dk_unset(PLUGIN.Url)
	if(ARGV0)
		dk_isUrl("${ARGV0}")
		if(dk_isUrl)
			message("${ARGV0} is a valid URL")
		endif()
	endif()
	set(PLUGIN.Url "${ARGV0}" CACHE INTERNAL "")
	dk_debug("PLUGIN.Url = '${PLUGIN.Url}'")


	### PLUGIN.Id												ZLIB
	PLUGIN_Id()

	### PLUGIN.Install_Path										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	PLUGIN_Install_Path()

	### PLUGIN.Url_Extension									.zip
	PLUGIN_Url_Extension()
	
	### PLUGIN.Install_Dirname									C:/Users/Administrator/DigitalKnob/Development/3rdParty
	PLUGIN_Import_Dirname()
	#####################################################
	############# PLUGIN.Target_Directries ##############
	#####################################################
	### PLUGIN.Tuple_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	set(PLUGIN.Tuple_Dir "${PLUGIN.Install_Path}/${Target_Tuple}" 	CACHE INTERNAL "")
	dk_debug("PLUGIN.Tuple_Dir = '${PLUGIN.Tuple_Dir}'")
	
	### PLUGIN.Config_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	dk_validate(Target_Config "dk_Target_Config()")
	set(PLUGIN.Config_Dir "${PLUGIN.Install_Path}/${Target_Config}" CACHE INTERNAL "")
	dk_debug("PLUGIN.Config_Dir = '${PLUGIN.Config_Dir}'")

	### PLUGIN.Build_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set(PLUGIN.Build_Dir "${PLUGIN.Install_Path}/${Target_Build}" 	CACHE INTERNAL "")
	dk_debug("PLUGIN.Build_Dir = '${PLUGIN.Build_Dir}'")

	### PLUGIN.Debug_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set(PLUGIN.Debug_Dir "${PLUGIN.Tuple_Dir}/${Debug_Dir}" 		CACHE INTERNAL "")
	dk_debug("PLUGIN.Debug_Dir = '${PLUGIN.Debug_Dir}'")

	### PLUGIN.Release_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	set(PLUGIN.Release_Dir "${PLUGIN.Tuple_Dir}/${Release_Dir}" 	CACHE INTERNAL "")
	dk_debug("PLUGIN.Release_Dir = '${PLUGIN.Release_Dir}'")

	### PLUGIN
	set(PLUGIN "${PLUGIN.Id}" CACHE INTERNAL "")
	dk_debug("PLUGIN = '${PLUGIN}'")
	
	### ${PLUGIN}
	set(${PLUGIN} "${PLUGIN.Install_Path}" CACHE INTERNAL "")
	dk_debug("${PLUGIN} = '${${PLUGIN}}'")

	Copy_Variables()
	PRINTVARS()
endfunction()


############################
function(PLUGIN_Import_Name)
	if(PLUGIN.Import_Name)
		return()
	endif()
		
	PLUGIN_Import_Path()

	if(NOT PLUGIN.Import_Path)
		dk_error("PLUGIN.Import_Path is invalid")
	endif()
	dk_debug("PLUGIN.Import_Path = '${PLUGIN.Import_Path}'")

	if(PLUGIN.Import_Path)
		dk_basename("${PLUGIN.Import_Path}"	PLUGIN.Import_Name)
		if(NOT PLUGIN.Import_Name)
			dk_error("PLUGIN.Import_Name is invalid")
		endif()
		dk_debug("PLUGIN.Import_Name = '${PLUGIN.Import_Name}'")
		
	else()
		dk_includes("${PLUGIN.Url}" "https://github.com" dk_includes)
		if(dk_includes)
			dk_replaceAll(${PLUGIN.Url}			"/" 	"" 	PLUGIN.Url_List)
			dk_replaceAll(${PLUGIN.Url_List} 	";;" 	";" PLUGIN.Url_List)
			if(NOT PLUGIN.Url_List)
				dk_error("PLUGIN.Url_List is invalid")
			endif()
			dk_debug("PLUGIN.Url_List = '${PLUGIN.Url_List}'")
			
			#d_k_listToArray("${PLUGIN.Url_List}"  PLUGIN.Url_Array)
			#dk_printVar(PLUGIN.Url_Array)
			#if(NOT PLUGIN.Url_Array)
			#	dk_error("PLUGIN.Url_Array is invalid")
			#endif()
			#dk_debug("PLUGIN.Url_Array = '${PLUGIN.Url_Array}'")
			
			#dk_arrayAt(PLUGIN.Url_Array	3	PLUGIN.Import_Name)
			#if(NOT PLUGIN.Import_Name)
			#	dk_error("PLUGIN.Import_Name is invalid")
			#endif()
		endif()
		dk_debug("PLUGIN.Import_Name = '${PLUGIN.Import_Name}'")
	endif()
	
	set(PLUGIN.Import_Name ${PLUGIN.Import_Name} CACHE INTERNAL "")
endfunction()

##################################
function(PLUGIN_Import_Name_Lower)
	if(PLUGIN.Import_Name_Lower)
		return()
	endif()
	
	PLUGIN_Import_Name()

	if(NOT PLUGIN.Import_Name)
		dk_error("PLUGIN.Import_Name is invalid")
	endif()
	dk_debug("PLUGIN.Import_Name = '${PLUGIN.Import_Name}'")
	
	dk_toLower("${PLUGIN.Import_Name}" 	PLUGIN.Import_Name_Lower)
	if(NOT PLUGIN.Import_Name_Lower)
		dk_error("PLUGIN.Import_Name_Lower is invalid")
	endif()
	dk_debug("PLUGIN.Import_Name_Lower = '${PLUGIN.Import_Name_Lower}'")
	
	set(PLUGIN.Import_Name_Lower ${PLUGIN.Import_Name_Lower}  CACHE INTERNAL "")
endfunction()

##################################
function(PLUGIN_Import_Dirname)
	if(PLUGIN.Import_Dirname)
		return()
	endif()
	
	PLUGIN_Import_Path()

	if(NOT PLUGIN.Import_Path)
		dk_notice("PLUGIN.Import_Path is invalid")
	endif()
	dk_debug("PLUGIN.Import_Path = '${PLUGIN.Import_Path}'")
	
	dk_dirname("${PLUGIN.Import_Path}" 	PLUGIN.Import_Dirname)
	if(NOT PLUGIN.Import_Dirname)
		dk_notice("PLUGIN.Import_Dirname is invalid")
	endif()
	dk_debug("PLUGIN.Import_Dirname = '${PLUGIN.Import_Dirname}'")
	
	set(PLUGIN.Import_Dirname ${PLUGIN.Import_Dirname}  CACHE INTERNAL "")
endfunction()

################################
function(PLUGIN_Install_Dirname)
	if(PLUGIN.Install_Dirname)
		return()
	endif()
	
	dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
	set(PLUGIN.Install_Dirname "${DK3RDPARTY_DIR}" CACHE INTERNAL "")
	if(NOT PLUGIN.Install_Dirname)
		dk_error("PLUGIN.Install_Dirname is invalid")
	endif()
	dk_debug("PLUGIN.Install_Dirname = '${PLUGIN.Install_Dirname}'")
	
	set(PLUGIN.Install_Dirname ${PLUGIN.Install_Dirname}  CACHE INTERNAL "")
endfunction()

#############################
function(PLUGIN_Url_Basename)
	if(PLUGIN.Url_Basename)
		return()
	endif()
	if(NOT PLUGIN.Url)
		return()
	endif()
	dk_basename("${PLUGIN.Url}")
	set(PLUGIN.Url_Basename "${dk_basename}" CACHE INTERNAL "")				# basename, filename
	if(NOT PLUGIN.Url_Basename)
		dk_notice("PLUGIN.Url_Basename is invalid")
	endif()
	dk_debug("PLUGIN.Url_Basename = '${PLUGIN.Url_Basename}'")
	
	set(PLUGIN.Url_Basename ${PLUGIN.Url_Basename} CACHE INTERNAL "")
endfunction()

#############################
function(PLUGIN_Url_Dirname)
	if(PLUGIN.Url_Dirname)
		return()
	endif()
	if(NOT PLUGIN.Url)
		return()
	endif()
	dk_dirname("${PLUGIN.Url}" PLUGIN.Url_Dirname)
	if(NOT PLUGIN.Url_Dirname)
		dk_notice("PLUGIN.Url_Dirname is invalid")
	endif()
	dk_debug("PLUGIN.Url_Dirname = '${PLUGIN.Url_Dirname}'")
	
	set(PLUGIN.Url_Dirname ${PLUGIN.Url_Dirname} CACHE INTERNAL "")
endfunction()

##############################
function(PLUGIN_Url_Extension)
	if(PLUGIN.Url_Extension)
		return()
	endif()
	if(NOT PLUGIN.Url)
		return()
	endif()
	dk_getExtension("${PLUGIN.Url}" PLUGIN.Url_Extension)
	if(NOT PLUGIN.Url_Extension)
		dk_notice("PLUGIN.Url_Extension is invalid")
	endif()
	dk_debug("PLUGIN.Url_Extension = '${PLUGIN.Url_Extension}'")
	
	set(PLUGIN.Url_Extension ${PLUGIN.Url_Extension} CACHE INTERNAL "")
endfunction()

#########################
function(PLUGIN_Url_Name)
	if(PLUGIN.Url_Name)
		return()
	endif()
	if(NOT PLUGIN.Url)
		return()
	endif()
	PLUGIN_Url_Basename()

	if(NOT PLUGIN.Url_Basename)
		dk_notice("PLUGIN.Url_Basename is invalid")
	endif()
	dk_debug("PLUGIN.Url_Basename = '${PLUGIN.Url_Basename}'")
	
	dk_removeExtension("${PLUGIN.Url_Basename}" PLUGIN.Url_Name) # name, file  (no extension)
	if(NOT PLUGIN.Url_Name)
		dk_notice("PLUGIN.Url_Name is invalid")
		#return()
	endif()
	dk_debug("PLUGIN.Url_Name = '${PLUGIN.Url_Name}'")
	
	set(PLUGIN.Url_Name ${PLUGIN.Url_Name} CACHE INTERNAL "")
endfunction()

###############################
function(PLUGIN_Url_Name_Lower)
	if(PLUGIN.Url_Name_Lower)
		return()
	endif()
	if(NOT PLUGIN.Url)
		return()
	endif()
	PLUGIN_Url_Name()

	if(NOT PLUGIN.Url_Name)
		dk_notice("PLUGIN.Url_Name is invalid")
		return()
	endif()
	dk_debug("PLUGIN.Url_Name = '${PLUGIN.Url_Name}'")
	
	dk_toLower(${PLUGIN.Url_Name})
 	set(PLUGIN.Url_Name_Lower "${dk_toLower}" CACHE INTERNAL "")
	if(NOT PLUGIN.Url_Name_Lower)
		dk_notice("PLUGIN.Url_Name_Lower is invalid")
		#return()
	endif()
	dk_debug("PLUGIN.Url_Name_Lower = '${PLUGIN.Url_Name_Lower}'")
	
	set(PLUGIN.Url_Name_Lower ${PLUGIN.Url_Name_Lower} CACHE INTERNAL "")
endfunction()

#############################
function(PLUGIN_Install_Name)
	if(PLUGIN.Install_Name)
		return()
	endif()
	
	PLUGIN_Import_Name()

	if(NOT PLUGIN.Import_Name)
		dk_error("PLUGIN.Import_Name is invalid")
	endif()
	dk_debug("PLUGIN.Import_Name = '${PLUGIN.Import_Name}'")
	
	PLUGIN_Version()
	if(NOT PLUGIN.Version)
		dk_notice("PLUGIN.Version is invalid")
	endif()
	dk_debug("PLUGIN.Version = '${PLUGIN.Version}'")
	
	if((PLUGIN.Import_Name) AND (PLUGIN.Version))
		set(PLUGIN.Install_Name "${PLUGIN.Import_Name}-${PLUGIN.Version}"  CACHE INTERNAL "")
	elseif(NOT PLUGIN.Install_Name)	
		set(PLUGIN.Install_Name "${PLUGIN.Import_Name}")
	endif()
	if(NOT PLUGIN.Install_Name)
		dk_error("PLUGIN.Install_Name is invalid")
	endif()
	dk_debug("PLUGIN.Install_Name = '${PLUGIN.Install_Name}'")
	
	set(PLUGIN.Install_Name ${PLUGIN.Install_Name} CACHE INTERNAL "")
endfunction()

#############################
function(PLUGIN_Install_Path)
	if(PLUGIN.Install_Path)
		return()
	endif()
	
	PLUGIN_Install_Dirname()

	if(NOT PLUGIN.Install_Dirname)
		dk_error("PLUGIN.Install_Dirname is invalid")
	endif()
	dk_debug("PLUGIN.Install_Dirname = '${PLUGIN.Install_Dirname}'")
	
	PLUGIN_Install_Name()

	if(NOT PLUGIN.Install_Name)
		dk_error("PLUGIN.Install_Name is invalid")
	endif()
	dk_debug("PLUGIN.Install_Name = '${PLUGIN.Install_Name}'")
	
	set(PLUGIN.Install_Path "${PLUGIN.Install_Dirname}/${PLUGIN.Install_Name}"  CACHE INTERNAL "")
	if(NOT PLUGIN.Install_Path)
		dk_error("PLUGIN.Install_Path is invalid")
	endif()
	dk_debug("PLUGIN.Install_Path = '${PLUGIN.Install_Path}'")
	
	set(PLUGIN.Install_Path ${PLUGIN.Install_Path} CACHE INTERNAL "")
endfunction()

############################
function(PLUGIN_Import_Path)
	if(PLUGIN.Import_Path)
		return()
	endif()
	
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	if(PLUGIN.Import_Name)
		set(PLUGIN.Import_Path "${DKIMPORTS_DIR}/${PLUGIN.Import_Name}" CACHE INTERNAL "")
	elseif(${CURRENT_PLUGIN}.Import_Path)
		dk_debug("${CURRENT_PLUGIN}.Import_Path = ${${CURRENT_PLUGIN}.Import_Path}")
		set(PLUGIN.Import_Path "${${CURRENT_PLUGIN}.Import_Path}" CACHE INTERNAL "")
	elseif(CURRENT_IMPORT)
		dk_debug("CURRENT_IMPORT = ${CURRENT_IMPORT}")
		### /_DKIMPORTS/
		dk_includes("${CURRENT_IMPORT}" "${DKIMPORTS_DIR}" dk_includes)
		if(dk_includes)
			set(PLUGIN.Import_Path "${CURRENT_IMPORT}" CACHE INTERNAL "")
		endif()
		
		### DKCpp/plugins/
		dk_validate(DKCPP_PLUGINS_DIR "dk_DKBRANCH_DIR()")
		dk_debug("CURRENT_IMPORT = ${CURRENT_IMPORT}")
		dk_debug("DKCPP_PLUGINS_DIR = ${DKCPP_PLUGINS_DIR}")
		dk_includes("${CURRENT_IMPORT}" "${DKCPP_PLUGINS_DIR}" dk_includes)
		
		dk_debug("dk_includes = ${dk_includes}")
		if(dk_includes)
			dk_success("dk_includes is true")
			set(PLUGIN.Import_Path "${CURRENT_IMPORT}" CACHE INTERNAL "")
		endif()
	else()
		dk_debug("CMAKE_CURRENT_FUNCTION_LIST_DIR = ${CMAKE_CURRENT_FUNCTION_LIST_DIR}")
	endif()
	
	if(NOT PLUGIN.Import_Path)
		dk_notice("PLUGIN.Import_Path is invalid")
	endif()
	dk_debug("PLUGIN.Import_Path = '${PLUGIN.Import_Path}'")
	
	set(PLUGIN.Import_Path ${PLUGIN.Import_Path} CACHE INTERNAL "")
endfunction()

########################
function(PLUGIN_Version)
	if(PLUGIN.Version)
		#return()
	endif()
		
	PLUGIN_Url_Name_Lower()

	if(NOT PLUGIN.Url_Name_Lower)
		dk_notice("PLUGIN.Url_Name_Lower is invalid")
		return()
	endif()
	dk_debug("PLUGIN.Url_Name_Lower = '${PLUGIN.Url_Name_Lower}'")
	
	PLUGIN_Import_Name_Lower()

	if(NOT PLUGIN.Import_Name_Lower)
		dk_error("PLUGIN.Import_Name_Lower is invalid")
	endif()
	dk_debug("PLUGIN.Import_Name_Lower = '${PLUGIN.Import_Name_Lower}'")
	
	if(PLUGIN.Url_Name_Lower)
		if(PLUGIN.Import_Name_Lower)
			dk_replaceAll("${PLUGIN.Url_Name_Lower}" 	"${PLUGIN.Import_Name_Lower}" 	""  PLUGIN.Version)
		endif()
		if(NOT PLUGIN.Version)
			set(PLUGIN.Version ${PLUGIN.TAG} CACHE INTERNAL "")
		endif()
		if(NOT PLUGIN.Version)
			set(PLUGIN.Version ${PLUGIN.Branch} CACHE INTERNAL "")
		endif()
	endif()
	
	dk_trimNonAlphaNumeric("${PLUGIN.Version}" PLUGIN.Version)
	
	if(NOT PLUGIN.Version)
		dk_notice("PLUGIN.Version is invalid")
	endif()
	dk_debug("PLUGIN.Version = '${PLUGIN.Version}'")
	
	set(PLUGIN.Version "${PLUGIN.Version}" CACHE INTERNAL "")
endfunction()

##################################
function(PLUGIN_Import_Name_Upper)
	if(PLUGIN.Import_Name_Upper)
		return()
	endif()
	
	PLUGIN_Import_Name()

	if(NOT PLUGIN.Import_Name)
		dk_error("PLUGIN.Import_Name is invalid")
	endif()
	dk_debug("PLUGIN.Import_Name = '${PLUGIN.Import_Name}'")
	
	dk_toUpper("${PLUGIN.Import_Name}")
	set(PLUGIN.Import_Name_Upper "${dk_toUpper}" CACHE INTERNAL "")
	if(NOT PLUGIN.Import_Name_Upper)
		dk_error("PLUGIN.Import_Name_Upper is invalid")
	endif()
	dk_debug("PLUGIN.Import_Name_Upper = '${PLUGIN.Import_Name_Upper}'")
	
	set(PLUGIN.Import_Name_Upper ${PLUGIN.Import_Name_Upper} CACHE INTERNAL "")
endfunction()

###################
function(PLUGIN_Id)
	if(${PLUGIN.Id})
		return()
	endif()
	
	PLUGIN_Import_Name_Upper()

	if(NOT PLUGIN.Import_Name_Upper)
		dk_error("PLUGIN.Import_Name_Upper is invalid")
	endif()
	dk_debug("PLUGIN.Import_Name_Upper = '${PLUGIN.Import_Name_Upper}'")
	
	dk_convertToCIdentifier("${PLUGIN.Import_Name_Upper}")
 	set(PLUGIN.Id "${dk_convertToCIdentifier}" CACHE INTERNAL "")
	if(NOT PLUGIN.Id)
		dk_error("PLUGIN.Id is invalid")
	endif()
	dk_debug("PLUGIN.Id = '${PLUGIN.Id}'")
	
	set(PLUGIN.Id ${PLUGIN.Id} CACHE INTERNAL "")
	set(PLUGIN ${PLUGIN.Id} CACHE INTERNAL "")
endfunction()
	
	
	
########################
function(Copy_Variables)
	### Set the <PLUGIN.ID> variable to mirror %PLUGIN%
	### All %PLUGIN.variables will be mirrored to the Plugin Import Name.  I.E.   $ZLIB.variables
	
	set(_prefix "PLUGIN.")
	set(_newprefix "${PLUGIN}.")
	get_cmake_property(_vars VARIABLES)
    string(REGEX MATCHALL "(^|;)${_prefix}[A-Za-z0-9_.]*" _matchedVars "${_vars}")
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
	dk_echo("################## PLUGIN.variables ##################")
	dk_echo("PLUGIN                               = '${PLUGIN}'")
	dk_echo("${PLUGIN}                            = '${${PLUGIN}}'")
	dk_echo("PLUGIN.Args                          = '${PLUGIN.Args}'")
	dk_echo("PLUGIN.Id                            = '${PLUGIN.Id}'")
	dk_echo("PLUGIN.Version                       = '${PLUGIN.Version}'")
	dk_echo("PLUGIN.Url                           = '${PLUGIN.Url}'")
	dk_echo("PLUGIN.Url_Basename                  = '${PLUGIN.Url_Basename}'")
	dk_echo("PLUGIN.Url_Name                      = '${PLUGIN.Url_Name}'")
	dk_echo("PLUGIN.Url_Extension                 = '${PLUGIN.Url_Extension}'")
	dk_echo("PLUGIN.Import_Dirname                = '${PLUGIN.Import_Dirname}'")
	dk_echo("PLUGIN.Import_Name                   = '${PLUGIN.Import_Name}'")
	dk_echo("PLUGIN.Import_Path                   = '${PLUGIN.Import_Path}'")
	dk_echo("PLUGIN.Install_Dirname               = '${PLUGIN.Install_Dirname}'")
	dk_echo("PLUGIN.Install_Name                  = '${PLUGIN.Install_Name}'")
	dk_echo("PLUGIN.Install_Path                  = '${PLUGIN.Install_Path}'")
	dk_echo("PLUGIN.Tuple_Dir                     = '${PLUGIN.Tuple_Dir}'")
	dk_echo("PLUGIN.Build_Dir                     = '${PLUGIN.Build_Dir}'")
	dk_echo("PLUGIN.Config_Dir                    = '${PLUGIN.Config_Dir}'")
	dk_echo("PLUGIN.Debug_Dir                     = '${PLUGIN.Debug_Dir}'")
	dk_echo("PLUGIN.Release_Dir                   = '${PLUGIN.Release_Dir}'")
	dk_echo()
	dk_echo()
	dk_echo("################## ${PLUGIN.Id}.variables ##################")
	dk_echo("${PLUGIN.Id}                          = '${${PLUGIN.Id}}'")
	dk_echo("${PLUGIN.Id}.Args                     = '${${PLUGIN.Id}.Args}'")
	dk_echo("${PLUGIN.Id}.Id                       = '${${PLUGIN.Id}.Id}'")
	dk_echo("${PLUGIN.Id}.Version                  = '${${PLUGIN.Id}.Version}'")
	dk_echo("${PLUGIN.Id}.Url                      = '${${PLUGIN.Id}.Url}'")
	dk_echo("${PLUGIN.Id}.Url_Basename             = '${${PLUGIN.Id}.Url_Basename}'")
	dk_echo("${PLUGIN.Id}.Url_Name                 = '${${PLUGIN.Id}.Url_Name}'")
	dk_echo("${PLUGIN.Id}.Url_Extension            = '${${PLUGIN.Id}.Url_Extension}'")
	dk_echo("${PLUGIN.Id}.Import_Dirname           = '${${PLUGIN.Id}.Import_Dirname}'")
	dk_echo("${PLUGIN.Id}.Import_Name              = '${${PLUGIN.Id}.Import_Name}'")
	dk_echo("${PLUGIN.Id}.Import_Path              = '${${PLUGIN.Id}.Import_Path}'")
	dk_echo("${PLUGIN.Id}.Install_Dirname          = '${${PLUGIN.Id}.Install_Dirname}'")
	dk_echo("${PLUGIN.Id}.Install_Name             = '${${PLUGIN.Id}.Install_Name}'")
	dk_echo("${PLUGIN.Id}.Install_Path             = '${${PLUGIN.Id}.Install_Path}'")
	dk_echo("${PLUGIN.Id}.Tuple_Dir                = '${${PLUGIN.Id}.Tuple_Dir}'")
	dk_echo("${PLUGIN.Id}.Build_Dir                = '${${PLUGIN.Id}.Build_Dir}'")
	dk_echo("${PLUGIN.Id}.Config_Dir               = '${${PLUGIN.Id}.Config_Dir}'")
	dk_echo("${PLUGIN.Id}.Debug_Dir                = '${${PLUGIN.Id}.Debug_Dir}'")
	dk_echo("${PLUGIN.Id}.Release_Dir              = '${${PLUGIN.Id}.Release_Dir}'")
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
