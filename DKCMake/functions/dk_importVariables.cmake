#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

#################################################################################
# dk_importVariables(PLUGIN_URL rtn_var) BRANCH FOLDER NAME PATH ROOT TAG VERSION
#
#	PLUGIN_URL												###### EXAMPLES ######
#		This url of the plugin to import.					https://github.com/madler/zlib.git     							* github repository link
#															https://github.com/madler/zlib/archive/refs/heads/master.zip	* github sourcecode download
#															https://github.com/madler/zlib        							* github page
#															https://zlib.net/zlib-1.3.1.tar.gz								* library sourcecode download
#															https://website.com/executable.exe              				* executable file
#
#	BRANCH (optional)
#															develop
#															master
#
#	FOLDER (optional)
#															zlib-develop
#															zlib-master
#
#	NAME (optional)
#															zlib
#															myZLIB
#
#	PATH (optional)
#															C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
#															C:/Users/Administrator/digitalknob/Development/3rdParty/myZLIB
#
#	ROOT (optional)
#															C:/Users/Administrator/digitalknob/Development/3rdParty
#															C:/Users/Administrator/MyLibraries
#
#	TAG (optional)
#															v1.3.1
#															v1.2.13
#
#	VERSION (optional)
#															master
#
function(dk_importVariables url rtn_var)
	#dk_debugFunc()
	unset(PLUGIN_ARG_BRANCH)
	dk_getParameter(BRANCH 	PLUGIN_ARG_BRANCH 	${ARGV}) 	# master
	dk_printVar(PLUGIN_ARG_BRANCH)
	
	unset(PLUGIN_ARG_FOLDER)
	dk_getParameter(FOLDER	PLUGIN_ARG_FOLDER 	${ARGV})	# zlib-master
	dk_printVar(PLUGIN_ARG_FOLDER)
	
	unset(PLUGIN_ARG_NAME)
	dk_getParameter(NAME 	PLUGIN_ARG_NAME		${ARGV})	# zlib
	dk_printVar(PLUGIN_ARG_NAME)
	
	unset(PLUGIN_ARG_PATH)
	dk_getParameter(PATH 	PLUGIN_ARG_PATH 	${ARGV})	# C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	dk_printVar(PLUGIN_ARG_PATH)
	
	unset(PLUGIN_ARG_ROOT)
	dk_getParameter(ROOT 	PLUGIN_ARG_ROOT 	${ARGV})	# C:/Users/Administrator/digitalknob/Development/3rdParty
	dk_printVar(PLUGIN_ARG_ROOT)
	
	unset(PLUGIN_ARG_TAG)
	dk_getParameter(TAG 	PLUGIN_ARG_TAG 		${ARGV})	# v1.3.1
	dk_printVar(PLUGIN_ARG_TAG)
	
	unset(PLUGIN_ARG_VERSION)
	dk_getParameter(VERSION PLUGIN_ARG_VERSION 	${ARGV})	# master
	dk_printVar(PLUGIN_ARG_VERSION)
	
	
	unset(PLUGIN_INSTALL_NAME)
	dk_set(PLUGIN_INSTALL_NAME "${NAME}")
	
	### POPULATE VARIABLES ###
	# PLUGIN_URL				- from arg:url														: https://github.com/madler/zlib/archive/refs/heads/master.zip
	# PLUGIN_URL_LIST			- from PLUGIN_URL													: https:;github.com;madler;zlib;archive;refs;heads;master.zip
	# PLUGIN_URL_LENGTH			- from PLUGIN_URL_LIST												: 8
	# PLUGIN_URL_NODE(n)		- from PLUGIN_URL_LIST												: [0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip
	# PLUGIN_URL_FILENAME   	- from PLUGIN_URL													: master.zip
	# PLUGIN_URL_EXTENSION  	- from PLUGIN_URL_FILENAME											: .zip
	# PLUGIN_URL_FILE      		- from PLUGIN_URL_FILENAME											: master
	
	# PLUGIN_IMPORT				- from CMAKE_CURRENT_LIST_DIR										: 1
	# PLUGIN_IMPORT_PATH		- from CMAKE_CURRENT_LIST_DIR										: C:\Users\Administrator\digitalknob\Development\3rdParty\_DKIMPORTS\zlib
	# PLUGIN_IMPORT_NAME		- from PLUGIN_IMPORT_PATH											: zlib
	
	# PLUGIN_GIT				- from PLUGIN_URL													: 1
	# PLUGIN_GIT_FILENAME		- from PLUGIN_URL													: zlib
	# PLUGIN_GIT_NAME			- from PLUGIN_GIT_FILENAME											: zlib
	# PLUGIN_GIT_BRANCH			- from default:master OR arg:BRANCH									: master
	# PLUGIN_GIT_TAG			- from default: OR arg:TAG
	
	# PLUGIN_INSTALL_NAME		- from PLUGIN_IMPORT_NAME, PLUGIN_GIT_NAME or PLUGIN_URL_NAME		: zlib
	# PLUGIN_INSTALL_VERSION	- from PLUGIN_URL_FILE and PLUGIN_IMPORT_NAME						: master
	# PLUGIN_INSTALL_FOLDER     - from PLUGIN_INSTALL_NAME amd PLUGIN_INSTALL_VERSION				: zlib-master
	# PLUGIN_INSTALL_ROOT		- from default:DK3RDPARTY OR arg:ROOT								: C:/Users/Administrator/digitalknob/Development/3rdParty
	# PLUGIN_INSTALL_PATH		- from PLUGIN_INSTALL_ROOT and PLUGIN_INSTALL_FOLDER				: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	
	# <PLUGIN>					- from PLUGIN_IMPORT_NAME						:ZLIB   			: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	# <CURRENT_PLUGIN>			- from <PLUGIN>									:ZLIB				: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	# <PLUGIN>_DIR				- from PLUGIN_INSTALL_PATH						:ZLIB_DIR			: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	# <PLUGIN>_URL				- from PLUGIN_URL								:ZLIB_URL			: https://github.com/madler/zlib/archive/refs/heads/master.zip
	# <PLUGIN>_DL_FILE			- from PLUGIN_URL_FILENAME						:ZLIB_DL_FILE		: master.zip
	# <PLUGIN>_VERSION          - from PLUGIN_INSTALL_VERSION					:ZLIB_VERSION		: master
	# <PLUGIN>_FOLDER			- from PLUGIN_INSTALL_FOLDER					:ZLIB_FOLDER		: zlib-master
	# <PLUGIN>_IMPORT_NAME		- from PLUGIN_IMPORT_NAME						:ZLIB_IMPORT_NAME	: zlib
	# <PLUGIN>_BRANCH			- from PLUGIN_GIT_BRANCH						:ZLIB_BRANCH		: master
	# <PLUGIN>_TAG				- from PLUGIN_GIT_TAG							:ZLIB_TAG			: 
	# <PLUGIN>_TRIPLE_DIR		- from PLUGIN_INSTALL_PATH and triple			:ZLIB_TRIPLE_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang
	# <PLUGIN>_CONFIG_DIR		- from PLUGIN_INSTALL_PATH and CONFIG_DIR		:ZLIB_CONFIG_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	# <PLUGIN>_BUILD_DIR		- from PLUGIN_INSTALL_PATH and BUILD_DIR		:ZLIB_BUILD_DIR		: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	# <PLUGIN>_DEBUG_DIR		- from PLUGIN_INSTALL_PATH and DEBUG_DIR		:ZLIB_DEBUG_DIR		: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	# <PLUGIN>_RELEASE_DIR		- from PLUGIN_INSTALL_PATH and RELEASE_DIR		:ZLIB_RELEASE_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Release
	
	
	##############################################
	############ PLUGIN_URL VARIABLES ############
	##############################################						################################# EXAMPLE ##########################
	# PLUGIN_URL
	unset(PLUGIN_URL)
	dk_assertVar(url)
	set(PLUGIN_URL ${url})	
	dk_printVar(PLUGIN_URL)												# PLUGIN_URL				: https://github.com/madler/zlib/archive/refs/heads/master.zip
	
	# PLUGIN_URL_FILENAME
	unset(PLUGIN_URL_FILENAME)
	dk_basename(${PLUGIN_URL} PLUGIN_URL_FILENAME)							
	dk_printVar(PLUGIN_URL_FILENAME)									# PLUGIN_URL_FILENAME		: master.zip
	
	# PLUGIN_URL_LIST
	unset(PLUGIN_URL_LIST)
	dk_replaceAll(${PLUGIN_URL}  "/"  ";"  PLUGIN_URL_LIST)					
	dk_printVar(PLUGIN_URL_LIST)										# PLUGIN_URL_LIST			: https:;github.com;madler;zlib;archive;refs;heads;master.zip
	
	# PLUGIN_GIT
	unset(PLUGIN_GIT)
	dk_includes(${PLUGIN_URL} https://github.com PLUGIN_GIT)				
	dk_printVar(PLUGIN_GIT)												# PLUGIN_GIT				: 1
	
	# PLUGIN_URL_EXTENSION
	unset(PLUGIN_URL_EXTENSION)
	dk_getExtension(${PLUGIN_URL_FILENAME} PLUGIN_URL_EXTENSION)			
	dk_printVar(PLUGIN_URL_EXTENSION)									# PLUGIN_URL_EXTENSION		: .zip

	# PLUGIN_URL_FILE
	unset(PLUGIN_URL_FILE)
	dk_removeExtension(${PLUGIN_URL_FILENAME} PLUGIN_URL_FILE)				
	dk_printVar(PLUGIN_URL_FILE)										# PLUGIN_URL_FILE			: master

	# PLUGIN_URL_NODE(n)
	# split the url into list converting / to divider ;
	set(index 0)
	foreach(PLUGIN_URL_ITEM ${PLUGIN_URL_LIST})
		unset(PLUGIN_URL_NODE${index})
		set(PLUGIN_URL_NODE${index} ${PLUGIN_URL_ITEM})						
		dk_printVar(PLUGIN_URL_NODE${index})							# PLUGIN_URL_NODE(n)		: [0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip
		math(EXPR index ${index}+1)
	endforeach()
	
	# PLUGIN_URL_LENGTH
	unset(PLUGIN_URL_LENGTH)
	list(LENGTH PLUGIN_URL_LIST PLUGIN_URL_LENGTH)							
	dk_printVar(PLUGIN_URL_LENGTH)										# PLUGIN_URL_LENGTH			: 8
	

	#######################################################
	############### PLUGIN_IMPORT VARIABLES ###############
	#######################################################
	dk_assertPath(CMAKE_CURRENT_LIST_DIR)
	dk_validate(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
	
	# PLUGIN_IMPORT
	unset(PLUGIN_IMPORT)
	dk_includes(${CMAKE_CURRENT_LIST_DIR} ${DKIMPORTS_DIR} PLUGIN_IMPORT)		
	dk_assertVar(PLUGIN_IMPORT)
	dk_printVar(PLUGIN_IMPORT)											# PLUGIN_IMPORT			 	: 1
	
	# PLUGIN_IMPORT_PATH
	unset(PLUGIN_IMPORT_PATH)
	set(PLUGIN_IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR})						
	dk_printVar(PLUGIN_IMPORT_PATH)										# PLUGIN_IMPORT_PATH		: C:\Users\Administrator\digitalknob\Development\3rdParty\_DKIMPORTS\zlib

	# PLUGIN_IMPORT_NAME
	unset(PLUGIN_IMPORT_NAME)
	dk_basename(${PLUGIN_IMPORT_PATH} PLUGIN_IMPORT_NAME)					
	dk_printVar(PLUGIN_IMPORT_NAME)										# PLUGIN_IMPORT_NAME		: zlib


	##############################################
	############ PLUGIN_GIT VARIABLES ############
	##############################################
	if(PLUGIN_GIT)
		# PLUGIN_GIT_FILENAME
		unset(PLUGIN_GIT_FILENAME)
		list(GET PLUGIN_URL_LIST 3 PLUGIN_GIT_FILENAME)										
		dk_printVar(PLUGIN_GIT_FILENAME)								# PLUGIN_GIT_FILENAME		: zlib
		
		# PLUGIN_GIT_NAME
		unset(PLUGIN_GIT_NAME)
		dk_replaceAll(${PLUGIN_GIT_FILENAME} ".git" "" PLUGIN_GIT_NAME)			
		dk_printVar(PLUGIN_GIT_NAME)									# PLUGIN_GIT_NAME			: zlib
		
		# PLUGIN_GIT_BRANCH
		unset(PLUGIN_GIT_BRANCH)
		if(PLUGIN_ARG_BRANCH)
			set(PLUGIN_GIT_BRANCH ${PLUGIN_ARG_BRANCH})
		endif()
		#dk_getGitBranchName(${PLUGIN_URL} PLUGIN_GIT_BRANCH)					
		if(NOT PLUGIN_GIT_BRANCH)
			set(PLUGIN_GIT_BRANCH master)
		endif()
		dk_printVar(PLUGIN_GIT_BRANCH)									# PLUGIN_GIT_BRANCH			: master
		
		# PLUGIN_GIT_TAG
		unset(PLUGIN_GIT_TAG)
		if(PLUGIN_ARG_TAG)
			set(PLUGIN_GIT_TAG ${PLUGIN_GIT_TAG})
		endif()
	endif()

	
	##################################################
	############ PLUGIN_INSTALL VARIABLES ############
	##################################################
	# PLUGIN_INSTALL_NAME
	unset(PLUGIN_INSTALL_NAME)
	if(PLUGIN_ARG_NAME)
		set(PLUGIN_INSTALL_NAME ${PLUGIN_ARG_NAME})
	elseif(PLUGIN_IMPORT_NAME)
		set(PLUGIN_INSTALL_NAME ${PLUGIN_IMPORT_NAME})
	elseif(PLUGIN_GIT_NAME)
		set(PLUGIN_INSTALL_NAME ${PLUGIN_GIT_NAME})
	elseif(PLUGIN_URL_NAME)
		set(PLUGIN_INSTALL_NAME ${PLUGIN_URL_NAME})							
	endif()
	dk_printVar(PLUGIN_INSTALL_NAME)									# PLUGIN_INSTALL_NAME		: zlib

	# PLUGIN_INSTALL_VERSION
	unset(PLUGIN_INSTALL_VERSION)
	if(PLUGIN_ARG_VERSION)
		set(PLUGIN_INSTALL_VERSION ${PLUGIN_ARG_VERSION})
	else()
		if(PLUGIN_IMPORT_NAME AND PLUGIN_URL_FILE)
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
	endif()
	dk_printVar(PLUGIN_INSTALL_VERSION)									# PLUGIN_INSTALL_VERSION	: master

	# PLUGIN_INSTALL_FOLDER
	unset(PLUGIN_INSTALL_FOLDER)
	if(PLUGIN_ARG_FOLDER)
		set(PLUGIN_INSTALL_FOLDER ${PLUGIN_ARG_FOLDER})
	elseif(PLUGIN_INSTALL_VERSION)
		set(PLUGIN_INSTALL_FOLDER ${PLUGIN_INSTALL_NAME}-${PLUGIN_INSTALL_VERSION})
	else()
		set(PLUGIN_INSTALL_FOLDER ${PLUGIN_INSTALL_NAME})
	endif()
	dk_printVar(PLUGIN_INSTALL_FOLDER)									# PLUGIN_INSTALL_FOLDER		: zlib-master

	# PLUGIN_INSTALL_ROOT
	unset(PLUGIN_INSTALL_ROOT)
	if(PLUGIN_ARG_ROOT)
		set(PLUGIN_INSTALL_ROOT ${PLUGIN_ARG_ROOT})
	else()
		dk_assertPath(DK3RDPARTY_DIR)
		set(PLUGIN_INSTALL_ROOT ${DK3RDPARTY_DIR})
	endif()
	dk_printVar(PLUGIN_INSTALL_ROOT)									# PLUGIN_INSTALL_ROOT		: C:/Users/Administrator/digitalknob/Development/3rdParty

	# PLUGIN_INSTALL_PATH
	unset(PLUGIN_INSTALL_PATH)
	if(PLUGIN_ARG_PATH)
		set(PLUGIN_INSTALL_PATH ${PLUGIN_ARG_PATH})
	else()
		dk_assertPath(${PLUGIN_INSTALL_ROOT})
		dk_assertVar(PLUGIN_INSTALL_FOLDER)
		set(PLUGIN_INSTALL_PATH ${PLUGIN_INSTALL_ROOT}/${PLUGIN_INSTALL_FOLDER})			
	endif()
	dk_printVar(PLUGIN_INSTALL_PATH)									# PLUGIN_INSTALL_PATH		: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master

	
	
	
	##############################################
	############# <PLUGIN>_VARIABLES #############
	##############################################
	
	unset(PLUGIN_IMPORT_NAME_LOWER)
	unset(PLUGIN_GIT_NAME_LOWER)
	if(PLUGIN_IMPORT AND PLUGIN_GIT)
		dk_toLower(${PLUGIN_IMPORT_NAME} 	PLUGIN_IMPORT_NAME_LOWER)
		dk_toLower(${PLUGIN_GIT_NAME} 		PLUGIN_GIT_NAME_LOWER)
		if(NOT "${PLUGIN_IMPORT_NAME_LOWER}" STREQUAL "${PLUGIN_GIT_NAME_LOWER}")
			dk_warning("PLUGIN_IMPORT_NAME:${PLUGIN_IMPORT_NAME_LOWER} and PLUGIN_GIT_NAME:${PLUGIN_GIT_NAME_LOWER} do not match ")
		endif()
	endif()

	# PLUGIN_PREFIX
	unset(PLUGIN_IMPORT_NAME_UPPER)
	unset(PLUGIN_PREFIX)
	dk_toUpper(${PLUGIN_IMPORT_NAME} PLUGIN_IMPORT_NAME_UPPER)
	dk_set(PLUGIN_PREFIX ${PLUGIN_IMPORT_NAME_UPPER})
	dk_convertToCIdentifier(${PLUGIN_IMPORT_NAME_UPPER} PLUGIN_PREFIX)
	if(NOT ${PLUGIN_IMPORT_NAME_UPPER} STREQUAL ${PLUGIN_PREFIX})
		dk_notice("${PLUGIN_IMPORT_NAME_UPPER} contains non-alphanumeric characters and is changed to ${PLUGIN_PREFIX}")
	endif()
	dk_printVar(PLUGIN_PREFIX)											# PLUGIN_PREFIX				: ZLIB
	
	# <PLUGIN>
	unset(${PLUGIN_PREFIX})
	dk_set(${PLUGIN_PREFIX} ${PLUGIN_INSTALL_PATH})
	dk_printVar(${PLUGIN_PREFIX})										# ZLIB						: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	
	# CURRENT_PLUGIN
	unset(CURRENT_PLUGIN)
	dk_set(CURRENT_PLUGIN ${PLUGIN_PREFIX})
	dk_printVar(CURRENT_PLUGIN)											# CURRENT_PLUGIN			: ZLIB
	
	# <PLUGIN>_DIR
	unset(${PLUGIN_PREFIX}_DIR)
	if(NOT "${PLUGIN_PREFIX}" STREQUAL "GIT") ### DO NOT USE GIT_DIR ###
		dk_set(${PLUGIN_PREFIX}_DIR ${PLUGIN_INSTALL_PATH})
		dk_printVar(${PLUGIN_PREFIX}_DIR)								# ZLIB_DIR					: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	endif()
	
	# <PLUGIN>_URL
	unset(${PLUGIN_PREFIX}_DIR)
	dk_set(${PLUGIN_PREFIX}_URL ${PLUGIN_URL})
	dk_printVar(${PLUGIN_PREFIX}_URL)									# ZLIB_URL					: https://github.com/madler/zlib/archive/refs/heads/master.zip
	
	# <PLUGIN>_DL_FILE
	unset(${PLUGIN_PREFIX}_DL_FILE)
	dk_set(${PLUGIN_PREFIX}_DL_FILE ${PLUGIN_URL_FILENAME})
	dk_printVar(${PLUGIN_PREFIX}_DL_FILE)								# ZLIB_DL_FILE 				: master.zip
	
	# <PLUGIN>_VERSION
	unset(${PLUGIN_PREFIX}_VERSION)
	dk_set(${PLUGIN_PREFIX}_VERSION ${PLUGIN_INSTALL_VERSION})
	dk_printVar(${PLUGIN_PREFIX}_VERSION)								# ZLIB_VERSION  			: master

	# <PLUGIN>_FOLDER
	unset(${PLUGIN_PREFIX}_FOLDER)
	dk_set(${PLUGIN_PREFIX}_FOLDER ${PLUGIN_INSTALL_FOLDER})
	dk_printVar(${PLUGIN_PREFIX}_FOLDER)								# ZLIB_FOLDER				: zlib-master

	# <PLUGIN>_IMPORT_NAME
	unset(PLUGIN_IMPORT_NAME_LOWER)
	unset(${PLUGIN_PREFIX}_IMPORT_NAME)
	dk_toLower(${PLUGIN_IMPORT_NAME} PLUGIN_IMPORT_NAME_LOWER)		
	dk_set(${PLUGIN_PREFIX}_IMPORT_NAME ${PLUGIN_IMPORT_NAME_LOWER})
	dk_printVar(${PLUGIN_PREFIX}_IMPORT_NAME)							# ZLIB_IMPORT_NAME			: zlib
		
	# <PLUGIN>_BRANCH
	unset(${PLUGIN_PREFIX}_BRANCH)
	if(PLUGIN_GIT_BRANCH)
		dk_set(${PLUGIN_PREFIX}_BRANCH ${PLUGIN_GIT_BRANCH})
		dk_printVar(${PLUGIN_PREFIX}_BRANCH)							# ZLIB_BRANCH				: master
	endif()
	
	# <PLUGIN>_TAG
	unset(${PLUGIN_PREFIX}_TAG)
	if(PLUGIN_GIT_TAG)
		dk_set(${PLUGIN_PREFIX}_TAG ${PLUGIN_GIT_TAG})
		dk_printVar(${PLUGIN_PREFIX}_TAG)								# ZLIB_TAG					:
	endif()
	
	
	
	
	#####################################################
	############# TARGET <PLUGIN>_VARIABLES #############
	#####################################################
	# <PLUGIN>_TRIPLE_DIR
	unset(${PLUGIN_PREFIX}_TRIPLE_DIR)
	if(triple)
		dk_set(${PLUGIN_PREFIX}_TRIPLE_DIR ${PLUGIN_INSTALL_PATH}/${triple})
		dk_printVar(${PLUGIN_PREFIX}_TRIPLE_DIR)						# ZLIB_TRIPLE_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang
	endif()
	
	# <PLUGIN>_CONFIG_DIR
	unset(${PLUGIN_PREFIX}_CONFIG_DIR)
	if(CONFIG_PATH)
		dk_set(${PLUGIN_PREFIX}_CONFIG_DIR ${PLUGIN_INSTALL_PATH}/${CONFIG_PATH})
		dk_printVar(${PLUGIN_PREFIX}_CONFIG_DIR)						# ZLIB_CONFIG_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	endif()
	
	# <PLUGIN>_BUILD_DIR
	unset(${PLUGIN_PREFIX}_BUILD_DIR)
	if(BUILD_PATH)
		dk_set(${PLUGIN_PREFIX}_BUILD_DIR ${PLUGIN_INSTALL_PATH}/${BUILD_PATH})
		dk_printVar(${PLUGIN_PREFIX}_BUILD_DIR)							# ZLIB_BUILD_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	endif()
	
	# <PLUGIN>_DEBUG_DIR
	unset(${PLUGIN_PREFIX}_DEBUG_DIR)
	if(DEBUG_DIR)
		dk_set(${PLUGIN_PREFIX}_DEBUG_DIR ${PLUGIN_INSTALL_PATH}/${triple}/${DEBUG_DIR})
		dk_printVar(${PLUGIN_PREFIX}_DEBUG_DIR)							# ZLIB_DEBUG_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	endif()
	
	# <PLUGIN>_RELEASE_DIR
	unset(${PLUGIN_PREFIX}_RELEASE_DIR)
	if(RELEASE_DIR)
		dk_set(${PLUGIN_PREFIX}_RELEASE_DIR ${PLUGIN_INSTALL_PATH}/${triple}/${RELEASE_DIR})
		dk_printVar(${PLUGIN_PREFIX}_RELEASE_DIR)						# ZLIB_RELEASE_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Release
	endif()
	
	unset(${rtn_var})
	set(${rtn_var} ${PLUGIN_PREFIX} PARENT_SCOPE)
	dk_printVar(PLUGIN_PREFIX)
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	set(CMAKE_CURRENT_LIST_DIR "C:/Users/Administrator/digitalknob/Development/3rdParty/_DKIMPORTS/git")
	dk_importVariables("https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe" PLUGIN)
endfunction()
