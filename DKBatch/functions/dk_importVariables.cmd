@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::######################################################################################################################################
::# dk_importVariables(PLUGIN.URL rtn_var) IMPORT_ROOT IMPORT_NAME IMPORT_PATH INSTALL_ROOT INSTALL_NAME INSTALL_PATH VERSION BRANCH TAG
::#
::#															###### EXAMPLES ######
::#	PLUGIN_URL												https://github.com/madler/zlib.git     							* github repository link
::#															https://github.com/madler/zlib/archive/refs/heads/master.zip	* github sourcecode download
::#															https://github.com/madler/zlib        							* github page
::#															https://zlib.net/zlib-1.3.1.tar.gz								* library sourcecode download
::#															https://website.com/executable.exe              				* executable file
::#
::#
::#	IMPORT_ROOT	(optional)									C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
::#
::#
::#	IMPORT_NAME (optional)									zlib
::#
::#
::#	IMPORT_PATH (optional)									C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
::#
::#
::#	INSTALL_ROOT (optional)									C:/Users/Administrator/DigitalKnob/Development/DKTools
::#
::#
::#	INSTALL_NAME (optional)									zlib-8-5-2025
::#															myZLIB
::#
::#	INSTALL_PATH (optional)									C:/Users/Administrator/DigitalKnob/Development/DKTools/zlib-8-5-2025
::#															C:/Users/Administrator/DigitalKnob/Development/DKTools/myZLIB
::#
::#	VERSION (optional)										master
::#
::#
::#	BRANCH (optional)										develop
::#															master
::#
::#	TAG (optional)											v1.3.1
::#															v1.2.13
::#
:dk_importVariables
::%setlocal%
::%dk_call% dk_debugFunc 1 9
	
	::### PLUGIN(hashtable) 
	:: declare -A -x PLUGIN   ##### TODO #####
	::####################
																::###### EXAMPLE ######
	::### IMPORT_ROOT											/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	%dk_call% dk_unset IMPORT_ROOT
	%dk_call% dk_getParameterValue IMPORT_ROOT %*
	set "PLUGIN.IMPORT_ROOT=%IMPORT_ROOT%"
	:: %dk_call% dk_echo "PLUGIN.IMPORT_ROOT = %PLUGIN.IMPORT_ROOT%"
	
	::### IMPORT_NAME											zlib
	%dk_call% dk_unset IMPORT_NAME
	%dk_call% dk_getParameterValue IMPORT_NAME %*
	set "PLUGIN.IMPORT_NAME=%IMPORT_NAME%"
	:: %dk_call% dk_echo "PLUGIN.IMPORT_NAME = '%PLUGIN.IMPORT_NAME%'"
	
	::### IMPORT_PATH											/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	%dk_call% dk_unset IMPORT_PATH
	%dk_call% dk_getParameterValue IMPORT_PATH %*
	set "PLUGIN.IMPORT_PATH=%IMPORT_PATH%"
	:: %dk_call% dk_echo "PLUGIN.IMPORT_PATH = '%PLUGIN.IMPORT_PATH%'"
	
	::### INSTALL_ROOT											/c/Users/Administrator/DigitalKnob/Development/3rdParty
	%dk_call% dk_unset INSTALL_ROOT
	%dk_call% dk_getParameterValue INSTALL_ROOT %*
	set "PLUGIN.INSTALL_ROOT=%INSTALL_ROOT%"
	:: %dk_call% dk_echo "PLUGIN.INSTALL_ROOT = '%PLUGIN.INSTALL_ROOT%'"
	
	::### INSTALL_NAME											zlib-master
	%dk_call% dk_unset INSTALL_NAME
	%dk_call% dk_getParameterValue INSTALL_NAME %*
	set "PLUGIN.INSTALL_NAME=%INSTALL_NAME%"
	:: %dk_call% dk_echo "PLUGIN.INSTALL_NAME = '%PLUGIN.INSTALL_NAME%'"
	
	::### INSTALL_PATH											/c/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	%dk_call% dk_unset INSTALL_PATH
	%dk_call% dk_getParameterValue INSTALL_PATH %*
	set "PLUGIN.INSTALL_PATH=%INSTALL_PATH%"
	:: %dk_call% dk_echo "PLUGIN.INSTALL_PATH = '%PLUGIN.INSTALL_PATH%'"
	
	::### VERSION												master
	%dk_call% dk_unset VERSION
	%dk_call% dk_getParameterValue VERSION %*
	set "PLUGIN.VERSION=%VERSION%"
	:: %dk_call% dk_echo "PLUGIN.VERSION = '%PLUGIN.VERSION%'"
	
	::### BRANCH												master
	%dk_call% dk_unset BRANCH
	%dk_call% dk_getParameterValue BRANCH	%*
	set "PLUGIN.BRANCH=%BRANCH%"
	:: %dk_call% dk_echo "PLUGIN.BRANCH = '%PLUGIN.BRANCH%'"
	
	::### TAG													v1.3.1
	%dk_call% dk_unset TAG
	%dk_call% dk_getParameterValue TAG %*
	set "PLUGIN.TAG=%TAG%"
	:: %dk_call% dk_echo "PLUGIN.TAG = '%PLUGIN.TAG%'"

		
		
		
		
	::############### $PLUGIN ##################
	
	::### PLUGIN.IMPORT_PATH										/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	if not defined PLUGIN.IMPORT_PATH (	
		%dk_call% dk_getcwd
		set "PLUGIN.IMPORT_PATH=%CD:\=/%"
	)
::	%dk_call% dk_echo "PLUGIN.IMPORT_PATH = %PLUGIN.IMPORT_PATH%"
	
	::### PLUGIN.IMPORT_ROOT										/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	if not defined PLUGIN.IMPORT_ROOT (	
		%dk_call% dk_dirname			%PLUGIN.IMPORT_PATH%		PLUGIN.IMPORT_ROOT
	)
::	%dk_call% dk_echo "PLUGIN.IMPORT_ROOT = %PLUGIN.IMPORT_ROOT%"
	
	::### PLUGIN.IMPORT_NAME										zlib
	if not defined PLUGIN.IMPORT_NAME (
		%dk_call% dk_basename				%PLUGIN.IMPORT_PATH%	PLUGIN.IMPORT_NAME
	)
::	%dk_call% dk_echo "PLUGIN.IMPORT_NAME = %PLUGIN.IMPORT_NAME%"
	
	::### PLUGIN.IMPORT_NAME_Upper
	%dk_call% dk_toUpper				%PLUGIN.IMPORT_NAME%		PLUGIN.IMPORT_NAME_Upper
::	%dk_call% dk_echo "PLUGIN.IMPORT_NAME_Upper = %PLUGIN.IMPORT_NAME_Upper%"
	
	::### PLUGIN.IMPORT_NAME_Alphanumeric
	%dk_call% dk_convertToCIdentifier	%PLUGIN.IMPORT_NAME_Upper% 	PLUGIN.IMPORT_NAME_Alphanumeric
::	%dk_call% dk_echo "PLUGIN.IMPORT_NAME_Alphanumeric = %PLUGIN.IMPORT_NAME_Alphanumeric%"
	
	::### PLUGIN.ID
	set "PLUGIN.ID=%PLUGIN.IMPORT_NAME_Upper%"
	if "%PLUGIN.ID%" neq "%PLUGIN.IMPORT_NAME_Alphanumeric%" (
		%dk_call% dk_notice "%PLUGIN.ID% contains non-alphanumeric characters and will be set to %PLUGIN.IMPORT_NAME_Alphanumeric%"
		set "PLUGIN.ID=%PLUGIN.IMPORT_NAME_Alphanumeric%"
	)
::	%dk_call% dk_echo "PLUGIN.ID = %PLUGIN.ID%"



	::###### <PLUGIN.ID>.variables ######
	::### <PLUGIN.ID>.ID
	set "%PLUGIN.ID%.ID = %PLUGIN.ID%"
	%dk_call% dk_echo "%PLUGIN.ID%.ID = !%PLUGIN.ID%.ID!"
	
	::### <PLUGIN.ID>.IMPORT_PATH
	set "%PLUGIN.ID%.IMPORT_PATH = %PLUGIN.IMPORT_PATH%"
	%dk_call% dk_echo "%PLUGIN.ID%.IMPORT_PATH = !%PLUGIN.ID%.IMPORT_PATH!"
	
	::### <PLUGIN.ID>.IMPORT_ROOT
	set "%PLUGIN.ID%.IMPORT_ROOT = %PLUGIN.IMPORT_ROOT%"
	%dk_call% dk_echo "%PLUGIN.ID%.IMPORT_ROOT = !%PLUGIN.ID%.IMPORT_ROOT!"
	
	::### <PLUGIN.ID>.IMPORT_NAME
	set "%PLUGIN.ID%.IMPORT_NAME = %PLUGIN.IMPORT_NAME%"
	%dk_call% dk_echo "%PLUGIN.ID%.IMPORT_NAME = !%PLUGIN.ID%.IMPORT_NAME!"
	
	::### <PLUGIN.ID>.IMPORT_NAME_Upper
	set "%PLUGIN.ID%.IMPORT_NAME_Upper = %PLUGIN.IMPORT_NAME_Upper%"
	%dk_call% dk_echo "%PLUGIN.ID%.IMPORT_NAME_Upper = !%PLUGIN.ID%.IMPORT_NAME_Upper!"
	
	::### <PLUGIN.ID>.IMPORT_NAME_Alphanumeric
	set "%PLUGIN.ID%.IMPORT_NAME_Alphanumeric = %PLUGIN.IMPORT_NAME_Alphanumeric%"
	%dk_call% dk_echo "%PLUGIN.ID%.IMPORT_NAME_Alphanumeric = !%PLUGIN.ID%.IMPORT_NAME_Alphanumeric!"
	
	
	
	
	::### PLUGIN.ARGS													"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	set "PLUGIN.ARGS=%*"
::	%dk_call% dk_echo "PLUGIN.ARGS = %PLUGIN.ARGS%"
	::### <PLUGIN.ID>.ARGS
	set "%PLUGIN.ID%.ARGS=%PLUGIN.ARGS%"
	%dk_call% dk_echo "%PLUGIN.ID%.ARGS = !%PLUGIN.ID%.ARGS!"
	
	::### PLUGIN.URL													"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	set "PLUGIN.URL=%~1"
::	%dk_call% dk_echo "PLUGIN.URL = %PLUGIN.URL%"
	::### <PLUGIN.ID>.URL
	set "%PLUGIN.ID%.URL=%PLUGIN.URL%"
	%dk_call% dk_echo "%PLUGIN.ID%.URL = !%PLUGIN.ID%.URL!"
	
	::### PLUGIN.IMPORT												1
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_includes %PLUGIN.IMPORT_PATH% %DKIMPORTS_DIR% && set "PLUGIN.IMPORT=1"
::	%dk_call% dk_echo "PLUGIN.IMPORT = %PLUGIN.IMPORT%"
	::### <PLUGIN.ID>.IMPORT	
	set "%PLUGIN.ID%.IMPORT=%PLUGIN.IMPORT%"
	%dk_call% dk_echo "%PLUGIN.ID%.IMPORT = !%PLUGIN.ID%.IMPORT!"
	
	::### PLUGIN.URL_Filename											master.zip
	%dk_call% dk_basename			%PLUGIN.URL%						PLUGIN.URL_Filename				
::	%dk_call% dk_echo "PLUGIN.URL_Filename = %PLUGIN.URL_Filename%"
	::### <PLUGIN.ID>.URL_Filename	
	set "%PLUGIN.ID%.URL_Filename=%PLUGIN.URL_Filename%"
	%dk_call% dk_echo "%PLUGIN.ID%.URL_Filename = !%PLUGIN.ID%.URL_Filename!"
	
	::### PLUGIN.URL_List												https:;github.com;madler;zlib;archive;refs;heads;master.zip
	%dk_call% dk_replaceAll 		%PLUGIN.URL% 		"/" 	";" 	PLUGIN.URL_List
::	%dk_call% dk_replaceAll 		%PLUGIN.URL_List% 	";;" 	";" 	PLUGIN.URL_List
::	%dk_call% dk_echo "PLUGIN.URL_List = %PLUGIN.URL_List%"
	::### <PLUGIN.ID>.URL_List	
	set "%PLUGIN.ID%.URL_List=%PLUGIN.URL_List%"
	%dk_call% dk_echo "%PLUGIN.ID%.URL_List = !%PLUGIN.ID%.URL_List!"
	
	::### PLUGIN.GIT													1
	%dk_call% dk_includes "%PLUGIN.URL%" "https://github.com" && (set "PLUGIN.GIT=1" )
::	%dk_call% dk_echo "PLUGIN.GIT = %PLUGIN.GIT%"
	::### <PLUGIN.ID>.GIT	
	set "%PLUGIN.ID%.GIT=%PLUGIN.GIT%"
	%dk_call% dk_echo "%PLUGIN.ID%.GIT = !%PLUGIN.ID%.GIT!"
	
	::### PLUGIN.URL_Extension											.zip
	%dk_call% dk_getExtension		%PLUGIN.URL_Filename%				PLUGIN.URL_Extension
::	%dk_call% dk_echo "PLUGIN.URL_Extension = %PLUGIN.URL_Extension%"
	::### <PLUGIN.ID>.URL_Extension	
	set "%PLUGIN.ID%.URL_Extension=%PLUGIN.URL_Extension%"
	%dk_call% dk_echo "%PLUGIN.ID%.URL_Extension = !%PLUGIN.ID%.URL_Extension!"
	
	::### PLUGIN.URL_File												master
	%dk_call% dk_removeExtension	%PLUGIN.URL_Filename%				PLUGIN.URL_File
::	%dk_call% dk_echo "PLUGIN.URL_File = %PLUGIN.URL_File%"
	::### <PLUGIN.ID>.URL_File	
	set "%PLUGIN.ID%.URL_File=%PLUGIN.URL_File%"
	%dk_call% dk_echo "%PLUGIN.ID%.URL_File = !%PLUGIN.ID%.URL_File!"
	
	::### PLUGIN.URL_File_Lower											master
	%dk_call% dk_toLower 			%PLUGIN.URL_File% 					PLUGIN.URL_File_Lower
::	%dk_call% dk_echo "PLUGIN.URL_File_Lower = %PLUGIN.URL_File_Lower%"
	::### <PLUGIN.ID>.URL_File_Lower	
	set "%PLUGIN.ID%.URL_File_Lower=%PLUGIN.URL_File_Lower%"
	%dk_call% dk_echo "%PLUGIN.ID%.URL_File_Lower = !%PLUGIN.ID%.URL_File_Lower!"
	
	::### PLUGIN.URL_Array												[0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip	
	%dk_call% dk_listToArray 		"%PLUGIN.URL_List%" 		PLUGIN.URL_Array
::	set /a "n=0"
::	:PLUGIN.URL_Array.loop
::	if defined PLUGIN.URL_Array[%n%] (
::		if "!DE!" neq "" (%dk_call% dk_echo "PLUGIN.URL_Array[%n%] = %%PLUGIN.URL_Array[%n%]%%")
::		if "!DE!" equ "" (%dk_call% dk_echo "PLUGIN.URL_Array[%n%] = !PLUGIN.URL_Array[%n%]!")
::	   	set /a n+=1
::		goto :PLUGIN.URL_Array.loop
::	)

	::### <PLUGIN.ID>.URL_Array	
	set /a "n=0"
	:URL_Array_loop
	if defined PLUGIN.URL_Array[%n%] (
		if "!DE!" neq "" (set "%PLUGIN.ID%.URL_Array[%n%]=%%PLUGIN.URL_Array[%n%]%%")
		if "!DE!" equ "" (set "%PLUGIN.ID%.URL_Array[%n%]=!PLUGIN.URL_Array[%n%]!")
		if "!DE!" neq "" (%dk_call% dk_echo "%PLUGIN.ID%.URL_Array[%n%] = %%%PLUGIN.ID%.URL_Array[%n%]%%")
		if "!DE!" equ "" (%dk_call% dk_echo "%PLUGIN.ID%.URL_Array[%n%] = !%PLUGIN.ID%.URL_Array[%n%]!")
		set /a n+=1
		goto:URL_Array_loop
	)
	
	::### PLUGIN.URL_Length												8
	%dk_call% dk_arrayLength 		PLUGIN.URL_Array		PLUGIN.URL_Length
::	%dk_call% dk_echo "PLUGIN.URL_Length = %PLUGIN.URL_Length%"
	::### <PLUGIN.ID>.URL_Length	
	set "%PLUGIN.ID%.URL_Length=%PLUGIN.URL_Length%"
	%dk_call% dk_echo "%PLUGIN.ID%.URL_Length = !%PLUGIN.ID%.URL_Length!"
	
	::### PLUGIN.IMPORT_NAME_Lower										zlib
	%dk_call% dk_toLower 			%PLUGIN.IMPORT_NAME% 	PLUGIN.IMPORT_NAME_Lower
::	%dk_call% dk_echo "PLUGIN.IMPORT_NAME_Lower = %PLUGIN.IMPORT_NAME_Lower%"
	::### <PLUGIN.ID>.IMPORT_NAME_Lower	
	set "%PLUGIN.ID%.IMPORT_NAME_Lower=%PLUGIN.IMPORT_NAME_Lower%"
	%dk_call% dk_echo "%PLUGIN.ID%.IMPORT_NAME_Lower = !%PLUGIN.ID%.IMPORT_NAME_Lower!"
	

	::###############################################
	::############ PLUGIN.GIT_Variables #############
	::###############################################
	::if "%PLUGIN.GIT%" equ "1" (	
		:: ### PLUGIN.GIT_NAME													zlib
		%dk_call% dk_arrayAt	PLUGIN.URL_Array	3	PLUGIN.GIT_NAME
::		%dk_call% dk_echo "PLUGIN.GIT_NAME = %PLUGIN.GIT_NAME%"
		:: ### <PLUGIN.ID>.GIT_NAME	
		set "%PLUGIN.ID%.GIT_NAME=%PLUGIN.GIT_NAME%"
		%dk_call% dk_echo "%PLUGIN.ID%.GIT_NAME = !%PLUGIN.ID%.GIT_NAME!"
	::)	

	:: ### PLUGIN.GIT_NAME_Lower											zlib
	%dk_call% dk_toLower 		%PLUGIN.GIT_NAME% 		PLUGIN.GIT_NAME_Lower
::	%dk_call% dk_echo "PLUGIN.GIT_NAME_Lower = %PLUGIN.GIT_NAME_Lower%"
	:: ### <PLUGIN.ID>.GIT_NAME_Lower	
	set "%PLUGIN.ID%.GIT_NAME_Lower=%PLUGIN.GIT_NAME_Lower%"
	%dk_call% dk_echo "%PLUGIN.ID%.GIT_NAME_Lower = !%PLUGIN.ID%.GIT_NAME_Lower!"
		
	:: ### PLUGIN.GIT_BRANCH												master
	if not defined PLUGIN.BRANCH (
		rem %dk_call% dk_getGitBRANCHName %PLUGIN_URL% PLUGIN_BRANCH
		set "PLUGIN.BRANCH=master"
	)
::	%dk_call% dk_echo "PLUGIN.GIT_BRANCH = !PLUGIN.GIT_BRANCH!"
	:: ### <PLUGIN.ID>.GIT_BRANCH	
	set "%PLUGIN.ID%.GIT_BRANCH=%PLUGIN.GIT_BRANCH%"
	%dk_call% dk_echo "%PLUGIN.ID%.GIT_BRANCH = !%PLUGIN.ID%.GIT_BRANCH!"
		
		::  ### PLUGIN.GIT_TAG													TODO
		if not defined PLUGIN.TAG (
			set "PLUGIN.TAG=###TODO###"
		)
::		%dk_call% dk_echo "PLUGIN.GIT_TAG = !PLUGIN.GIT_TAG!"
		:: ### <PLUGIN.ID>.GIT_TAG	
		set "%PLUGIN.ID%.GIT_TAG=%PLUGIN.GIT_TAG%"
		%dk_call% dk_echo "%PLUGIN.ID%.GIT_TAG = !%PLUGIN.ID%.GIT_TAG!"
	::)

	::###################################################
	::############ PLUGIN.INSTALL_Variables #############
	::###################################################
	
	::### PLUGIN.NAME
	if not defined PLUGIN.NAME (set "PLUGIN.NAME=%PLUGIN.IMPORT_NAME%") 
	if not defined PLUGIN.NAME (set "PLUGIN.NAME=%PLUGIN.GIT_NAME%")
	if not defined PLUGIN.NAME (set "PLUGIN.NAME=%PLUGIN.URL_NAME%")
	if not defined PLUGIN.NAME (%dk_call% dk_error "PLUGIN.NAME invalid")
	:: %dk_call% dk_convertToCIdentifier	%PLUGIN.NAME%	PLUGIN.NAME
::	%dk_call% dk_echo "PLUGIN.NAME = %PLUGIN.NAME%"
	:: ### <PLUGIN.ID>.NAME	
	set "%PLUGIN.ID%.NAME=%PLUGIN.NAME%"
	%dk_call% dk_echo "%PLUGIN.ID%.NAME = !%PLUGIN.ID%.NAME!"

	::### PLUGIN.VERSION													master
	if not defined PLUGIN.VERSION (set "PLUGIN.VERSION=%VERSION%") 
	if not defined PLUGIN.VERSION if defined PLUGIN.URL_File_Lower if defined PLUGIN.IMPORT_NAME_Lower (
		%dk_call% dk_replaceAll "%PLUGIN.URL_File_Lower%" 	"%PLUGIN.IMPORT_NAME_Lower%" 	"" 	PLUGIN.VERSION
		if not defined PLUGIN.VERSION (set "PLUGIN.VERSION=%PLUGIN.TAG%")
		if not defined PLUGIN.VERSION (set "PLUGIN.VERSION=%PLUGIN.BRANCH%") 
	)
	if not defined PLUGIN.VERSION (set "PLUGIN.VERSION=master")
	if not defined PLUGIN.VERSION (%dk_call% dk_error "PLUGIN.VERSION invalid")
::	%dk_call% dk_echo "PLUGIN.VERSION = %PLUGIN.VERSION%"
	:: ### <PLUGIN.ID>.VERSION	
	set "%PLUGIN.ID%.VERSION=%PLUGIN.VERSION%"
	%dk_call% dk_echo "%PLUGIN.ID%.VERSION = !%PLUGIN.ID%.VERSION!"

::	string FIND %PLUGIN.VERSION - index
::	if [ %index% -eq 0 ] then
::		string SUBSTRING %PLUGIN.VERSION% 1 -1 PLUGIN.VERSION
::	fi  
::	string FIND %PLUGIN.VERSION _ index
::	if [ %index% -eq 0 ] then
::		string SUBSTRING %PLUGIN.VERSION 1 -1 PLUGIN.VERSION
::	fi 

	::### PLUGIN.INSTALL_NAME													zlib-master
	if not defined PLUGIN.INSTALL_NAME if defined PLUGIN.NAME if defined PLUGIN.VERSION (
		set "PLUGIN.INSTALL_NAME=%PLUGIN.NAME%-%PLUGIN.VERSION%"
	)
	if not defined PLUGIN.INSTALL_NAME (set "PLUGIN.INSTALL_NAME=%PLUGIN.NAME%")
	if not defined PLUGIN.INSTALL_NAME (%dk_call% dk_error "PLUGIN.INSTALL_NAME invalid")
::	%dk_call% dk_echo "PLUGIN.INSTALL_NAME = %PLUGIN.INSTALL_NAME%"
	:: ### <PLUGIN.ID>.INSTALL_NAME	
	set "%PLUGIN.ID%.INSTALL_NAME=%PLUGIN.INSTALL_NAME%"
	%dk_call% dk_echo "%PLUGIN.ID%.INSTALL_NAME = !%PLUGIN.ID%.INSTALL_NAME!"

	::### PLUGIN.INSTALL_ROOT														C:/Users/Administrator/DigitalKnob/Development/3rdParty
	if not defined PLUGIN.INSTALL_ROOT (
		%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
		set "PLUGIN.INSTALL_ROOT=%DK3RDPARTY_DIR%"
	)
	if not defined PLUGIN.INSTALL_ROOT (%dk_call% dk_error "PLUGIN.INSTALL_ROOT invalid")
::	%dk_call% dk_echo "PLUGIN.INSTALL_ROOT = %PLUGIN.INSTALL_ROOT%"
	:: ### <PLUGIN.ID>.INSTALL_ROOT	
	set "%PLUGIN.ID%.INSTALL_ROOT=%PLUGIN.INSTALL_ROOT%"
	%dk_call% dk_echo "%PLUGIN.ID%.INSTALL_ROOT = !%PLUGIN.ID%.INSTALL_ROOT!"
	
	::### PLUGIN.INSTALL_PATH														C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	if not defined PLUGIN.INSTALL_PATH (set "PLUGIN.INSTALL_PATH=%PLUGIN.INSTALL_ROOT%/%PLUGIN.INSTALL_NAME%")
	if not defined PLUGIN.INSTALL_PATH (%dk_call% dk_error "PLUGIN.INSTALL_PATH invalid")
::	%dk_call% dk_echo "PLUGIN.INSTALL_PATH = %PLUGIN.INSTALL_PATH%"
	:: ### <PLUGIN.ID>.INSTALL_PATH	
	set "%PLUGIN.ID%.INSTALL_PATH=%PLUGIN.INSTALL_PATH%"
	%dk_call% dk_echo "%PLUGIN.ID%.INSTALL_PATH = !%PLUGIN.ID%.INSTALL_PATH!"

	::### PLUGIN
	set "PLUGIN=%PLUGIN.INSTALL_PATH%"
::	%dk_call% dk_echo "PLUGIN = %PLUGIN%"	
	:: ### <PLUGIN.ID>.INSTALL_PATH	
	set "%PLUGIN.ID%=%PLUGIN%"
	%dk_call% dk_echo "%PLUGIN.ID% = !%PLUGIN.ID%!"
	
	::##############################################
	::############# PLUGIN.Variables ###############
	::##############################################
	if defined PLUGIN.IMPORT_NAME_Lower if defined PLUGIN.GIT_NAME_Lower (
		if "%PLUGIN.IMPORT_NAME_Lower%" neq "%PLUGIN.GIT_NAME_Lower%" (
			%dk_call% dk_warning "PLUGIN.IMPORT_NAME_Lower:%PLUGIN.IMPORT_NAME_Lower% and PLUGIN.GIT_NAME_Lower:%PLUGIN.GIT_NAME_Lower% do not match"
		)
	)	
	
	::### PLUGIN.DIR												C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	::### DO NOT USE GIT_DIR ###
	if "%PLUGIN.ID%" neq "GIT" (	
		set "PLUGIN.DIR=%PLUGIN.INSTALL_PATH%"
	)
::	%dk_call% dk_echo "PLUGIN.DIR = %PLUGIN.DIR%"
	:: ### <PLUGIN.ID>.DIR	
	set "%PLUGIN.ID%.DIR=%PLUGIN.DIR%"
	%dk_call% dk_echo "%PLUGIN.ID%.DIR = !%PLUGIN.ID%.DIR!"
		
	::#####################################################
	::############# TARGET %PLUGIN.Variables ##############
	::#####################################################

	::### PLUGIN.Tuple_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	set "PLUGIN.Tuple_Dir=%PLUGIN.INSTALL_PATH%/%Target_Tuple%"
::	%dk_call% dk_echo "PLUGIN.Tuple_Dir = %PLUGIN.Tuple_Dir%"
	:: ### <PLUGIN.ID>.Tuple_Dir	
	set "%PLUGIN.ID%.Tuple_Dir=%PLUGIN.Tuple_Dir%"
	%dk_call% dk_echo "%PLUGIN.ID%.Tuple_Dir = !%PLUGIN.ID%.Tuple_Dir!"
	
	::### PLUGIN.Config_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set "PLUGIN.Config_Dir=%PLUGIN.INSTALL_PATH%/%Config_Path%"
::	%dk_call% dk_echo "PLUGIN.Config_Dir = %PLUGIN.Config_Dir%"
	:: ### <PLUGIN.ID>.Config_Dir	
	set "%PLUGIN.ID%.Config_Dir=%PLUGIN.Config_Dir%"
	%dk_call% dk_echo "%PLUGIN.ID%.Config_Dir = !%PLUGIN.ID%.Config_Dir!"
	
	::### PLUGIN.Build_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set "PLUGIN.Build_Dir=%PLUGIN.INSTALL_PATH%/%Build_Path%"
::	%dk_call% dk_echo "PLUGIN.Build_Dir = %PLUGIN.Build_Dir%"
	:: ### <PLUGIN.ID>.Build_Dir
	set "%PLUGIN.ID%.Build_Dir=%PLUGIN.Build_Dir%"
	%dk_call% dk_echo "%PLUGIN.ID%.Build_Dir = !%PLUGIN.ID%.Build_Dir!"
	
	::### PLUGIN.Debug_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set "PLUGIN.Debug_Dir=%PLUGIN.Tuple_Dir%/%Debug_Dir%"
::	%dk_call% dk_echo "PLUGIN.Debug_Dir = %PLUGIN.Debug_Dir%"
	:: ### <PLUGIN.ID>.Debug_Dir
	set "%PLUGIN.ID%.Debug_Dir=%PLUGIN.Debug_Dir%"
	%dk_call% dk_echo "%PLUGIN.ID%.Debug_Dir = !%PLUGIN.ID%.Debug_Dir!"
	
	::### PLUGIN.Release_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	set "PLUGIN.Release_Dir=%PLUGIN.Tuple_Dir%/%Release_Dir%"
::	%dk_call% dk_echo "PLUGIN.Release_Dir = %PLUGIN.Release_Dir%"
	:: ### <PLUGIN.ID>.Release_Dir
	set "%PLUGIN.ID%.Release_Dir=%PLUGIN.Release_Dir%"
	%dk_call% dk_echo "%PLUGIN.ID%.Release_Dir = !%PLUGIN.ID%.Release_Dir!"
	
	::### Set the <PLUGIN.ID> variable to mirror %PLUGIN%
	::### All %PLUGIN.variables will be mirrored to the Plugin Import Name.  I.E.   $ZLIB.variables
	for /F "tokens=* delims=" %%G in ('set PLUGIN.') do (
		set "line=%%G"
		set "!line:PLUGIN.=%PLUGIN.ID%.!"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_chdir "%DKIMPORTS_DIR%/git"
	%dk_call% dk_importVariables "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe" INSTALL_ROOT "%DKTOOLS_DIR%"
%endfunction%
	::### Import hashtable #################
	:: 		 ####### TODO #######
	::######################################
	
::	%dk_call% dk_echo
::	%dk_call% dk_echo "IMPORT_ROOT                     		= %IMPORT_ROOT%"
::	%dk_call% dk_echo "IMPORT_NAME                     		= %IMPORT_NAME%"
::	%dk_call% dk_echo "IMPORT_PATH                     		= %IMPORT_PATH%"
::	%dk_call% dk_echo "INSTALL_ROOT                    		= %INSTALL_ROOT%"
::	%dk_call% dk_echo "INSTALL_NAME                    		= %INSTALL_NAME%"
::	%dk_call% dk_echo "INSTALL_PATH                    		= %INSTALL_PATH%"
::	%dk_call% dk_echo "VERSION                         		= %VERSION%"
::	%dk_call% dk_echo "BRANCH                          		= %BRANCH%"
::	%dk_call% dk_echo "TAG                             		= %TAG%"
	%dk_call% dk_echo
	%dk_call% dk_echo "%PLUGIN.ID%.ARGS                     = !%PLUGIN.ID%.ARGS!"
	%dk_call% dk_echo "%PLUGIN.ID%.ID                       = !%PLUGIN.ID%.ID!"
	%dk_call% dk_echo "%PLUGIN.ID%.IMPORT_ROOT              = !%PLUGIN.ID%.IMPORT_ROOT!"
	%dk_call% dk_echo "%PLUGIN.ID%.IMPORT_NAME              = !%PLUGIN.ID%.IMPORT_NAME!"
	%dk_call% dk_echo "%PLUGIN.ID%.IMPORT_PATH              = !%PLUGIN.ID%.IMPORT_PATH!"
	%dk_call% dk_echo "%PLUGIN.ID%.INSTALL_ROOT             = !%PLUGIN.ID%.INSTALL_ROOT!"
	%dk_call% dk_echo "%PLUGIN.ID%.INSTALL_NAME             = !%PLUGIN.ID%.INSTALL_NAME!"
	%dk_call% dk_echo "%PLUGIN.ID%.INSTALL_PATH             = !%PLUGIN.ID%.INSTALL_PATH!"
	%dk_call% dk_echo "%PLUGIN.ID%.VERSION                  = !%PLUGIN.ID%.VERSION!"
	%dk_call% dk_echo "%PLUGIN.ID%.BRANCH                   = !%PLUGIN.ID%.BRANCH%!"
	%dk_call% dk_echo "%PLUGIN.ID%.TAG                      = !%PLUGIN.ID%.TAG!"
	%dk_call% dk_echo
	%dk_call% dk_echo "%PLUGIN.ID%.URL                      = !%PLUGIN.ID%.URL!"
	%dk_call% dk_echo "%PLUGIN.ID%.URL_Filename             = !%PLUGIN.ID%.URL_Filename!"
	%dk_call% dk_echo "%PLUGIN.ID%.URL_File                 = !%PLUGIN.ID%.URL_File!"
	%dk_call% dk_echo "%PLUGIN.ID%.URL_Extension            = !%PLUGIN.ID%.URL_Extension!"
	%dk_call% dk_echo "%PLUGIN.ID%.URL_List                 = !%PLUGIN.ID%.URL_List!"
	%dk_call% dk_echo "%PLUGIN.ID%.URL_Array                = !%PLUGIN.ID%.URL_Array!"
	%dk_call% dk_echo "%PLUGIN.ID%.URL_Length               = !%PLUGIN.ID%.URL_Length!"
	%dk_call% dk_echo
	%dk_call% dk_echo "%PLUGIN.ID%.GIT                      = !%PLUGIN.ID%.GIT!"
	%dk_call% dk_echo "%PLUGIN.ID%.GIT_NAME                 = !%PLUGIN.ID%.GIT_NAME!"
	%dk_call% dk_echo
	%dk_call% dk_echo "%PLUGIN.ID%.IMPORT                   = !%PLUGIN.ID%.IMPORT!"
	%dk_call% dk_echo "%PLUGIN.ID%.IMPORT_NAME_Lower        = !%PLUGIN.ID%.IMPORT_NAME_Lower!"
	%dk_call% dk_echo "%PLUGIN.ID%.IMPORT_NAME_Upper        = !%PLUGIN.ID%.IMPORT_NAME_Upper!"	
	%dk_call% dk_echo "%PLUGIN.ID%.IMPORT_NAME_Alphanumeric = !%PLUGIN.ID%.IMPORT_NAME_Alphanumeric!"
	%dk_call% dk_echo
	%dk_call% dk_echo "%PLUGIN.ID%.Build_Dir                = !%PLUGIN.ID%.Build_Dir!"
	%dk_call% dk_echo "%PLUGIN.ID%.Config_Dir               = !%PLUGIN.ID%.Config_Dir!"
	%dk_call% dk_echo "%PLUGIN.ID%.Debug_Dir                = !%PLUGIN.ID%.Debug_Dir!"
	%dk_call% dk_echo "%PLUGIN.ID%.Release_Dir              = !%PLUGIN.ID%.Release_Dir!"
	%dk_call% dk_echo "%PLUGIN.ID%.Tuple_Dir                = !%PLUGIN.ID%.Tuple_Dir!"
	%dk_call% dk_echo
%endfunction%
