@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#################################################################################
::### dk_importVariables(PLUGIN_URL) BRANCH FOLDER NAME PATH ROOT TAG VERSION
::#
::#	PLUGIN_URL (arg0)										###### EXAMPLES ######
::#		This url of the plugin to import.					https://github.com/madler/zlib.git     							* github repository link
::#															https://github.com/madler/zlib/archive/refs/heads/master.zip	* github sourcecode download
::#															https://github.com/madler/zlib        							* github page
::#															https://zlib.net/zlib-1.3.1.tar.gz								* library sourcecode download
::#															https://website.com/executable.exe              				* executable file
::#
::#	IMPORT_PATH  optional 
::#															C:/Users/Administrator/digitalknob/Development/3rdParty/_DKIMPORTS/zlib
::#
::#	BRANCH  optional 
::#															develop
::#															master
::#
::#	FOLDER  optional 
::#															zlib-develop
::#															zlib-master
::#
::#	NAME  optional 
::#															zlib
::#															myZLIB
::#
::#	PATH  optional 
::#															C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
::#															C:/Users/Administrator/digitalknob/Development/3rdParty/myZLIB
::#
::#	ROOT  optional 
::#															C:/Users/Administrator/digitalknob/Development/3rdParty
::#															C:/Users/Administrator/MyLibraries
::#
::#	TAG  optional 
::#															v1.3.1
::#															v1.2.13
::#
::#	VERSION  optional 
::#															master
::#
:dk_importVariables
::%setlocal%
	%dk_call% dk_debugFunc 1 9
	
	set "URL=%~1"
	%dk_call% dk_assertVar URL
	rem %dk_call% dk_printVar URL
	
	set "IMPORT_PATH="
	%dk_call% dk_getParameterValue	IMPORT_PATH	%*		&rem C:/Users/Administrator/digitalknob/Development/3rdParty/_DKIMPORTS/zlib
	if defined IMPORT_PATH (set "IMPORT_PATH=%IMPORT_PATH:\=/%")
	rem %dk_call% dk_printVar IMPORT_PATH
	
	set "BRANCH="
	%dk_call% dk_getParameterValue  BRANCH      %*     &rem master
	rem %dk_call% dk_printVar BRANCH
	
	set "FOLDER="
	%dk_call% dk_getParameterValue  FOLDER      %*     &rem zlib-master
	rem %dk_call% dk_printVar FOLDER
	
	set "NAME="
	%dk_call% dk_getParameterValue  NAME        %*     &rem zlib
	rem %dk_call% dk_printVar NAME
	
	set "DIR="
	%dk_call% dk_getParameterValue  DIR         %*     &rem C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	rem %dk_call% dk_printVar DIR
	
	set "ROOT="
	%dk_call% dk_getParameterValue  ROOT        %*     &rem C:/Users/Administrator/digitalknob/Development/3rdParty
	rem %dk_call% dk_printVar ROOT
	
	set "TAG="
	%dk_call% dk_getParameterValue  TAG         %*     &rem v1.3.1
	rem %dk_call% dk_printVar TAG
	
	set "VERSION="
	%dk_call% dk_getParameterValue  VERSION     %*     &rem master
	rem %dk_call% dk_printVar VERSION

	rem ###### POPULATE VARIABLES ######
	rem PLUGIN_URL				- from arg:url														: https://github.com/madler/zlib/archive/refs/heads/master.zip
	rem PLUGIN_URL_LIST			- from PLUGIN_URL													: https:;github.com;madler;zlib;archive;refs;heads;master.zip
	rem PLUGIN_URL_LENGTH		- from PLUGIN_URL_LIST												: 8
	rem PLUGIN_URL_NODE n 		- from PLUGIN_URL_LIST												: [0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip
	rem PLUGIN_URL_FILENAME   	- from PLUGIN_URL													: master.zip
	rem PLUGIN_URL_EXTENSION  	- from PLUGIN_URL_FILENAME											: .zip
	rem PLUGIN_URL_FILE      	- from PLUGIN_URL_FILENAME											: master
	
	rem PLUGIN_IMPORT			- from CMAKE_CURRENT_LIST_DIR										: 1
	rem PLUGIN_IMPORT_PATH		- from CMAKE_CURRENT_LIST_DIR										: C:/Users/Administrator/digitalknob/Development/3rdParty/_DKIMPORTS/zlib
	rem PLUGIN_IMPORT_NAME		- from PLUGIN_IMPORT_PATH											: zlib
	
	rem PLUGIN_GIT				- from PLUGIN_URL													: 1
	rem PLUGIN_GIT_FILENAME		- from PLUGIN_URL													: zlib
	rem PLUGIN_GIT_NAME			- from PLUGIN_GIT_FILENAME											: zlib
	rem PLUGIN_GIT_BRANCH		- from default:master OR arg:BRANCH									: master
	rem PLUGIN_GIT_TAG			- from default: OR arg:TAG
	
	rem PLUGIN_INSTALL_NAME		- from PLUGIN_IMPORT_NAME, PLUGIN_GIT_NAME or PLUGIN_URL_NAME		: zlib
	rem PLUGIN_INSTALL_VERSION	- from PLUGIN_URL_FILE and PLUGIN_IMPORT_NAME						: master
	rem PLUGIN_INSTALL_FOLDER    - from PLUGIN_INSTALL_NAME amd PLUGIN_INSTALL_VERSION				: zlib-master
	rem PLUGIN_INSTALL_ROOT		- from default:DK3RDPARTY OR arg:ROOT								: C:/Users/Administrator/digitalknob/Development/3rdParty
	rem PLUGIN_INSTALL_PATH		- from PLUGIN_INSTALL_ROOT and PLUGIN_INSTALL_FOLDER				: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	
	rem <PLUGIN>				- from PLUGIN_IMPORT_NAME						:ZLIB   			: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	rem <CURRENT_PLUGIN>		- from <PLUGIN>									:ZLIB				: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	rem <PLUGIN>_DIR			- from PLUGIN_INSTALL_PATH						:ZLIB_DIR			: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	rem <PLUGIN>_URL			- from PLUGIN_URL								:ZLIB_URL			: https://github.com/madler/zlib/archive/refs/heads/master.zip
	rem <PLUGIN>_DL_FILE		- from PLUGIN_URL_FILENAME						:ZLIB_DL_FILE		: master.zip
	rem <PLUGIN>_VERSION        - from PLUGIN_INSTALL_VERSION					:ZLIB_VERSION		: master
	rem <PLUGIN>_FOLDER			- from PLUGIN_INSTALL_FOLDER					:ZLIB_FOLDER		: zlib-master
	rem <PLUGIN>_IMPORT_NAME	- from PLUGIN_IMPORT_NAME						:ZLIB_IMPORT_NAME	: zlib
	rem <PLUGIN>_BRANCH			- from PLUGIN_GIT_BRANCH						:ZLIB_BRANCH		: master
	rem <PLUGIN>_TAG			- from PLUGIN_GIT_TAG							:ZLIB_TAG			: 
	rem <PLUGIN>_TRIPLE_DIR		- from PLUGIN_INSTALL_PATH and target_triple	:ZLIB_TRIPLE_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang
	rem <PLUGIN>_CONFIG_DIR		- from PLUGIN_INSTALL_PATH and CONFIG_DIR		:ZLIB_CONFIG_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	rem <PLUGIN>_BUILD_DIR		- from PLUGIN_INSTALL_PATH and BUILD_DIR		:ZLIB_BUILD_DIR		: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	rem <PLUGIN>_DEBUG_DIR		- from PLUGIN_INSTALL_PATH and DEBUG_DIR		:ZLIB_DEBUG_DIR		: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	rem <PLUGIN>_RELEASE_DIR	- from PLUGIN_INSTALL_PATH and RELEASE_DIR		:ZLIB_RELEASE_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Release
	
	
rem ##############################################
rem ############ PLUGIN_URL VARIABLES ############
rem ##############################################					################################# EXAMPLE ##########################
	
rem ### PLUGIN_URL
	rem set "PLUGIN_URL="
	rem set "PLUGIN_URL=%URL:\=/%"
	%dk_call% dk_set PLUGIN_URL "%URL:\=/%"											&rem PLUGIN_URL				: https://github.com/madler/zlib/archive/refs/heads/master.zip
	rem %dk_call% dk_printVar PLUGIN_URL 										

rem ### PLUGIN_URL_FILENAME
	rem set "PLUGIN_URL_FILENAME="
	%dk_call% dk_basename !PLUGIN_URL! PLUGIN_URL_FILENAME 							&rem PLUGIN_URL_FILENAME	: master.zip
	rem %dk_call% dk_printVar PLUGIN_URL_FILENAME 									
	
rem ### PLUGIN_URL_LIST
	set "PLUGIN_URL_LIST="
	%dk_call% dk_replaceAll !PLUGIN_URL!  "/"  ";"  PLUGIN_URL_LIST 				&rem PLUGIN_URL_LIST		: https:;github.com;madler;zlib;archive;refs;heads;master.zip		
	rem %dk_call% dk_printVar PLUGIN_URL_LIST 									
	
rem ### PLUGIN_GIT
	set "PLUGIN_GIT="
	%dk_call% dk_includes "!PLUGIN_URL!" "https://github.com" && set "PLUGIN_GIT=1"	&rem PLUGIN_GIT				: 1
	rem %dk_call% dk_printVar PLUGIN_GIT 											
	
rem ### PLUGIN_URL_EXTENSION
	set "PLUGIN_URL_EXTENSION="
	%dk_call% dk_getExtension !PLUGIN_URL_FILENAME! PLUGIN_URL_EXTENSION 			&rem PLUGIN_URL_EXTENSION	: .zip		
	rem %dk_call% dk_printVar PLUGIN_URL_EXTENSION 									

rem ### PLUGIN_URL_FILE
	set "PLUGIN_URL_FILE="
	%dk_call% dk_removeExtension !PLUGIN_URL_FILENAME! PLUGIN_URL_FILE 				&rem PLUGIN_URL_FILE		: master	
	rem %dk_call% dk_printVar PLUGIN_URL_FILE 										

rem ### PLUGIN_URL_NODE n 
	%dk_call% dk_listToArray "!PLUGIN_URL_LIST!" PLUGIN_URL_ARRAY					&rem PLUGIN_URL_NODE n 		: [0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip
	rem %dk_call% dk_printVar PLUGIN_URL_ARRAY                                      

rem ### PLUGIN_URL_LENGTH
	set "PLUGIN_URL_LENGTH="
	%dk_call% Array/dk_length PLUGIN_URL_ARRAY
	set "PLUGIN_URL_LENGTH=%dk_length%"												&rem PLUGIN_URL_LENGTH		: 8
	rem %dk_call% dk_printVar PLUGIN_URL_LENGTH 									
	
		
		
		
rem #######################################################
rem ############### PLUGIN_IMPORT VARIABLES ###############
rem #######################################################
	if not defined IMPORT_PATH  set "IMPORT_PATH=%CD:\=/%"
	if "%IMPORT_PATH:~-1%" equ "/" set "IMPORT_PATH=%IMPORT_PATH:~0,-1%"
	rem %dk_call% dk_printVar IMPORT_PATH

rem ### PLUGIN_IMPORT ###
	set "PLUGIN_IMPORT="
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_includes %IMPORT_PATH% !DKIMPORTS_DIR! && set "PLUGIN_IMPORT=1"
	rem %dk_call% dk_printVar PLUGIN_IMPORT
	
rem ### PLUGIN_IMPORT_PATH ###
	set "PLUGIN_IMPORT_PATH="
	set "PLUGIN_IMPORT_PATH=%IMPORT_PATH%"											&rem PLUGIN_IMPORT_PATH		: C:/Users/Administrator/digitalknob/Development/3rdParty/_DKIMPORTS/zlib
	rem %dk_call% dk_printVar PLUGIN_IMPORT_PATH 								

rem ### PLUGIN_IMPORT_NAME ###
	set "PLUGIN_IMPORT_NAME="
	if defined NAME (
		set "PLUGIN_IMPORT_NAME=!NAME!"
	) else (
		%dk_call% dk_basename "!PLUGIN_IMPORT_PATH!" PLUGIN_IMPORT_NAME 					
	)																				&rem PLUGIN_IMPORT_NAME		: zlib
	rem %dk_call% dk_printVar PLUGIN_IMPORT_NAME 								

rem ### PLUGIN_IMPORT_NAME_LOWER ###
	set "PLUGIN_IMPORT_NAME_LOWER="
	%dk_call% dk_toLower "!PLUGIN_IMPORT_NAME!" PLUGIN_IMPORT_NAME_LOWER			&rem PLUGIN_IMPORT_NAME_LOWER	: zlib
	rem %dk_call% dk_printVar PLUGIN_IMPORT_NAME_LOWER				         	
	
rem ### PLUGIN_IMPORT_NAME_UPPER ###
	set "PLUGIN_IMPORT_NAME_UPPER="
	%dk_call% dk_toUpper "!PLUGIN_IMPORT_NAME!" PLUGIN_IMPORT_NAME_UPPER			&rem PLUGIN_IMPORT_NAME_UPPER	: ZLIB
	rem %dk_call% dk_printVar PLUGIN_IMPORT_NAME_UPPER							
		
rem ##############################################
rem ############ PLUGIN_GIT VARIABLES ############
rem ##############################################
	if defined PLUGIN_GIT (
rem 	### PLUGIN_GIT_FILENAME
		set "PLUGIN_GIT_FILENAME="
        %dk_call% Array/dk_at PLUGIN_URL_ARRAY 3
		set "PLUGIN_GIT_FILENAME=!dk_at!"											&rem PLUGIN_GIT_FILENAME		: zlib
		rem %dk_call% dk_printVar PLUGIN_GIT_FILENAME 							
		
rem 	### PLUGIN_GIT_NAME
		set "PLUGIN_GIT_NAME="
		%dk_call% dk_replaceAll "!PLUGIN_GIT_FILENAME!" ".git" "" PLUGIN_GIT_NAME 	&rem PLUGIN_GIT_NAME			: zlib			
		rem %dk_call% dk_printVar PLUGIN_GIT_NAME 								
		
rem 	### PLUGIN_GIT_NAME_LOWER
		set "PLUGIN_GIT_NAME_LOWER="
		%dk_call% dk_toLower "!PLUGIN_GIT_NAME!" PLUGIN_GIT_NAME_LOWER				& rem PLUGIN_GIT_NAME_LOWER		: zlib
		rem %dk_call% dk_printVar PLUGIN_GIT_NAME_LOWER						    
		
rem 	### PLUGIN_GIT_BRANCH
		set "PLUGIN_GIT_BRANCH="
		if defined BRANCH (
			set "PLUGIN_GIT_BRANCH=!BRANCH!"
		)
		rem %dk_call% dk_getGitBranchName !PLUGIN_URL! PLUGIN_GIT_BRANCH 					
		if NOT defined PLUGIN_GIT_BRANCH (
			set "PLUGIN_GIT_BRANCH=master" 
		)																			&rem PLUGIN_GIT_BRANCH			: master
		rem %dk_call% dk_printVar PLUGIN_GIT_BRANCH 							
		
rem 	### PLUGIN_GIT_TAG
		set "PLUGIN_GIT_TAG="
		if defined TAG (
			set "PLUGIN_GIT_TAG=!TAG!"
		)																			&rem PLUGIN_GIT_BRANCH			: TODO
		rem %dk_call% dk_printVar PLUGIN_GIT_TAG
	)

rem ##################################################
rem ############ PLUGIN_INSTALL VARIABLES ############
rem ##################################################

rem ### PLUGIN_INSTALL_NAME
	set "PLUGIN_INSTALL_NAME="
	if defined NAME (
		set "PLUGIN_INSTALL_NAME=!NAME!"
	) else if defined PLUGIN_IMPORT_NAME (
		set "PLUGIN_INSTALL_NAME=!PLUGIN_IMPORT_NAME!"
	) else if defined PLUGIN_GIT_NAME (
		set "PLUGIN_INSTALL_NAME=!PLUGIN_GIT_NAME!"
	) else if defined PLUGIN_URL_NAME (
		set "PLUGIN_INSTALL_NAME=!PLUGIN_URL_NAME!"						
	)  																				&rem PLUGIN_INSTALL_NAME		: zlib
	::dk_convertToCIdentifier "!PLUGIN_INSTALL_NAME!" PLUGIN_INSTALL_NAME
	:: %dk_call% dk_printVar PLUGIN_INSTALL_NAME 								

rem ### PLUGIN_INSTALL_VERSION
	set "PLUGIN_INSTALL_VERSION="
	if defined VERSION (
		set "PLUGIN_INSTALL_VERSION=!VERSION!"
	) else if defined PLUGIN_IMPORT_NAME if defined PLUGIN_URL_FILE (
		%dk_call% dk_toLower !PLUGIN_IMPORT_NAME! PLUGIN_IMPORT_NAME_LOWER 	
		%dk_call% dk_toLower !PLUGIN_URL_FILE!    PLUGIN_URL_FILE_LOWER 
		rem ### deduce the plugin version		
		%dk_call% dk_replaceAll !PLUGIN_URL_FILE_LOWER! !PLUGIN_IMPORT_NAME_LOWER! "" PLUGIN_INSTALL_VERSION 	
		if "!PLUGIN_IMPORT_NAME_LOWER!" equ "!PLUGIN_URL_FILE_LOWER!" (
			if defined PLUGIN_GIT_TAG (
				set "PLUGIN_INSTALL_VERSION=!PLUGIN_GIT_TAG!"
			) else if defined PLUGIN_GIT_BRANCH (
				set "PLUGIN_INSTALL_VERSION=!PLUGIN_GIT_BRANCH!" 
			) else (
				set "PLUGIN_INSTALL_VERSION=master"
			)  
		)  
		if "!PLUGIN_INSTALL_VERSION:~0,1!" equ "-" (
			set "PLUGIN_INSTALL_VERSION=!PLUGIN_INSTALL_VERSION:~1!"
		)  
		if "!PLUGIN_INSTALL_VERSION:~0,1!" equ "_" (
			set "PLUGIN_INSTALL_VERSION=!PLUGIN_INSTALL_VERSION:~1!"
		)  
	)    																			&rem PLUGIN_INSTALL_VERSION		: master
	rem %dk_call% dk_printVar PLUGIN_INSTALL_VERSION 							


rem ### PLUGIN_INSTALL_FOLDER
	set "PLUGIN_INSTALL_FOLDER="
	if defined FOLDER (
		set "PLUGIN_INSTALL_FOLDER=!FOLDER!"
	) else if defined PLUGIN_INSTALL_VERSION (
		set "PLUGIN_INSTALL_FOLDER=!PLUGIN_INSTALL_NAME!-!PLUGIN_INSTALL_VERSION!"
	) else ( 
		set "PLUGIN_INSTALL_FOLDER=!PLUGIN_INSTALL_NAME!"
	)  																				&rem PLUGIN_INSTALL_FOLDER		: zlib-master
	rem %dk_call% dk_printVar PLUGIN_INSTALL_FOLDER 								

rem ### PLUGIN_INSTALL_ROOT
	set "PLUGIN_INSTALL_ROOT="
	if defined ROOT (
		set "PLUGIN_INSTALL_ROOT=!ROOT!"
		set "ROOT="
	) else (
		%dk_call% dk_assertPath DK3RDPARTY_DIR
		set "PLUGIN_INSTALL_ROOT=!DK3RDPARTY_DIR!"
	)																				&rem PLUGIN_INSTALL_ROOT		: C:/Users/Administrator/digitalknob/Development/3rdParty
	rem %dk_call% dk_printVar PLUGIN_INSTALL_ROOT 								
	
rem ### PLUGIN_INSTALL_PATH
	set "PLUGIN_INSTALL_PATH="
	if defined DIR (
		set "PLUGIN_INSTALL_PATH=!DIR!"
	) else (
		%dk_call% dk_assertVar PLUGIN_INSTALL_ROOT 
		%dk_call% dk_assertVar PLUGIN_INSTALL_FOLDER
		set "PLUGIN_INSTALL_PATH=!PLUGIN_INSTALL_ROOT!/!PLUGIN_INSTALL_FOLDER!"	
	)																				&rem PLUGIN_INSTALL_PATH		: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	rem %dk_call% dk_printVar PLUGIN_INSTALL_PATH 								

	
	
	
rem ##############################################
rem ############# <PLUGIN>_VARIABLES #############
rem ##############################################
	
	if defined PLUGIN_IMPORT_NAME_LOWER (
		if defined PLUGIN_GIT_NAME_LOWER (
			if "!PLUGIN_IMPORT_NAME_LOWER!" neq "!PLUGIN_GIT_NAME_LOWER!" (
				%dk_call% dk_warning "PLUGIN_IMPORT_NAME:!PLUGIN_IMPORT_NAME_LOWER! and PLUGIN_GIT_NAME:!PLUGIN_GIT_NAME_LOWER! do not match"
			)
		)
	)

rem ### CURRENT_PLUGIN
	set "CURRENT_PLUGIN="
	%dk_call% dk_set CURRENT_PLUGIN !PLUGIN_IMPORT_NAME_UPPER!
	%dk_call% dk_convertToCIdentifier !CURRENT_PLUGIN! CURRENT_PLUGIN 
	if "!PLUGIN_IMPORT_NAME_UPPER!" neq "!CURRENT_PLUGIN!" (
		%dk_call% dk_notice "!PLUGIN_IMPORT_NAME_UPPER! contains non-alphanumeric characters and is changed to !CURRENT_PLUGIN!" 
	)  
	rem %dk_call% dk_printVar CURRENT_PLUGIN 									&rem CURRENT_PLUGIN			: ZLIB

rem ### <PLUGIN>
	set "!CURRENT_PLUGIN!="
	%dk_call% dk_set !CURRENT_PLUGIN! !PLUGIN_INSTALL_PATH!
	rem %dk_call% dk_printVar !CURRENT_PLUGIN!  								&rem ZLIB					: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	
rem ### <PLUGIN>_DIR     ### DO NOT USE GIT_DIR ###
	if "!CURRENT_PLUGIN!" neq "GIT" (
		set "!CURRENT_PLUGIN!_DIR="
		%dk_call% dk_set !CURRENT_PLUGIN!_DIR !PLUGIN_INSTALL_PATH! 
		rem %dk_call% dk_printVar !CURRENT_PLUGIN!_DIR 							& rem ZLIB_DIR				: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master
	)

rem ### <PLUGIN>_URL
	set "!CURRENT_PLUGIN!_URL="
	%dk_call% dk_set !CURRENT_PLUGIN!_URL !PLUGIN_URL! 
	rem %dk_call% dk_printVar !CURRENT_PLUGIN!_URL 								&rem ZLIB_URL				: https://github.com/madler/zlib/archive/refs/heads/master.zip
	
rem ### <PLUGIN>_DL_FILE
	set "!CURRENT_PLUGIN!_DK_FILE="
	%dk_call% dk_set !CURRENT_PLUGIN!_DL_FILE !PLUGIN_URL_FILENAME! 
	rem %dk_call% dk_printVar !CURRENT_PLUGIN!_DL_FILE 							&rem ZLIB_DL_FILE 			: master.zip
	
rem ### <PLUGIN>_VERSION
	set "!CURRENT_PLUGIN!_VERSION="
	%dk_call% dk_set !CURRENT_PLUGIN!_VERSION !PLUGIN_INSTALL_VERSION! 
	rem %dk_call% dk_printVar !CURRENT_PLUGIN!_VERSION 							&rem ZLIB_VERSION  			: master

rem ### <PLUGIN>_FOLDER
	set "!CURRENT_PLUGIN!_FOLDER="
	%dk_call% dk_set !CURRENT_PLUGIN!_FOLDER !PLUGIN_INSTALL_FOLDER! 
	rem %dk_call% dk_printVar !CURRENT_PLUGIN!_FOLDER 							&rem ZLIB_FOLDER			: zlib-master

rem ### <PLUGIN>_IMPORT_NAME
	set "!CURRENT_PLUGIN!_IMPORT_NAME="	
	%dk_call% dk_set !CURRENT_PLUGIN!_IMPORT_NAME !PLUGIN_IMPORT_NAME_LOWER! 
	rem %dk_call% dk_printVar !CURRENT_PLUGIN!_IMPORT_NAME                      &rem ZLIB_IMPORT_NAME		: zlib

rem ### <PLUGIN>_BRANCH
	set "!CURRENT_PLUGIN!_BRANCH="
	if defined PLUGIN_GIT_BRANCH (
		set "!CURRENT_PLUGIN!_BRANCH=!PLUGIN_GIT_BRANCH!"
		rem %dk_call% dk_printVar !CURRENT_PLUGIN!_BRANCH 						&rem ZLIB_BRANCH			: master
    )
	
rem ### <PLUGIN>_TAG
	set "!CURRENT_PLUGIN!_TAG="
	if defined PLUGIN_GIT_TAG (
		%dk_call% dk_set !CURRENT_PLUGIN!_TAG !PLUGIN_GIT_TAG! 
		rem %dk_call% dk_printVar !CURRENT_PLUGIN!_TAG 							&rem ZLIB_TAG				:
    )
	
	
rem #####################################################
rem ############# TARGET <PLUGIN>_VARIABLES #############
rem #####################################################

rem ### <PLUGIN>_TRIPLE_DIR
	set "!CURRENT_PLUGIN!_TRIPLE_DIR="
	if defined target_triple (
		%dk_call% dk_set !CURRENT_PLUGIN!_TRIPLE_DIR "!PLUGIN_INSTALL_PATH!/!target_triple!" 
		rem %dk_call% dk_printVar !CURRENT_PLUGIN!_TRIPLE_DIR 					&rem ZLIB_TRIPLE_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang
	)  
	
rem ### <PLUGIN>_CONFIG_DIR
	set "!CURRENT_PLUGIN!_CONFIG_DIR="
	if defined CONFIG_PATH (
		%dk_call% dk_set !CURRENT_PLUGIN!_CONFIG_DIR "!PLUGIN_INSTALL_PATH!/!CONFIG_PATH!" 
		rem %dk_call% dk_printVar !CURRENT_PLUGIN!_CONFIG_DIR 					&rem ZLIB_CONFIG_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	)  
	
rem ### <PLUGIN>_BUILD_DIR
	set "!CURRENT_PLUGIN!_BUILD_DIR="
	if defined BUILD_PATH (
		%dk_call% dk_set !CURRENT_PLUGIN!_BUILD_DIR "!PLUGIN_INSTALL_PATH!/!BUILD_PATH!" 
		rem %dk_call% dk_printVar !CURRENT_PLUGIN!_BUILD_DIR 					&rem ZLIB_BUILD_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	)  
	
rem ### <PLUGIN>_DEBUG_DIR
	set "!CURRENT_PLUGIN!_DEBUG_DIR="
	if defined DEBUG_DIR (
		%dk_call% dk_set !CURRENT_PLUGIN!_DEBUG_DIR "!PLUGIN_INSTALL_PATH!/!target_triple!/!DEBUG_DIR!" 
		rem %dk_call% dk_printVar !CURRENT_PLUGIN!_DEBUG_DIR 					&rem ZLIB_DEBUG_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Debug
	)  
	
rem ### <PLUGIN>_RELEASE_DIR
	set "!CURRENT_PLUGIN!_RELEASE_DIR="
	if defined RELEASE_DIR (
		%dk_call% dk_set !CURRENT_PLUGIN!_RELEASE_DIR "!PLUGIN_INSTALL_PATH!/!target_triple!/!RELEASE_DIR!" 
		rem %dk_call% dk_printVar !CURRENT_PLUGIN!_RELEASE_DIR 					&rem ZLIB_RELEASE_DIR	: C:/Users/Administrator/digitalknob/Development/3rdParty/zlib-master/win_x86_64_clang/Release
	)  

	rem %dk_call% dk_printVar !CURRENT_PLUGIN! 
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe"    NAME git    ROOT %DKTOOLS_DIR%
	%dk_call% dk_echo "CURRENT_PLUGIN  = %CURRENT_PLUGIN%"
	%dk_call% dk_echo "GIT             = %GIT%"
	%dk_call% dk_echo "GIT_DIR         = %GIT_DIR%"
	%dk_call% dk_echo "GIT_URL         = %GIT_URL%"
	%dk_call% dk_echo "GIT_DL_FILE     = %GIT_DL_FILE%"
	%dk_call% dk_echo "GIT_VERSION     = %GIT_VERSION%"
	%dk_call% dk_echo "GIT_FOLDER      = %GIT_FOLDER%"
	%dk_call% dk_echo "GIT_IMPORT_NAME = %GIT_IMPORT_NAME%"
	%dk_call% dk_echo "GIT_BRANCH      = %GIT_BRANCH%"
	%dk_call% dk_echo "GIT_TAG         = %GIT_TAG%"
%endfunction%
