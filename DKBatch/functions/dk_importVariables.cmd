@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################












::#################################################################################
::### dk_importVariables(PLUGIN_URL) BRANCH FOLDER NAME PATH ROOT TAG VERSION
::#
::#															###### EXAMPLES ######
::#	PLUGIN_URL												https://github.com/madler/zlib.git     							* github repository link
::#															https://github.com/madler/zlib/archive/refs/heads/master.zip	* github sourcecode download
::#															https://github.com/madler/zlib        							* github page
::#															https://zlib.net/zlib-1.3.1.tar.gz								* library sourcecode download
::#															https://website.com/executable.exe              				* executable file
::#
::#	IMPORT_PATH  optional									C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
::#
::#
::#	BRANCH  optional										develop
::#															master
::#
::#	FOLDER  optional										zlib-develop
::#															zlib-master
::#
::#	NAME  optional											zlib
::#															myZLIB
::#
::#	PATH  optional											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
::#															C:/Users/Administrator/DigitalKnob/Development/3rdParty/myZLIB
::#
::#	ROOT  optional											C:/Users/Administrator/DigitalKnob/Development/3rdParty
::#															C:/Users/Administrator/MyLibraries
::#
::#	TAG  optional											v1.3.1
::#															v1.2.13
::#
::#	VERSION  optional										master
::#															
::#
:dk_importVariables
rem %setlocal%
	%dk_call% dk_debugFunc 1 9
	
	::														###### EXAMPLES ######
	::### PLUGIN_ARGS										"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	set "PLUGIN_ARGS=%*"
	
	::### URL												https://github.com/madler/zlib/archive/refs/heads/master.zip
	set "PLUGIN_URL=%~1"
	set "PLUGIN_URL=%PLUGIN_URL:\=/%"
	rem %dk_call% dk_printVar PLUGIN_URL
	
	::### IMPORT_PATH										C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	set "IMPORT_PATH="
	%dk_call% dk_getParameterValue	IMPORT_PATH	%*
	if not defined IMPORT_PATH  set "IMPORT_PATH=%CD:\=/%"
	if "%IMPORT_PATH:~-1%" equ "/" set "IMPORT_PATH=%IMPORT_PATH:~0,-1%"
	rem %dk_call% dk_printVar IMPORT_PATH
	
	::###  BRANCH											master
	set "BRANCH="
	%dk_call% dk_getParameterValue  BRANCH      %*
	rem %dk_call% dk_printVar BRANCH
	
	::### FOLDER											zlib-master
	set "FOLDER="
	%dk_call% dk_getParameterValue  FOLDER      %*
	rem %dk_call% dk_printVar FOLDER
	
	::### NAME												zlib
	set "NAME="
	%dk_call% dk_getParameterValue  NAME        %*
	rem %dk_call% dk_printVar NAME
	
	::### DIR												C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	set "DIR="
	%dk_call% dk_getParameterValue  DIR         %*
	rem %dk_call% dk_printVar DIR
	
	::### ROOT												C:/Users/Administrator/DigitalKnob/Development/3rdParty
	set "ROOT="
	%dk_call% dk_getParameterValue  ROOT        %*
	rem %dk_call% dk_printVar ROOT
	
	::### TAG												v1.3.1
	set "TAG="
	%dk_call% dk_getParameterValue  TAG         %*
	rem %dk_call% dk_printVar TAG
	
	::### VERSION											master
	set "VERSION="
	%dk_call% dk_getParameterValue  VERSION     %*
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
	rem PLUGIN_IMPORT_PATH		- from CMAKE_CURRENT_LIST_DIR										: C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	rem PLUGIN_IMPORT_NAME		- from PLUGIN_IMPORT_PATH											: zlib
	
	rem PLUGIN_GIT				- from PLUGIN_URL													: 1
	rem PLUGIN_GIT_FILENAME		- from PLUGIN_URL													: zlib
	rem PLUGIN_GIT_NAME			- from PLUGIN_GIT_FILENAME											: zlib
	rem PLUGIN_GIT_BRANCH		- from default:master OR arg:BRANCH									: master
	rem PLUGIN_GIT_TAG			- from default: OR arg:TAG
	
	rem PLUGIN_INSTALL_NAME		- from PLUGIN_IMPORT_NAME, PLUGIN_GIT_NAME or PLUGIN_URL_NAME		: zlib
	rem PLUGIN_INSTALL_VERSION	- from PLUGIN_URL_FILE and PLUGIN_IMPORT_NAME						: master
	rem PLUGIN_INSTALL_FOLDER    - from PLUGIN_INSTALL_NAME amd PLUGIN_INSTALL_VERSION				: zlib-master
	rem PLUGIN_INSTALL_ROOT		- from default:DK3RDPARTY OR arg:ROOT								: C:/Users/Administrator/DigitalKnob/Development/3rdParty
	rem PLUGIN_INSTALL_PATH		- from PLUGIN_INSTALL_ROOT and PLUGIN_INSTALL_FOLDER				: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	
	rem <PLUGIN>				- from PLUGIN_IMPORT_NAME						:ZLIB   			: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	rem <CURRENT_PLUGIN>		- from <PLUGIN>									:ZLIB				: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	rem <PLUGIN>_DIR			- from PLUGIN_INSTALL_PATH						:ZLIB_DIR			: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	rem <PLUGIN>_URL			- from PLUGIN_URL								:ZLIB_URL			: https://github.com/madler/zlib/archive/refs/heads/master.zip
	rem <PLUGIN>_IMPORT_FILE	- from PLUGIN_URL_FILENAME						:ZLIB_IMPORT_FILE	: master.zip
	rem <PLUGIN>_VERSION        - from PLUGIN_INSTALL_VERSION					:ZLIB_VERSION		: master
	rem <PLUGIN>_FOLDER			- from PLUGIN_INSTALL_FOLDER					:ZLIB_FOLDER		: zlib-master
	rem <PLUGIN>_IMPORT_NAME	- from PLUGIN_IMPORT_NAME						:ZLIB_IMPORT_NAME	: zlib
	rem <PLUGIN>_BRANCH			- from PLUGIN_GIT_BRANCH						:ZLIB_BRANCH		: master
	rem <PLUGIN>_TAG			- from PLUGIN_GIT_TAG							:ZLIB_TAG			:
	rem <PLUGIN>_TUPLE_DIR		- from PLUGIN_INSTALL_PATH and Target_Tuple		:ZLIB_TUPLE_DIR		: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	rem <PLUGIN>_CONFIG_DIR		- from PLUGIN_INSTALL_PATH and CONFIG_DIR		:ZLIB_CONFIG_DIR	: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	rem <PLUGIN>_BUILD_DIR		- from PLUGIN_INSTALL_PATH and BUILD_DIR		:ZLIB_BUILD_DIR		: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	rem <PLUGIN>_DEBUG_DIR		- from PLUGIN_INSTALL_PATH and Debug_Dir		:ZLIB_DEBUG_DIR		: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	rem <PLUGIN>_RELEASE_DIR	- from PLUGIN_INSTALL_PATH and Release_Dir		:ZLIB_RELEASE_DIR	: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	
	
rem ##############################################
rem ############ PLUGIN_URL VARIABLES ############
rem ##############################################					################################# EXAMPLE ##########################

	::### PLUGIN_URL_FILENAME								master.zip
	rem set "PLUGIN_URL_FILENAME="
	%dk_call% dk_basename !PLUGIN_URL! PLUGIN_URL_FILENAME
	rem %dk_call% dk_printVar PLUGIN_URL_FILENAME 									
	
	::### PLUGIN_URL_LIST									https:;github.com;madler;zlib;archive;refs;heads;master.zip
	set "PLUGIN_URL_LIST="
	%dk_call% dk_replaceAll !PLUGIN_URL!  "/"  ";"  PLUGIN_URL_LIST
	rem %dk_call% dk_printVar PLUGIN_URL_LIST 									
	
	::### PLUGIN_GIT										1
	set "PLUGIN_GIT="
	%dk_call% dk_includes "!PLUGIN_URL!" "https://github.com" && set "PLUGIN_GIT=1"
	rem %dk_call% dk_printVar PLUGIN_GIT 											
	
	::### PLUGIN_URL_EXTENSION								.zip
	set "PLUGIN_URL_EXTENSION="
	%dk_call% dk_getExtension !PLUGIN_URL_FILENAME! PLUGIN_URL_EXTENSION
	rem %dk_call% dk_printVar PLUGIN_URL_EXTENSION 									

	::### PLUGIN_URL_FILE									master
	set "PLUGIN_URL_FILE="
	%dk_call% dk_removeExtension !PLUGIN_URL_FILENAME! PLUGIN_URL_FILE
	rem %dk_call% dk_printVar PLUGIN_URL_FILE 										

	::### PLUGIN_URL_NODE n									[0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip
	%dk_call% dk_listToArray "!PLUGIN_URL_LIST!" PLUGIN_URL_ARRAY
	rem %dk_call% dk_printVar PLUGIN_URL_ARRAY                                     

	::### PLUGIN_URL_LENGTH									8
	set "PLUGIN_URL_LENGTH="
	%dk_call% Array/dk_length PLUGIN_URL_ARRAY
	set "PLUGIN_URL_LENGTH=%dk_length%"
	rem %dk_call% dk_printVar PLUGIN_URL_LENGTH 									
	
		
	
rem #######################################################
rem ############### PLUGIN_IMPORT VARIABLES ###############
rem #######################################################

	::### PLUGIN_IMPORT										1
	set "PLUGIN_IMPORT="
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_includes %IMPORT_PATH% !DKIMPORTS_DIR! && set "PLUGIN_IMPORT=1"
	rem %dk_call% dk_printVar PLUGIN_IMPORT
	
	::### PLUGIN_IMPORT_PATH								C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	set "PLUGIN_IMPORT_PATH="
	set "PLUGIN_IMPORT_PATH=%IMPORT_PATH%"
	rem %dk_call% dk_printVar PLUGIN_IMPORT_PATH 								

	::### PLUGIN_IMPORT_NAME								zlib
	set "PLUGIN_IMPORT_NAME="
	if defined NAME (
		set "PLUGIN_IMPORT_NAME=!NAME!"
	) else (
		%dk_call% dk_basename "!PLUGIN_IMPORT_PATH!" PLUGIN_IMPORT_NAME 					
	)
	rem %dk_call% dk_printVar PLUGIN_IMPORT_NAME 								

	::### PLUGIN_IMPORT_NAME_LOWER							zlib
	set "PLUGIN_IMPORT_NAME_LOWER="
	%dk_call% dk_toLower "!PLUGIN_IMPORT_NAME!" PLUGIN_IMPORT_NAME_LOWER
	rem %dk_call% dk_printVar PLUGIN_IMPORT_NAME_LOWER				         	
	
	::### PLUGIN_IMPORT_NAME_UPPER							ZLIB
	set "PLUGIN_IMPORT_NAME_UPPER="
	%dk_call% dk_toUpper "!PLUGIN_IMPORT_NAME!" PLUGIN_IMPORT_NAME_UPPER
	rem %dk_call% dk_printVar PLUGIN_IMPORT_NAME_UPPER							
		
rem ##############################################
rem ############ PLUGIN_GIT VARIABLES ############
rem ##############################################
	if defined PLUGIN_GIT (
rem 	### PLUGIN_GIT_FILENAME								zlib
		set "PLUGIN_GIT_FILENAME="
        %dk_call% Array/dk_at PLUGIN_URL_ARRAY 3
		set "PLUGIN_GIT_FILENAME=!dk_at!"
		rem %dk_call% dk_printVar PLUGIN_GIT_FILENAME 							
		
rem 	### PLUGIN_GIT_NAME									zlib
		set "PLUGIN_GIT_NAME="
		%dk_call% dk_replaceAll "!PLUGIN_GIT_FILENAME!" ".git" "" PLUGIN_GIT_NAME		
		rem %dk_call% dk_printVar PLUGIN_GIT_NAME 								
		
rem 	### PLUGIN_GIT_NAME_LOWER							zlib
		set "PLUGIN_GIT_NAME_LOWER="
		%dk_call% dk_toLower "!PLUGIN_GIT_NAME!" PLUGIN_GIT_NAME_LOWER
		rem %dk_call% dk_printVar PLUGIN_GIT_NAME_LOWER						   
		
rem 	### PLUGIN_GIT_BRANCH								master
		set "PLUGIN_GIT_BRANCH="
		if defined BRANCH (
			set "PLUGIN_GIT_BRANCH=!BRANCH!"
		)
::		%dk_call% dk_getGitBranchName !PLUGIN_URL! PLUGIN_GIT_BRANCH 					
		if NOT defined PLUGIN_GIT_BRANCH (
			set "PLUGIN_GIT_BRANCH=master"
		)
		rem %dk_call% dk_printVar PLUGIN_GIT_BRANCH 							
		
rem 	### PLUGIN_GIT_TAG									TODO
		set "PLUGIN_GIT_TAG="
		if defined TAG (
			set "PLUGIN_GIT_TAG=!TAG!"
		)
		rem %dk_call% dk_printVar PLUGIN_GIT_TAG
	)

rem ##################################################
rem ############ PLUGIN_INSTALL VARIABLES ############
rem ##################################################

	::### PLUGIN_INSTALL_NAME								zlib
	set "PLUGIN_INSTALL_NAME="
	if defined NAME (
		set "PLUGIN_INSTALL_NAME=!NAME!"
	) else if defined PLUGIN_IMPORT_NAME (
		set "PLUGIN_INSTALL_NAME=!PLUGIN_IMPORT_NAME!"
	) else if defined PLUGIN_GIT_NAME (
		set "PLUGIN_INSTALL_NAME=!PLUGIN_GIT_NAME!"
	) else if defined PLUGIN_URL_NAME (
		set "PLUGIN_INSTALL_NAME=!PLUGIN_URL_NAME!"						
	)
	rem %dk_call% dk_convertToCIdentifier "!PLUGIN_INSTALL_NAME!" PLUGIN_INSTALL_NAME
	rem %dk_call% dk_printVar PLUGIN_INSTALL_NAME 								

	::### PLUGIN_INSTALL_VERSION							master
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
	)
	rem %dk_call% dk_printVar PLUGIN_INSTALL_VERSION 							

	::### PLUGIN_INSTALL_FOLDER									zlib-master
	set "PLUGIN_INSTALL_FOLDER="
	if defined FOLDER (
		set "PLUGIN_INSTALL_FOLDER=!FOLDER!"
	) else if defined PLUGIN_INSTALL_VERSION (
		set "PLUGIN_INSTALL_FOLDER=!PLUGIN_INSTALL_NAME!-!PLUGIN_INSTALL_VERSION!"
	) else (
		set "PLUGIN_INSTALL_FOLDER=!PLUGIN_INSTALL_NAME!"
	)
	rem %dk_call% dk_printVar PLUGIN_INSTALL_FOLDER 								

	::### PLUGIN_INSTALL_ROOT									C:/Users/Administrator/DigitalKnob/Development/3rdParty
	set "PLUGIN_INSTALL_ROOT="
	if defined ROOT (
		set "PLUGIN_INSTALL_ROOT=!ROOT!"
	) else (
		%dk_call% dk_assertPath DK3RDPARTY_DIR
		set "PLUGIN_INSTALL_ROOT=!DK3RDPARTY_DIR!"
	)
	rem %dk_call% dk_printVar PLUGIN_INSTALL_ROOT 								
	
	::### PLUGIN_INSTALL_PATH									C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	set "PLUGIN_INSTALL_PATH="
	if defined DIR (
		set "PLUGIN_INSTALL_PATH=!DIR!"
	) else (
		set "PLUGIN_INSTALL_PATH=!PLUGIN_INSTALL_ROOT!/!PLUGIN_INSTALL_FOLDER!"	
	)
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

	::### CURRENT_PLUGIN														ZLIB
	set "CURRENT_PLUGIN=!PLUGIN_IMPORT_NAME_UPPER!"
	%dk_call% dk_convertToCIdentifier !CURRENT_PLUGIN! CURRENT_PLUGIN
	if "!PLUGIN_IMPORT_NAME_UPPER!" neq "!CURRENT_PLUGIN!" (
		%dk_call% dk_notice "!PLUGIN_IMPORT_NAME_UPPER! contains non-alphanumeric characters and is changed to !CURRENT_PLUGIN!"
	) 
	rem %dk_call% dk_printVar CURRENT_PLUGIN

	::### <PLUGIN>																C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	set "!CURRENT_PLUGIN!=!PLUGIN_INSTALL_PATH!"
	rem %dk_call% dk_printVar !CURRENT_PLUGIN!
	
	::### <PLUGIN>_DIR     ### DO NOT USE GIT_DIR ###							C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	if "!CURRENT_PLUGIN!" neq "GIT" (
		set "!CURRENT_PLUGIN!_DIR=!PLUGIN_INSTALL_PATH!"
		rem %dk_call% dk_printVar !CURRENT_PLUGIN!_DIR
	)

	::### <PLUGIN>_URL															https://github.com/madler/zlib/archive/refs/heads/master.zip
	set "!CURRENT_PLUGIN!_URL=!PLUGIN_URL!"
	rem %dk_call% dk_printVar !CURRENT_PLUGIN!_URL
	
	::### <PLUGIN>_IMPORT_FILE													master.zip
	set "!CURRENT_PLUGIN!_IMPORT_FILE="
	set "!CURRENT_PLUGIN!_IMPORT_FILE=!PLUGIN_URL_FILENAME!"
	rem %dk_call% dk_printVar !CURRENT_PLUGIN!_IMPORT_FILE
	
	::### <PLUGIN>_VERSION														master
	set "!CURRENT_PLUGIN!_VERSION="
	set "!CURRENT_PLUGIN!_VERSION=!PLUGIN_INSTALL_VERSION!"
	rem %dk_call% dk_printVar !CURRENT_PLUGIN!_VERSION

	::### <PLUGIN>_FOLDER														zlib-master
	set "!CURRENT_PLUGIN!_FOLDER="
	set "!CURRENT_PLUGIN!_FOLDER=!PLUGIN_INSTALL_FOLDER!"
	rem %dk_call% dk_printVar !CURRENT_PLUGIN!_FOLDER

	::### <PLUGIN>_IMPORT_NAME													zlib
	set "!CURRENT_PLUGIN!_IMPORT_NAME="	
	set "!CURRENT_PLUGIN!_IMPORT_NAME=!PLUGIN_IMPORT_NAME_LOWER!"
	rem %dk_call% dk_printVar !CURRENT_PLUGIN!_IMPORT_NAME

	::### <PLUGIN>_BRANCH														master
	set "!CURRENT_PLUGIN!_BRANCH="
	if defined PLUGIN_GIT_BRANCH (
		set "!CURRENT_PLUGIN!_BRANCH=!PLUGIN_GIT_BRANCH!"
		rem %dk_call% dk_printVar !CURRENT_PLUGIN!_BRANCH
    )
	
	::### <PLUGIN>_TAG															TODO
	set "!CURRENT_PLUGIN!_TAG="
	if defined PLUGIN_GIT_TAG (
		set "!CURRENT_PLUGIN!_TAG=!PLUGIN_GIT_TAG!"
		rem %dk_call% dk_printVar !CURRENT_PLUGIN!_TAG
    )
	
	
rem #####################################################
rem ############# TARGET <PLUGIN>_VARIABLES #############
rem #####################################################

	::### <PLUGIN>_TUPLE_DIR													C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	set "!CURRENT_PLUGIN!_TUPLE_DIR="
	if defined Target_Tuple (
		set "!CURRENT_PLUGIN!_TUPLE_DIR=!PLUGIN_INSTALL_PATH!/!Target_Tuple!"
		rem %dk_call% dk_printVar !CURRENT_PLUGIN!_TUPLE_DIR
	) 
	
	::### <PLUGIN>_CONFIG_DIR													C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set "!CURRENT_PLUGIN!_CONFIG_DIR="
	if defined CONFIG_PATH (
		set "!CURRENT_PLUGIN!_CONFIG_DIR=!PLUGIN_INSTALL_PATH!/!CONFIG_PATH!"
		rem %dk_call% dk_printVar !CURRENT_PLUGIN!_CONFIG_DIR
	) 
	
	::### <PLUGIN>_BUILD_DIR													C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set "!CURRENT_PLUGIN!_BUILD_DIR="
	if defined BUILD_PATH (
		set "!CURRENT_PLUGIN!_BUILD_DIR=!PLUGIN_INSTALL_PATH!/!BUILD_PATH!"
		rem %dk_call% dk_printVar !CURRENT_PLUGIN!_BUILD_DIR
	) 
	
	::### <PLUGIN>_DEBUG_DIR													C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set "!CURRENT_PLUGIN!_DEBUG_DIR="
	if defined Debug_Dir (
		set "!CURRENT_PLUGIN!_DEBUG_DIR=!PLUGIN_INSTALL_PATH!/!Target_Tuple!/!Debug_Dir!"
		rem %dk_call% dk_printVar !CURRENT_PLUGIN!_DEBUG_DIR
	) 
	
	::### <PLUGIN>_RELEASE_DIR													C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	set "!CURRENT_PLUGIN!_RELEASE_DIR="
	if defined Release_Dir (
		set "!CURRENT_PLUGIN!_RELEASE_DIR=!PLUGIN_INSTALL_PATH!/!Target_Tuple!/!Release_Dir!"
		rem %dk_call% dk_printVar !CURRENT_PLUGIN!_RELEASE_DIR
	) 
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_chdir "%DKIMPORTS_DIR%/git"
	%dk_call% dk_importVariables "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe" NAME git ROOT "%DKTOOLS_DIR%"
	%dk_call% dk_echo
	%dk_call% dk_printVar PLUGIN_ARGS
	%dk_call% dk_printVar PLUGIN_URL
	%dk_call% dk_printVar IMPORT_PATH
	%dk_call% dk_printVar BRANCH
	%dk_call% dk_printVar FOLDER
	%dk_call% dk_printVar NAME
	%dk_call% dk_printVar DIR
	%dk_call% dk_printVar ROOT
	%dk_call% dk_printVar TAG
	%dk_call% dk_printVar VERSION
	%dk_call% dk_printVar PLUGIN_URL_FILENAME
	%dk_call% dk_printVar PLUGIN_URL_LIST
	%dk_call% dk_printVar PLUGIN_GIT
	%dk_call% dk_printVar PLUGIN_URL_EXTENSION
	%dk_call% dk_printVar PLUGIN_URL_FILE
	%dk_call% dk_printVar PLUGIN_URL_ARRAY
	%dk_call% dk_printVar PLUGIN_URL_LENGTH
	%dk_call% dk_printVar IMPORT_PATH
	%dk_call% dk_printVar PLUGIN_IMPORT
	%dk_call% dk_printVar PLUGIN_IMPORT_PATH
	%dk_call% dk_printVar PLUGIN_IMPORT_NAME
	%dk_call% dk_printVar PLUGIN_IMPORT_NAME_LOWER
	%dk_call% dk_printVar PLUGIN_IMPORT_NAME_UPPER
	%dk_call% dk_printVar PLUGIN_GIT_FILENAME
	%dk_call% dk_printVar PLUGIN_GIT_NAME
	%dk_call% dk_printVar PLUGIN_GIT_NAME_LOWER
	%dk_call% dk_printVar PLUGIN_GIT_BRANCH
	%dk_call% dk_printVar PLUGIN_GIT_TAG
	%dk_call% dk_printVar PLUGIN_INSTALL_NAME
	%dk_call% dk_printVar PLUGIN_INSTALL_VERSION
	%dk_call% dk_printVar PLUGIN_INSTALL_FOLDER
	%dk_call% dk_printVar PLUGIN_INSTALL_ROOT
	%dk_call% dk_printVar PLUGIN_INSTALL_PATH
	%dk_call% dk_printVar CURRENT_PLUGIN
	%dk_call% dk_printVar %CURRENT_PLUGIN%_DIR
	%dk_call% dk_printVar %CURRENT_PLUGIN%_URL
	%dk_call% dk_printVar %CURRENT_PLUGIN%_IMPORT_FILE
	%dk_call% dk_printVar %CURRENT_PLUGIN%_VERSION
	%dk_call% dk_printVar %CURRENT_PLUGIN%_FOLDER
	%dk_call% dk_printVar %CURRENT_PLUGIN%_IMPORT_NAME
	%dk_call% dk_printVar %CURRENT_PLUGIN%_BRANCH
	%dk_call% dk_printVar %CURRENT_PLUGIN%_TAG
	%dk_call% dk_printVar %CURRENT_PLUGIN%_TUPLE_DIR
	%dk_call% dk_printVar %CURRENT_PLUGIN%_CONFIG_DIR
	%dk_call% dk_printVar %CURRENT_PLUGIN%_BUILD_DIR
	%dk_call% dk_printVar %CURRENT_PLUGIN%_DEBUG_DIR
	%dk_call% dk_printVar %CURRENT_PLUGIN%_RELEASE_DIR
	
	%dk_call% dk_chdir "%DKIMPORTS_DIR%/zlib"
	%dk_call% dk_importVariables "https://github.com/madler/zlib/archive/refs/heads/master.zip"
	%dk_call% dk_echo
	%dk_call% dk_printVar PLUGIN_ARGS
	%dk_call% dk_printVar PLUGIN_URL
	%dk_call% dk_printVar IMPORT_PATH
	%dk_call% dk_printVar BRANCH
	%dk_call% dk_printVar FOLDER
	%dk_call% dk_printVar NAME
	%dk_call% dk_printVar DIR
	%dk_call% dk_printVar ROOT
	%dk_call% dk_printVar TAG
	%dk_call% dk_printVar VERSION
	%dk_call% dk_printVar PLUGIN_URL_FILENAME
	%dk_call% dk_printVar PLUGIN_URL_LIST
	%dk_call% dk_printVar PLUGIN_GIT
	%dk_call% dk_printVar PLUGIN_URL_EXTENSION
	%dk_call% dk_printVar PLUGIN_URL_FILE
	%dk_call% dk_printVar PLUGIN_URL_ARRAY
	%dk_call% dk_printVar PLUGIN_URL_LENGTH
	%dk_call% dk_printVar IMPORT_PATH
	%dk_call% dk_printVar PLUGIN_IMPORT
	%dk_call% dk_printVar PLUGIN_IMPORT_PATH
	%dk_call% dk_printVar PLUGIN_IMPORT_NAME
	%dk_call% dk_printVar PLUGIN_IMPORT_NAME_LOWER
	%dk_call% dk_printVar PLUGIN_IMPORT_NAME_UPPER
	%dk_call% dk_printVar PLUGIN_GIT_FILENAME
	%dk_call% dk_printVar PLUGIN_GIT_NAME
	%dk_call% dk_printVar PLUGIN_GIT_NAME_LOWER
	%dk_call% dk_printVar PLUGIN_GIT_BRANCH
	%dk_call% dk_printVar PLUGIN_GIT_TAG
	%dk_call% dk_printVar PLUGIN_INSTALL_NAME
	%dk_call% dk_printVar PLUGIN_INSTALL_VERSION
	%dk_call% dk_printVar PLUGIN_INSTALL_FOLDER
	%dk_call% dk_printVar PLUGIN_INSTALL_ROOT
	%dk_call% dk_printVar PLUGIN_INSTALL_PATH
	%dk_call% dk_printVar CURRENT_PLUGIN
	%dk_call% dk_printVar %CURRENT_PLUGIN%_DIR
	%dk_call% dk_printVar %CURRENT_PLUGIN%_URL
	%dk_call% dk_printVar %CURRENT_PLUGIN%_IMPORT_FILE
	%dk_call% dk_printVar %CURRENT_PLUGIN%_VERSION
	%dk_call% dk_printVar %CURRENT_PLUGIN%_FOLDER
	%dk_call% dk_printVar %CURRENT_PLUGIN%_IMPORT_NAME
	%dk_call% dk_printVar %CURRENT_PLUGIN%_BRANCH
	%dk_call% dk_printVar %CURRENT_PLUGIN%_TAG
	%dk_call% dk_printVar %CURRENT_PLUGIN%_TUPLE_DIR
	%dk_call% dk_printVar %CURRENT_PLUGIN%_CONFIG_DIR
	%dk_call% dk_printVar %CURRENT_PLUGIN%_BUILD_DIR
	%dk_call% dk_printVar %CURRENT_PLUGIN%_DEBUG_DIR
	%dk_call% dk_printVar %CURRENT_PLUGIN%_RELEASE_DIR
%endfunction%
