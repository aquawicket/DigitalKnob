@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::############################################################################
::# dk_importVariables()
::#
::#
::#
::#	*** Variables ***
::#
::#	url (required)
::#		*** variations ***
::#		https://github.com/orginization/library.git     * Git repository link
::#		https://github.com/orginization/library         * Git page
::#		https://website.com/library.zip					* library source code 
::#		https://website.com/executable.exe              * executable file
::#
::#
::#	plugin - The name of the plugin
::#		obtained: 1. from current cmake directory name
::#				  2. from github url 4th node
::#				  3. from filename in url minus version and extension
::#				  4. Supplied by user in dk_import() call   I.E. dk_import(url PLUGIN MyLib)
::#	plugin_path - The full path to the plugin
::#		obtained: 1. from current cmake directory


::###############################################################################
::# dk_importVariables(url rtn_var)
::#
::#	Rework of dk_import()
::#
::#	@url	- TODO
::#
:dk_importVariables PLUGIN_URL rtn_var
	::call dk_debugFunc "\%ARGV%" 
	
	::##### Test if we have any non-alphanumeric characters ######
	::#dk_convertToCIdentifier %PLUGIN_URL% PLUGIN_URL_TEST 
	::#if NOT %PLUGIN_URL% STREQUAL %PLUGIN_URL_TEST% 
	::#	dk_fatal "%PLUGIN_URL% contains non-alphanumeric characters" 
	::#	dk_convertToCIdentifier %PLUGIN_URL% PLUGIN_URL 
	::#endif  
	::###################################################################
	
	::%dk_call% dk_printVar ARGV 
	::### POPULATE VARIABLES ###
	::# PLUGIN_URL				- from arguments
	::# PLUGIN_URL_LIST
	::# PLUGIN_URL_LENGTH
	::# PLUGIN_URL_NODE n 
	::# PLUGIN_URL_FILENAME   	- from PLUGIN_URL
	::# PLUGIN_URL_EXTENSION  	- from PLUGIN_URL_FILENAME
	::# PLUGIN_URL_FILE      		- from PLUGIN_URL_FILENAME
	::# PLUGIN_URL_FILE_LOWER 	- from PLUGIN_URL_FILE
	::# PLUGIN_URL_FILE_UPPER 	- from PLUGIN_URL_FILE
	
	::# PLUGIN_IMPORT
	::# PLUGIN_IMPORT_PATH		- from CMAKE_CURRENT_LIST_DIR
	::# PLUGIN_IMPORT_NAME		- from PLUGIN_IMPORT_PATH
	::# PLUGIN_IMPORT_NAME_LOWER	- from PLUGIN_IMPORT_NAME
	::# PLUGIN_IMPORT_NAME_UPPER	- from PLUGIN_IMPORT_NAME
	
	::# PLUGIN_GIT
	::# PLUGIN_GIT_FILENAME		- from PLUGIN_URL
	::# PLUGIN_GIT_NAME			- from PLUGIN_GIT_FILENAME
	::# PLUGIN_GIT_NAME_LOWER 	- from PLUGIN_GIT_NAME
	::# PLUGIN_GIT_NAME_UPPER 	- from PLUGIN_GIT_NAME
	
	::# PLUGIN_INSTALL_NAME
	::# PLUGIN_INSTALL_NAME_LOWER
	::# PLUGIN_INSTALL_NAME_UPPER
	::# PLUGIN_INSTALL_VERSION	- from PLUGIN_URL_FILE_LOWER and PLUGIN_IMPORT_NAME_LOWER
	::# PLUGIN_INSTALL_FOLDER
	::# PLUGIN_INSTALL_PATH		- from PLUGIN_URL_FILE and PLUGIN_INSTALL_VERSION
	
	::# PLUGIN_VAR_PREFIX			- from PLUGIN_IMPORT_NAME
	
::	%dk_call% dk_getParameter NAME PLUGIN_INSTALL_NAME %*			&:: myLibrary
::	%dk_call% dk_getParameter VERSION PLUGIN_INSTALL_VERSION %*		&:: 1.0
::	%dk_call% dk_getParameter FOLDER PLUGIN_INSTALL_FOLDER %*		&:: myLibrary_1.0
::	%dk_call% dk_getParameter ROOT PLUGIN_INSTALL_ROOT %*			&:: C:\Users\Administrator\digitalknob\3rdParty
::	%dk_call% dk_getParameter PATH PLUGIN_INSTALL_PATH %*			&:: C:\Users\Administrator\digitalknob\3rdParty\myLibrary_1.0
::	%dk_call% dk_getParameter BRANCH PLUGIN_GIT_BRANCH %*			&:: master
::	%dk_call% dk_getParameter TAG PLUGIN_GIT_TAG %*					&:: develop_bug_fix100

	%dk_call% dk_set PLUGIN_INSTALL_NAME "%NAME%"
																				::################################# EXAMPLE ##########################
	if defined PLUGIN_URL																
		%dk_call% dk_printVar PLUGIN_URL										&:: PLUGIN_URL				: https://github.com/madler/zlib/archive/refs/heads/master.zip
		%dk_call% dk_basename %PLUGIN_URL% PLUGIN_URL_FILENAME							
		%dk_call% dk_printVar PLUGIN_URL_FILENAME								&:: PLUGIN_URL_FILENAME		: master.zip
		%dk_call% dk_replaceAll %PLUGIN_URL% "/" ";" PLUGIN_URL_LIST					
		%dk_call% dk_printVar PLUGIN_URL_LIST									&:: PLUGIN_URL_LIST			: https:;github.com;madler;zlib;archive;refs;heads;master.zip
		%dk_call% dk_includes %PLUGIN_URL% https://github.com PLUGIN_GIT				
		%dk_call% dk_printVar PLUGIN_GIT 										&:: PLUGIN_GIT				: 1
	endif  
	if defined PLUGIN_URL_FILENAME 
		%dk_call% dk_getExtension %PLUGIN_URL_FILENAME% PLUGIN_URL_EXTENSION 			
		%dk_call% dk_printVar PLUGIN_URL_EXTENSION 								&:: PLUGIN_URL_EXTENSION	: .zip
		%dk_call% dk_removeExtension %PLUGIN_URL_FILENAME% PLUGIN_URL_FILE 				
		%dk_call% dk_printVar PLUGIN_URL_FILE 									&:: PLUGIN_URL_FILE			: master
	endif  
	if defined PLUGIN_URL_FILE 
		%dk_call% dk_toLower %PLUGIN_URL_FILE% PLUGIN_URL_FILE_LOWER 					
		%dk_call% dk_printVar PLUGIN_URL_FILE_LOWER 							&:: PLUGIN_URL_FILE_LOWER	: master
		%dk_call% dk_toUpper %PLUGIN_URL_FILE% PLUGIN_URL_FILE_UPPER 					
		%dk_call% dk_printVar PLUGIN_URL_FILE_UPPER 							&:: PLUGIN_URL_FILE_UPPER	: MASTER
	endif  
	if defined PLUGIN_URL_LIST 
		::# split the url into list converting / to divider ;
		set index 0 
		foreach PLUGIN_URL_ITEM %PLUGIN_URL_LIST% 
			set PLUGIN_URL_NODE%index% %PLUGIN_URL_ITEM% 						
			%dk_call% dk_printVar PLUGIN_URL_NODE%index% 						&:: PLUGIN_URL_NODE n 		: [0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip
			math EXPR index %index%+1 
		endforeach  
		list LENGTH PLUGIN_URL_LIST PLUGIN_URL_LENGTH 							
		%dk_call% dk_printVar PLUGIN_URL_LENGTH 								&:: PLUGIN_URL_LENGTH		: 8
	endif  

	%dk_call% dk_validate DKIMPORTS_DIR "dk_DKBRANCH_DIR  " 
	%dk_call% dk_assert CMAKE_CURRENT_LIST_DIR 
	%dk_call% dk_assert DKIMPORTS_DIR 
	%dk_call% dk_includes %CMAKE_CURRENT_LIST_DIR% %DKIMPORTS_DIR% PLUGIN_IMPORT 		
	%dk_call% dk_printVar PLUGIN_IMPORT 										&:: PLUGIN_IMPORT			 : 1
	
	if NOT defined PLUGIN_IMPORT 
		%dk_call% dk_fatal "PLUGIN_IMPORT invalid" 
	endif  
	
	if defined PLUGIN_IMPORT 
		set PLUGIN_IMPORT_PATH %CMAKE_CURRENT_LIST_DIR% 						
		%dk_call% dk_printVar PLUGIN_IMPORT_PATH 								&:: PLUGIN_IMPORT_PATH		: C:\Users\Administrator\digitalknob\Development\3rdParty\_DKIMPORTS\zlib
	endif  
	if defined PLUGIN_IMPORT_PATH 
		%dk_call% dk_basename %PLUGIN_IMPORT_PATH% PLUGIN_IMPORT_NAME 					
		%dk_call% dk_printVar PLUGIN_IMPORT_NAME 								&:: PLUGIN_IMPORT_NAME		: zlib
	endif  
	if defined PLUGIN_IMPORT_NAME 
		%dk_call% dk_toLower %PLUGIN_IMPORT_NAME% PLUGIN_IMPORT_NAME_LOWER 				
		%dk_call% dk_printVar PLUGIN_IMPORT_NAME_LOWER 							&:: PLUGIN_IMPORT_NAME_LOWER	: zlib
		%dk_call% dk_toUpper %PLUGIN_IMPORT_NAME% PLUGIN_IMPORT_NAME_UPPER 
		%dk_call% dk_printVar PLUGIN_IMPORT_NAME_UPPER 							&:: PLUGIN_IMPORT_NAME_UPPER	: ZLIB
	endif  

	if defined PLUGIN_GIT 
		::list GET PLUGIN_URL_LIST 4 PLUGIN_GIT_FILENAME 
		list GET PLUGIN_URL_LIST 3 PLUGIN_GIT_FILENAME 										
		%dk_call% dk_printVar PLUGIN_GIT_FILENAME 								&:: PLUGIN_GIT_FILENAME		: zlib
		%dk_call% dk_replaceAll %PLUGIN_GIT_FILENAME% ".git" "" PLUGIN_GIT_NAME 			
		%dk_call% dk_printVar PLUGIN_GIT_NAME 									&:: PLUGIN_GIT_NAME			: zlib
		::dk_getGitBranchName %PLUGIN_URL% PLUGIN_GIT_BRANCH 					
		if NOT PLUGIN_GIT_BRANCH 
			set PLUGIN_GIT_BRANCH master 
		endif  
		%dk_call% dk_printVar PLUGIN_GIT_BRANCH 								&:: PLUGIN_GIT_BRANCH		: master
	endif  
	if defined PLUGIN_GIT_NAME 
		%dk_call% dk_toLower %PLUGIN_GIT_NAME% PLUGIN_GIT_NAME_LOWER 					
		%dk_call% dk_printVar PLUGIN_GIT_NAME_LOWER 							&:: PLUGIN_GIT_NAME_LOWER	: zlib
		%dk_call% dk_toUpper %PLUGIN_GIT_NAME% PLUGIN_GIT_NAME_UPPER 					
		%dk_call% dk_printVar PLUGIN_GIT_NAME_UPPER 							&:: PLUGIN_GIT_NAME_UPPER	: ZLIB
	endif  
	
	### PLUGIN_INSTALL VARIABLES ###
	if NOT defined PLUGIN_INSTALL_URL 
		set PLUGIN_INSTALL_URL %PLUGIN_URL% 									
		%dk_call% dk_printVar PLUGIN_INSTALL_URL 								&:: PLUGIN_INSTALL_URL		: https://github.com/madler/zlib/archive/refs/heads/master.zip
	endif  
	if NOT PLUGIN_INSTALL_NAME 
		if PLUGIN_IMPORT_NAME 
			set PLUGIN_INSTALL_NAME %PLUGIN_IMPORT_NAME% 
		elseif PLUGIN_GIT_NAME 
			set PLUGIN_INSTALL_NAME %PLUGIN_GIT_NAME% 
		elseif PLUGIN_URL_NAME 
			set PLUGIN_INSTALL_NAME %PLUGIN_URL_NAME% 							
		endif  
		%dk_call% dk_printVar PLUGIN_INSTALL_NAME 								&:: PLUGIN_INSTALL_NAME		: zlib
	endif  
	
	if defined PLUGIN_INSTALL_NAME 
		%dk_call% dk_toLower %PLUGIN_INSTALL_NAME% PLUGIN_INSTALL_NAME_LOWER 			
		%dk_call% dk_printVar PLUGIN_INSTALL_NAME_LOWER 						&:: PLUGIN_INSTALL_NAME_LOWER	: zlib
		%dk_call% dk_toUpper %PLUGIN_INSTALL_NAME% PLUGIN_INSTALL_NAME_UPPER 			
		%dk_call% dk_printVar PLUGIN_INSTALL_NAME_LOWER 						&:: PLUGIN_INSTALL_NAME_UPPER	: ZLIB
	endif  
	if NOT defined PLUGIN_INSTALL_VERSION 
		if defined PLUGIN_IMPORT_NAME_LOWER if defined PLUGIN_URL_FILE_LOWER 
			# deduct the plugin version		
			%dk_call% dk_replaceAll %PLUGIN_URL_FILE_LOWER% %PLUGIN_IMPORT_NAME_LOWER% "" PLUGIN_INSTALL_VERSION 	
			if "%PLUGIN_IMPORT_NAME_LOWER%" == "%PLUGIN_URL_FILE_LOWER%" 
				if defined PLUGIN_GIT_TAG 
					set PLUGIN_INSTALL_VERSION %PLUGIN_GIT_TAG% 
				elseif PLUGIN_GIT_BRANCH 
					set PLUGIN_INSTALL_VERSION %PLUGIN_GIT_BRANCH% 
				else  
					set PLUGIN_INSTALL_VERSION master 
				endif  
			endif  
			
			string FIND %PLUGIN_INSTALL_VERSION% - index 
			if %index% EQUAL 0 
				string SUBSTRING %PLUGIN_INSTALL_VERSION% 1 -1 PLUGIN_INSTALL_VERSION 
			endif  
			
			string FIND %PLUGIN_INSTALL_VERSION% _ index 
			if %index% EQUAL 0 
				string SUBSTRING %PLUGIN_INSTALL_VERSION% 1 -1 PLUGIN_INSTALL_VERSION 
			endif  
		endif  
		%dk_call% dk_printVar PLUGIN_INSTALL_VERSION 							&:: PLUGIN_INSTALL_VERSION	:
	endif  																				
	if NOT defined PLUGIN_INSTALL_FOLDER 		
		if defined PLUGIN_INSTALL_VERSION 
			set PLUGIN_INSTALL_FOLDER %PLUGIN_INSTALL_NAME%-%PLUGIN_INSTALL_VERSION% 	
		endif  
		%dk_call% dk_printVar PLUGIN_INSTALL_FOLDER 							&:: PLUGIN_INSTALL_FOLDER	: zlib-master
	endif  
	if NOT defined PLUGIN_INSTALL_URL 
		if defined DK3RDPARTY_DIR 
			set PLUGIN_INSTALL_URL %PLUGIN_URL% 										
		endif  
		%dk_call% dk_printVar PLUGIN_INSTALL_URL 								&:: PLUGIN_INSTALL_URL		: https://github.com/madler/zlib/archive/refs/heads/master.zip
	endif  
	if NOT defined PLUGIN_INSTALL_ROOT 
		if defined DK3RDPARTY_DIR 
			set PLUGIN_INSTALL_ROOT %DK3RDPARTY_DIR% 			
		endif  
		%dk_call% dk_printVar PLUGIN_INSTALL_ROOT 								&:: PLUGIN_INSTALL_PATH		: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	endif  
	if NOT defined PLUGIN_INSTALL_PATH 
		if defined PLUGIN_INSTALL_ROOT 
			set PLUGIN_INSTALL_PATH %PLUGIN_INSTALL_ROOT%/%PLUGIN_INSTALL_FOLDER% 			
		endif  
		%dk_call% dk_printVar PLUGIN_INSTALL_PATH 								&:: PLUGIN_INSTALL_PATH		: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	endif  
	if NOT defined PLUGIN_INSTALL_BRANCH 
		if defined PLUGIN_GIT_BRANCH 
			set PLUGIN_INSTALL_BRANCH %PLUGIN_GIT_BRANCH% 
		else  
			set PLUGIN_INSTALL_BRANCH master 
		endif  
		%dk_call% dk_printVar PLUGIN_INSTALL_BRANCH 							&:: PLUGIN_INSTALL_BRANCH	: master
	endif  

	if NOT defined PLUGIN_INSTALL_TAG 
		if defined PLUGIN_GIT_TAG 
			set PLUGIN_INSTALL_TAG %PLUGIN_GIT_TAG% 
		endif  
		%dk_call% dk_printVar PLUGIN_INSTALL_TAG 								&:: PLUGIN_INSTALL_TAG		: UNDEFINED
	endif  

	::%dk_call% dk_printVar PLUGIN_URL 
	::%dk_call% dk_printVar PLUGIN_URL_LIST 
	::%dk_call% dk_printVar PLUGIN_URL_LENGTH 
	::%dk_call% dk_printVar PLUGIN_URL_NODE0 
	::%dk_call% dk_printVar PLUGIN_URL_NODE1 
	::%dk_call% dk_printVar PLUGIN_URL_NODE2 
	::%dk_call% dk_printVar PLUGIN_URL_NODE3 
	::%dk_call% dk_printVar PLUGIN_URL_NODE4 
	::%dk_call% dk_printVar PLUGIN_URL_NODE5 
	::%dk_call% dk_printVar PLUGIN_URL_FILENAME 
	::%dk_call% dk_printVar PLUGIN_URL_EXTENSION 
	::%dk_call% dk_printVar PLUGIN_URL_FILE 
	::%dk_call% dk_printVar PLUGIN_URL_FILE_LOWER 
	::%dk_call% dk_printVar PLUGIN_URL_FILE_UPPER 
	::%dk_call% dk_printVar PLUGIN_URL_LENGTH 
	::%dk_call% dk_printVar PLUGIN_IMPORT 
	::%dk_call% dk_printVar PLUGIN_IMPORT_PATH 
	::%dk_call% dk_printVar PLUGIN_IMPORT_NAME 
	::%dk_call% dk_printVar PLUGIN_IMPORT_NAME_LOWER 
	::%dk_call% dk_printVar PLUGIN_IMPORT_NAME_UPPER 
	::%dk_call% dk_printVar PLUGIN_GIT 
	::%dk_call% dk_printVar PLUGIN_GIT_FILENAME 
	::%dk_call% dk_printVar PLUGIN_GIT_NAME 
	::%dk_call% dk_printVar PLUGIN_GIT_NAME_LOWER 
	::%dk_call% dk_printVar PLUGIN_GIT_NAME_UPPER 
	::%dk_call% dk_printVar PLUGIN_GIT_BRANCH 
	::%dk_call% dk_printVar PLUGIN_GIT_TAG 
	::%dk_call% dk_printVar PLUGIN_INSTALL 
	::%dk_call% dk_printVar PLUGIN_INSTALL_URL 
	::%dk_call% dk_printVar PLUGIN_INSTALL_NAME 
	::%dk_call% dk_printVar PLUGIN_INSTALL_VERSION 
	::%dk_call% dk_printVar PLUGIN_INSTALL_FOLDER 
	::%dk_call% dk_printVar PLUGIN_INSTALL_PATH 
	
	if PLUGIN_IMPORT AND PLUGIN_GIT 
		if NOT %PLUGIN_IMPORT_NAME_LOWER% STREQUAL %PLUGIN_GIT_NAME_LOWER% 
			%dk_call% dk_warning "PLUGIN_IMPORT_NAME_LOWER:%PLUGIN_IMPORT_NAME_LOWER% and PLUGIN_GIT_NAME_LOWER:%PLUGIN_GIT_NAME_LOWER% do not match " 
		endif  
	endif  

	::## Setup the PLUGIN_VAR_PREFIX
	dk_set PLUGIN_VAR_PREFIX %PLUGIN_IMPORT_NAME_UPPER% 
	
	::##### Warn if there are any non-alphanumeric characters in the PLUGIN_IMPORT_NAME ######
	%dk_call% dk_convertToCIdentifier %PLUGIN_IMPORT_NAME_UPPER% PLUGIN_VAR_PREFIX 
	if NOT %PLUGIN_IMPORT_NAME_UPPER% STREQUAL %PLUGIN_VAR_PREFIX% 
		%dk_call% dk_notice "%PLUGIN_IMPORT_NAME_UPPER% contains non-alphanumeric characters and is changed to %PLUGIN_VAR_PREFIX%" 
	endif  
	
	::# LIB
	::#if NOT %PLUGIN_VAR_PREFIX% 
	if PLUGIN_INSTALL_PATH 
		%dk_call% dk_set %PLUGIN_VAR_PREFIX% %PLUGIN_INSTALL_PATH% 
	endif  
	::dk_printVar %PLUGIN_VAR_PREFIX% 													&:: PLUGIN_VAR_PREFIX		: ZLIB
		
	if EXISTS %%PLUGIN_VAR_PREFIX%% 
		%dk_call% dk_set CURRENT_PLUGIN %PLUGIN_VAR_PREFIX% 
		%dk_call% dk_printVar CURRENT_PLUGIN 											&:: CURRENT_PLUGIN			: ZLIB
	endif  
	::#endif  
	
	::# LIB_DIR
	#if NOT %PLUGIN_VAR_PREFIX%_DIR 
		if PLUGIN_INSTALL_PATH 
			%dk_call% dk_set %PLUGIN_VAR_PREFIX%_DIR %PLUGIN_INSTALL_PATH% 
			%dk_call% dk_printVar %PLUGIN_VAR_PREFIX%_DIR 								&:: ZLIB_DIR				: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
		endif  
	::#endif  
	#if EXISTS %%PLUGIN_VAR_PREFIX%_DIR% 
		%dk_call% dk_set CURRENT_PLUGIN_DIR %%PLUGIN_VAR_PREFIX%_DIR% 
		%dk_call% dk_printVar CURRENT_PLUGIN_DIR 										&:: CURRENT_PLUGIN_DIR		: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	::#endif  
	
	
	::# LIB_URL
	#if NOT %PLUGIN_VAR_PREFIX%_URL 
		if PLUGIN_INSTALL_URL 
			%dk_call% dk_set %PLUGIN_VAR_PREFIX%_URL %PLUGIN_INSTALL_URL% 
			%dk_call% dk_printVar %PLUGIN_VAR_PREFIX%_URL 								&:: ZLIB_URL				: https://github.com/madler/zlib/archive/refs/heads/master.zip
		endif  
	::#endif  
	
	# LIB_DL_FILE
	#if NOT %PLUGIN_VAR_PREFIX%_DL_FILE 
		if PLUGIN_URL_FILENAME 
			%dk_call% dk_set %PLUGIN_VAR_PREFIX%_DL_FILE %PLUGIN_URL_FILENAME% 
			%dk_call% dk_printVar %PLUGIN_VAR_PREFIX%_DL_FILE 							&:: ZLIB_DL_FILE 			: master.zip
		endif  
	::#endif  
	
	# LIB_VERSION
	#if NOT %PLUGIN_VAR_PREFIX%_VERSION 
		if PLUGIN_INSTALL_VERSION 
			%dk_call% dk_set %PLUGIN_VAR_PREFIX%_VERSION %PLUGIN_INSTALL_VERSION% 
			%dk_call% dk_printVar %PLUGIN_VAR_PREFIX%_VERSION 							&:: ZLIB_VERSION  			: master
		endif  
	::#endif  
	
	# LIB_FOLDER
	#if NOT %PLUGIN_VAR_PREFIX%_FOLDER 
		if PLUGIN_INSTALL_FOLDER 
			%dk_call% dk_set %PLUGIN_VAR_PREFIX%_FOLDER %PLUGIN_INSTALL_FOLDER% 
			%dk_call% dk_printVar %PLUGIN_VAR_PREFIX%_FOLDER 							&:: ZLIB_FOLDER				: zlib-master
		endif  
		if EXISTS %%PLUGIN_VAR_PREFIX%% 
			%dk_call% dk_set CURRENT_PLUGIN_FOLDER %%PLUGIN_VAR_PREFIX%_FOLDER% 
			%dk_call% dk_printVar CURRENT_PLUGIN_FOLDER 								&:: CURRENT_PLUGIN_FOLDER	: zlib-master
		endif  
	::#endif  
	
	# LIB_NAME
	#if NOT %PLUGIN_VAR_PREFIX%_NAME 
		if PLUGIN_INSTALL_FOLDER 
			%dk_call% dk_set %PLUGIN_VAR_PREFIX%_NAME %PLUGIN_INSTALL_FOLDER% 
			%dk_call% dk_printVar %PLUGIN_VAR_PREFIX%_NAME 								&:: ZLIB_NAME				: zlib-master
		endif  
	::#endif  
	
	if PLUGIN_IMPORT_NAME_LOWER 
		%dk_call% dk_set %PLUGIN_VAR_PREFIX%_IMPORT_NAME %PLUGIN_IMPORT_NAME_LOWER% 
		%dk_call% dk_printVar %PLUGIN_VAR_PREFIX%_IMPORT_NAME 							&:: ZLIB_IMPORT_NAME		: zlib
	endif  
		
	# LIB_BRANCH
	#if NOT %PLUGIN_VAR_PREFIX%_BRANCH 
		if PLUGIN_INSTALL_BRANCH 
			%dk_call% dk_set %PLUGIN_VAR_PREFIX%_BRANCH %PLUGIN_INSTALL_BRANCH% 
			%dk_call% dk_printVar %PLUGIN_VAR_PREFIX%_BRANCH 							&:: ZLIB_BRANCH				: master
		endif  
	::#endif  
	
	# LIB_TAG
	#if NOT %PLUGIN_VAR_PREFIX%_TAG 
		if PLUGIN_INSTALL_TAG 
			%dk_call% dk_set %PLUGIN_VAR_PREFIX%_TAG %PLUGIN_INSTALL_TAG% 
			%dk_call% dk_printVar %PLUGIN_VAR_PREFIX%_TAG 								&:: ZLIB_TAG				:
		endif  
	::#endif  
	
	# LIB_TRIPLE_DIR
	#if NOT %PLUGIN_VAR_PREFIX%_TRIPLE_DIR 
		%dk_call% dk_assert triple 
		%dk_call% dk_set %PLUGIN_VAR_PREFIX%_TRIPLE_DIR %PLUGIN_INSTALL_PATH%/%triple% 
		%dk_call% dk_printVar %PLUGIN_VAR_PREFIX%_TRIPLE_DIR 							&:: ZLIB_TRIPLE_DIR		: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang
	::#endif  
	
	# LIB_CONFIG_DIR
	#if NOT %PLUGIN_VAR_PREFIX%_CONFIG_DIR 
		%dk_call% dk_assert CONFIG_PATH 
		%dk_call% dk_set %PLUGIN_VAR_PREFIX%_CONFIG_DIR %PLUGIN_INSTALL_PATH%/%CONFIG_PATH% 
		%dk_call% dk_printVar %PLUGIN_VAR_PREFIX%_CONFIG_DIR 							&:: ZLIB_CONFIG_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	::#endif  
	
	# LIB_BUILD_DIR
	#if NOT %PLUGIN_VAR_PREFIX%_BUILD_DIR 
		%dk_call% dk_assert BUILD_PATH 
		%dk_call% dk_set %PLUGIN_VAR_PREFIX%_BUILD_DIR %PLUGIN_INSTALL_PATH%/%BUILD_PATH% 
		%dk_call% dk_printVar %PLUGIN_VAR_PREFIX%_BUILD_DIR 							&:: ZLIB_BUILD_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	::#endif  
	
	# LIB_DEBUG_DIR
	#if NOT %PLUGIN_VAR_PREFIX%_DEBUG_DIR 
		%dk_call% dk_assert DEBUG_DIR 
		%dk_call% dk_set %PLUGIN_VAR_PREFIX%_DEBUG_DIR %PLUGIN_INSTALL_PATH%/%triple%/%DEBUG_DIR% 
		%dk_call% dk_printVar %PLUGIN_VAR_PREFIX%_DEBUG_DIR 							&:: ZLIB_DEBUG_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	::#endif  
	
	# LIB_RELEASE_DIR
	#if NOT %PLUGIN_VAR_PREFIX%_RELEASE_DIR 
		%dk_call% dk_assert RELEASE_DIR 
		%dk_call% dk_set %PLUGIN_VAR_PREFIX%_RELEASE_DIR %PLUGIN_INSTALL_PATH%/%triple%/%RELEASE_DIR% 
		%dk_call% dk_printVar %PLUGIN_VAR_PREFIX%_RELEASE_DIR 							&:: ZLIB_RELEASE_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Release
	::#endif  
	
	set %rtn_var% %PLUGIN_VAR_PREFIX% PARENT_SCOPE 
	%dk_call% dk_printVar PLUGIN_VAR_PREFIX 
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_todo  
%endfunction%