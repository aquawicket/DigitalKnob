#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_import(url) details
#
#	*** Variables ***
#
#	url (required)
#		*** variations ***
#		https://github.com/orginization/library.git     * Git repository link
#		https://github.com/orginization/library         * Git page
#		https://website.com/library.zip					* library source code 
#		https://website.com/executable.exe              * executable file
#
#
#	plugin - The name of the plugin
#		obtained: 1. from current cmake directory name
#				  2. from github url 4th node
#				  3. from filename in url minus version and extension
#				  4. Supplied by user in dk_import() call   I.E. dk_import(url PLUGIN MyLib)
#	plugin_path - The full path to the plugin
#		obtained: 1. from current cmake directory


###############################################################################
# dk_importVariables(url rtn_var)
#
#	Rework of dk_import()
#
#	@url	- TODO
#
function(dk_importVariables PLUGIN_URL rtn_var)
	#dk_debugFunc("\${ARGV}")
	
	##### Test if we have any non-alphanumeric characters ######
	#dk_convertToCIdentifier(${PLUGIN_URL} PLUGIN_URL_TEST)
	#if(NOT ${PLUGIN_URL} STREQUAL ${PLUGIN_URL_TEST})
	#	dk_fatal("${PLUGIN_URL} contains non-alphanumeric characters")
	#	dk_convertToCIdentifier(${PLUGIN_URL} PLUGIN_URL)
	#endif()
	###################################################################
	
	dk_getParameter(NAME PLUGIN_INSTALL_NAME ${ARGV})			# zlib
	dk_getParameter(VERSION PLUGIN_INSTALL_VERSION ${ARGV})		# master
	dk_getParameter(FOLDER PLUGIN_INSTALL_FOLDER ${ARGV})		# zlib-master
	dk_getParameter(ROOT PLUGIN_INSTALL_ROOT ${ARGV})			# C:/Users/Administrator/digitalknob/Development/3rdParty
	dk_getParameter(PATH PLUGIN_INSTALL_PATH ${ARGV})			# C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	dk_getParameter(BRANCH PLUGIN_GIT_BRANCH ${ARGV})			# master
	dk_getParameter(TAG PLUGIN_GIT_TAG ${ARGV})					# Release-1.0
	dk_set(PLUGIN_INSTALL_NAME "${NAME}")
	
	### POPULATE VARIABLES ###
	# PLUGIN_URL				- from arg:PLUGIN_URL												: https://github.com/madler/zlib/archive/refs/heads/master.zip
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
	
	# PLUGIN_INSTALL_NAME		- from PLUGIN_IMPORT_NAME, PLUGIN_GIT_NAME or PLUGIN_URL_NAME		: zlib
	# PLUGIN_INSTALL_VERSION	- from PLUGIN_URL_FILE and PLUGIN_IMPORT_NAME						: master
	# PLUGIN_INSTALL_FOLDER     - from PLUGIN_INSTALL_NAME amd PLUGIN_INSTALL_VERSION				: zlib-master
	# PLUGIN_INSTALL_ROOT		- from default:DK3RDPARTY OR arg:ROOT								: C:/Users/Administrator/digitalknob/Development/3rdParty
	# PLUGIN_INSTALL_PATH		- from PLUGIN_URL_FILE and PLUGIN_INSTALL_VERSION					: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	# PLUGIN_INSTALL_TAG		: from default: OR arg:TAG											: UNDEFINED
	
	# <PLUGIN>					- from PLUGIN_IMPORT_NAME						:ZLIB   			: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	# <CURRENT_PLUGIN>			- from <PLUGIN>									:ZLIB				: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	# <PLUGIN>_DIR				- from PLUGIN_INSTALL_PATH						:ZLIB_DIR			: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	# <CURRENT_PLUGIN_DIR>		- from PLUGIN_DIR								:ZLIB_DIR			: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	# <PLUGIN>_URL				- from PLUGIN_URL								:ZLIB_URL			: https://github.com/madler/zlib/archive/refs/heads/master.zip
	# <PLUGIN>_DL_FILE			- from PLUGIN_URL_FILENAME						:ZLIB_DL_FILE		: master.zip
	# <PLUGIN>_VERSION          - from PLUGIN_INSTALL_VERSION					:ZLIB_VERSION		: master
	# <PLUGIN>_FOLDER			- from PLUGIN_INSTALL_FOLDER					:ZLIB_FOLDER		: zlib-master
	# <PLUGIN>_NAME				- from PLUGIN_INSTALL_FOLDER					:ZLIB_NAME			: zlib-master
	# <PLUGIN>_IMPORT_NAME		- from PLUGIN_IMPORT_NAME						:ZLIB_IMPORT_NAME	: zlib
	# <PLUGIN>_BRANCH			- from PLUGIN_INSTALL_BRANCH					:ZLIB_BRANCH		: master
	# <PLUGIN>_TAG				- from PLUGIN_INSTALL_TAG						:ZLIB_TAG			: UNDEFINED
	# <PLUGIN>_TRIPLE_DIR		- from PLUGIN_INSTALL_PATH and triple			:ZLIB_TRIPLE_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang
	# <PLUGIN>_CONFIG_DIR		- from PLUGIN_INSTALL_PATH and CONFIG_DIR		:ZLIB_CONFIG_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	# <PLUGIN>_BUILD_DIR		- from PLUGIN_INSTALL_PATH and BUILD_DIR		:ZLIB_BUILD_DIR		: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	# <PLUGIN>_DEBUG_DIR		- from PLUGIN_INSTALL_PATH and DEBUG_DIR		:ZLIB_DEBUG_DIR		: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	# <PLUGIN>_RELEASE_DIR		- from PLUGIN_INSTALL_PATH and RELEASE_DIR		:ZLIB_RELEASE_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Release
	
	

	##############################################
	###### VARIABLES PULLED FROM PLUGIN_URL ######
	##############################################
																				################################# EXAMPLE ##########################
	if(PLUGIN_URL)																
		dk_printVar(PLUGIN_URL)													# PLUGIN_URL				: https://github.com/madler/zlib/archive/refs/heads/master.zip
		dk_basename(${PLUGIN_URL} PLUGIN_URL_FILENAME)							
		dk_printVar(PLUGIN_URL_FILENAME)										# PLUGIN_URL_FILENAME		: master.zip
		dk_replaceAll(${PLUGIN_URL}  "/"  ";"  PLUGIN_URL_LIST)					
		dk_printVar(PLUGIN_URL_LIST)											# PLUGIN_URL_LIST			: https:;github.com;madler;zlib;archive;refs;heads;master.zip
		dk_includes(${PLUGIN_URL} https://github.com PLUGIN_GIT)				
		dk_printVar(PLUGIN_GIT)													# PLUGIN_GIT				: 1
	endif()
	if(PLUGIN_URL_FILENAME)
		dk_getExtension(${PLUGIN_URL_FILENAME} PLUGIN_URL_EXTENSION)			
		dk_printVar(PLUGIN_URL_EXTENSION)										# PLUGIN_URL_EXTENSION		: .zip
		dk_removeExtension(${PLUGIN_URL_FILENAME} PLUGIN_URL_FILE)				
		dk_printVar(PLUGIN_URL_FILE)											# PLUGIN_URL_FILE			: master
	endif()
	if(PLUGIN_URL_LIST)
		# split the url into list converting / to divider ;
		set(index 0)
		foreach(PLUGIN_URL_ITEM ${PLUGIN_URL_LIST})
			set(PLUGIN_URL_NODE${index} ${PLUGIN_URL_ITEM})						
			dk_printVar(PLUGIN_URL_NODE${index})								# PLUGIN_URL_NODE(n)		: [0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip
			math(EXPR index ${index}+1)
		endforeach()
		list(LENGTH PLUGIN_URL_LIST PLUGIN_URL_LENGTH)							
		dk_printVar(PLUGIN_URL_LENGTH)											# PLUGIN_URL_LENGTH			: 8
	endif()



	##########################################################
	###### VARIABLES PULLED FROM CMAKE_CURRENT_LIST_DIR ######
	##########################################################
	
	dk_validate(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
	dk_assert(CMAKE_CURRENT_LIST_DIR)
	dk_assert(DKIMPORTS_DIR)
	dk_includes(${CMAKE_CURRENT_LIST_DIR} ${DKIMPORTS_DIR} PLUGIN_IMPORT)		
	dk_printVar(PLUGIN_IMPORT)													# PLUGIN_IMPORT			 	: 1
	
	if(NOT PLUGIN_IMPORT)
		dk_fatal("PLUGIN_IMPORT invalid")
	endif()
	
	if(PLUGIN_IMPORT)
		set(PLUGIN_IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR})						
		dk_printVar(PLUGIN_IMPORT_PATH)											# PLUGIN_IMPORT_PATH		: C:\Users\Administrator\digitalknob\Development\3rdParty\_DKIMPORTS\zlib
	endif()
	if(PLUGIN_IMPORT_PATH)
		dk_basename(${PLUGIN_IMPORT_PATH} PLUGIN_IMPORT_NAME)					
		dk_printVar(PLUGIN_IMPORT_NAME)											# PLUGIN_IMPORT_NAME		: zlib
	endif()



	##############################################
	###### VARIABLES PULLED FROM PLUGIN_GIT ######
	##############################################
	
	if(PLUGIN_GIT)
		#list(GET PLUGIN_URL_LIST 4 PLUGIN_GIT_FILENAME)
		list(GET PLUGIN_URL_LIST 3 PLUGIN_GIT_FILENAME)										
		dk_printVar(PLUGIN_GIT_FILENAME)										# PLUGIN_GIT_FILENAME		: zlib
		dk_replaceAll(${PLUGIN_GIT_FILENAME} ".git" "" PLUGIN_GIT_NAME)			
		dk_printVar(PLUGIN_GIT_NAME)											# PLUGIN_GIT_NAME			: zlib
		#dk_getGitBranchName(${PLUGIN_URL} PLUGIN_GIT_BRANCH)					
		if(NOT PLUGIN_GIT_BRANCH)
			set(PLUGIN_GIT_BRANCH master)
		endif()
		dk_printVar(PLUGIN_GIT_BRANCH)											# PLUGIN_GIT_BRANCH			: master
	endif()

	
	### PLUGIN_INSTALL VARIABLES ###
	if(NOT PLUGIN_INSTALL_NAME)
		if(PLUGIN_IMPORT_NAME)
			set(PLUGIN_INSTALL_NAME ${PLUGIN_IMPORT_NAME})
		elseif(PLUGIN_GIT_NAME)
			set(PLUGIN_INSTALL_NAME ${PLUGIN_GIT_NAME})
		elseif(PLUGIN_URL_NAME)
			set(PLUGIN_INSTALL_NAME ${PLUGIN_URL_NAME})							
		endif()
		dk_printVar(PLUGIN_INSTALL_NAME)										# PLUGIN_INSTALL_NAME		: zlib
	endif()
	
	if(NOT PLUGIN_INSTALL_VERSION)
		if(PLUGIN_IMPORT_NAME AND PLUGIN_URL_FILE)
			dk_toLower(${PLUGIN_IMPORT_NAME} PLUGIN_IMPORT_NAME_LOWER)	
			dk_toLower(${PLUGIN_URL_FILE}    PLUGIN_URL_FILE_LOWER)
			# deduct the plugin version		
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
		dk_printVar(PLUGIN_INSTALL_VERSION)										# PLUGIN_INSTALL_VERSION	: master
	endif()																				
	if(NOT PLUGIN_INSTALL_FOLDER)		
		if(PLUGIN_INSTALL_VERSION)
			set(PLUGIN_INSTALL_FOLDER ${PLUGIN_INSTALL_NAME}-${PLUGIN_INSTALL_VERSION})	
		endif()
		dk_printVar(PLUGIN_INSTALL_FOLDER)										# PLUGIN_INSTALL_FOLDER		: zlib-master
	endif()
	if(NOT PLUGIN_INSTALL_ROOT)
		if(DK3RDPARTY_DIR)
			set(PLUGIN_INSTALL_ROOT ${DK3RDPARTY_DIR})			
		endif()
		dk_printVar(PLUGIN_INSTALL_ROOT)										# PLUGIN_INSTALL_ROOT		: C:/Users/Administrator/digitalknob/Development/3rdParty
	endif()
	if(NOT PLUGIN_INSTALL_PATH)
		if(PLUGIN_INSTALL_ROOT)
			set(PLUGIN_INSTALL_PATH ${PLUGIN_INSTALL_ROOT}/${PLUGIN_INSTALL_FOLDER})			
		endif()
		dk_printVar(PLUGIN_INSTALL_PATH)										# PLUGIN_INSTALL_PATH		: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	endif()
	if(NOT PLUGIN_INSTALL_BRANCH)
		if(PLUGIN_GIT_BRANCH)
			set(PLUGIN_INSTALL_BRANCH ${PLUGIN_GIT_BRANCH})
		else()
			set(PLUGIN_INSTALL_BRANCH master)
		endif()
		dk_printVar(PLUGIN_INSTALL_BRANCH)										# PLUGIN_INSTALL_BRANCH		: master
	endif()

	if(NOT PLUGIN_INSTALL_TAG)
		if(PLUGIN_GIT_TAG)
			set(PLUGIN_INSTALL_TAG ${PLUGIN_GIT_TAG})
		endif()
		dk_printVar(PLUGIN_INSTALL_TAG)											# PLUGIN_INSTALL_TAG		: UNDEFINED
	endif()

	#dk_printVar(PLUGIN_URL)
	#dk_printVar(PLUGIN_URL_LIST)
	#dk_printVar(PLUGIN_URL_LENGTH)
	#dk_printVar(PLUGIN_URL_NODE0)
	#dk_printVar(PLUGIN_URL_NODE1)
	#dk_printVar(PLUGIN_URL_NODE2)
	#dk_printVar(PLUGIN_URL_NODE3)
	#dk_printVar(PLUGIN_URL_NODE4)
	#dk_printVar(PLUGIN_URL_NODE5)
	#dk_printVar(PLUGIN_URL_FILENAME)
	#dk_printVar(PLUGIN_URL_EXTENSION)
	#dk_printVar(PLUGIN_URL_FILE)
	#dk_printVar(PLUGIN_URL_LENGTH)
	#dk_printVar(PLUGIN_IMPORT)
	#dk_printVar(PLUGIN_IMPORT_PATH)
	#dk_printVar(PLUGIN_IMPORT_NAME)
	#dk_printVar(PLUGIN_GIT)
	#dk_printVar(PLUGIN_GIT_FILENAME)
	#dk_printVar(PLUGIN_GIT_NAME)
	#dk_printVar(PLUGIN_GIT_BRANCH)
	#dk_printVar(PLUGIN_GIT_TAG)
	#dk_printVar(PLUGIN_INSTALL)
	#dk_printVar(PLUGIN_INSTALL_NAME)
	#dk_printVar(PLUGIN_INSTALL_VERSION)
	#dk_printVar(PLUGIN_INSTALL_FOLDER)
	#dk_printVar(PLUGIN_INSTALL_PATH)
	
	if(PLUGIN_IMPORT AND PLUGIN_GIT)
		dk_toLower(${PLUGIN_IMPORT_NAME} PLUGIN_IMPORT_NAME_LOWER)
		dk_toLower(${PLUGIN_GIT_NAME} PLUGIN_GIT_NAME_LOWER)
		if(NOT ${PLUGIN_IMPORT_NAME_LOWER} STREQUAL ${PLUGIN_GIT_NAME_LOWER})
			dk_warning("PLUGIN_IMPORT_NAME_LOWER:${PLUGIN_IMPORT_NAME_LOWER} and PLUGIN_GIT_NAME_LOWER:${PLUGIN_GIT_NAME_LOWER} do not match ")
		endif()
	endif()

	## Setup the PLUGIN_VAR_PREFIX
	dk_toUpper(${PLUGIN_IMPORT_NAME} PLUGIN_IMPORT_NAME_UPPER)
	dk_set(PLUGIN_VAR_PREFIX ${PLUGIN_IMPORT_NAME_UPPER})
	
	##### Warn if there are any non-alphanumeric characters in the PLUGIN_IMPORT_NAME ######
	dk_convertToCIdentifier(${PLUGIN_IMPORT_NAME_UPPER} PLUGIN_VAR_PREFIX)
	if(NOT ${PLUGIN_IMPORT_NAME_UPPER} STREQUAL ${PLUGIN_VAR_PREFIX})
		dk_notice("${PLUGIN_IMPORT_NAME_UPPER} contains non-alphanumeric characters and is changed to ${PLUGIN_VAR_PREFIX}")
	endif()
	
	# <PLUGIN>
	#if(NOT ${PLUGIN_VAR_PREFIX})
	if(PLUGIN_INSTALL_PATH)
		dk_set(${PLUGIN_VAR_PREFIX} ${PLUGIN_INSTALL_PATH})
	endif()
	dk_printVar(${PLUGIN_VAR_PREFIX})											# PLUGIN_VAR_PREFIX			: ZLIB
		
	if(EXISTS ${${PLUGIN_VAR_PREFIX}})
		dk_set(CURRENT_PLUGIN ${PLUGIN_VAR_PREFIX})
		dk_printVar(CURRENT_PLUGIN)												# CURRENT_PLUGIN			: ZLIB
	endif()
	#endif()
	
	# <PLUGIN>_DIR
	#if(NOT ${PLUGIN_VAR_PREFIX}_DIR)
		if(PLUGIN_INSTALL_PATH)
			dk_set(${PLUGIN_VAR_PREFIX}_DIR ${PLUGIN_INSTALL_PATH})
			dk_printVar(${PLUGIN_VAR_PREFIX}_DIR)								# ZLIB_DIR					: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
		endif()
	#endif()
	#if(EXISTS ${${PLUGIN_VAR_PREFIX}_DIR})
		dk_set(CURRENT_PLUGIN_DIR ${${PLUGIN_VAR_PREFIX}_DIR})
		dk_printVar(CURRENT_PLUGIN_DIR)											# CURRENT_PLUGIN_DIR		: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	#endif()
	
	
	# <PLUGIN>_URL
	#if(NOT ${PLUGIN_VAR_PREFIX}_URL)
		if(PLUGIN_URL)
			dk_set(${PLUGIN_VAR_PREFIX}_URL ${PLUGIN_URL})
			dk_printVar(${PLUGIN_VAR_PREFIX}_URL)								# ZLIB_URL					: https://github.com/madler/zlib/archive/refs/heads/master.zip
		endif()
	#endif()
	
	# <PLUGIN>_DL_FILE
	#if(NOT ${PLUGIN_VAR_PREFIX}_DL_FILE)
		if(PLUGIN_URL_FILENAME)
			dk_set(${PLUGIN_VAR_PREFIX}_DL_FILE ${PLUGIN_URL_FILENAME})
			dk_printVar(${PLUGIN_VAR_PREFIX}_DL_FILE)							# ZLIB_DL_FILE 				: master.zip
		endif()
	#endif()
	
	# <PLUGIN>_VERSION
	#if(NOT ${PLUGIN_VAR_PREFIX}_VERSION)
		if(PLUGIN_INSTALL_VERSION)
			dk_set(${PLUGIN_VAR_PREFIX}_VERSION ${PLUGIN_INSTALL_VERSION})
			dk_printVar(${PLUGIN_VAR_PREFIX}_VERSION)							# ZLIB_VERSION  			: master
		endif()
	#endif()
	
	# <PLUGIN>_FOLDER
	#if(NOT ${PLUGIN_VAR_PREFIX}_FOLDER)
		if(PLUGIN_INSTALL_FOLDER)
			dk_set(${PLUGIN_VAR_PREFIX}_FOLDER ${PLUGIN_INSTALL_FOLDER})
			dk_printVar(${PLUGIN_VAR_PREFIX}_FOLDER)							# ZLIB_FOLDER				: zlib-master
		endif()
		if(EXISTS ${${PLUGIN_VAR_PREFIX}})
			dk_set(CURRENT_PLUGIN_FOLDER ${${PLUGIN_VAR_PREFIX}_FOLDER})
			dk_printVar(CURRENT_PLUGIN_FOLDER)									# CURRENT_PLUGIN_FOLDER		: zlib-master
		endif()
	#endif()
	
	# <PLUGIN>_NAME
	#if(NOT ${PLUGIN_VAR_PREFIX}_NAME)
		if(PLUGIN_INSTALL_FOLDER)
			dk_set(${PLUGIN_VAR_PREFIX}_NAME ${PLUGIN_INSTALL_FOLDER})
			dk_printVar(${PLUGIN_VAR_PREFIX}_NAME)								# ZLIB_NAME					: zlib-master
		endif()
	#endif()
	
	# <PLUGIN>_IMPORT_NAME
	if(PLUGIN_IMPORT_NAME)
		dk_toLower(${PLUGIN_IMPORT_NAME} PLUGIN_IMPORT_NAME_LOWER)		
		dk_set(${PLUGIN_VAR_PREFIX}_IMPORT_NAME ${PLUGIN_IMPORT_NAME_LOWER})
		dk_printVar(${PLUGIN_VAR_PREFIX}_IMPORT_NAME)							# ZLIB_IMPORT_NAME			: zlib
	endif()
		
	# <PLUGIN>_BRANCH
	#if(NOT ${PLUGIN_VAR_PREFIX}_BRANCH)
		if(PLUGIN_INSTALL_BRANCH)
			dk_set(${PLUGIN_VAR_PREFIX}_BRANCH ${PLUGIN_INSTALL_BRANCH})
			dk_printVar(${PLUGIN_VAR_PREFIX}_BRANCH)							# ZLIB_BRANCH				: master
		endif()
	#endif()
	
	# <PLUGIN>_TAG
	#if(NOT ${PLUGIN_VAR_PREFIX}_TAG)
		if(PLUGIN_INSTALL_TAG)
			dk_set(${PLUGIN_VAR_PREFIX}_TAG ${PLUGIN_INSTALL_TAG})
			dk_printVar(${PLUGIN_VAR_PREFIX}_TAG)								# ZLIB_TAG					:
		endif()
	#endif()
	
	
	#################################
	###### LIB TARGET VARIABLES #####
	#################################
	
	# <PLUGIN>_TRIPLE_DIR
	#if(NOT ${PLUGIN_VAR_PREFIX}_TRIPLE_DIR)
		dk_assert(triple)
		dk_set(${PLUGIN_VAR_PREFIX}_TRIPLE_DIR ${PLUGIN_INSTALL_PATH}/${triple})
		dk_printVar(${PLUGIN_VAR_PREFIX}_TRIPLE_DIR)							# ZLIB_TRIPLE_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang
	#endif()
	
	# <PLUGIN>_CONFIG_DIR
	#if(NOT ${PLUGIN_VAR_PREFIX}_CONFIG_DIR)
		dk_assert(CONFIG_PATH)
		dk_set(${PLUGIN_VAR_PREFIX}_CONFIG_DIR ${PLUGIN_INSTALL_PATH}/${CONFIG_PATH})
		dk_printVar(${PLUGIN_VAR_PREFIX}_CONFIG_DIR)							# ZLIB_CONFIG_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	#endif()
	
	# <PLUGIN>_BUILD_DIR
	#if(NOT ${PLUGIN_VAR_PREFIX}_BUILD_DIR)
		dk_assert(BUILD_PATH)
		dk_set(${PLUGIN_VAR_PREFIX}_BUILD_DIR ${PLUGIN_INSTALL_PATH}/${BUILD_PATH})
		dk_printVar(${PLUGIN_VAR_PREFIX}_BUILD_DIR)								# ZLIB_BUILD_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	#endif()
	
	# <PLUGIN>_DEBUG_DIR
	#if(NOT ${PLUGIN_VAR_PREFIX}_DEBUG_DIR)
		dk_assert(DEBUG_DIR)
		dk_set(${PLUGIN_VAR_PREFIX}_DEBUG_DIR ${PLUGIN_INSTALL_PATH}/${triple}/${DEBUG_DIR})
		dk_printVar(${PLUGIN_VAR_PREFIX}_DEBUG_DIR)								# ZLIB_DEBUG_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	#endif()
	
	# <PLUGIN>_RELEASE_DIR
	#if(NOT ${PLUGIN_VAR_PREFIX}_RELEASE_DIR)
		dk_assert(RELEASE_DIR)
		dk_set(${PLUGIN_VAR_PREFIX}_RELEASE_DIR ${PLUGIN_INSTALL_PATH}/${triple}/${RELEASE_DIR})
		dk_printVar(${PLUGIN_VAR_PREFIX}_RELEASE_DIR)							# ZLIB_RELEASE_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Release
	#endif()
	
	set(${rtn_var} ${PLUGIN_VAR_PREFIX} PARENT_SCOPE)
	dk_printVar(PLUGIN_VAR_PREFIX)
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	#set(PLUGIN_IMPORT 1)
	set(CMAKE_CURRENT_LIST_DIR "C:/Users/Administrator/digitalknob/Development/3rdParty/_DKIMPORTS/git")
	dk_importVariables("https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe" PLUGIN)
endfunction()
