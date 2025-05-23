#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

#################################################################################
# dk_importVariables(PLUGIN_URL) BRANCH FOLDER NAME PATH ROOT TAG VERSION
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
	
	set(URL ${ARGV0})
	dk_assertVar(URL)
#	dk_printVar(URL)
	
	unset(IMPORT_PATH)
	dk_getOptionValue(IMPORT_PATH) 	# C:/Users/name/digitalknob/Development/3rdParty/_DKIMPORTS/zlib
#	dk_printVar(IMPORT_PATH)
	
	unset(BRANCH)
	dk_getOptionValue(BRANCH) 		# master
#	dk_printVar(BRANCH)
	
	unset(FOLDER)
	dk_getOptionValue(FOLDER)		# zlib-master
#	dk_printVar(FOLDER)
	
	unset(NAME)
	dk_getOptionValue(NAME)			# zlib
	dk_printVar(NAME)
	
	unset(PATH)
	dk_getOptionValue(PATH)			# C:/Users/name/digitalknob/Development/3rdParty/zlib-master
#	dk_printVar(PATH)
	
	unset(ROOT)
	dk_getOptionValue(ROOT)			# C:/Users/name/digitalknob/Development/3rdParty
#	dk_printVar(ROOT)
	
	unset(TAG)
	dk_getOptionValue(TAG)			# v1.3.1
#	dk_printVar(TAG)
	
	unset(VERSION)
	dk_getOptionValue(VERSION)		# master
#	dk_printVar(VERSION)
	
	
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
# <PLUGIN>_DL_FILE			- from PLUGIN_URL_FILENAME						:ZLIB_DL_FILE		: master.zip
# <PLUGIN>_VERSION          - from PLUGIN_INSTALL_VERSION					:ZLIB_VERSION		: master
# <PLUGIN>_FOLDER			- from PLUGIN_INSTALL_FOLDER					:ZLIB_FOLDER		: zlib-master
# <PLUGIN>_IMPORT_NAME		- from PLUGIN_IMPORT_NAME						:ZLIB_IMPORT_NAME	: zlib
# <PLUGIN>_BRANCH			- from PLUGIN_GIT_BRANCH						:ZLIB_BRANCH		: master
# <PLUGIN>_TAG				- from PLUGIN_GIT_TAG							:ZLIB_TAG			: 
# <PLUGIN>_TRIPLE_DIR		- from PLUGIN_INSTALL_PATH and target_triple	:ZLIB_TRIPLE_DIR	: C:/Users/name/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang
# <PLUGIN>_CONFIG_DIR		- from PLUGIN_INSTALL_PATH and CONFIG_DIR		:ZLIB_CONFIG_DIR	: C:/Users/name/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
# <PLUGIN>_BUILD_DIR		- from PLUGIN_INSTALL_PATH and BUILD_DIR		:ZLIB_BUILD_DIR		: C:/Users/name/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
# <PLUGIN>_DEBUG_DIR		- from PLUGIN_INSTALL_PATH and DEBUG_DIR		:ZLIB_DEBUG_DIR		: C:/Users/name/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
# <PLUGIN>_RELEASE_DIR		- from PLUGIN_INSTALL_PATH and RELEASE_DIR		:ZLIB_RELEASE_DIR	: :/Users/name/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Release
	
	
	##############################################
	############ PLUGIN_URL VARIABLES ############
	##############################################						################################# EXAMPLE ##########################
	# PLUGIN_URL
	unset(PLUGIN_URL)
	set(PLUGIN_URL ${URL})	
#	dk_printVar(PLUGIN_URL)												# PLUGIN_URL: https://github.com/madler/zlib/archive/refs/heads/master.zip
	
	# PLUGIN_URL_FILENAME
	unset(PLUGIN_URL_FILENAME)
	dk_basename(${PLUGIN_URL} PLUGIN_URL_FILENAME)							
#	dk_printVar(PLUGIN_URL_FILENAME)									# PLUGIN_URL_FILENAME: master.zip
	
	# PLUGIN_URL_LIST
	unset(PLUGIN_URL_LIST)
	dk_replaceAll(${PLUGIN_URL}  "/"  ";"  PLUGIN_URL_LIST)					
#	dk_printVar(PLUGIN_URL_LIST)										# PLUGIN_URL_LIST: https:;github.com;madler;zlib;archive;refs;heads;master.zip
	
	# PLUGIN_GIT
	unset(PLUGIN_GIT)
	dk_includes(PLUGIN_URL "https://github.com")
	if(${dk_includes})
		set(PLUGIN_GIT 1)
	endif()		
#	dk_printVar(PLUGIN_GIT)												# PLUGIN_GIT: 1
	
	# PLUGIN_URL_EXTENSION
	unset(PLUGIN_URL_EXTENSION)
	dk_getExtension(${PLUGIN_URL_FILENAME} PLUGIN_URL_EXTENSION)			
#	dk_printVar(PLUGIN_URL_EXTENSION)									# PLUGIN_URL_EXTENSION: .zip

	# PLUGIN_URL_FILE
	unset(PLUGIN_URL_FILE)
	dk_removeExtension(${PLUGIN_URL_FILENAME} PLUGIN_URL_FILE)				
#	dk_printVar(PLUGIN_URL_FILE)										# PLUGIN_URL_FILE: master

	# PLUGIN_URL_NODE(n)
	# split the url into list converting / to divider ;
	set(index 0)
	foreach(PLUGIN_URL_ITEM ${PLUGIN_URL_LIST})
		unset(PLUGIN_URL_NODE${index})
		set(PLUGIN_URL_NODE${index} ${PLUGIN_URL_ITEM})						
#		dk_printVar(PLUGIN_URL_NODE${index})							# PLUGIN_URL_NODE(n): [0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip
		math(EXPR index ${index}+1)
	endforeach()
	
	# PLUGIN_URL_LENGTH
	unset(PLUGIN_URL_LENGTH)
	list(LENGTH PLUGIN_URL_LIST PLUGIN_URL_LENGTH)							
#	dk_printVar(PLUGIN_URL_LENGTH)										# PLUGIN_URL_LENGTH: 8
	

	#######################################################
	############### PLUGIN_IMPORT VARIABLES ###############
	#######################################################
	if(NOT IMPORT_PATH)
		set(IMPORT_PATH "${CMAKE_CURRENT_LIST_DIR}")
	endif()
#	dk_printVar(IMPORT_PATH)
	
	# PLUGIN_IMPORT
	unset(PLUGIN_IMPORT)
	dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
	if(IMPORT_PATH MATCHES "$ENV{DKIMPORTS_DIR}")
		set(PLUGIN_IMPORT 1)
	endif()	
#	dk_printVar(PLUGIN_IMPORT)											# PLUGIN_IMPORT: 1
	
	# PLUGIN_IMPORT_PATH
	unset(PLUGIN_IMPORT_PATH)
	if(IMPORT_PATH)
		set(PLUGIN_IMPORT_PATH "${IMPORT_PATH}")		
	endif()
#	dk_printVar(PLUGIN_IMPORT_PATH)										# PLUGIN_IMPORT_PATH: C:\Users\name\digitalknob\Development\3rdParty\_DKIMPORTS\zlib

	# PLUGIN_IMPORT_NAME
	unset(PLUGIN_IMPORT_NAME)
	dk_dirname(${PLUGIN_IMPORT_PATH} PLUGIN_IMPORT_DIR)
#	dk_printVar(PLUGIN_IMPORT_DIR)
	if("${PLUGIN_IMPORT_DIR}" STREQUAL "$ENV{DKIMPORTS_DIR}")
		dk_basename(${PLUGIN_IMPORT_PATH} PLUGIN_IMPORT_NAME)		
	elseif(NAME)
		#dk_fixme("PLUGIN_IMPORT_NAME is the parent folder name only if the next parent folder is _DKIMPORTS")
		set(PLUGIN_IMPORT_NAME ${NAME})
	else()
		set(PLUGIN_IMPORT_NAME ${PLUGIN_URL_FILE})
	endif()
#	dk_printVar(PLUGIN_IMPORT_NAME)										# PLUGIN_IMPORT_NAME: zLib	
	
	# PLUGIN_IMPORT_NAME_LOWER
	unset(PLUGIN_IMPORT_NAME_LOWER)
	dk_toLower(${PLUGIN_IMPORT_NAME} PLUGIN_IMPORT_NAME_LOWER)
#	dk_printVar(PLUGIN_IMPORT_NAME_LOWER)								# PLUGIN_IMPORT_NAME_LOWER: zlib
	
	# PLUGIN_IMPORT_NAME_UPPER
	unset(PLUGIN_IMPORT_NAME_UPPER)
	dk_toUpper(${PLUGIN_IMPORT_NAME} PLUGIN_IMPORT_NAME_UPPER)
#	dk_printVar(PLUGIN_IMPORT_NAME_UPPER)								# PLUGIN_IMPORT_NAME_UPPER: ZLIB
	
	##############################################
	############ PLUGIN_GIT VARIABLES ############
	##############################################
	if(PLUGIN_GIT)
		# PLUGIN_GIT_FILENAME
		unset(PLUGIN_GIT_FILENAME)
		list(GET PLUGIN_URL_LIST 3 PLUGIN_GIT_FILENAME)										
		dk_printVar(PLUGIN_GIT_FILENAME)								# PLUGIN_GIT_FILENAME: zlib
		
		# PLUGIN_GIT_NAME
		unset(PLUGIN_GIT_NAME)
		dk_replaceAll(${PLUGIN_GIT_FILENAME} ".git" "" PLUGIN_GIT_NAME)			
#		dk_printVar(PLUGIN_GIT_NAME)									# PLUGIN_GIT_NAME: zlib
		
		# PLUGIN_GIT_NAME_LOWER
		unset(PLUGIN_GIT_NAME_LOWER)
		dk_toLower(${PLUGIN_GIT_NAME} 		PLUGIN_GIT_NAME_LOWER)
#		dk_printVar(PLUGIN_GIT_NAME_LOWER)								# PLUGIN_GIT_NAME_LOWER: zlib
		
		# PLUGIN_GIT_BRANCH
		unset(PLUGIN_GIT_BRANCH)
		if(BRANCH)
			set(PLUGIN_GIT_BRANCH ${BRANCH})
		endif()
		#dk_getGitBranchName(${PLUGIN_URL} PLUGIN_GIT_BRANCH)					
		if(NOT PLUGIN_GIT_BRANCH)
			set(PLUGIN_GIT_BRANCH master)
		endif()
#		dk_printVar(PLUGIN_GIT_BRANCH)									# PLUGIN_GIT_BRANCH: master
		
		# PLUGIN_GIT_TAG
		unset(PLUGIN_GIT_TAG)
		if(TAG)
			set(PLUGIN_GIT_TAG ${TAG})
		endif()
	endif()

	
	##################################################
	############ PLUGIN_INSTALL VARIABLES ############
	##################################################
	# PLUGIN_INSTALL_NAME
	unset(PLUGIN_INSTALL_NAME)
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
#	dk_printVar(PLUGIN_INSTALL_NAME)									# PLUGIN_INSTALL_NAME: zlib

	# PLUGIN_INSTALL_VERSION
	unset(PLUGIN_INSTALL_VERSION)
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
	dk_printVar(PLUGIN_INSTALL_VERSION)									# PLUGIN_INSTALL_VERSION: master

	# PLUGIN_INSTALL_FOLDER
	unset(PLUGIN_INSTALL_FOLDER)
	if(FOLDER)
		set(PLUGIN_INSTALL_FOLDER ${FOLDER})
	elseif(PLUGIN_INSTALL_VERSION)
		set(PLUGIN_INSTALL_FOLDER ${PLUGIN_INSTALL_NAME}-${PLUGIN_INSTALL_VERSION})
	else()
		set(PLUGIN_INSTALL_FOLDER ${PLUGIN_INSTALL_NAME})
	endif()
	dk_printVar(PLUGIN_INSTALL_FOLDER)									# PLUGIN_INSTALL_FOLDER: zlib-master

	# PLUGIN_INSTALL_ROOT
	unset(PLUGIN_INSTALL_ROOT)
	if(ROOT)
		set(PLUGIN_INSTALL_ROOT "${ROOT}")
		unset(ROOT)
	else()
		dk_assertPath($ENV{DK3RDPARTY_DIR})
		set(PLUGIN_INSTALL_ROOT $ENV{DK3RDPARTY_DIR})
	endif()
	dk_printVar(PLUGIN_INSTALL_ROOT)									# PLUGIN_INSTALL_ROOT: C:/Users/name/digitalknob/Development/3rdParty

	# PLUGIN_INSTALL_PATH
	unset(PLUGIN_INSTALL_PATH)
	if(PATH)
		set(PLUGIN_INSTALL_PATH ${PATH})
	else()
		#dk_assertPath(PLUGIN_INSTALL_ROOT)	
		#dk_assertVar(PLUGIN_INSTALL_FOLDER)
		set(PLUGIN_INSTALL_PATH ${PLUGIN_INSTALL_ROOT}/${PLUGIN_INSTALL_FOLDER})			
	endif()
	dk_printVar(PLUGIN_INSTALL_PATH)									# PLUGIN_INSTALL_PATH: C:/Users/name/digitalknob/Development/3rdParty/zlib-master

	
	
	
	##############################################
	############# <PLUGIN>_VARIABLES #############
	##############################################
	###### Print the current plugin to the window title bar ######
	if(NOT DEFINED ENV{CURRENT_PLUGIN})
		dk_envList(PLUGIN PUSH "${PLUGIN_IMPORT_NAME_UPPER}")
	endif()
	dk_assertVar(ENV{CURRENT_PLUGIN})
	
	message("############# $ENV{CURRENT_PLUGIN}_VARIABLES #############")
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
	unset($ENV{CURRENT_PLUGIN})
	dk_set($ENV{CURRENT_PLUGIN} ${PLUGIN_INSTALL_PATH})
#	dk_printVar($ENV{CURRENT_PLUGIN})										# ZLIB: C:/Users/name/digitalknob/Development/3rdParty/zlib-master
	
	# <PLUGIN>_DIR      ### DO NOT USE GIT_DIR ###
	unset($ENV{CURRENT_PLUGIN}_DIR)
	if(NOT "$ENV{CURRENT_PLUGIN}" STREQUAL "GIT")
		dk_set($ENV{CURRENT_PLUGIN}_DIR ${PLUGIN_INSTALL_PATH})
#		dk_printVar($ENV{CURRENT_PLUGIN}_DIR)								# ZLIB_DIR: C:/Users/name/digitalknob/Development/3rdParty/zlib-master
	endif()
	
	# <PLUGIN>_URL
	unset($ENV{CURRENT_PLUGIN}_URL)
	dk_set($ENV{CURRENT_PLUGIN}_URL ${PLUGIN_URL})
#	dk_printVar($ENV{CURRENT_PLUGIN}_URL)									# ZLIB_URL: https://github.com/madler/zlib/archive/refs/heads/master.zip
	
	# <PLUGIN>_DL_FILE
	unset($ENV{CURRENT_PLUGIN}_DL_FILE)
	dk_set($ENV{CURRENT_PLUGIN}_DL_FILE ${PLUGIN_URL_FILENAME})
	dk_printVar($ENV{CURRENT_PLUGIN}_DL_FILE)								# ZLIB_DL_FILE: master.zip
	
	# <PLUGIN>_VERSION
	unset($ENV{CURRENT_PLUGIN}_VERSION)
	dk_set($ENV{CURRENT_PLUGIN}_VERSION ${PLUGIN_INSTALL_VERSION})
#	dk_printVar($ENV{CURRENT_PLUGIN}_VERSION)								# ZLIB_VERSION: master

	# <PLUGIN>_FOLDER
	unset($ENV{CURRENT_PLUGIN}_FOLDER)
	dk_set($ENV{CURRENT_PLUGIN}_FOLDER ${PLUGIN_INSTALL_FOLDER})
#	dk_printVar($ENV{CURRENT_PLUGIN}_FOLDER)								# ZLIB_FOLDER: zlib-master	
	
	# <PLUGIN>_IMPORT_NAME
	unset($ENV{CURRENT_PLUGIN}_IMPORT_NAME)
	dk_set($ENV{CURRENT_PLUGIN}_IMPORT_NAME ${PLUGIN_IMPORT_NAME_LOWER})
#	dk_printVar($ENV{CURRENT_PLUGIN}_IMPORT_NAME)							# ZLIB_IMPORT_NAME: zlib
		
	# <PLUGIN>_BRANCH
	unset($ENV{CURRENT_PLUGIN}_BRANCH)
	if(PLUGIN_GIT_BRANCH)
		dk_set($ENV{CURRENT_PLUGIN}_BRANCH ${PLUGIN_GIT_BRANCH})
#		dk_printVar($ENV{CURRENT_PLUGIN}_BRANCH)							# ZLIB_BRANCH: master
	endif()
	
	# <PLUGIN>_TAG
	unset($ENV{CURRENT_PLUGIN}_TAG)
	if(PLUGIN_GIT_TAG)
		dk_set($ENV{CURRENT_PLUGIN}_TAG ${PLUGIN_GIT_TAG})
#		dk_printVar($ENV{CURRENT_PLUGIN}_TAG)								# ZLIB_TAG:
	endif()
	
	
	
	#####################################################
	############# TARGET <PLUGIN>_VARIABLES #############
	#####################################################
	# These variables require a target_triple
	if(NOT target_triple)
		return()
	endif()
	dk_validate(target_triple "dk_target_triple()")
	
	# <PLUGIN>_TRIPLE_DIR
	unset($ENV{CURRENT_PLUGIN}_TRIPLE_DIR)
	if(target_triple)
		dk_set($ENV{CURRENT_PLUGIN}_TRIPLE_DIR ${PLUGIN_INSTALL_PATH}/${target_triple})
#		dk_printVar($ENV{CURRENT_PLUGIN}_TRIPLE_DIR)						# ZLIB_TRIPLE_DIR: C:/Users/name/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang
	endif()
	
	# <PLUGIN>_CONFIG_DIR
	unset($ENV{CURRENT_PLUGIN}_CONFIG_DIR)
	dk_validate(CONFIG_PATH "dk_CONFIG_PATH()")
	if(CONFIG_PATH)
		dk_set($ENV{CURRENT_PLUGIN}_CONFIG_DIR ${PLUGIN_INSTALL_PATH}/${CONFIG_PATH})
#		dk_printVar($ENV{CURRENT_PLUGIN}_CONFIG_DIR)						# ZLIB_CONFIG_DIR: C:/Users/user/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	endif()
	
	# <PLUGIN>_BUILD_DIR
	unset($ENV{CURRENT_PLUGIN}_BUILD_DIR)
	if(BUILD_PATH)
		dk_set($ENV{CURRENT_PLUGIN}_BUILD_DIR ${PLUGIN_INSTALL_PATH}/${BUILD_PATH})
#		dk_printVar($ENV{CURRENT_PLUGIN}_BUILD_DIR)							# ZLIB_BUILD_DIR: C:/Users/name/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	endif()
	
	# <PLUGIN>_DEBUG_DIR
	unset($ENV{CURRENT_PLUGIN}_DEBUG_DIR)
	if(DEBUG_DIR)
		dk_set($ENV{CURRENT_PLUGIN}_DEBUG_DIR ${PLUGIN_INSTALL_PATH}/${target_triple}/${DEBUG_DIR})
#		dk_printVar($ENV{CURRENT_PLUGIN}_DEBUG_DIR)							# ZLIB_DEBUG_DIR: C:/Users/name/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	endif()
	
	# <PLUGIN>_RELEASE_DIR
	unset($ENV{CURRENT_PLUGIN}_RELEASE_DIR)
	if(RELEASE_DIR)
		dk_set($ENV{CURRENT_PLUGIN}_RELEASE_DIR ${PLUGIN_INSTALL_PATH}/${target_triple}/${RELEASE_DIR})
#		dk_printVar($ENV{CURRENT_PLUGIN}_RELEASE_DIR)						# ZLIB_RELEASE_DIR: C:/Users/name/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Release
	endif()
	
endfunction()














###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_importVariables("https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe"  NAME git   ROOT $ENV{DKTOOLS_DIR})
endfunction()
