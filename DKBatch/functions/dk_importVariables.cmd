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
%setlocal%
::%dk_call% dk_debugFunc 1 9
																	::###### EXAMPLE ######
	::### PLUGIN.ARGS												"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	set "PLUGIN.ARGS=%*"

	::### PLUGIN.URL												"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	set "PLUGIN.URL=%~1"
																	
	::### IMPORT_ROOT												/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	%dk_call% dk_unset IMPORT_ROOT
	%dk_call% dk_getParameterValue IMPORT_ROOT %*
	set "PLUGIN.IMPORT_ROOT=%IMPORT_ROOT%"
	
	::### IMPORT_NAME												zlib
	%dk_call% dk_unset IMPORT_NAME
	%dk_call% dk_getParameterValue IMPORT_NAME %*
	set "PLUGIN.IMPORT_NAME=%IMPORT_NAME%"

	::### IMPORT_PATH												/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	%dk_call% dk_unset IMPORT_PATH
	%dk_call% dk_getParameterValue IMPORT_PATH %*
	set "PLUGIN.IMPORT_PATH=%IMPORT_PATH%"

	::### INSTALL_ROOT												/c/Users/Administrator/DigitalKnob/Development/3rdParty
	%dk_call% dk_unset INSTALL_ROOT
	%dk_call% dk_getParameterValue INSTALL_ROOT %*
	set "PLUGIN.INSTALL_ROOT=%INSTALL_ROOT%"

	::### INSTALL_NAME												zlib-master
	%dk_call% dk_unset INSTALL_NAME
	%dk_call% dk_getParameterValue INSTALL_NAME %*
	set "PLUGIN.INSTALL_NAME=%INSTALL_NAME%"

	::### INSTALL_PATH												/c/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	%dk_call% dk_unset INSTALL_PATH
	%dk_call% dk_getParameterValue INSTALL_PATH %*
	set "PLUGIN.INSTALL_PATH=%INSTALL_PATH%"

	::### VERSION / TAG												v1.3.1
	%dk_call% dk_unset VERSION
	%dk_call% dk_getParameterValue VERSION %*
	set "PLUGIN.VERSION=%VERSION%"

	::### BRANCH													master
	%dk_call% dk_unset BRANCH
	%dk_call% dk_getParameterValue BRANCH	%*
	set "PLUGIN.BRANCH=%BRANCH%"
	
	if not defined PLUGIN.URL_Protocol 	(%dk_call% dk_protocol			%PLUGIN.URL%  			PLUGIN.URL_Protocol)
	if not defined PLUGIN.URL_dirname 	(%dk_call% dk_dirname			%PLUGIN.URL%  			PLUGIN.URL_dirname)
	if not defined PLUGIN.URL_Filename 	(%dk_call% dk_basename			%PLUGIN.URL%  			PLUGIN.URL_Filename)
	if not defined PLUGIN.URL_File		(%dk_call% dk_removeExtension	%PLUGIN.URL_Filename%	PLUGIN.URL_File)
	if not defined PLUGIN.URL_Extension	(%dk_call% dk_getExtension		%PLUGIN.URL_Filename%	PLUGIN.URL_Extension)
	
	::### DEFAULT.IMPORT_ROOT
	if not defined PLUGIN.IMPORT_ROOT (
		if not defined PLUGIN.IMPORT_PATH (
			%dk_call% dk_validate DKIMPORTS_DIR	"%dk_call% dk_DKIMPORTS_DIR"
			set "PLUGIN.IMPORT_ROOT=!DKIMPORTS_DIR!"
		)
	)
	
	::### DEFAULT.INSTALL_ROOT
	if not defined PLUGIN.INSTALL_ROOT (
		if not defined PLUGIN.INSTALL_PATH (
			%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
			set "PLUGIN.INSTALL_ROOT=!DK3RDPARTY_DIR!"
		)
	)
	
	if not defined PLUGIN.ID 			(call :dk_importVariables.PLUGIN)

	::### PLUGIN.BRANCH
	if not defined PLUGIN.BRANCH (
		rem %dk_call% dk_getGitBRANCHName %PLUGIN_URL% PLUGIN_BRANCH
		set "PLUGIN.BRANCH=master"
	)
	
	::### PLUGIN.VERSION / TAG
	%dk_call% dk_toLower 			%PLUGIN.URL_File% 		PLUGIN.URL_File_Lower
	%dk_call% dk_toLower 			%PLUGIN.IMPORT_NAME% 	PLUGIN.IMPORT_NAME_Lower
	if not defined PLUGIN.VERSION (set "PLUGIN.VERSION=%VERSION%") 
	if not defined PLUGIN.VERSION if defined PLUGIN.URL_File_Lower if defined PLUGIN.IMPORT_NAME_Lower (
		%dk_call% dk_replaceAll "%PLUGIN.URL_File_Lower%" 	"%PLUGIN.IMPORT_NAME_Lower%" 	"" 	PLUGIN.VERSION
		if not defined PLUGIN.VERSION (set "PLUGIN.VERSION=%PLUGIN.TAG%")
		if not defined PLUGIN.VERSION (set "PLUGIN.VERSION=%PLUGIN.BRANCH%") 
	)
	if not defined PLUGIN.VERSION (set "PLUGIN.VERSION=master")
	if not defined PLUGIN.VERSION (%dk_call% dk_error "PLUGIN.VERSION invalid")
	%dk_call% dk_echo "PLUGIN.VERSION = %PLUGIN.VERSION%"

	::### PLUGIN.INSTALL_NAME										zlib-master
	if not defined PLUGIN.INSTALL_NAME if defined PLUGIN.IMPORT_NAME if defined PLUGIN.VERSION (
		set "PLUGIN.INSTALL_NAME=%PLUGIN.IMPORT_NAME%-%PLUGIN.VERSION%"
	)
	if not defined PLUGIN.INSTALL_NAME (set "PLUGIN.INSTALL_NAME=%PLUGIN.IMPORT_NAME%")
	if not defined PLUGIN.INSTALL_NAME (%dk_call% dk_error "PLUGIN.INSTALL_NAME invalid")
	%dk_call% dk_echo "PLUGIN.INSTALL_NAME = %PLUGIN.INSTALL_NAME%"

	::### PLUGIN.INSTALL_ROOT										C:/Users/Administrator/DigitalKnob/Development/3rdParty
	if not defined PLUGIN.INSTALL_ROOT (
		%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
		set "PLUGIN.INSTALL_ROOT=%DK3RDPARTY_DIR%"
	)
	if not defined PLUGIN.INSTALL_ROOT (%dk_call% dk_error "PLUGIN.INSTALL_ROOT invalid")
	%dk_call% dk_echo "PLUGIN.INSTALL_ROOT = %PLUGIN.INSTALL_ROOT%"

	::### PLUGIN.INSTALL_PATH										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	if not defined PLUGIN.INSTALL_PATH (set "PLUGIN.INSTALL_PATH=%PLUGIN.INSTALL_ROOT%/%PLUGIN.INSTALL_NAME%")
	if not defined PLUGIN.INSTALL_PATH (%dk_call% dk_error "PLUGIN.INSTALL_PATH invalid")
	%dk_call% dk_echo "PLUGIN.INSTALL_PATH = %PLUGIN.INSTALL_PATH%"

	

	%dk_call% dk_toLower 	%PLUGIN.IMPORT_NAME% 	PLUGIN.IMPORT_NAME_Lower
	%dk_call% dk_toLower 	%PLUGIN.GIT_NAME% 		PLUGIN.GIT_NAME_Lower
	if defined PLUGIN.IMPORT_NAME_Lower if defined PLUGIN.GIT_NAME_Lower (
		if "%PLUGIN.IMPORT_NAME_Lower%" neq "%PLUGIN.GIT_NAME_Lower%" (
			%dk_call% dk_warning "PLUGIN.IMPORT_NAME_Lower:%PLUGIN.IMPORT_NAME_Lower% and PLUGIN.GIT_NAME_Lower:%PLUGIN.GIT_NAME_Lower% do not match"
		)
	)	

	

	

	::#####################################################
	::############# PLUGIN.Target_Directries ##############
	::#####################################################

	::### PLUGIN.Tuple_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	set "PLUGIN.Tuple_Dir=%PLUGIN.INSTALL_PATH%/%Target_Tuple%"
	%dk_call% dk_echo "PLUGIN.Tuple_Dir = %PLUGIN.Tuple_Dir%"

	::### PLUGIN.Config_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set "PLUGIN.Config_Dir=%PLUGIN.INSTALL_PATH%/%Config_Path%"
	%dk_call% dk_echo "PLUGIN.Config_Dir = %PLUGIN.Config_Dir%"

	::### PLUGIN.Build_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set "PLUGIN.Build_Dir=%PLUGIN.INSTALL_PATH%/%Build_Path%"
	%dk_call% dk_echo "PLUGIN.Build_Dir = %PLUGIN.Build_Dir%"

	::### PLUGIN.Debug_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set "PLUGIN.Debug_Dir=%PLUGIN.Tuple_Dir%/%Debug_Dir%"
	%dk_call% dk_echo "PLUGIN.Debug_Dir = %PLUGIN.Debug_Dir%"

	::### PLUGIN.Release_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	set "PLUGIN.Release_Dir=%PLUGIN.Tuple_Dir%/%Release_Dir%"
	%dk_call% dk_echo "PLUGIN.Release_Dir = %PLUGIN.Release_Dir%"

	::### PLUGIN
	set "PLUGIN=%PLUGIN.ID%"
	%dk_call% dk_echo "PLUGIN = %PLUGIN%"
	
	::### Set the <PLUGIN.ID> variable to mirror %PLUGIN%
	::### All %PLUGIN.variables will be mirrored to the Plugin Import Name.  I.E.   $ZLIB.variables
	set "currentScope=1"
	for /F "tokens=* delims=" %%G in ('set PLUGIN') do (
		if defined currentScope endlocal
		set "line=%%G"
		set "!line!"
		set "!line:PLUGIN=%PLUGIN.ID%!"
	)
	
	::### %PLUGIN%
	set "%PLUGIN%=%PLUGIN.INSTALL_PATH%"
%endfunction%
















::########################
:dk_importVariables.URL.IMPORT_NAME

	::### TODO
::	if not defined PLUGIN.IMPORT_PATH (
::		%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
::		set "PLUGIN.IMPORT_PATH=${DKIMPORTS_DIR}/${PLUGIN.IMPORT_NAME}"
::		%dk_call% dk_echo 	"PLUGIN.IMPORT_PATH = %PLUGIN.IMPORT_PATH%"
::	)
%endfunction%

::#################################
:dk_importVariables.GIT.IMPORT_NAME
	%dk_call% dk_includes "%PLUGIN.URL%" "https://github.com" && (set "PLUGIN.GIT=1" ) || (set "PLUGIN.GIT=0")
	if "%PLUGIN.GIT%" neq "1" (%return%)
	%dk_call% dk_replaceAll 	%PLUGIN.URL% 		"/" 	"				;" 			PLUGIN.URL_List
	%dk_call% dk_listToArray 	"%PLUGIN.URL_List%" PLUGIN.URL_Array
	%dk_call% dk_arrayAt		PLUGIN.URL_Array	3						PLUGIN.IMPORT_NAME
	%dk_call% dk_echo 			"PLUGIN.IMPORT_NAME = %PLUGIN.IMPORT_NAME%"
	if not defined PLUGIN.IMPORT_PATH (
		%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
		set "PLUGIN.IMPORT_PATH=!DKIMPORTS_DIR!/%PLUGIN.IMPORT_NAME%"
		%dk_call% dk_echo 	"PLUGIN.IMPORT_PATH = %PLUGIN.IMPORT_PATH%"
	)
%endfunction%

::####################################
:dk_importVariables.IMPORT.IMPORT_NAME
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	
	%dk_call% dk_includes "%CD:\=/%" "%DKIMPORTS_DIR%" && (
		if not defined PLUGIN.IMPORT_PATH (	
			rem	%dk_call% dk_getcwd
			set "PLUGIN.IMPORT_PATH=%CD:\=/%"
		)
		set "PLUGIN.IMPORT=1"		
	) || (exit /b 0)
	%dk_call% dk_echo 	"PLUGIN.IMPORT_PATH = %PLUGIN.IMPORT_PATH%"
	
	%dk_call% dk_basename	%PLUGIN.IMPORT_PATH%	PLUGIN.IMPORT_NAME
	%dk_call% dk_echo "PLUGIN.IMPORT_NAME = '!PLUGIN.IMPORT_NAME!'"
%endfunction%


::#############################
:dk_importVariables.PLUGIN.IMPORT_NAME
	if not defined PLUGIN.IMPORT_NAME (call :dk_importVariables.IMPORT.IMPORT_NAME)
	if not defined PLUGIN.IMPORT_NAME (call :dk_importVariables.GIT.IMPORT_NAME)
	if not defined PLUGIN.IMPORT_NAME (call :dk_importVariables.URL.IMPORT_NAME)
	if not defined PLUGIN.IMPORT_NAME (%dk_call% dk_error "PLUGIN.IMPORT_NAME invalid")
	%dk_call% dk_echo "PLUGIN.IMPORT_NAME = %PLUGIN.IMPORT_NAME%"
%endfunction%

::#############################
:dk_importVariables.PLUGIN.ID
	if not defined PLUGIN.IMPORT_NAME 	(call :dk_importVariables.PLUGIN.IMPORT_NAME)

	%dk_call% dk_toUpper				%PLUGIN.IMPORT_NAME%		PLUGIN.IMPORT_NAME_Upper	
	%dk_call% dk_convertToCIdentifier	%PLUGIN.IMPORT_NAME_Upper% 	PLUGIN.ID	
	
	if not defined PLUGIN.ID (%dk_call% dk_error "PLUGIN.ID invalid")
	%dk_call% dk_echo "PLUGIN.ID = %PLUGIN.ID%"
%endfunction%






::########################
:dk_importVariables.PLUGIN
:dk_importVariables.PLUGIN
:dk_importVariables.PLUGIN
:dk_importVariables.PLUGIN
:dk_importVariables.PLUGIN
	if not defined PLUGIN.ID 				(call :dk_importVariables.PLUGIN.ID)
%endfunction%














::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_chdir "%DKIMPORTS_DIR%/git"
	%dk_call% dk_importVariables "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe" INSTALL_ROOT "%DKTOOLS_DIR%"

	%dk_call% dk_echo
	%dk_call% dk_echo
	%dk_call% dk_echo "################## PLUGIN.variables ##################"
	%dk_call% dk_echo "PLUGIN                               = %PLUGIN%"
	%dk_call% dk_echo "%PLUGIN%                            = !%PLUGIN%!"
	%dk_call% dk_echo "PLUGIN.ARGS                          = %PLUGIN.ARGS%"
	%dk_call% dk_echo "PLUGIN.URL                           = %PLUGIN.URL%"
	%dk_call% dk_echo "PLUGIN.ID                            = %PLUGIN.ID%"
	%dk_call% dk_echo "PLUGIN.IMPORT_ROOT                   = %PLUGIN.IMPORT_ROOT%"
	%dk_call% dk_echo "PLUGIN.IMPORT_NAME                   = %PLUGIN.IMPORT_NAME%"
	%dk_call% dk_echo "PLUGIN.IMPORT_PATH                   = %PLUGIN.IMPORT_PATH%"
	%dk_call% dk_echo "PLUGIN.INSTALL_ROOT                  = %PLUGIN.INSTALL_ROOT%"
	%dk_call% dk_echo "PLUGIN.INSTALL_NAME                  = %PLUGIN.INSTALL_NAME%"
	%dk_call% dk_echo "PLUGIN.INSTALL_PATH                  = %PLUGIN.INSTALL_PATH%"
	%dk_call% dk_echo "PLUGIN.VERSION                       = %PLUGIN.VERSION%"
	%dk_call% dk_echo "PLUGIN.URL_Filename                  = %PLUGIN.URL_Filename%"
	%dk_call% dk_echo "PLUGIN.URL_File                      = %PLUGIN.URL_File%"
	%dk_call% dk_echo "PLUGIN.URL_Extension                 = %PLUGIN.URL_Extension%"
	%dk_call% dk_echo "PLUGIN.Tuple_Dir                     = %PLUGIN.Tuple_Dir%"
	%dk_call% dk_echo "PLUGIN.Build_Dir                     = %PLUGIN.Build_Dir%"
	%dk_call% dk_echo "PLUGIN.Config_Dir                    = %PLUGIN.Config_Dir%"
	%dk_call% dk_echo "PLUGIN.Debug_Dir                     = %PLUGIN.Debug_Dir%"
	%dk_call% dk_echo "PLUGIN.Release_Dir                   = %PLUGIN.Release_Dir%"
	%dk_call% dk_echo
	%dk_call% dk_echo
	%dk_call% dk_echo "################## %PLUGIN.ID%.variables ##################"
	%dk_call% dk_echo "%PLUGIN.ID%                          = !%PLUGIN.ID%!"
	%dk_call% dk_echo "%PLUGIN.ID%.ARGS                     = !%PLUGIN.ID%.ARGS!"
	%dk_call% dk_echo "%PLUGIN.ID%.URL                      = !%PLUGIN.ID%.URL!"
	%dk_call% dk_echo "%PLUGIN.ID%.ID                       = !%PLUGIN.ID%.ID!"
	%dk_call% dk_echo "%PLUGIN.ID%.IMPORT_ROOT              = !%PLUGIN.ID%.IMPORT_ROOT!"
	%dk_call% dk_echo "%PLUGIN.ID%.IMPORT_NAME              = !%PLUGIN.ID%.IMPORT_NAME!"
	%dk_call% dk_echo "%PLUGIN.ID%.IMPORT_PATH              = !%PLUGIN.ID%.IMPORT_PATH!"
	%dk_call% dk_echo "%PLUGIN.ID%.INSTALL_ROOT             = !%PLUGIN.ID%.INSTALL_ROOT!"
	%dk_call% dk_echo "%PLUGIN.ID%.INSTALL_NAME             = !%PLUGIN.ID%.INSTALL_NAME!"
	%dk_call% dk_echo "%PLUGIN.ID%.INSTALL_PATH             = !%PLUGIN.ID%.INSTALL_PATH!"
	%dk_call% dk_echo "%PLUGIN.ID%.VERSION                  = !%PLUGIN.ID%.VERSION!"
	%dk_call% dk_echo "%PLUGIN.ID%.URL_Filename             = !%PLUGIN.ID%.URL_Filename!"
	%dk_call% dk_echo "%PLUGIN.ID%.URL_File                 = !%PLUGIN.ID%.URL_File!"
	%dk_call% dk_echo "%PLUGIN.ID%.URL_Extension            = !%PLUGIN.ID%.URL_Extension!"
	%dk_call% dk_echo "%PLUGIN.ID%.Tuple_Dir                = !%PLUGIN.ID%.Tuple_Dir!"
	%dk_call% dk_echo "%PLUGIN.ID%.Build_Dir                = !%PLUGIN.ID%.Build_Dir!"
	%dk_call% dk_echo "%PLUGIN.ID%.Config_Dir               = !%PLUGIN.ID%.Config_Dir!"
	%dk_call% dk_echo "%PLUGIN.ID%.Debug_Dir                = !%PLUGIN.ID%.Debug_Dir!"
	%dk_call% dk_echo "%PLUGIN.ID%.Release_Dir              = !%PLUGIN.ID%.Release_Dir!"
	%dk_call% dk_echo
%endfunction%
