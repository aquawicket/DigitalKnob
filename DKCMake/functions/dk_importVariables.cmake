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


######################################################################################################################################
# dk_importVariables(PLUGIN.URL rtn_var) IMPORT_ROOT IMPORT_NAME IMPORT_PATH INSTALL_ROOT INSTALL_NAME INSTALL_PATH VERSION BRANCH TAG
#
#															###### EXAMPLES ######
#	PLUGIN_URL												https://github.com/madler/zlib.git     							* github repository link
#															https://github.com/madler/zlib/archive/refs/heads/master.zip	* github sourcecode download
#															https://github.com/madler/zlib        							* github page
#															https://zlib.net/zlib-1.3.1.tar.gz								* library sourcecode download
#															https://website.com/executable.exe              				* executable file
#
#
#	IMPORT_ROOT	(optional)									C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
#
#
#	IMPORT_NAME (optional)									zlib
#
#
#	IMPORT_PATH (optional)									C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
#
#
#	INSTALL_ROOT (optional)									C:/Users/Administrator/DigitalKnob/Development/DKTools
#
#
#	INSTALL_NAME (optional)									zlib-8-5-2025
#															myZLIB
#
#	INSTALL_PATH (optional)									C:/Users/Administrator/DigitalKnob/Development/DKTools/zlib-8-5-2025
#															C:/Users/Administrator/DigitalKnob/Development/DKTools/myZLIB
#
#	VERSION (optional)										master
#
#
#	BRANCH (optional)										develop
#															master
#
#	TAG (optional)											v1.3.1
#															v1.2.13
#
function(dk_importVariables)

	dk_debugFunc(1 9)
	
	### IMPORT_ROOT											/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	dk_unset(IMPORT_ROOT)
	dk_getParameterValue(IMPORT_ROOT)
	set(PLUGIN.IMPORT_ROOT ${IMPORT_ROOT})
	dk_echo("PLUGIN.IMPORT_ROOT = ${PLUGIN.IMPORT_ROOT}'")

	### IMPORT_NAME												zlib
	dk_unset(IMPORT_NAME)
	dk_getParameterValue(IMPORT_NAME)
	set(PLUGIN.IMPORT_NAME ${IMPORT_NAME})
	dk_echo("PLUGIN.IMPORT_NAME = '${PLUGIN.IMPORT_NAME}'")

	### IMPORT_PATH												/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	dk_unset(IMPORT_PATH)
	dk_getParameterValue(IMPORT_PATH)
	set(PLUGIN.IMPORT_PATH ${IMPORT_PATH})
	dk_echo("PLUGIN.IMPORT_PATH = '${PLUGIN.IMPORT_PATH}'")

	### INSTALL_ROOT												/c/Users/Administrator/DigitalKnob/Development/3rdParty
	dk_unset(INSTALL_ROOT)
	dk_getParameterValue(INSTALL_ROOT)
	set(PLUGIN.INSTALL_ROOT ${INSTALL_ROOT})
	dk_echo("PLUGIN.INSTALL_ROOT = '${PLUGIN.INSTALL_ROOT}'")

	### INSTALL_NAME												zlib-master
	dk_unset(INSTALL_NAME)
	dk_getParameterValue(INSTALL_NAME)
	set(PLUGIN.INSTALL_NAME ${INSTALL_NAME})
	dk_echo("PLUGIN.INSTALL_NAME = '${PLUGIN.INSTALL_NAME}'")

	### INSTALL_PATH												/c/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	dk_unset(INSTALL_PATH)
	dk_getParameterValue(INSTALL_PATH)
	set(PLUGIN.INSTALL_PATH ${INSTALL_PATH})
	dk_echo("PLUGIN.INSTALL_PATH = '${PLUGIN.INSTALL_PATH}'")

	### VERSION													master
	dk_unset(VERSION)
	dk_getParameterValue(VERSION)
	set(PLUGIN.VERSION ${VERSION})
	dk_echo("PLUGIN.VERSION = '${PLUGIN.VERSION}'")

	### BRANCH													master
	dk_unset(BRANCH)
	dk_getParameterValue(BRANCH)
	set(PLUGIN.BRANCH ${BRANCH})
	dk_echo("PLUGIN.BRANCH = '${PLUGIN.BRANCH}'")

	### TAG														v1.3.1
	dk_unset(TAG)
	dk_getParameterValue(TAG)
	set(PLUGIN.TAG ${TAG})
	dk_echo("PLUGIN.TAG = '${PLUGIN.TAG}'")
	
	
	############### PLUGIN.variables ##################

	### PLUGIN.IMPORT_PATH										/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	if(NOT PLUGIN.IMPORT_PATH)
		dk_getcwd()
		set(PLUGIN.IMPORT_PATH ${DKPWD})
	endif()
	dk_echo("PLUGIN.IMPORT_PATH = '${PLUGIN.IMPORT_PATH}'")

	### PLUGIN.IMPORT_ROOT										/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	if(NOT PLUGIN.IMPORT_ROOT)
		dk_dirname(${PLUGIN.IMPORT_PATH}	PLUGIN.IMPORT_ROOT)
	endif()
	dk_echo("PLUGIN.IMPORT_ROOT = '${PLUGIN.IMPORT_ROOT}'")

	### PLUGIN.IMPORT_NAME										zlib
	if(NOT PLUGIN.IMPORT_NAME)
		dk_basename(${PLUGIN.IMPORT_PATH}		PLUGIN.IMPORT_NAME)
	endif()
	dk_echo("PLUGIN.IMPORT_NAME = '${PLUGIN.IMPORT_NAME}'")

	### PLUGIN.IMPORT_NAME_Upper
	if(NOT PLUGIN.IMPORT_NAME_Upper)
		dk_toUpper(${PLUGIN.IMPORT_NAME}		PLUGIN.IMPORT_NAME_Upper)
	endif()
	dk_echo("PLUGIN.IMPORT_NAME_Upper = '${PLUGIN.IMPORT_NAME_Upper}'")

	### PLUGIN.IMPORT_NAME_Alphanumeric
	if(NOT PLUGIN.IMPORT_NAME_Alphanumeric)
		dk_convertToCIdentifier("${PLUGIN.IMPORT_NAME_Upper}" 	PLUGIN.IMPORT_NAME_Alphanumeric)
	endif()
	dk_echo("PLUGIN.IMPORT_NAME_Alphanumeric = '${PLUGIN.IMPORT_NAME_Alphanumeric}'")

	### PLUGIN.ID
	if(NOT PLUGIN.ID)
		set(PLUGIN.ID ${PLUGIN.IMPORT_NAME_Upper})
		if(NOT "${PLUGIN.ID}" STREQUAL "${PLUGIN.IMPORT_NAME_Alphanumeric}")
			dk_notice("${PLUGIN.ID} contains non-alphanumeric characters and will be set to ${PLUGIN.IMPORT_NAME_Alphanumeric}")
			set(PLUGIN.ID ${PLUGIN.IMPORT_NAME_Alphanumeric})
		endif()
	endif()
	dk_echo("PLUGIN.ID = '${PLUGIN.ID}'")

	### PLUGIN.ARGS												"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	set(PLUGIN.ARGS ${ARGV})
	dk_echo("PLUGIN.ARGS = '${PLUGIN.ARGS}'")

	### PLUGIN.URL												"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	set(PLUGIN.URL ${ARGV0})
	dk_echo("PLUGIN.URL = '${PLUGIN.URL}'")

	### PLUGIN.IMPORT												1
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	dk_includes("${PLUGIN.IMPORT_PATH}" "${DKIMPORTS_DIR}")
	if(${dk_includes})
		set(PLUGIN.IMPORT 1)
	endif()
	dk_echo("PLUGIN.IMPORT = '${PLUGIN.IMPORT}'")

	### PLUGIN.URL_Filename										master.zip
	dk_basename(${PLUGIN.URL} PLUGIN.URL_Filename)				
	dk_echo("PLUGIN.URL_Filename = '${PLUGIN.URL_Filename}'")

	### PLUGIN.URL_List											https:;github.com;madler;zlib;archive;refs;heads;master.zip
	dk_replaceAll(${PLUGIN.URL} "/" ";"			PLUGIN.URL_List)
	dk_replaceAll(${PLUGIN.URL_List} ";;" ";" PLUGIN.URL_List)
	dk_echo("PLUGIN.URL_List = '${PLUGIN.URL_List}'")

	### PLUGIN.GIT												1
	dk_includes(${PLUGIN.URL} "https://github.com")
	if(${dk_includes})
		set(PLUGIN.GIT 1)
	endif()
	dk_echo("PLUGIN.GIT = '${PLUGIN.GIT}'")

	### PLUGIN.URL_Extension										.zip
	dk_getExtension(${PLUGIN.URL_Filename}		PLUGIN.URL_Extension)
	dk_echo("PLUGIN.URL_Extension = '${PLUGIN.URL_Extension}'")

	### PLUGIN.URL_File												master
	dk_removeExtension(${PLUGIN.URL_Filename}	PLUGIN.URL_File)
	dk_echo("PLUGIN.URL_File = '${PLUGIN.URL_File}'")

	### PLUGIN.URL_File_Lower										master
	dk_toLower(${PLUGIN.URL_File}				PLUGIN.URL_File_Lower)
	dk_echo("PLUGIN.URL_File_Lower = '${PLUGIN.URL_File_Lower}'")

	### PLUGIN.URL_Array											[0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip	
#	d_k_listToArray(${PLUGIN.URL_List}			PLUGIN.URL_Array)
#	set /a "n=0"
#	:PLUGIN.URL_Array.loop
#	if defined PLUGIN.URL_Array[%n%] (
#		if "!DE!" neq "" (dk_echo("PLUGIN.URL_Array[%n%] = %'${PLUGIN.URL_Array[%n%]%}"))
#		if "!DE!" equ "" (dk_echo("PLUGIN.URL_Array[%n%] = !PLUGIN.URL_Array[%n%]!")
#	   	set /a n+=1
#		goto :PLUGIN.URL_Array.loop
#	endif()
	set(PLUGIN.URL_Array ${PLUGIN.URL_List})
	dk_echo("PLUGIN.URL_Array = '${PLUGIN.URL_Array}'")

	### PLUGIN.URL_Length											8
	dk_arrayLength(PLUGIN.URL_List		PLUGIN.URL_Length)
	dk_echo("PLUGIN.URL_Length = '${PLUGIN.URL_Length}'")

	### PLUGIN.IMPORT_NAME_Lower									zlib
	dk_toLower(${PLUGIN.IMPORT_NAME} 	PLUGIN.IMPORT_NAME_Lower)
	dk_echo("PLUGIN.IMPORT_NAME_Lower = '${PLUGIN.IMPORT_NAME_Lower}'")

	
	###############################################
	############ PLUGIN.GIT_Variables #############
	###############################################
	#if(${PLUGIN.GIT} EQUAL 1)	
		### PLUGIN.GIT_NAME											zlib
		######!!!!!! FIXME: using list instead of array !!!!!!######		
		dk_arrayAt(PLUGIN.URL_List	3	PLUGIN.GIT_NAME)
		dk_echo("PLUGIN.GIT_NAME = ${PLUGIN.GIT_NAME}")
	#endif()	

	### PLUGIN.GIT_NAME_Lower										zlib
	dk_toLower(${PLUGIN.GIT_NAME} 		PLUGIN.GIT_NAME_Lower)
	dk_echo("PLUGIN.GIT_NAME_Lower = ${PLUGIN.GIT_NAME_Lower}")

	### PLUGIN.GIT_BRANCH											master
	if(NOT PLUGIN.BRANCH)
		# dk_getGitBRANCHName %PLUGIN_URL% PLUGIN_BRANCH
		set(PLUGIN.BRANCH "master")
	endif()
	dk_echo("PLUGIN.GIT_BRANCH = ${PLUGIN.GIT_BRANCH}")

	### PLUGIN.GIT_TAG												TODO
	if(NOT PLUGIN.TAG)
		set(PLUGIN.TAG "###TODO###")
	endif()
	dk_echo("PLUGIN.GIT_TAG = ${PLUGIN.GIT_TAG}")

	###################################################
	############ PLUGIN.INSTALL_Variables #############
	###################################################

	### PLUGIN.NAME
	if(NOT PLUGIN.NAME)
		set(PLUGIN.NAME ${PLUGIN.IMPORT_NAME}) 
	endif()
	if(NOT PLUGIN.NAME) 
		set(PLUGIN.NAME ${PLUGIN.GIT_NAME})
	endif()	
	if(NOT PLUGIN.NAME) 
		set(PLUGIN.NAME ${PLUGIN.URL_NAME})
	endif()
	if(NOT PLUGIN.NAME) 
		dk_error("PLUGIN.NAME invalid")
	endif()
	# dk_convertToCIdentifier("${PLUGIN.NAME}"	PLUGIN.NAME)
	dk_echo("PLUGIN.NAME = ${PLUGIN.NAME}")

	### PLUGIN.VERSION											master
	if(NOT PLUGIN.VERSION)
		set(PLUGIN.VERSION ${VERSION})
	endif()
	if(NOT PLUGIN.VERSION)
		if((PLUGIN.URL_File_Lower) AND (PLUGIN.IMPORT_NAME_Lower))
			dk_replaceAll("${PLUGIN.URL_File_Lower}" 	"${PLUGIN.IMPORT_NAME_Lower}" 	"" 	PLUGIN.VERSION)
			if(NOT PLUGIN.VERSION)
				set(PLUGIN.VERSION ${PLUGIN.TAG})
			endif()
			if(NOT PLUGIN.VERSION)
				set(PLUGIN.VERSION ${PLUGIN.BRANCH}) 
			endif()
		endif()
	endif()
	if(NOT PLUGIN.VERSION)
		set(PLUGIN.VERSION "master")
	endif()
	if(NOT PLUGIN.VERSION)
		dk_error("PLUGIN.VERSION invalid")
	endif()
	dk_echo("PLUGIN.VERSION = ${PLUGIN.VERSION}")

#	string(FIND ${PLUGIN.VERSION} "-" index)
#	if [ %index% -eq 0 ] then
#		string SUBSTRING %PLUGIN.VERSION% 1 -1 PLUGIN.VERSION
#	fi  
#	string FIND %PLUGIN.VERSION _ index
#	if [ %index% -eq 0 ] then
#		string SUBSTRING %PLUGIN.VERSION 1 -1 PLUGIN.VERSION
#	fi 

	### PLUGIN.INSTALL_NAME										zlib-master
	if(NOT (PLUGIN.INSTALL_NAME) AND (PLUGIN.NAME) AND (PLUGIN.VERSION))
		set(PLUGIN.INSTALL_NAME "${PLUGIN.NAME}-${PLUGIN.VERSION}")
	endif()
	if(NOT PLUGIN.INSTALL_NAME)
		set(PLUGIN.INSTALL_NAME ${PLUGIN.NAME})
	endif()
	if(NOT PLUGIN.INSTALL_NAME)
		dk_error("PLUGIN.INSTALL_NAME invalid")
	endif()
	dk_echo("PLUGIN.INSTALL_NAME = ${PLUGIN.INSTALL_NAME}")

	### PLUGIN.INSTALL_ROOT										C:/Users/Administrator/DigitalKnob/Development/3rdParty
	if(NOT PLUGIN.INSTALL_ROOT)
		dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
		set(PLUGIN.INSTALL_ROOT ${DK3RDPARTY_DIR})
	endif()
	if(NOT PLUGIN.INSTALL_ROOT)
		dk_error("PLUGIN.INSTALL_ROOT invalid")
	endif()
	dk_echo("PLUGIN.INSTALL_ROOT = ${PLUGIN.INSTALL_ROOT}")

	### PLUGIN.INSTALL_PATH										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	if(NOT PLUGIN.INSTALL_PATH)
		set(PLUGIN.INSTALL_PATH "${PLUGIN.INSTALL_ROOT}/${PLUGIN.INSTALL_NAME}")
	endif()
	if(NOT PLUGIN.INSTALL_PATH)
		dk_error("PLUGIN.INSTALL_PATH invalid")
	endif()
	dk_echo("PLUGIN.INSTALL_PATH = ${PLUGIN.INSTALL_PATH}")

	### PLUGIN
	set(PLUGIN ${PLUGIN.INSTALL_PATH})
	dk_echo("PLUGIN = ${PLUGIN}")
	
		
	##############################################
	############# PLUGIN.Variables ###############
	##############################################
	if((PLUGIN.IMPORT_NAME_Lower) AND (PLUGIN.GIT_NAME_Lower))
		if(NOT "${PLUGIN.IMPORT_NAME_Lower}" STREQUAL "${PLUGIN.GIT_NAME_Lower}")
			dk_warning("PLUGIN.IMPORT_NAME_Lower:${PLUGIN.IMPORT_NAME_Lower} and PLUGIN.GIT_NAME_Lower:${PLUGIN.GIT_NAME_Lower} do not match")
		endif()
	endif()	

	### <PLUGIN.ID>	
	set(${PLUGIN.ID} ${PLUGIN.INSTALL_PATH})
	dk_echo("${PLUGIN.ID} = ${${PLUGIN.ID}}")
	
	### PLUGIN.DIR												C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	### DO NOT USE GIT_DIR ###
	if(NOT "${PLUGIN.ID}" STREQUAL "GIT")
		set(PLUGIN.DIR ${PLUGIN.INSTALL_PATH})
	endif()
	dk_echo("PLUGIN.DIR = ${PLUGIN.DIR}")
	
	
	#####################################################
	############# TARGET %PLUGIN.Variables ##############
	#####################################################

	### PLUGIN.Tuple_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	set(PLUGIN.Tuple_Dir "${PLUGIN.INSTALL_PATH}/${Target_Tuple}")
	dk_echo("PLUGIN.Tuple_Dir = ${PLUGIN.Tuple_Dir}")

	### PLUGIN.Config_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set(PLUGIN.Config_Dir "${PLUGIN.INSTALL_PATH}/${Config_Path}")
	dk_echo("PLUGIN.Config_Dir = ${PLUGIN.Config_Dir}")

	### PLUGIN.Build_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set(PLUGIN.Build_Dir "${PLUGIN.INSTALL_PATH}/${Build_Path}")
	dk_echo("PLUGIN.Build_Dir ${PLUGIN.Build_Dir}")

	### PLUGIN.Debug_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set(PLUGIN.Debug_Dir "${PLUGIN.Tuple_Dir}/${Debug_Dir}")
	dk_echo("PLUGIN.Debug_Dir = ${PLUGIN.Debug_Dir}")

	### PLUGIN.Release_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	set(PLUGIN.Release_Dir "${PLUGIN.Tuple_Dir}/${Release_Dir}")
	dk_echo("PLUGIN.Release_Dir = ${PLUGIN.Release_Dir}")

	### Set the <PLUGIN.ID> variable to mirror %PLUGIN%
	### All %PLUGIN.variables will be mirrored to the Plugin Import Name.  I.E.   $ZLIB.variables
	get_cmake_property(_vars VARIABLES)
    string(REGEX MATCHALL "(^|;)PLUGIN[A-Za-z0-9_.]*" _matchedVars "${_vars}")
    foreach(_variable ${_matchedVars})
		set(${_variable} ${${_variable}} PARENT_SCOPE)
		string(REPLACE "PLUGIN" "${PLUGIN.ID}" _variable_B ${_variable})
		set(${_variable_B} ${${_variable}} PARENT_SCOPE)
    endforeach()

endfunction()	
	
	
	
	
		
	
	
	
	
	
	
	
	
	
	



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
	dk_chdir("${DKIMPORTS_DIR}/git")
	dk_importVariables("https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe" IMPORT_NAME git INSTALL_ROOT "${DKTOOLS_DIR}")
	
	dk_echo()
	dk_echo()
	dk_echo("################## PLUGIN.variables ##################")
	dk_echo("PLUGIN                               = ${PLUGIN}")
	dk_echo("PLUGIN.ARGS                          = ${PLUGIN.ARGS}")
	dk_echo("PLUGIN.ID                            = ${PLUGIN.ID}")
	dk_echo("PLUGIN.IMPORT_ROOT                   = ${PLUGIN.IMPORT_ROOT}")
	dk_echo("PLUGIN.IMPORT_NAME                   = ${PLUGIN.IMPORT_NAME}")
	dk_echo("PLUGIN.IMPORT_PATH                   = ${PLUGIN.IMPORT_PATH}")
	dk_echo("PLUGIN.INSTALL_ROOT                  = ${PLUGIN.INSTALL_ROOT}")
	dk_echo("PLUGIN.INSTALL_NAME                  = ${PLUGIN.INSTALL_NAME}")
	dk_echo("PLUGIN.INSTALL_PATH                  = ${PLUGIN.INSTALL_PATH}")
	dk_echo("PLUGIN.VERSION                       = ${PLUGIN.VERSION}")
	dk_echo("PLUGIN.BRANCH                        = ${PLUGIN.BRANCH}")
	dk_echo("PLUGIN.TAG                           = ${PLUGIN.TAG}")
	dk_echo("PLUGIN.URL                           = ${PLUGIN.URL}")
	dk_echo("PLUGIN.URL_Filename                  = ${PLUGIN.URL_Filename}")
	dk_echo("PLUGIN.URL_File                      = ${PLUGIN.URL_File}")
	dk_echo("PLUGIN.URL_Extension                 = ${PLUGIN.URL_Extension}")
	dk_echo("PLUGIN.URL_List                      = ${PLUGIN.URL_List}")
	dk_echo("PLUGIN.URL_Array                     = ${PLUGIN.URL_Array}")
	dk_echo("PLUGIN.URL_Length                    = ${PLUGIN.URL_Length}")
	dk_echo("PLUGIN.GIT                           = ${PLUGIN.GIT}")
	dk_echo("PLUGIN.GIT_NAME                      = ${PLUGIN.GIT_NAME}")
	dk_echo("PLUGIN.IMPORT                        = ${PLUGIN.IMPORT}")
	dk_echo("PLUGIN.IMPORT_NAME_Lower             = ${PLUGIN.IMPORT_NAME_Lower}")
	dk_echo("PLUGIN.IMPORT_NAME_Upper             = ${PLUGIN.IMPORT_NAME_Upper}")	
	dk_echo("PLUGIN.IMPORT_NAME_Alphanumeric      = ${PLUGIN.IMPORT_NAME_Alphanumeric}")
	dk_echo("PLUGIN.Build_Dir                     = ${PLUGIN.Build_Dir}")
	dk_echo("PLUGIN.Config_Dir                    = ${PLUGIN.Config_Dir}")
	dk_echo("PLUGIN.Debug_Dir                     = ${PLUGIN.Debug_Dir}")
	dk_echo("PLUGIN.Release_Dir                   = ${PLUGIN.Release_Dir}")
	dk_echo("PLUGIN.Tuple_Dir                     = ${PLUGIN.Tuple_Dir}")
	dk_echo()
	dk_echo()
	dk_echo("################## ${PLUGIN.ID}.variables ##################")
	dk_echo("${PLUGIN.ID}                         = ${${PLUGIN.ID}}")
	dk_echo("${PLUGIN.ID}.ARGS                    = ${${PLUGIN.ID}.ARGS}")
	dk_echo("${PLUGIN.ID}.ID                      = ${${PLUGIN.ID}.ID}")
	dk_echo("${PLUGIN.ID}.IMPORT_ROOT             = ${${PLUGIN.ID}.IMPORT_ROOT}")
	dk_echo("${PLUGIN.ID}.IMPORT_NAME             = ${${PLUGIN.ID}.IMPORT_NAME}")
	dk_echo("${PLUGIN.ID}.IMPORT_PATH             = ${${PLUGIN.ID}.IMPORT_PATH}")
	dk_echo("${PLUGIN.ID}.INSTALL_ROOT            = ${${PLUGIN.ID}.INSTALL_ROOT}")
	dk_echo("${PLUGIN.ID}.INSTALL_NAME            = ${${PLUGIN.ID}.INSTALL_NAME}")
	dk_echo("${PLUGIN.ID}.INSTALL_PATH            = ${${PLUGIN.ID}.INSTALL_PATH}")
	dk_echo("${PLUGIN.ID}.VERSION                 = ${${PLUGIN.ID}.VERSION}")
	dk_echo("${PLUGIN.ID}.BRANCH                  = ${${PLUGIN.ID}.BRANCH}")
	dk_echo("${PLUGIN.ID}.TAG                     = ${${PLUGIN.ID}.TAG}")
	dk_echo("${PLUGIN.ID}.URL                     = ${${PLUGIN.ID}.URL}")
	dk_echo("${PLUGIN.ID}.URL_Filename            = ${${PLUGIN.ID}.URL_Filename}")
	dk_echo("${PLUGIN.ID}.URL_File                = ${${PLUGIN.ID}.URL_File}")
	dk_echo("${PLUGIN.ID}.URL_Extension           = ${${PLUGIN.ID}.URL_Extension}")
	dk_echo("${PLUGIN.ID}.URL_List                = ${${PLUGIN.ID}.URL_List}")
	dk_echo("${PLUGIN.ID}.URL_Array               = ${${PLUGIN.ID}.URL_Array}")
	dk_echo("${PLUGIN.ID}.URL_Length              = ${${PLUGIN.ID}.URL_Length}")
	dk_echo("${PLUGIN.ID}.GIT                     = ${${PLUGIN.ID}.GIT}")
	dk_echo("${PLUGIN.ID}.GIT_NAME                = ${${PLUGIN.ID}.GIT_NAME}")
	dk_echo("${PLUGIN.ID}.IMPORT                  = ${${PLUGIN.ID}.IMPORT}")
	dk_echo("${PLUGIN.ID}.IMPORT_NAME_Lower       = ${${PLUGIN.ID}.IMPORT_NAME_Lower}")
	dk_echo("${PLUGIN.ID}.IMPORT_NAME_Upper       = ${${PLUGIN.ID}.IMPORT_NAME_Upper}")	
	dk_echo("${PLUGIN.ID}.IMPORT_NAME_Alphanumeric= ${${PLUGIN.ID}.IMPORT_NAME_Alphanumeric}")
	dk_echo("${PLUGIN.ID}.Build_Dir               = ${${PLUGIN.ID}.Build_Dir}")
	dk_echo("${PLUGIN.ID}.Config_Dir              = ${${PLUGIN.ID}.Config_Dir}")
	dk_echo("${PLUGIN.ID}.Debug_Dir               = ${${PLUGIN.ID}.Debug_Dir}")
	dk_echo("${PLUGIN.ID}.Release_Dir             = ${${PLUGIN.ID}.Release_Dir}")
	dk_echo("${PLUGIN.ID}.Tuple_Dir               = ${${PLUGIN.ID}.Tuple_Dir}")
	dk_echo()
endfunction()
