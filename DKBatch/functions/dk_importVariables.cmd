@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#################################################################################
::# dk_importVariables(PLUGIN_URL) BRANCH FOLDER NAME PATH ROOT TAG VERSION
::#
::#	PLUGIN_URL (arg0)										###### EXAMPLES ######
::#		This url of the plugin to import.					https://github.com/madler/zlib.git     							* github repository link
::#															https://github.com/madler/zlib/archive/refs/heads/master.zip	* github sourcecode download
::#															https://github.com/madler/zlib        							* github page
::#															https://zlib.net/zlib-1.3.1.tar.gz								* library sourcecode download
::#															https://website.com/executable.exe              				* executable file
::#
::#	IMPORT_PATH  optional 
::#															C:\Users\Administrator\digitalknob\Development\3rdParty\_DKIMPORTS\zlib
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
::#															C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master
::#															C:\Users\Administrator\digitalknob\Development\3rdParty\myZLIB
::#
::#	ROOT  optional 
::#															C:\Users\Administrator\digitalknob\Development\3rdParty
::#															C:\Users\Administrator\MyLibraries
::#
::#	TAG  optional 
::#															v1.3.1
::#															v1.2.13
::#
::#	VERSION  optional 
::#															master
::#
:dk_importVariables
	::dk_debugFunc 1 9
	
	set "URL=%~1"
	%dk_call% dk_assertVar URL
	::%dk_call% dk_printVar URL
	
	set "IMPORT_PATH="
	%dk_call% dk_getOptionValue  IMPORT_PATH %* 	&:: C:\Users\Administrator\digitalknob\Development\3rdParty\_DKIMPORTS\zlib
	::%dk_call% dk_printVar IMPORT_PATH
	
	set "BRANCH="
	%dk_call% dk_getOptionValue  BRANCH      %*     &:: master
	::%dk_call% dk_printVar BRANCH
	
	set "FOLDER="
	%dk_call% dk_getOptionValue  FOLDER      %*     &:: zlib-master
	::%dk_call% dk_printVar FOLDER
	
	set "NAME="
	%dk_call% dk_getOptionValue  NAME        %*     &:: zlib
	::%dk_call% dk_printVar NAME
	
	set "DIR="
	%dk_call% dk_getOptionValue  DIR         %*     &:: C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master
	::%dk_call% dk_printVar DIR
	
	set "ROOT="
	%dk_call% dk_getOptionValue  ROOT        %*     &:: C:\Users\Administrator\digitalknob\Development\3rdParty
	::%dk_call% dk_printVar ROOT
	
	set "TAG="
	%dk_call% dk_getOptionValue  TAG         %*     &:: v1.3.1
	::%dk_call% dk_printVar TAG
	
	set "VERSION="
	%dk_call% dk_getOptionValue  VERSION     %*     &:: master
	::%dk_call% dk_printVar VERSION

	::### POPULATE VARIABLES ###
	:: PLUGIN_URL				- from arg:url														: https://github.com/madler/zlib/archive/refs/heads/master.zip
	:: PLUGIN_URL_LIST			- from PLUGIN_URL													: https:;github.com;madler;zlib;archive;refs;heads;master.zip
	:: PLUGIN_URL_LENGTH		- from PLUGIN_URL_LIST												: 8
	:: PLUGIN_URL_NODE n 		- from PLUGIN_URL_LIST												: [0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip
	:: PLUGIN_URL_FILENAME   	- from PLUGIN_URL													: master.zip
	:: PLUGIN_URL_EXTENSION  	- from PLUGIN_URL_FILENAME											: .zip
	:: PLUGIN_URL_FILE      	- from PLUGIN_URL_FILENAME											: master
	
	:: PLUGIN_IMPORT			- from CMAKE_CURRENT_LIST_DIR										: 1
	:: PLUGIN_IMPORT_PATH		- from CMAKE_CURRENT_LIST_DIR										: C:\Users\Administrator\digitalknob\Development\3rdParty\_DKIMPORTS\zlib
	:: PLUGIN_IMPORT_NAME		- from PLUGIN_IMPORT_PATH											: zlib
	
	:: PLUGIN_GIT				- from PLUGIN_URL													: 1
	:: PLUGIN_GIT_FILENAME		- from PLUGIN_URL													: zlib
	:: PLUGIN_GIT_NAME			- from PLUGIN_GIT_FILENAME											: zlib
	:: PLUGIN_GIT_BRANCH		- from default:master OR arg:BRANCH									: master
	:: PLUGIN_GIT_TAG			- from default: OR arg:TAG
	
	:: PLUGIN_INSTALL_NAME		- from PLUGIN_IMPORT_NAME, PLUGIN_GIT_NAME or PLUGIN_URL_NAME		: zlib
	:: PLUGIN_INSTALL_VERSION	- from PLUGIN_URL_FILE and PLUGIN_IMPORT_NAME						: master
	:: PLUGIN_INSTALL_FOLDER    - from PLUGIN_INSTALL_NAME amd PLUGIN_INSTALL_VERSION				: zlib-master
	:: PLUGIN_INSTALL_ROOT		- from default:DK3RDPARTY OR arg:ROOT								: C:\Users\Administrator\digitalknob\Development\3rdParty
	:: PLUGIN_INSTALL_PATH		- from PLUGIN_INSTALL_ROOT and PLUGIN_INSTALL_FOLDER				: C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master
	
	:: <PLUGIN>					- from PLUGIN_IMPORT_NAME						:ZLIB   			: C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master
	:: <CURRENT_PLUGIN>			- from <PLUGIN>									:ZLIB				: C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master
	:: <PLUGIN>_DIR				- from PLUGIN_INSTALL_PATH						:ZLIB_DIR			: C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master
	:: <PLUGIN>_URL				- from PLUGIN_URL								:ZLIB_URL			: https://github.com/madler/zlib/archive/refs/heads/master.zip
	:: <PLUGIN>_DL_FILE			- from PLUGIN_URL_FILENAME						:ZLIB_DL_FILE		: master.zip
	:: <PLUGIN>_VERSION         - from PLUGIN_INSTALL_VERSION					:ZLIB_VERSION		: master
	:: <PLUGIN>_FOLDER			- from PLUGIN_INSTALL_FOLDER					:ZLIB_FOLDER		: zlib-master
	:: <PLUGIN>_IMPORT_NAME		- from PLUGIN_IMPORT_NAME						:ZLIB_IMPORT_NAME	: zlib
	:: <PLUGIN>_BRANCH			- from PLUGIN_GIT_BRANCH						:ZLIB_BRANCH		: master
	:: <PLUGIN>_TAG				- from PLUGIN_GIT_TAG							:ZLIB_TAG			: 
	:: <PLUGIN>_TRIPLE_DIR		- from PLUGIN_INSTALL_PATH and target_triple	:ZLIB_TRIPLE_DIR	: C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master\win_x86_64_clang
	:: <PLUGIN>_CONFIG_DIR		- from PLUGIN_INSTALL_PATH and CONFIG_DIR		:ZLIB_CONFIG_DIR	: C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master\win_x86_64_clang\Debug
	:: <PLUGIN>_BUILD_DIR		- from PLUGIN_INSTALL_PATH and BUILD_DIR		:ZLIB_BUILD_DIR		: C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master\win_x86_64_clang\Debug
	:: <PLUGIN>_DEBUG_DIR		- from PLUGIN_INSTALL_PATH and DEBUG_DIR		:ZLIB_DEBUG_DIR		: C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master\win_x86_64_clang\Debug
	:: <PLUGIN>_RELEASE_DIR		- from PLUGIN_INSTALL_PATH and RELEASE_DIR		:ZLIB_RELEASE_DIR	: C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master\win_x86_64_clang\Release
	
	
	::##############################################
	::############ PLUGIN_URL VARIABLES ############
	::##############################################					################################# EXAMPLE ##########################
	::# PLUGIN_URL
	set "PLUGIN_URL="
	set "PLUGIN_URL=%URL%"
	::%dk_call% dk_printVar PLUGIN_URL 											&:: PLUGIN_URL				: https://github.com/madler/zlib/archive/refs/heads/master.zip

	::# PLUGIN_URL_FILENAME
	set "PLUGIN_URL_FILENAME="
	%dk_call% dk_basename !PLUGIN_URL! PLUGIN_URL_FILENAME 							
	::%dk_call% dk_printVar PLUGIN_URL_FILENAME 									&:: PLUGIN_URL_FILENAME		: master.zip
	
	::# PLUGIN_URL_LIST
	set "PLUGIN_URL_LIST="
	%dk_call% dk_replaceAll !PLUGIN_URL!  "/"  ";"  PLUGIN_URL_LIST 					
	::%dk_call% dk_printVar PLUGIN_URL_LIST 										&:: PLUGIN_URL_LIST			: https:;github.com;madler;zlib;archive;refs;heads;master.zip
	
	::# PLUGIN_GIT
	set "PLUGIN_GIT="
	%dk_call% dk_includes "!PLUGIN_URL!" "https://github.com" && set "PLUGIN_GIT=1"			
	::%dk_call% dk_printVar PLUGIN_GIT 											&:: PLUGIN_GIT				: 1
	
	::# PLUGIN_URL_EXTENSION
	set "PLUGIN_URL_EXTENSION="
	%dk_call% dk_getExtension !PLUGIN_URL_FILENAME! PLUGIN_URL_EXTENSION 			
	::%dk_call% dk_printVar PLUGIN_URL_EXTENSION 									&:: PLUGIN_URL_EXTENSION	: .zip

	::# PLUGIN_URL_FILE
	set "PLUGIN_URL_FILE="
	%dk_call% dk_removeExtension !PLUGIN_URL_FILENAME! PLUGIN_URL_FILE 				
	::%dk_call% dk_printVar PLUGIN_URL_FILE 										&:: PLUGIN_URL_FILE			: master

	::# PLUGIN_URL_NODE n 
	%dk_call% dk_listToArray "!PLUGIN_URL_LIST!" PLUGIN_URL_ARRAY
	::%dk_call% dk_printVar PLUGIN_URL_ARRAY                                      &:: PLUGIN_URL_NODE n 		: [0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip

	::# PLUGIN_URL_LENGTH
	set "PLUGIN_URL_LENGTH="
	%dk_call% Array::dk_length PLUGIN_URL_ARRAY
	set "PLUGIN_URL_LENGTH=%dk_length%"
	::%dk_call% dk_printVar PLUGIN_URL_LENGTH 									&:: PLUGIN_URL_LENGTH		: 8
	

	::#######################################################
	::############### PLUGIN_IMPORT VARIABLES ###############
	::#######################################################
	if not defined IMPORT_PATH  set "IMPORT_PATH=%CD%"
	::%dk_call% dk_printVar IMPORT_PATH
	
	::# PLUGIN_IMPORT	
	set "PLUGIN_IMPORT="
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_includes %IMPORT_PATH% !DKIMPORTS_DIR! && set "PLUGIN_IMPORT=1"
	::%dk_call% dk_printVar PLUGIN_IMPORT
	
	rem # PLUGIN_IMPORT_PATH
	set "PLUGIN_IMPORT_PATH="
	set "PLUGIN_IMPORT_PATH=%IMPORT_PATH%"				
	::%dk_call% dk_printVar PLUGIN_IMPORT_PATH 								& rem PLUGIN_IMPORT_PATH		: C:\Users\Administrator\digitalknob\Development\3rdParty\_DKIMPORTS\zlib

	rem # PLUGIN_IMPORT_NAME
	set "PLUGIN_IMPORT_NAME="
	if defined NAME (
		set "PLUGIN_IMPORT_NAME=!NAME!"
	) else (
		%dk_call% dk_basename "!PLUGIN_IMPORT_PATH!" PLUGIN_IMPORT_NAME 					
	)
	::%dk_call% dk_printVar PLUGIN_IMPORT_NAME 								& rem PLUGIN_IMPORT_NAME		: zlib

	rem # PLUGIN_IMPORT_NAME_LOWER
	set "PLUGIN_IMPORT_NAME_LOWER="
	%dk_call% dk_toLower "!PLUGIN_IMPORT_NAME!" PLUGIN_IMPORT_NAME_LOWER
	::%dk_call% dk_printVar PLUGIN_IMPORT_NAME_LOWER				         	& rem PLUGIN_IMPORT_NAME_LOWER	: zlib
	
	rem # PLUGIN_IMPORT_NAME_UPPER
	set "PLUGIN_IMPORT_NAME_UPPER="
	%dk_call% dk_toUpper "!PLUGIN_IMPORT_NAME!" PLUGIN_IMPORT_NAME_UPPER
	::%dk_call% dk_printVar PLUGIN_IMPORT_NAME_UPPER							& rem PLUGIN_IMPORT_NAME_UPPER	: ZLIB
	
	::##############################################
	::############ PLUGIN_GIT VARIABLES ############
	::##############################################
	if defined PLUGIN_GIT (
		rem # PLUGIN_GIT_FILENAME
		set "PLUGIN_GIT_FILENAME="
        %dk_call% Array::dk_at PLUGIN_URL_ARRAY 3 
		(set PLUGIN_GIT_FILENAME=%dk_at%)							
		rem %dk_call% dk_printVar PLUGIN_GIT_FILENAME 								&rem PLUGIN_GIT_FILENAME		: zlib
		
		rem # PLUGIN_GIT_NAME
		set "PLUGIN_GIT_NAME="
		%dk_call% dk_replaceAll "!PLUGIN_GIT_FILENAME!" ".git" "" PLUGIN_GIT_NAME 			
		rem %dk_call% dk_printVar PLUGIN_GIT_NAME 									&rem PLUGIN_GIT_NAME			: zlib
		
		rem # PLUGIN_GIT_NAME_LOWER
		set "PLUGIN_GIT_NAME_LOWER="
		%dk_call% dk_toLower "!PLUGIN_GIT_NAME!" PLUGIN_GIT_NAME_LOWER
		rem %dk_call% dk_printVar PLUGIN_GIT_NAME_LOW						        & rem PLUGIN_GIT_NAME_LOWER			: zlib
		
		rem # PLUGIN_GIT_BRANCH
		set "PLUGIN_GIT_BRANCH="
		if defined BRANCH (
			set "PLUGIN_GIT_BRANCH=!BRANCH!"
		)
		rem %dk_call% dk_getGitBranchName !PLUGIN_URL! PLUGIN_GIT_BRANCH 					
		if NOT defined PLUGIN_GIT_BRANCH (
			set "PLUGIN_GIT_BRANCH=master" 
		)
		rem %dk_call% dk_printVar PLUGIN_GIT_BRANCH 								&rem PLUGIN_GIT_BRANCH		: master
		
		rem # PLUGIN_GIT_TAG
		set "PLUGIN_GIT_TAG="
		if defined TAG (
			set "PLUGIN_GIT_TAG=!TAG!"
		)
	)

	
	::##################################################
	::############ PLUGIN_INSTALL VARIABLES ############
	::##################################################
	::# PLUGIN_INSTALL_NAME
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
	::dk_convertToCIdentifier "!PLUGIN_INSTALL_NAME!" PLUGIN_INSTALL_NAME
	:: %dk_call% dk_printVar PLUGIN_INSTALL_NAME 									&:: PLUGIN_INSTALL_NAME		: zlib

	::# PLUGIN_INSTALL_VERSION
	set "PLUGIN_INSTALL_VERSION="
	if defined VERSION (
		set "PLUGIN_INSTALL_VERSION=!VERSION!"
	) else if defined PLUGIN_IMPORT_NAME if defined PLUGIN_URL_FILE (
		%dk_call% dk_toLower !PLUGIN_IMPORT_NAME! PLUGIN_IMPORT_NAME_LOWER 	
		%dk_call% dk_toLower !PLUGIN_URL_FILE!    PLUGIN_URL_FILE_LOWER 
		rem # deduce the plugin version		
		%dk_call% dk_replaceAll !PLUGIN_URL_FILE_LOWER! !PLUGIN_IMPORT_NAME_LOWER! "" PLUGIN_INSTALL_VERSION 	
		if "!PLUGIN_IMPORT_NAME_LOWER!" == "!PLUGIN_URL_FILE_LOWER!" (
			if defined PLUGIN_GIT_TAG (
				set "PLUGIN_INSTALL_VERSION=!PLUGIN_GIT_TAG!"
			) else if defined PLUGIN_GIT_BRANCH (
				set "PLUGIN_INSTALL_VERSION=!PLUGIN_GIT_BRANCH!" 
			) else (
				set "PLUGIN_INSTALL_VERSION=master"
			)  
		)  
		if "!PLUGIN_INSTALL_VERSION:~0,1!" == "-" (
			set "PLUGIN_INSTALL_VERSION=!PLUGIN_INSTALL_VERSION:~1!"
		)  
		if "!PLUGIN_INSTALL_VERSION:~0,1!" == "_" (
			set "PLUGIN_INSTALL_VERSION=!PLUGIN_INSTALL_VERSION:~1!"
		)  
	)    
	:: %dk_call% dk_printVar PLUGIN_INSTALL_VERSION 								&:: PLUGIN_INSTALL_VERSION	: master

	::# PLUGIN_INSTALL_FOLDER
	set "PLUGIN_INSTALL_FOLDER="
	if defined FOLDER (
		set "PLUGIN_INSTALL_FOLDER=!FOLDER!"
	) else if defined PLUGIN_INSTALL_VERSION (
		set "PLUGIN_INSTALL_FOLDER=!PLUGIN_INSTALL_NAME!-!PLUGIN_INSTALL_VERSION!"
	) else ( 
		set "PLUGIN_INSTALL_FOLDER=!PLUGIN_INSTALL_NAME!"
	)  
	:: %dk_call% dk_printVar PLUGIN_INSTALL_FOLDER 								&:: PLUGIN_INSTALL_FOLDER	: zlib-master

	::# PLUGIN_INSTALL_ROOT
	set "PLUGIN_INSTALL_ROOT="
	if defined ROOT (
		set "PLUGIN_INSTALL_ROOT=!ROOT!"
		set "ROOT="
	) else (
		%dk_call% dk_assertPath DK3RDPARTY_DIR
		set "PLUGIN_INSTALL_ROOT=!DK3RDPARTY_DIR!"
	)
	:: %dk_call% dk_printVar PLUGIN_INSTALL_ROOT 					&:: PLUGIN_INSTALL_ROOT		: C:\Users\Administrator\digitalknob\Development\3rdParty
	
	::# PLUGIN_INSTALL_PATH
	set "PLUGIN_INSTALL_PATH="
	if defined DIR (
		set "PLUGIN_INSTALL_PATH=!DIR!"
	) else (
		%dk_call% dk_assertVar PLUGIN_INSTALL_ROOT 
		%dk_call% dk_assertVar PLUGIN_INSTALL_FOLDER
		set "PLUGIN_INSTALL_PATH=!PLUGIN_INSTALL_ROOT!\!PLUGIN_INSTALL_FOLDER!"	
	)
	:: %dk_call% dk_printVar PLUGIN_INSTALL_PATH 									&:: PLUGIN_INSTALL_PATH		: C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master

	
	
	
	::##############################################
	::############# <PLUGIN>_VARIABLES #############
	::##############################################
	
	if defined PLUGIN_IMPORT_NAME_LOWER if defined PLUGIN_GIT_NAME_LOWER (
		if NOT "!PLUGIN_IMPORT_NAME_LOWER!"=="!PLUGIN_GIT_NAME_LOWER!" (
			%dk_call% dk_warning "PLUGIN_IMPORT_NAME:!PLUGIN_IMPORT_NAME_LOWER! and PLUGIN_GIT_NAME:!PLUGIN_GIT_NAME_LOWER! do not match " 
		)  
	)  

	::# CURRENT_PLUGIN
	set "CURRENT_PLUGIN="
	%dk_call% dk_set CURRENT_PLUGIN !PLUGIN_IMPORT_NAME_UPPER! 
	%dk_call% dk_convertToCIdentifier !CURRENT_PLUGIN! CURRENT_PLUGIN 
	if not "!PLUGIN_IMPORT_NAME_UPPER!" == "!CURRENT_PLUGIN!" (
		%dk_call% dk_notice "!PLUGIN_IMPORT_NAME_UPPER! contains non-alphanumeric characters and is changed to !CURRENT_PLUGIN!" 
	)  
	%dk_call% dk_printVar CURRENT_PLUGIN 										&:: CURRENT_PLUGIN			: ZLIB

	::# <PLUGIN>
	set "!CURRENT_PLUGIN!="
	%dk_call% dk_set !CURRENT_PLUGIN! !PLUGIN_INSTALL_PATH! 
	%dk_call% dk_printVar !CURRENT_PLUGIN! 										&:: ZLIB					: C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master
	
	::# <PLUGIN>_DIR     ### DO NOT USE GIT_DIR ###
	set "!CURRENT_PLUGIN!_DIR="
	if "!CURRENT_PLUGIN!" neq "GIT" ( 
		%dk_call% dk_set !CURRENT_PLUGIN!_DIR !PLUGIN_INSTALL_PATH! 
		%dk_call% dk_printVar !CURRENT_PLUGIN!_DIR 								& rem ZLIB_DIR				: C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master
	)
	
	::# <PLUGIN>_URL
	set "!CURRENT_PLUGIN!_URL="
	%dk_call% dk_set !CURRENT_PLUGIN!_URL !PLUGIN_URL! 
	%dk_call% dk_printVar !CURRENT_PLUGIN!_URL 									&:: ZLIB_URL				: https://github.com/madler/zlib/archive/refs/heads/master.zip
	
	::# <PLUGIN>_DL_FILE
	set "!CURRENT_PLUGIN!_DK_FILE="
	%dk_call% dk_set !CURRENT_PLUGIN!_DL_FILE !PLUGIN_URL_FILENAME! 
	%dk_call% dk_printVar !CURRENT_PLUGIN!_DL_FILE 								&:: ZLIB_DL_FILE 			: master.zip
	
	::# <PLUGIN>_VERSION
	set "!CURRENT_PLUGIN!_VERSION="
	%dk_call% dk_set !CURRENT_PLUGIN!_VERSION !PLUGIN_INSTALL_VERSION! 
	%dk_call% dk_printVar !CURRENT_PLUGIN!_VERSION 								&:: ZLIB_VERSION  			: master

	::# <PLUGIN>_FOLDER
	set "!CURRENT_PLUGIN!_FOLDER="
	%dk_call% dk_set !CURRENT_PLUGIN!_FOLDER !PLUGIN_INSTALL_FOLDER! 
	%dk_call% dk_printVar !CURRENT_PLUGIN!_FOLDER 								&:: ZLIB_FOLDER				: zlib-master

	::# <PLUGIN>_IMPORT_NAME
	set "!CURRENT_PLUGIN!_IMPORT_NAME="	
	%dk_call% dk_set !CURRENT_PLUGIN!_IMPORT_NAME !PLUGIN_IMPORT_NAME_LOWER! 
	%dk_call% dk_printVar !CURRENT_PLUGIN!_IMPORT_NAME                           &:: ZLIB_IMPORT_NAME		: zlib

	::# <PLUGIN>_BRANCH
	set "!CURRENT_PLUGIN!_BRANCH="
	if defined PLUGIN_GIT_BRANCH (
		set "!CURRENT_PLUGIN!_BRANCH=!PLUGIN_GIT_BRANCH!"
		%dk_call% dk_printVar !CURRENT_PLUGIN!_BRANCH 							&rem ZLIB_BRANCH			: master
    )
	
	::# <PLUGIN>_TAG
	set "!CURRENT_PLUGIN!_TAG="
	if defined PLUGIN_GIT_TAG (
		%dk_call% dk_set !CURRENT_PLUGIN!_TAG !PLUGIN_GIT_TAG! 
		%dk_call% dk_printVar !CURRENT_PLUGIN!_TAG 								&rem ZLIB_TAG				:
    )
	
	
	
	::#####################################################
	::############# TARGET <PLUGIN>_VARIABLES #############
	::#####################################################
	::# <PLUGIN>_TRIPLE_DIR
	set "!CURRENT_PLUGIN!_TRIPLE_DIR="
	if defined target_triple (
		%dk_call% dk_set !CURRENT_PLUGIN!_TRIPLE_DIR "!PLUGIN_INSTALL_PATH!\!target_triple!" 
		%dk_call% dk_printVar !CURRENT_PLUGIN!_TRIPLE_DIR 					&rem ZLIB_TRIPLE_DIR	: C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master\win_x86_64_clang
	)  
	
	::# <PLUGIN>_CONFIG_DIR
	set "!CURRENT_PLUGIN!_CONFIG_DIR="
	if defined CONFIG_PATH (
		%dk_call% dk_set !CURRENT_PLUGIN!_CONFIG_DIR "!PLUGIN_INSTALL_PATH!\!CONFIG_PATH!" 
		%dk_call% dk_printVar !CURRENT_PLUGIN!_CONFIG_DIR 					&rem ZLIB_CONFIG_DIR	: C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master\win_x86_64_clang\Debug
	)  
	
	::# <PLUGIN>_BUILD_DIR
	set "!CURRENT_PLUGIN!_BUILD_DIR="
	if defined BUILD_PATH (
		%dk_call% dk_set !CURRENT_PLUGIN!_BUILD_DIR "!PLUGIN_INSTALL_PATH!\!BUILD_PATH!" 
		%dk_call% dk_printVar !CURRENT_PLUGIN!_BUILD_DIR 					&rem ZLIB_BUILD_DIR	: C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master\win_x86_64_clang\Debug
	)  
	
	::# <PLUGIN>_DEBUG_DIR
	set "!CURRENT_PLUGIN!_DEBUG_DIR="
	if defined DEBUG_DIR (
		%dk_call% dk_set !CURRENT_PLUGIN!_DEBUG_DIR "!PLUGIN_INSTALL_PATH!\!target_triple!\!DEBUG_DIR!" 
		%dk_call% dk_printVar !CURRENT_PLUGIN!_DEBUG_DIR 					&rem ZLIB_DEBUG_DIR	: C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master\win_x86_64_clang\Debug
	)  
	
	::# <PLUGIN>_RELEASE_DIR
	set "!CURRENT_PLUGIN!_RELEASE_DIR="
	if defined RELEASE_DIR (
		%dk_call% dk_set !CURRENT_PLUGIN!_RELEASE_DIR "!PLUGIN_INSTALL_PATH!\!target_triple!\!RELEASE_DIR!" 
		%dk_call% dk_printVar !CURRENT_PLUGIN!_RELEASE_DIR 					&rem ZLIB_RELEASE_DIR	: C:\Users\Administrator\digitalknob\Development\3rdParty\zlib-master\win_x86_64_clang\Release
	)  

	::endlocal & set "%2=!CURRENT_PLUGIN!"
	%dk_call% dk_printVar !CURRENT_PLUGIN! 
!endfunction!







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
 ::setlocal
	
::	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
::	%dk_call% dk_importVariables "https://qemu.weilnetz.de/w64/qemu-w64-setup-20240903.exe" NAME qemu ROOT %DKTOOLS_DIR%
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe"    NAME git    ROOT %DKTOOLS_DIR%
!endfunction!
