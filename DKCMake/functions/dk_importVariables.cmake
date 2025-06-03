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


#if(NOT DEFINED dk_importVariables_DEBUG)
#	set(dk_importVariables_DEBUG 1)
#endif()
#################################################################################
# dk_importVariables(PLUGIN_URL) BRANCH FOLDER NAME _PATH_ ROOT TAG VERSION
#
#	PLUGIN_URL (arg0)					###### EXAMPLES ######
#	This url of the plugin to import.	https://github.com/madler/zlib.git     							* github repository link
#										https://github.com/madler/zlib/archive/refs/heads/master.zip	* github sourcecode download
#										https://github.com/madler/zlib        							* github page
#										https://zlib.net/zlib-1.3.1.tar.gz								* library sourcecode download
#										https://website.com/executable.exe              				* executable file
#
#	IMPORT_PATH (optional)
#										C:/Users/name/digitalknob/Development/3rdParty/_DKIMPORTS/zlib
#
#	BRANCH (optional)
#										develop
#										master
#
#	FOLDER (optional)
#										zlib-develop
#										zlib-master
#
#	NAME (optional)
#										zlib
#										myZLIB
#
#	PATH (optional)
#										C:/Users/name/digitalknob/Development/3rdParty/zlib-master
#										C:/Users/name/digitalknob/Development/3rdParty/myZLIB
#
#	ROOT (optional)
#										C:/Users/name/digitalknob/Development/3rdParty
#										C:/Users/name/MyLibraries
#
#	TAG (optional)
#										v1.3.1
#										v1.2.13
#
#	VERSION (optional)
#										master
#
function(dk_importVariables)
	dk_debugFunc()
	
	dk_unset(URL)
	set(URL ${ARGV0})
	dk_assertVar(URL)
	if(${dk_importVariables_DEBUG})
		dk_printVar(URL)
	endif()
	
	dk_unset(IMPORT_PATH)
	dk_getParameterValue(IMPORT_PATH) 	# C:/Users/name/digitalknob/Development/3rdParty/_DKIMPORTS/zlib
	if(${dk_importVariables_DEBUG})
		dk_printVar(IMPORT_PATH)
	endif()
	
	dk_unset(BRANCH)
	dk_getParameterValue(BRANCH) 		# master
	if(${dk_importVariables_DEBUG})
		dk_printVar(BRANCH)
	endif()
	
	dk_unset(FOLDER)
	dk_getParameterValue(FOLDER)		# zlib-master
	if(${dk_importVariables_DEBUG})
		dk_printVar(FOLDER)
	endif()
	
	dk_unset(NAME)
	dk_getParameterValue(NAME)			# zlib
	if(${dk_importVariables_DEBUG})
		dk_printVar(NAME)
	endif()
	
	dk_unset(_PATH_)
	dk_getParameterValue(_PATH_)		# C:/Users/name/digitalknob/Development/3rdParty/zlib-master
	if(${dk_importVariables_DEBUG})
		dk_printVar(_PATH_)
	endif()
	
	dk_unset(ROOT)
	dk_getParameterValue(ROOT)			# C:/Users/name/digitalknob/Development/3rdParty
	if(${dk_importVariables_DEBUG})
		dk_printVar(ROOT)
	endif()
	
	dk_unset(TAG)
	dk_getParameterValue(TAG)			# v1.3.1
	if(${dk_importVariables_DEBUG})
		dk_printVar(TAG)
	endif()
	
	dk_unset(VERSION)
	dk_getParameterValue(VERSION)		# master
	if(${dk_importVariables_DEBUG})
		dk_printVar(VERSION)
	endif()
	
	
### POPULATE VARIABLES ###
# PLUGIN_URL				- from arg:URL													  	: https://github.com/madler/zlib/archive/refs/heads/master.zip
# PLUGIN_URL_LIST			- from PLUGIN_URL											 		: https:;github.com;madler;zlib;archive;refs;heads;master.zip
# PLUGIN_URL_LENGTH			- from PLUGIN_URL_LIST												: 8
# PLUGIN_URL_NODE(n)		- from PLUGIN_URL_LIST												: [0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip
# PLUGIN_URL_FILENAME   	- from PLUGIN_URL													: master.zip
# PLUGIN_URL_EXTENSION  	- from PLUGIN_URL_FILENAME											: .zip
# PLUGIN_URL_FILE      		- from PLUGIN_URL_FILENAME											: master
	
# PLUGIN_IMPORT				- from CMAKE_CURRENT_LIST_DIR										: 1
# PLUGIN_IMPORT_PATH		- from CMAKE_CURRENT_LIST_DIR										: C:\Users\name\digitalknob\Development\3rdParty\_DKIMPORTS\zlib
# PLUGIN_IMPORT_NAME		- from PLUGIN_IMPORT_PATH											: zlib

# PLUGIN_GIT				- from PLUGIN_URL													: 1
# PLUGIN_GIT_FILENAME		- from PLUGIN_URL													: zlib
# PLUGIN_GIT_NAME			- from PLUGIN_GIT_FILENAME											: zlib
# PLUGIN_GIT_BRANCH			- from default:master OR arg:BRANCH									: master
# PLUGIN_GIT_TAG			- from default: OR arg:TAG
	
# PLUGIN_INSTALL_NAME		- from PLUGIN_IMPORT_NAME, PLUGIN_GIT_NAME or PLUGIN_URL_NAME		: zlib
# PLUGIN_INSTALL_VERSION	- from PLUGIN_URL_FILE and PLUGIN_IMPORT_NAME						: master
# PLUGIN_INSTALL_FOLDER     - from PLUGIN_INSTALL_NAME amd PLUGIN_INSTALL_VERSION				: zlib-master
# PLUGIN_INSTALL_ROOT		- from default:DK3RDPARTY OR arg:ROOT								: C:/Users/name/digitalknob/Development/3rdParty
# PLUGIN_INSTALL_PATH		- from PLUGIN_INSTALL_ROOT and PLUGIN_INSTALL_FOLDER				: C:/Users/name/digitalknob/Development/3rdParty/zlib-master
	
# <PLUGIN>					- from PLUGIN_IMPORT_NAME						:ZLIB   			: C:/Users/name/digitalknob/Development/3rdParty/zlib-master
# <CURRENT_PLUGIN>			- from <PLUGIN>									:ZLIB				: C:/Users/name/digitalknob/Development/3rdParty/zlib-master
# <PLUGIN>_DIR				- from PLUGIN_INSTALL_PATH						:ZLIB_DIR			: C:/Users/name/digitalknob/Development/3rdParty/zlib-master
# <PLUGIN>_URL				- from PLUGIN_URL								:ZLIB_URL			: https://github.com/madler/zlib/archive/refs/heads/master.zip
# <PLUGIN>_IMPORT_FILE			- from PLUGIN_URL_FILENAME						:ZLIB_IMPORT_FILE		: master.zip
# <PLUGIN>_VERSION          - from PLUGIN_INSTALL_VERSION					:ZLIB_VERSION		: master
# <PLUGIN>_FOLDER			- from PLUGIN_INSTALL_FOLDER					:ZLIB_FOLDER		: zlib-master
# <PLUGIN>_IMPORT_NAME		- from PLUGIN_IMPORT_NAME						:ZLIB_IMPORT_NAME	: zlib
# <PLUGIN>_BRANCH			- from PLUGIN_GIT_BRANCH						:ZLIB_BRANCH		: master
# <PLUGIN>_TAG				- from PLUGIN_GIT_TAG							:ZLIB_TAG			: 
# <PLUGIN>_TUPLE_DIR		- from PLUGIN_INSTALL_PATH and Target_Tuple	:ZLIB_TUPLE_DIR	: C:/Users/name/digitalknob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
# <PLUGIN>_CONFIG_DIR		- from PLUGIN_INSTALL_PATH and CONFIG_DIR		:ZLIB_CONFIG_DIR	: C:/Users/name/digitalknob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
# <PLUGIN>_BUILD_DIR		- from PLUGIN_INSTALL_PATH and BUILD_DIR		:ZLIB_BUILD_DIR		: C:/Users/name/digitalknob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
# <PLUGIN>_DEBUG_DIR		- from PLUGIN_INSTALL_PATH and Debug_Dir		:ZLIB_DEBUG_DIR		: C:/Users/name/digitalknob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
# <PLUGIN>_RELEASE_DIR		- from PLUGIN_INSTALL_PATH and Release_Dir		:ZLIB_RELEASE_DIR	: :/Users/name/digitalknob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	
	
	##############################################
	############ PLUGIN_URL VARIABLES ############
	##############################################						################################# EXAMPLE ##########################
	# PLUGIN_URL
	dk_unset(PLUGIN_URL)
	set(PLUGIN_URL ${URL})	
	if(${dk_importVariables_DEBUG})
		dk_printVar(PLUGIN_URL)											# PLUGIN_URL: https://github.com/madler/zlib/archive/refs/heads/master.zip
	endif()
	
	# PLUGIN_URL_FILENAME
	dk_unset(PLUGIN_URL_FILENAME)
	dk_basename(${PLUGIN_URL} PLUGIN_URL_FILENAME)							
	if(${dk_importVariables_DEBUG})
		dk_printVar(PLUGIN_URL_FILENAME)								# PLUGIN_URL_FILENAME: master.zip
	endif()
	
	# PLUGIN_URL_LIST
	dk_unset(PLUGIN_URL_LIST)
	dk_replaceAll(${PLUGIN_URL}  "/"  ";"  PLUGIN_URL_LIST)					
	if(${dk_importVariables_DEBUG})
		dk_printVar(PLUGIN_URL_LIST)									# PLUGIN_URL_LIST: https:;github.com;madler;zlib;archive;refs;heads;master.zip
	endif()
	
	# PLUGIN_GIT
	dk_unset(PLUGIN_GIT)
	dk_includes(PLUGIN_URL "https://github.com")
	if(${dk_includes})
		set(PLUGIN_GIT 1)
	endif()		
	if(${dk_importVariables_DEBUG})
		dk_printVar(PLUGIN_GIT)											# PLUGIN_GIT: 1
	endif()
	
	# PLUGIN_URL_EXTENSION
	dk_unset(PLUGIN_URL_EXTENSION)
	dk_getExtension(${PLUGIN_URL_FILENAME} PLUGIN_URL_EXTENSION)			
	if(${dk_importVariables_DEBUG})
		dk_printVar(PLUGIN_URL_EXTENSION)								# PLUGIN_URL_EXTENSION: .zip
	endif()
	
	# PLUGIN_URL_FILE
	dk_unset(PLUGIN_URL_FILE)
	dk_removeExtension(${PLUGIN_URL_FILENAME} PLUGIN_URL_FILE)				
	if(${dk_importVariables_DEBUG})
		dk_printVar(PLUGIN_URL_FILE)									# PLUGIN_URL_FILE: master
	endif()
	
	# PLUGIN_URL_NODE(n)
	# split the url into list converting / to divider ;
	set(index 0)
	foreach(PLUGIN_URL_ITEM ${PLUGIN_URL_LIST})
		dk_unset(PLUGIN_URL_NODE${index})
		set(PLUGIN_URL_NODE${index} ${PLUGIN_URL_ITEM})						
		dk_printVar(PLUGIN_URL_NODE${index})							# PLUGIN_URL_NODE(n): [0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip
		math(EXPR index ${index}+1)
	endforeach()
	
	# PLUGIN_URL_LENGTH
	dk_unset(PLUGIN_URL_LENGTH)
	list(LENGTH PLUGIN_URL_LIST PLUGIN_URL_LENGTH)							
	if(${dk_importVariables_DEBUG})
		dk_printVar(PLUGIN_URL_LENGTH)									# PLUGIN_URL_LENGTH: 8
	endif()

	#######################################################
	############### PLUGIN_IMPORT VARIABLES ###############
	#######################################################
	if(NOT IMPORT_PATH)
		set(IMPORT_PATH "${CMAKE_CURRENT_LIST_DIR}")
	endif()
	if(${dk_importVariables_DEBUG})
		dk_printVar(IMPORT_PATH)
	endif()
	
	# PLUGIN_IMPORT
	dk_unset(PLUGIN_IMPORT)
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	if(IMPORT_PATH MATCHES "${DKIMPORTS_DIR}")
		set(PLUGIN_IMPORT 1)
	endif()	
	if(${dk_importVariables_DEBUG})
		dk_printVar(PLUGIN_IMPORT)										# PLUGIN_IMPORT: 1
	endif()
	
	# PLUGIN_IMPORT_PATH
	dk_unset(PLUGIN_IMPORT_PATH)
	if(IMPORT_PATH)
		set(PLUGIN_IMPORT_PATH "${IMPORT_PATH}")		
	endif()
	if(${dk_importVariables_DEBUG})
		dk_printVar(PLUGIN_IMPORT_PATH)									# PLUGIN_IMPORT_PATH: C:\Users\name\digitalknob\Development\3rdParty\_DKIMPORTS\zlib
	endif()
	
	# PLUGIN_IMPORT_DIR
	dk_dirname(${PLUGIN_IMPORT_PATH} PLUGIN_IMPORT_DIR)
	if(${dk_importVariables_DEBUG})
		dk_printVar(PLUGIN_IMPORT_DIR)
	endif()
	
	# PLUGIN_IMPORT_NAME
	dk_unset(PLUGIN_IMPORT_NAME)
	if("${PLUGIN_IMPORT_DIR}" STREQUAL "${DKIMPORTS_DIR}")
		dk_basename(${PLUGIN_IMPORT_PATH} PLUGIN_IMPORT_NAME)		
	elseif(NAME)
		#dk_fixme("PLUGIN_IMPORT_NAME is the parent folder name only if the next parent folder is _DKIMPORTS")
		set(PLUGIN_IMPORT_NAME ${NAME})
	else()
		set(PLUGIN_IMPORT_NAME ${PLUGIN_URL_FILE})
	endif()
	if(${dk_importVariables_DEBUG})
		dk_printVar(PLUGIN_IMPORT_NAME)									# PLUGIN_IMPORT_NAME: zLib	
	endif()
	
	# PLUGIN_IMPORT_NAME_LOWER
	dk_unset(PLUGIN_IMPORT_NAME_LOWER)
	dk_toLower(${PLUGIN_IMPORT_NAME} PLUGIN_IMPORT_NAME_LOWER)
	if(${dk_importVariables_DEBUG})
		dk_printVar(PLUGIN_IMPORT_NAME_LOWER)							# PLUGIN_IMPORT_NAME_LOWER: zlib
	endif()
	
	# PLUGIN_IMPORT_NAME_UPPER
	dk_unset(PLUGIN_IMPORT_NAME_UPPER)
	dk_toUpper(${PLUGIN_IMPORT_NAME} PLUGIN_IMPORT_NAME_UPPER)
	dk_assertVar(PLUGIN_IMPORT_NAME_UPPER)
	if(${dk_importVariables_DEBUG})
		dk_printVar(PLUGIN_IMPORT_NAME_UPPER)							# PLUGIN_IMPORT_NAME_UPPER: ZLIB
	endif()
	
	##############################################
	############ PLUGIN_GIT VARIABLES ############
	##############################################
	if(PLUGIN_GIT)
		# PLUGIN_GIT_FILENAME
		dk_unset(PLUGIN_GIT_FILENAME)
		list(GET PLUGIN_URL_LIST 3 PLUGIN_GIT_FILENAME)										
		if(${dk_importVariables_DEBUG})
			dk_printVar(PLUGIN_GIT_FILENAME)							# PLUGIN_GIT_FILENAME: zlib
		endif()
		
		# PLUGIN_GIT_NAME
		dk_unset(PLUGIN_GIT_NAME)
		dk_replaceAll(${PLUGIN_GIT_FILENAME} ".git" "" PLUGIN_GIT_NAME)			
		if(${dk_importVariables_DEBUG})
			dk_printVar(PLUGIN_GIT_NAME)								# PLUGIN_GIT_NAME: zlib
		endif()
		
		# PLUGIN_GIT_NAME_LOWER
		dk_unset(PLUGIN_GIT_NAME_LOWER)
		dk_toLower(${PLUGIN_GIT_NAME} 		PLUGIN_GIT_NAME_LOWER)
		if(${dk_importVariables_DEBUG})
			dk_printVar(PLUGIN_GIT_NAME_LOWER)							# PLUGIN_GIT_NAME_LOWER: zlib
		endif()
		
		# PLUGIN_GIT_BRANCH
		dk_unset(PLUGIN_GIT_BRANCH)
		if(BRANCH)
			set(PLUGIN_GIT_BRANCH ${BRANCH})
		endif()
		#dk_getGitBranchName(${PLUGIN_URL} PLUGIN_GIT_BRANCH)					
		if(NOT PLUGIN_GIT_BRANCH)
			set(PLUGIN_GIT_BRANCH master)
		endif()
		if(${dk_importVariables_DEBUG})
			dk_printVar(PLUGIN_GIT_BRANCH)								# PLUGIN_GIT_BRANCH: master
		endif()
		
		# PLUGIN_GIT_TAG
		dk_unset(PLUGIN_GIT_TAG)
		if(TAG)
			set(PLUGIN_GIT_TAG ${TAG})
		endif()
		if(${dk_importVariables_DEBUG})
			dk_printVar(PLUGIN_GIT_TAG)									# PLUGIN_GIT_TAG: master
		endif()
	endif()

	
	##################################################
	############ PLUGIN_INSTALL VARIABLES ############
	##################################################
	# PLUGIN_INSTALL_NAME
	dk_unset(PLUGIN_INSTALL_NAME)
	if(NAME)
		set(PLUGIN_INSTALL_NAME ${NAME})
	elseif(PLUGIN_IMPORT_NAME)
		set(PLUGIN_INSTALL_NAME ${PLUGIN_IMPORT_NAME})
	elseif(PLUGIN_GIT_NAME)
		set(PLUGIN_INSTALL_NAME ${PLUGIN_GIT_NAME})
	elseif(PLUGIN_URL_NAME)
		set(PLUGIN_INSTALL_NAME ${PLUGIN_URL_NAME})							
	endif()
	#dk_convertToCIdentifier(${PLUGIN_INSTALL_NAME} PLUGIN_INSTALL_NAME)
	if(${dk_importVariables_DEBUG})
		dk_printVar(PLUGIN_INSTALL_NAME)								# PLUGIN_INSTALL_NAME: zlib
	endif()
	
	# PLUGIN_INSTALL_VERSION
	dk_unset(PLUGIN_INSTALL_VERSION)
	if(VERSION)
		set(PLUGIN_INSTALL_VERSION ${VERSION})
	elseif(PLUGIN_IMPORT_NAME AND PLUGIN_URL_FILE)
		dk_toLower(${PLUGIN_IMPORT_NAME} PLUGIN_IMPORT_NAME_LOWER)	
		dk_toLower(${PLUGIN_URL_FILE}    PLUGIN_URL_FILE_LOWER)
		# calculate the plugin version		
		dk_replaceAll(${PLUGIN_URL_FILE_LOWER} ${PLUGIN_IMPORT_NAME_LOWER} "" PLUGIN_INSTALL_VERSION)	
		if(${PLUGIN_IMPORT_NAME_LOWER} STREQUAL ${PLUGIN_URL_FILE_LOWER})
			if(PLUGIN_GIT_TAG)
				set(PLUGIN_INSTALL_VERSION ${PLUGIN_GIT_TAG})
			elseif(PLUGIN_GIT_BRANCH)
				set(PLUGIN_INSTALL_VERSION ${PLUGIN_GIT_BRANCH})
			else()
				set(PLUGIN_INSTALL_VERSION master)
			endif()
		endif()

		string(FIND ${PLUGIN_INSTALL_VERSION} - index)
		if(${index} EQUAL 0)
			string(SUBSTRING ${PLUGIN_INSTALL_VERSION} 1 -1 PLUGIN_INSTALL_VERSION)
		endif()
			
		string(FIND ${PLUGIN_INSTALL_VERSION} _ index)
		if(${index} EQUAL 0)
			string(SUBSTRING ${PLUGIN_INSTALL_VERSION} 1 -1 PLUGIN_INSTALL_VERSION)
		endif()
	endif()
	if(NOT PLUGIN_INSTALL_VERSION)
		set(PLUGIN_INSTALL_VERSION "UNKNOWN")
	endif()
	if(${dk_importVariables_DEBUG})
		dk_printVar(PLUGIN_INSTALL_VERSION)								# PLUGIN_INSTALL_VERSION: master
	endif()
	
	# PLUGIN_INSTALL_FOLDER
	dk_unset(PLUGIN_INSTALL_FOLDER)
	if(FOLDER)
		set(PLUGIN_INSTALL_FOLDER ${FOLDER})
	elseif(PLUGIN_INSTALL_VERSION)
		set(PLUGIN_INSTALL_FOLDER ${PLUGIN_INSTALL_NAME}-${PLUGIN_INSTALL_VERSION})
	else()
		set(PLUGIN_INSTALL_FOLDER ${PLUGIN_INSTALL_NAME})
	endif()
	if(${dk_importVariables_DEBUG})
		dk_printVar(PLUGIN_INSTALL_FOLDER)								# PLUGIN_INSTALL_FOLDER: zlib-master
	endif()
	
	# PLUGIN_INSTALL_ROOT
	dk_unset(PLUGIN_INSTALL_ROOT)
	if(ROOT)
		set(PLUGIN_INSTALL_ROOT "${ROOT}")
		dk_unset(ROOT)
	else()
		dk_assertPath(${DK3RDPARTY_DIR})
		set(PLUGIN_INSTALL_ROOT ${DK3RDPARTY_DIR})
	endif()
	if(${dk_importVariables_DEBUG})
		dk_printVar(PLUGIN_INSTALL_ROOT)								# PLUGIN_INSTALL_ROOT: C:/Users/name/digitalknob/Development/3rdParty
	endif()
	
	# PLUGIN_INSTALL_PATH
	dk_unset(PLUGIN_INSTALL_PATH)
	if(_PATH_)
		set(PLUGIN_INSTALL_PATH ${_PATH_})
	else()
		#dk_assertPath(PLUGIN_INSTALL_ROOT)	
		#dk_assertVar(PLUGIN_INSTALL_FOLDER)
		set(PLUGIN_INSTALL_PATH ${PLUGIN_INSTALL_ROOT}/${PLUGIN_INSTALL_FOLDER})			
	endif()
	if(${dk_importVariables_DEBUG})
		dk_printVar(PLUGIN_INSTALL_PATH)								# PLUGIN_INSTALL_PATH: C:/Users/name/digitalknob/Development/3rdParty/zlib-master
	endif()
	
	
	
	##############################################
	############# <PLUGIN>_VARIABLES #############
	##############################################
	###### Print the current plugin to the window title bar ######
	if(NOT DEFINED ENV{CURRENT_PLUGIN})
		dk_envList(PLUGIN PUSH "${PLUGIN_IMPORT_NAME_UPPER}")
		#dk_set(CURRENT_PLUGIN "${PLUGIN_IMPORT_NAME_UPPER}")
	endif()
	dk_set(CURRENT_PLUGIN "$ENV{CURRENT_PLUGIN}")
	dk_assertVar(CURRENT_PLUGIN)
	if(${dk_importVariables_DEBUG})
		dk_printVar(CURRENT_PLUGIN)	
	endif()
	
	message("############# ${CURRENT_PLUGIN}_VARIABLES #############")
	if(PLUGIN_IMPORT_NAME_LOWER AND PLUGIN_GIT_NAME_LOWER)
		if(NOT "${PLUGIN_IMPORT_NAME_LOWER}" STREQUAL "${PLUGIN_GIT_NAME_LOWER}")
			dk_warning("PLUGIN_IMPORT_NAME:${PLUGIN_IMPORT_NAME_LOWER} and PLUGIN_GIT_NAME:${PLUGIN_GIT_NAME_LOWER} do not match ")
		endif()
	endif()

	### NOTE:
	#	We may wish to create a PLUGIN_STACK to hold a referece to out plugin order. If and when plugins are built nested inside eachother at 
	#   multiple levels, we'll need to keep up with the current position in the stack. 
	#	For example, libpng depends on zlib. We import libpng, CURRENT_PLUGIN is LIBPNG. Inside libpng's build script we depend on zlib. 
	#   Now the CURRENT_PLUGIN is ZLIB. Zlib get's configured and built and returns back the libpng to configure, problem is CURRENT_PLUGIN is still ZLIB.
	#   So we need to pop zlib off of the stack when it completes so out CURRENT_PLUGIN points back to libpng. Currently dk_importVariables is how we
	#   push the current plugin to the stack, we just need to find a good place to pop from the stack.
	
	# <PLUGIN>
	dk_unset(${CURRENT_PLUGIN})
	dk_set(${CURRENT_PLUGIN} "${PLUGIN_INSTALL_PATH}")
	dk_assertVar(CURRENT_PLUGIN)
	if(${dk_importVariables_DEBUG})
		dk_printVar(CURRENT_PLUGIN)										# ZLIB: C:/Users/name/digitalknob/Development/3rdParty/zlib-master
	endif()
	
	# <PLUGIN>_DIR      ### DO NOT USE GIT_DIR ###
	dk_unset(${CURRENT_PLUGIN}_DIR)
	if(NOT "${CURRENT_PLUGIN}" STREQUAL "GIT")
		dk_set(${CURRENT_PLUGIN}_DIR ${PLUGIN_INSTALL_PATH})
	endif()
	if(${dk_importVariables_DEBUG})
		dk_printVar(${CURRENT_PLUGIN}_DIR)								# ZLIB_DIR: C:/Users/name/digitalknob/Development/3rdParty/zlib-master
	endif()
	
	# <PLUGIN>_URL
	dk_unset(${CURRENT_PLUGIN}_URL)
	dk_set(${CURRENT_PLUGIN}_URL ${PLUGIN_URL})
	if(${dk_importVariables_DEBUG})
		dk_printVar(${CURRENT_PLUGIN}_URL)								# ZLIB_URL: https://github.com/madler/zlib/archive/refs/heads/master.zip
	endif()
	
	# <PLUGIN>_IMPORT_FILE
	dk_unset(${CURRENT_PLUGIN}_IMPORT_FILE)
	dk_set(${CURRENT_PLUGIN}_IMPORT_FILE ${PLUGIN_URL_FILENAME})
	if(${dk_importVariables_DEBUG})
		dk_printVar(${CURRENT_PLUGIN}_IMPORT_FILE)						# ZLIB_IMPORT_FILE: master.zip
	endif()
	
	# <PLUGIN>_VERSION
	dk_unset(${CURRENT_PLUGIN}_VERSION)
	dk_set(${CURRENT_PLUGIN}_VERSION ${PLUGIN_INSTALL_VERSION})
	if(${dk_importVariables_DEBUG})
		dk_printVar(${CURRENT_PLUGIN}_VERSION)							# ZLIB_VERSION: master
	endif()
	
	# <PLUGIN>_FOLDER
	dk_unset(${CURRENT_PLUGIN}_FOLDER)
	dk_set(${CURRENT_PLUGIN}_FOLDER ${PLUGIN_INSTALL_FOLDER})
	if(${dk_importVariables_DEBUG})
		dk_printVar(${CURRENT_PLUGIN}_FOLDER)							# ZLIB_FOLDER: zlib-master	
	endif()
	
	# <PLUGIN>_IMPORT_NAME
	dk_unset(${CURRENT_PLUGIN}_IMPORT_NAME)
	dk_set(${CURRENT_PLUGIN}_IMPORT_NAME ${PLUGIN_IMPORT_NAME_LOWER})
	if(${dk_importVariables_DEBUG})
		dk_printVar(${CURRENT_PLUGIN}_IMPORT_NAME)						# ZLIB_IMPORT_NAME: zlib
	endif()
	
	# <PLUGIN>_BRANCH
	dk_unset(${CURRENT_PLUGIN}_BRANCH)
	if(PLUGIN_GIT_BRANCH)
		dk_set(${CURRENT_PLUGIN}_BRANCH ${PLUGIN_GIT_BRANCH})
	endif()
	if(${dk_importVariables_DEBUG})
		dk_printVar(${CURRENT_PLUGIN}_BRANCH)							# ZLIB_BRANCH: master
	endif()
	
	# <PLUGIN>_TAG
	dk_unset(${CURRENT_PLUGIN}_TAG)
	if(PLUGIN_GIT_TAG)
		dk_set(${CURRENT_PLUGIN}_TAG ${PLUGIN_GIT_TAG})
	endif()
	if(${dk_importVariables_DEBUG})
		dk_printVar(${CURRENT_PLUGIN}_TAG)								# ZLIB_TAG:
	endif()
	
	
	#####################################################
	############# TARGET <PLUGIN>_VARIABLES #############
	#####################################################
	# These variables require a Target_Tuple
#	if(NOT Target_Tuple)
#		return()
#	endif()
	
	# <PLUGIN>_TUPLE_DIR
	dk_unset(${CURRENT_PLUGIN}_TUPLE_DIR)
#	dk_validate(Target_Tuple "dk_Target_Tuple()")
	if(Target_Tuple)
		dk_set(${CURRENT_PLUGIN}_TUPLE_DIR ${PLUGIN_INSTALL_PATH}/${Target_Tuple})
	endif()
	if(${dk_importVariables_DEBUG})
		dk_printVar(${CURRENT_PLUGIN}_TUPLE_DIR)						# ZLIB_TUPLE_DIR: C:/Users/name/digitalknob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	endif()
	
	# <PLUGIN>_CONFIG_DIR
	dk_unset(${CURRENT_PLUGIN}_CONFIG_DIR)
#	dk_validate(Config_Path "dk_Config_Path()")
	if(Config_Path)
		dk_set(${CURRENT_PLUGIN}_CONFIG_DIR ${PLUGIN_INSTALL_PATH}/${Config_Path})
	endif()
	if(${dk_importVariables_DEBUG})
		dk_printVar(${CURRENT_PLUGIN}_CONFIG_DIR)						# ZLIB_CONFIG_DIR: C:/Users/user/digitalknob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	endif()
	
	# <PLUGIN>_BUILD_DIR
	dk_unset(${CURRENT_PLUGIN}_BUILD_DIR)
#	dk_validate(BUILD_PATH "dk_Config_Path()")
	if(BUILD_PATH)
		dk_set(${CURRENT_PLUGIN}_BUILD_DIR ${PLUGIN_INSTALL_PATH}/${BUILD_PATH})
	endif()	
	if(${dk_importVariables_DEBUG})
		dk_printVar(${CURRENT_PLUGIN}_BUILD_DIR)						# ZLIB_BUILD_DIR: C:/Users/name/digitalknob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	endif()
	
	# <PLUGIN>_DEBUG_DIR
	dk_unset(${CURRENT_PLUGIN}_DEBUG_DIR)
	if(Debug_Dir)
		dk_set(${CURRENT_PLUGIN}_DEBUG_DIR ${PLUGIN_INSTALL_PATH}/${Target_Tuple}/${Debug_Dir})
	endif()
	if(${dk_importVariables_DEBUG})
		dk_printVar(${CURRENT_PLUGIN}_DEBUG_DIR)						# ZLIB_DEBUG_DIR: C:/Users/name/digitalknob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	endif()
	
	# <PLUGIN>_RELEASE_DIR
	dk_unset(${CURRENT_PLUGIN}_RELEASE_DIR)
	if(Release_Dir)
		dk_set(${CURRENT_PLUGIN}_RELEASE_DIR ${PLUGIN_INSTALL_PATH}/${Target_Tuple}/${Release_Dir})
	endif()	
	if(${dk_importVariables_DEBUG})
		dk_printVar(${CURRENT_PLUGIN}_RELEASE_DIR)						# ZLIB_RELEASE_DIR: C:/Users/name/digitalknob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	endif()
endfunction()














###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_importVariables("https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe"  NAME git   ROOT ${DKTOOLS_DIR})
endfunction()
