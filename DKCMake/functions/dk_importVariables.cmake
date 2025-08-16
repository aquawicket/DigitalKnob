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
# dk_importVariables(Url Rtn_Var) IMPORT_ROOT Import.Name IMPORT_PATH INSTALL_ROOT INSTALL_NAME INSTALL_PATH VERSION BRANCH 
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
#	Import.Name (optional)											zlib
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
	
	dk_getParameter(PRINTVARS)
	if(PRINTVARS)
		dk_unset(PRINTVARS)
		PRINTVARS()
		return()
	endif()
	
	dk_unset(PLUGIN)
	dk_unset(PLUGIN_Args)
	dk_unset(PLUGIN_Build_Dir)
	dk_unset(PLUGIN_Config_Dir)
	dk_unset(PLUGIN_Debug_Dir)
	dk_unset(PLUGIN_Id)
	dk_unset(PLUGIN_Import.Dirname)
	dk_unset(PLUGIN_Import.Name)
	dk_unset(PLUGIN_Import.Name_Lower)
	dk_unset(PLUGIN_Import.Name_Upper)
	dk_unset(PLUGIN_Import.Path)
	dk_unset(PLUGIN_Install.Dirname)
	dk_unset(PLUGIN_Install.Name)
	dk_unset(PLUGIN_Install.Path)
	dk_unset(PLUGIN_Release_Dir)
	dk_unset(PLUGIN_Tuple_Dir)
	dk_unset(PLUGIN_Url)
	dk_unset(PLUGIN_Url.Basename)
	dk_unset(PLUGIN_Url.Extension)
	dk_unset(PLUGIN_Url.Name)
	dk_unset(PLUGIN_Url.Name_Lower)
	dk_unset(PLUGIN_Version)
	
	### PLUGIN(hashtable) 
	##  TODO
	####################
	
	
																	###### EXAMPLE ######
	### IMPORT_ROOT (PLUGIN;Import.Dirname)							/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	dk_unset(IMPORT_ROOT)
	dk_getParameterValue(IMPORT_ROOT)
	dk_echo("IMPORT_ROOT = '${IMPORT_ROOT}'")
	set(PLUGIN.Import.Dirname "${IMPORT_ROOT}" CACHE INTERNAL "")

	### IMPORT_NAME (PLUGIN.Import.Name)							zlib
	dk_unset(IMPORT_NAME)
	dk_getParameterValue(IMPORT_NAME)
	dk_echo("IMPORT_NAME = '${IMPORT_NAME}'")
	set(PLUGIN.Import.Name "${IMPORT_NAME}")

	### IMPORT_PATH (PLUGIN.Import.Path)							/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	dk_unset(IMPORT_PATH)
	dk_getParameterValue(IMPORT_PATH)
	dk_echo("IMPORT_PATH = '${IMPORT_PATH}'")
	set(PLUGIN.Import.Path "${IMPORT_PATH}")

	### INSTALL_ROOT (PLUGIN.Install.Dirname)						/c/Users/Administrator/DigitalKnob/Development/3rdParty
	dk_unset(INSTALL_ROOT)
	dk_getParameterValue(INSTALL_ROOT)
	dk_echo("INSTALL_ROOT = '${INSTALL_ROOT}'")
	set(PLUGIN.Install.Dirname "${INSTALL_ROOT}")

	### INSTALL_NAME (PLUGIN.Install.Name)							zlib-master
	dk_unset(INSTALL_NAME)
	dk_getParameterValue(INSTALL_NAME)
	dk_echo("INSTALL_NAME = '${INSTALL_NAME}'")
	set(PLUGIN.Install.Name "${INSTALL_NAME}")

	### INSTALL_PATH (PLUGIN.Install.Path)							/c/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	dk_unset(INSTALL_PATH)
	dk_getParameterValue(INSTALL_PATH)
	dk_echo("INSTALL_PATH = '${INSTALL_PATH}'")
	set(PLUGIN.Install.Path "${INSTALL_PATH}")

	### VERSION (PLUGIN.Version)									v1.3.1
	dk_unset(VERSION)
	dk_getParameterValue(VERSION)
	dk_echo("VERSION = '${VERSION}'")
	set(PLUGIN.Version "${VERSION}")

	### BRANCH (PLUGIN.Branch)										master
	dk_unset(BRANCH)
	dk_getParameterValue(BRANCH)
	dk_echo("BRANCH = '${BRANCH}'")
	set(PLUGIN.Branch "${BRANCH}")
	
	### PLUGIN.Args													"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	dk_unset(PLUGIN.Args)
	set(PLUGIN.Args ${ARGV} CACHE INTERNAL "")
	dk_echo("PLUGIN.Args = '${PLUGIN.Args}'")
		
	### PLUGIN.Url													"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	dk_unset(PLUGIN.Url)
	set(PLUGIN.Url "${ARGV0}" CACHE INTERNAL "")
	dk_echo("PLUGIN.Url = '${PLUGIN.Url}'")


	### PLUGIN.Id													ZLIB
	PLUGIN_Id()

	### PLUGIN.Install.Path											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	PLUGIN_Install_Path()
	
	### PLUGIN.Url.Extension										.zip
	PLUGIN_Url_Extension()
	#####################################################
	############# PLUGIN.Target_Directries ##############
	#####################################################

	### PLUGIN.Tuple_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	set(PLUGIN.Tuple_Dir "${PLUGIN.Install.Path}/${Target_Tuple}" CACHE INTERNAL "")
	dk_echo("PLUGIN.Tuple_Dir = '${PLUGIN.Tuple_Dir}'")
	
	### PLUGIN.Config_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set(PLUGIN.Config_Dir "${PLUGIN.Install.Path}/${Config_Path}" CACHE INTERNAL "")
	dk_echo("PLUGIN.Config_Dir = '${PLUGIN.Config_Dir}'")

	### PLUGIN.Build_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set(PLUGIN.Build_Dir "${PLUGIN.Install.Path}/${Build_Path}" CACHE INTERNAL "")
	dk_echo("PLUGIN.Build_Dir = '${PLUGIN.Build_Dir}'")

	### PLUGIN.Debug_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set(PLUGIN.Debug_Dir "${PLUGIN.Tuple_Dir}/${Debug_Dir}" CACHE INTERNAL "")
	dk_echo("PLUGIN.Debug_Dir = '${PLUGIN.Debug_Dir}'")

	### PLUGIN.Release_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	set(PLUGIN.Release_Dir "${PLUGIN.Tuple_Dir}/${Release_Dir}" CACHE INTERNAL "")
	dk_echo("PLUGIN.Release_Dir = '${PLUGIN.Release_Dir}'")

	### PLUGIN
	set(PLUGIN "${PLUGIN.Id}" CACHE INTERNAL "")
	dk_echo("PLUGIN = '${PLUGIN}'")
	
	### ${PLUGIN}
	set(${PLUGIN} "${PLUGIN.Install.Path}" CACHE INTERNAL "")
	dk_echo("${PLUGIN} = '${${PLUGIN}}'")
	
endfunction()


############################
function(PLUGIN_Import_Name)
	if(PLUGIN.Import.Name)
		return()
	endif()
		
	PLUGIN_Import_Path()

	if(NOT PLUGIN.Import.Path)
		dk_error("PLUGIN.Import.Path is invalid")
	endif()
	dk_debug("PLUGIN.Import.Path = '${PLUGIN.Import.Path}'")

	if(PLUGIN.Import.Path)
		dk_basename("${PLUGIN.Import.Path}"	PLUGIN.Import.Name)
		if(NOT PLUGIN.Import.Name)
			dk_error("PLUGIN.Import.Name is invalid")
		endif()
		dk_debug("PLUGIN.Import.Name = '${PLUGIN.Import.Name}'")
		
	else()
		dk_includes("${PLUGIN.Url}" "https://github.com" dk_includes)
		if(dk_includes)
			dk_replaceAll(${PLUGIN.Url}			"/" 	"" 	PLUGIN.Url.List)
			dk_replaceAll(${PLUGIN.Url.List} 	";;" 	";" PLUGIN.Url.List)
			if(NOT PLUGIN.Url.List)
				dk_error("PLUGIN.Url.List is invalid")
			endif()
			dk_debug("PLUGIN.Url.List = '${PLUGIN.Url.List}'")
			
			#d_k_listToArray("${PLUGIN.Url.List}"  PLUGIN_Url_Array)
			#dk_printVar(PLUGIN_Url_Array)
			#if(NOT PLUGIN_Url_Array)
			#	dk_error("PLUGIN_Url_Array is invalid")
			#endif()
			#dk_debug("PLUGIN_Url_Array = '${PLUGIN_Url_Array}'")
			
			#dk_arrayAt(PLUGIN_Url_Array	3	PLUGIN.Import.Name)
			#if(NOT PLUGIN.Import.Name)
			#	dk_error("PLUGIN.Import.Name is invalid")
			#endif()
		endif()
		dk_debug("PLUGIN.Import.Name = '${PLUGIN.Import.Name}'")
	endif()
	
	set(PLUGIN.Import.Name ${PLUGIN.Import.Name} PARENT_SCOPE)
	set(PLUGIN.Import.Name ${PLUGIN.Import.Name} CACHE INTERNAL "")
endfunction()

##################################
function(PLUGIN_Import_Name_Lower)
	if(PLUGIN.Import.Name_Lower)
		return()
	endif()
	
	PLUGIN_Import_Name()

	if(NOT PLUGIN.Import.Name)
		dk_error("PLUGIN.Import.Name is invalid")
	endif()
	dk_debug("PLUGIN.Import.Name = '${PLUGIN.Import.Name}'")
	
	dk_toLower("${PLUGIN.Import.Name}" 	PLUGIN.Import.Name_Lower)
	if(NOT PLUGIN.Import.Name_Lower)
		dk_error("PLUGIN.Import.Name_Lower is invalid")
	endif()
	dk_debug("PLUGIN.Import.Name_Lower = '${PLUGIN.Import.Name_Lower}'")
	
	set(PLUGIN.Import.Name_Lower ${PLUGIN.Import.Name_Lower}  PARENT_SCOPE)
	set(PLUGIN.Import.Name_Lower ${PLUGIN.Import.Name_Lower}  CACHE INTERNAL "")
endfunction()

################################
function(PLUGIN_Install_Dirname)
	if(PLUGIN.Install.Dirname)
		return()
	endif()
	
	dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
	set(PLUGIN.Install.Dirname "${DK3RDPARTY_DIR}")
	if(NOT PLUGIN.Install.Dirname)
		dk_error("PLUGIN.Install.Dirname is invalid")
	endif()
	dk_debug("PLUGIN.Install.Dirname = '${PLUGIN.Install.Dirname}'")
	
	set(PLUGIN.Install.Dirname ${PLUGIN.Install.Dirname}  PARENT_SCOPE)
	set(PLUGIN.Install.Dirname ${PLUGIN.Install.Dirname}  CACHE INTERNAL "")
endfunction()

#############################
function(PLUGIN_Url_Basename)
	if(PLUGIN.Url.Basename)
		return()
	endif()

	dk_basename("${PLUGIN.Url}")
	set(PLUGIN.Url.Basename "${dk_basename}")				# basename, filename
	if(NOT PLUGIN.Url.Basename)
		dk_error("PLUGIN.Url.Basename is invalid")
	endif()
	dk_debug("PLUGIN.Url.Basename = '${PLUGIN.Url.Basename}'")
	
	set(PLUGIN.Url.Basename ${PLUGIN.Url.Basename} PARENT_SCOPE)
	set(PLUGIN.Url.Basename ${PLUGIN.Url.Basename} CACHE INTERNAL "")
endfunction()

#############################
function(PLUGIN_Url_Dirname)
	if(PLUGIN.Url.Dirname)
		return()
	endif()

	dk_dirname("${PLUGIN.Url}" PLUGIN.Url.Dirname)
	if(NOT PLUGIN.Url.Dirname)
		dk_error("PLUGIN.Url.Dirname is invalid")
	endif()
	dk_debug("PLUGIN.Url.Dirname = '${PLUGIN.Url.Dirname}'")
	
	set(PLUGIN.Url.Dirname ${PLUGIN.Url.Dirname} PARENT_SCOPE)
	set(PLUGIN.Url.Dirname ${PLUGIN.Url.Dirname} CACHE INTERNAL "")
endfunction()

##############################
function(PLUGIN_Url_Extension)
	if(PLUGIN.Url.Extension)
		return()
	endif()

	dk_getExtension("${PLUGIN.Url}" PLUGIN.Url.Extension)
	if(NOT PLUGIN.Url.Extension)
		dk_error("PLUGIN.Url.Extension is invalid")
	endif()
	dk_debug("PLUGIN.Url.Extension = '${PLUGIN.Url.Extension}'")
	
	set(PLUGIN.Url.Extension ${PLUGIN.Url.Extension} PARENT_SCOPE)
	set(PLUGIN.Url.Extension ${PLUGIN.Url.Extension} CACHE INTERNAL "")
endfunction()

#########################
function(PLUGIN_Url_Name)
	if(PLUGIN.Url.Name)
		return()
	endif()
	
	PLUGIN_Url_Basename()

	if(NOT PLUGIN.Url.Basename)
		dk_error("PLUGIN.Url.Basename is invalid")
	endif()
	dk_debug("PLUGIN.Url.Basename = '${PLUGIN.Url.Basename}'")
	
	dk_removeExtension("${PLUGIN.Url.Basename}" PLUGIN.Url.Name) # name, file  (no extension)
	if(NOT PLUGIN.Url.Name)
		dk_error("PLUGIN.Url.Name is invalid")
	endif()
	dk_debug("PLUGIN.Url.Name = '${PLUGIN.Url.Name}'")
	
	set(PLUGIN.Url.Name ${PLUGIN.Url.Name} PARENT_SCOPE)
	set(PLUGIN.Url.Name ${PLUGIN.Url.Name} CACHE INTERNAL "")
endfunction()

###############################
function(PLUGIN_Url_Name_Lower)
	if(PLUGIN.Url.Name_Lower)
		return()
	endif()
	
	PLUGIN_Url_Name()

	if(NOT PLUGIN.Url.Name)
		dk_error("PLUGIN.Url.Name is invalid")
	endif()
	dk_debug("PLUGIN.Url.Name = '${PLUGIN.Url.Name}'")
	
	dk_toLower(${PLUGIN.Url.Name})
 	set(PLUGIN.Url.Name_Lower "${dk_toLower}")
	if(NOT PLUGIN.Url.Name_Lower)
		dk_error("PLUGIN.Url.Name_Lower is invalid")
	endif()
	dk_debug("PLUGIN.Url.Name_Lower = '${PLUGIN.Url.Name_Lower}'")
	
	set(PLUGIN.Url.Name_Lower ${PLUGIN.Url.Name_Lower} PARENT_SCOPE)
	set(PLUGIN.Url.Name_Lower ${PLUGIN.Url.Name_Lower} CACHE INTERNAL "")
endfunction()

#############################
function(PLUGIN_Install_Name)
	if(PLUGIN.Install.Name)
		return()
	endif()
	
	PLUGIN_Import_Name()

	if(NOT PLUGIN.Import.Name)
		dk_error("PLUGIN.Import.Name is invalid")
	endif()
	dk_debug("PLUGIN.Import.Name = '${PLUGIN.Import.Name}'")
	
	PLUGIN_Version()
	if(NOT PLUGIN.Version)
		dk_error("PLUGIN.Version is invalid")
	endif()
	dk_debug("PLUGIN.Version = '${PLUGIN.Version}'")
	
	if((PLUGIN.Import.Name) AND (PLUGIN.Version))
		set(PLUGIN.Install.Name "${PLUGIN.Import.Name}-${PLUGIN.Version}")
	elseif(NOT PLUGIN.Install.Name)	
		set(PLUGIN.Install.Name "${PLUGIN.Import.Name}")
	endif()
	if(NOT PLUGIN.Install.Name)
		dk_error("PLUGIN.Install.Name is invalid")
	endif()
	dk_debug("PLUGIN.Install.Name = '${PLUGIN.Install.Name}'")
	
	set(PLUGIN.Install.Name ${PLUGIN.Install.Name} PARENT_SCOPE)
	set(PLUGIN.Install.Name ${PLUGIN.Install.Name} CACHE INTERNAL "")
endfunction()

#######################
function(PLUGIN_Install_Path)
	if(PLUGIN.Install.Path)
		return()
	endif()
	
	PLUGIN_Install_Dirname()

	if(NOT PLUGIN.Install.Dirname)
		dk_error("PLUGIN.Install.Dirname is invalid")
	endif()
	dk_debug("PLUGIN.Install.Dirname = '${PLUGIN.Install.Dirname}'")
	
	PLUGIN_Install_Name()

	if(NOT PLUGIN.Install.Name)
		dk_error("PLUGIN.Install.Name is invalid")
	endif()
	dk_debug("PLUGIN.Install.Name = '${PLUGIN.Install.Name}'")
	
	set(PLUGIN.Install.Path "${PLUGIN.Install.Dirname}/${PLUGIN.Install.Name}")
	if(NOT PLUGIN.Install.Path)
		dk_error("PLUGIN.Install.Path is invalid")
	endif()
	dk_debug("PLUGIN.Install.Path = '${PLUGIN.Install.Path}'")
	
	set(PLUGIN.Install.Path ${PLUGIN.Install.Path} PARENT_SCOPE)
	set(PLUGIN.Install.Path ${PLUGIN.Install.Path} CACHE INTERNAL "")
endfunction()

######################
function(PLUGIN_Import_Path)
	if(PLUGIN.Import.Path)
		return()
	endif()
	
	if(PLUGIN.Import.Name)
		dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
		set(PLUGIN.Import.Path "${DKIMPORTS_DIR}/${PLUGIN.Import.Name}")
	else()
		dk_includes("${dk_depend}" "${DKIMPORTS_DIR}" dk_includes)
		if(dk_includes)
			set(PLUGIN.Import.Path "${dk_depend}")
		endif()
	endif()
	
	if(NOT PLUGIN.Import.Path)
		dk_error("PLUGIN.Import.Path is invalid")
	endif()
	dk_debug("PLUGIN.Import.Path = '${PLUGIN.Import.Path}'")
	
	set(PLUGIN.Import.Path ${PLUGIN.Import.Path} PARENT_SCOPE)
	set(PLUGIN.Import.Path ${PLUGIN.Import.Path} CACHE INTERNAL "")
endfunction()

########################
function(PLUGIN_Version)
	if(PLUGIN.Version)
		return()
	endif()
		
	PLUGIN_Url_Name_Lower()

	if(NOT PLUGIN.Url.Name_Lower)
		dk_error("PLUGIN.Url.Name_Lower is invalid")
	endif()
	dk_debug("PLUGIN.Url.Name_Lower = '${PLUGIN.Url.Name_Lower}'")
	
	PLUGIN_Import_Name_Lower()

	if(NOT PLUGIN.Import.Name_Lower)
		dk_error("PLUGIN.Import.Name_Lower is invalid")
	endif()
	dk_debug("PLUGIN.Import.Name_Lower = '${PLUGIN.Import.Name_Lower}'")
	
	if(PLUGIN.Url.Name_Lower)
		if(PLUGIN.Import.Name_Lower)
			dk_replaceAll("${PLUGIN.Url.Name_Lower}" 	"${PLUGIN.Import.Name_Lower}" 	""  PLUGIN.Version)
		endif()
		if(NOT PLUGIN.Version)
			set(PLUGIN.Version ${PLUGIN.TAG})
		endif()
		if(NOT PLUGIN.Version)
			set(PLUGIN.Version ${PLUGIN.Branch})
		endif()
	endif()
	
	dk_trimNonAlphaNumeric("${PLUGIN.Version}" PLUGIN.Version)
	
	if(NOT PLUGIN.Version)
		dk_error("PLUGIN.Version is invalid")
	endif()
	dk_debug("PLUGIN.Version = '${PLUGIN.Version}'")
	
	set(PLUGIN.Version ${PLUGIN.Version} PARENT_SCOPE)
	set(PLUGIN.Version ${PLUGIN.Version} CACHE INTERNAL "")
endfunction()

############################
function(PLUGIN_Import_Name_Upper)
	if(PLUGIN.Import.Name_Upper)
		return()
	endif()
	
	PLUGIN_Import_Name()

	if(NOT PLUGIN.Import.Name)
		dk_error("PLUGIN.Import.Name is invalid")
	endif()
	dk_debug("PLUGIN.Import.Name = '${PLUGIN.Import.Name}'")
	
	dk_toUpper("${PLUGIN.Import.Name}")
	set(PLUGIN.Import.Name_Upper "${dk_toUpper}")
	if(NOT PLUGIN.Import.Name_Upper)
		dk_error("PLUGIN.Import.Name_Upper is invalid")
	endif()
	dk_debug("PLUGIN.Import.Name_Upper = '${PLUGIN.Import.Name_Upper}'")
	
	set(PLUGIN.Import.Name_Upper ${PLUGIN.Import.Name_Upper} PARENT_SCOPE)
	set(PLUGIN.Import.Name_Upper ${PLUGIN.Import.Name_Upper} CACHE INTERNAL "")
endfunction()

#############
function(PLUGIN_Id)
	if(PLUGIN.Id)
		return()
	endif()
	
	PLUGIN_Import_Name_Upper()

	if(NOT PLUGIN.Import.Name_Upper)
		dk_error("PLUGIN.Import.Name_Upper is invalid")
	endif()
	dk_debug("PLUGIN.Import.Name_Upper = '${PLUGIN.Import.Name_Upper}'")
	
	dk_convertToCIdentifier("${PLUGIN.Import.Name_Upper}")
 	set(PLUGIN.Id "${dk_convertToCIdentifier}")
	if(NOT PLUGIN.Id)
		dk_error("PLUGIN.Id is invalid")
	endif()
	dk_debug("PLUGIN.Id = '${PLUGIN.Id}'")
	
	set(PLUGIN.Id ${PLUGIN.Id} PARENT_SCOPE)
	set(PLUGIN.Id ${PLUGIN.Id} CACHE INTERNAL "")
endfunction()
	
	
	

function(Copy_Variables)
	### Set the <PLUGIN.ID> variable to mirror %PLUGIN%
	### All %PLUGIN.variables will be mirrored to the Plugin Import Name.  I.E.   $ZLIB.variables
	get_cmake_property(_vars VARIABLES)
	string(REGEX MATCHALL "(^|;)PLUGIN.[A-Za-z0-9_.*" _matchedVars "${_vars}")
	foreach(_variable ${_matchedVars})
		set(${_variable} ${${_variable}} PARENT_SCOPE)
		string(REPLACE "PLUGIN" "${PLUGIN.ID}" _variable_B ${_variable})
		set(${_variable_B} ${${_variable}} PARENT_SCOPE)
	endforeach()
endfunction()

	
	
	
	
		
	
	
	
	
	
	
	
	
	
###################
function(PRINTVARS)
	dk_echo(" ")
	dk_echo(" ")
	dk_echo("################## PLUGIN.variables ##################")
	dk_echo("PLUGIN                               = '${PLUGIN}'")
	dk_echo("${PLUGIN}                            = '${${PLUGIN}}'")
	dk_echo("PLUGIN.Args                          = '${PLUGIN.Args}'")
	dk_echo("PLUGIN.Id                            = '${PLUGIN.Id}'")
	dk_echo("PLUGIN.Version                       = '${PLUGIN.Version}'")
	dk_echo("PLUGIN.Url                           = '${PLUGIN.Url}'")
	dk_echo("PLUGIN.Url.Basename                  = '${PLUGIN.Url.Basename}'")
	dk_echo("PLUGIN.Url.Name                      = '${PLUGIN.Url.Name}'")
	dk_echo("PLUGIN.Url.Extension                 = '${PLUGIN.Url.Extension}'")
	dk_echo("PLUGIN.Import.Dirname                = '${PLUGIN.Import.Dirname}'")
	dk_echo("PLUGIN.Import.Name                   = '${PLUGIN.Import.Name}'")
	dk_echo("PLUGIN.Import.Path                   = '${PLUGIN.Import.Path}'")
	dk_echo("PLUGIN.Install.Dirname               = '${PLUGIN.Install.Dirname}'")
	dk_echo("PLUGIN.Install.Name                  = '${PLUGIN.Install.Name}'")
	dk_echo("PLUGIN.Install.Path                  = '${PLUGIN.Install.Path}'")
	dk_echo("PLUGIN.Tuple_Dir                     = '${PLUGIN.Tuple_Dir}'")
	dk_echo("PLUGIN.Build_Dir                     = '${PLUGIN.Build_Dir}'")
	dk_echo("PLUGIN.Config_Dir                    = '${PLUGIN.Config_Dir}'")
	dk_echo("PLUGIN.Debug_Dir                     = '${PLUGIN.Debug_Dir}'")
	dk_echo("PLUGIN.Release_Dir                   = '${PLUGIN.Release_Dir}'")
	dk_echo("")
	dk_echo("")
	dk_echo("################## ${PLUGIN.Id}.variables ##################")
	dk_echo("${PLUGIN.Id}                          = '${${PLUGIN.Id}}'")
	dk_echo("${PLUGIN.Id}.Args                     = '${${PLUGIN.Id}.Args}'")
	dk_echo("${PLUGIN.Id}.Id                       = '${${PLUGIN.Id}.Id}'")
	dk_echo("${PLUGIN.Id}.Version                  = '${${PLUGIN.Id}.Version}'")
	dk_echo("${PLUGIN.Id}.Url                      = '${${PLUGIN.Id}.Url}'")
	dk_echo("${PLUGIN.Id}.Url.Basename             = '${${PLUGIN.Id}.Url.Basename}'")
	dk_echo("${PLUGIN.Id}.Url.Name                 = '${${PLUGIN.Id}.Url.Name}'")
	dk_echo("${PLUGIN.Id}.Url.Extension            = '${${PLUGIN.Id}.Url.Extension}'")
	dk_echo("${PLUGIN.Id}.Import.Dirname           = '${${PLUGIN.Id}.Import.Dirname}'")
	dk_echo("${PLUGIN.Id}.Import.Name              = '${${PLUGIN.Id}.Import.Name}'")
	dk_echo("${PLUGIN.Id}.Import.Path              = '${${PLUGIN.Id}.Import.Path}'")
	dk_echo("${PLUGIN.Id}.Install.Dirname          = '${${PLUGIN.Id}.Install.Dirname}'")
	dk_echo("${PLUGIN.Id}.Install.Name             = '${${PLUGIN.Id}.Install.Name}'")
	dk_echo("${PLUGIN.Id}.Install.Path             = '${${PLUGIN.Id}.Install.Path}'")
	dk_echo("${PLUGIN.Id}.Tuple_Dir                = '${${PLUGIN.Id}.Tuple_Dir}'")
	dk_echo("${PLUGIN.Id}.Build_Dir                = '${${PLUGIN.Id}.Build_Dir}'")
	dk_echo("${PLUGIN.Id}.Config_Dir               = '${${PLUGIN.Id}.Config_Dir}'")
	dk_echo("${PLUGIN.Id}.Debug_Dir                = '${${PLUGIN.Id}.Debug_Dir}'")
	dk_echo("${PLUGIN.Id}.Release_Dir              = '${${PLUGIN.Id}.Release_Dir}'")
	dk_echo("")
endfunction()	



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
	
	set(dk_depend "${DKIMPORTS_DIR}/msys2")
	dk_importVariables("https://repo.msys2.org/distrib/x86_64/msys2-base-x86_64-20241208.tar.xz")
	dk_importVariables(PRINTVARS)
	
	set(dk_depend "${DKIMPORTS_DIR}/git")
	dk_importVariables("https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe" INSTALL_ROOT "${DKTOOLS_DIR}")
	dk_importVariables(PRINTVARS)
	
	set(dk_depend "${DKIMPORTS_DIR}/php-src")
	dk_importVariables("https://windows.php.net/downloads/releases/php-8.4.11-Win32-vs17-x64.zip")
	dk_importVariables(PRINTVARS)
endfunction()
