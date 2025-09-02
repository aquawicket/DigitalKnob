@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################












::###########################################################################################################################
::# dk_importVariables(Url Rtn_Var) IMPORT_ROOT IMPORT_NAME IMPORT_PATH INSTALL_ROOT INSTALL_NAME INSTALL_PATH VERSION BRANCH 
::#
::#																	###### EXAMPLES ######
::#	URL																https://github.com/madler/zlib.git     							* github repository link
::#																	https://github.com/madler/zlib/archive/refs/heads/master.zip	* github sourcecode download
::#																	https://github.com/madler/zlib        							* github page
::#																	https://zlib.net/zlib-1.3.1.tar.gz								* library sourcecode download
::#																	https://website.com/executable.exe              				* executable file
::#
::#
::#	IMPORT_ROOT	(optional)											C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
::#
::#
::#	IMPORT_NAME (optional)											zlib
::#
::#
::#	IMPORT_PATH (optional)											C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
::#
::#
::#	INSTALL_ROOT (optional)											C:/Users/Administrator/DigitalKnob/Development/DKTools
::#
::#
::#	INSTALL_NAME (optional)											zlib-8-5-2025
::#																	myZLIB
::#
::#	INSTALL_PATH (optional)											C:/Users/Administrator/DigitalKnob/Development/DKTools/zlib-8-5-2025
::#																	C:/Users/Administrator/DigitalKnob/Development/DKTools/myZLIB
::#
::#	VERSION (optional)												master
::#
::#
::#	BRANCH (optional)												develop
::#																	master
::#################################################################################
::#	
::#	PRINTVARS - specifying PRINTVARS will dump the current variable values of the current PLUGIN
::#
	set "DEBUG=rem "
	::set "DEBUG=call %DKBATCH_FUNCTIONS_DIR_%dk_call.cmd dk_debug"
	

:dk_importVariables
%setlocal%
::%dk_call% dk_debugFunc 1 9
	
	%dk_call% dk_getParameterValue PRINTVARS %*
	if defined PRINTVARS (
		%dk_call% dk_unset PRINTVARS
		call :PRINTVARS
		%return%
	)

	%dk_call% dk_unset PLUGIN
	%dk_call% dk_unset PLUGIN_Args
	%dk_call% dk_unset PLUGIN_Build_Dir
	%dk_call% dk_unset PLUGIN_Config_Dir
	%dk_call% dk_unset PLUGIN_Debug_Dir
	%dk_call% dk_unset PLUGIN_Id
	%dk_call% dk_unset PLUGIN_Import_Dirname
	%dk_call% dk_unset PLUGIN_Import_Name
	%dk_call% dk_unset PLUGIN_Import_Name_Lower
	%dk_call% dk_unset PLUGIN_Import_Name_Upper
	%dk_call% dk_unset PLUGIN_Import_Path
	%dk_call% dk_unset PLUGIN_Install_Dirname
	%dk_call% dk_unset PLUGIN_Install_Name
	%dk_call% dk_unset PLUGIN_Install_Path
	%dk_call% dk_unset PLUGIN_Release_Dir
	%dk_call% dk_unset PLUGIN_Tuple_Dir
	%dk_call% dk_unset PLUGIN_Url
	%dk_call% dk_unset PLUGIN_Url_Basename
	%dk_call% dk_unset PLUGIN_Url_Extension
	%dk_call% dk_unset PLUGIN_Url_Name
	%dk_call% dk_unset PLUGIN_Url_Name_Lower
	%dk_call% dk_unset PLUGIN_Version





																	::###### EXAMPLE ######
	::### IMPORT_ROOT (PLUGIN_Import_Dirname)						/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	%dk_call% dk_unset IMPORT_ROOT
	%dk_call% dk_getParameterValue IMPORT_ROOT %*
	%DEBUG% "IMPORT_ROOT = '%IMPORT_ROOT%'"
	set "PLUGIN_Import_Dirname=%IMPORT_ROOT%"
	
	::### IMPORT_NAME (PLUGIN_Import_Name)							zlib
	%dk_call% dk_unset IMPORT_NAME
	%dk_call% dk_getParameterValue IMPORT_NAME %*
	%DEBUG% "IMPORT_NAME = '%IMPORT_NAME%'"
	set "PLUGIN_Import_Name=%IMPORT_NAME%"

	::### IMPORT_PATH (PLUGIN_Import_Path)							/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	%dk_call% dk_unset IMPORT_PATH
	%dk_call% dk_getParameterValue IMPORT_PATH %*
	%DEBUG% "IMPORT_PATH = '%IMPORT_PATH%'"
	set "PLUGIN_Import_Path=%IMPORT_PATH%"

	::### INSTALL_ROOT (PLUGIN_Install_Dirname)						/c/Users/Administrator/DigitalKnob/Development/3rdParty
	%dk_call% dk_unset INSTALL_ROOT
	%dk_call% dk_getParameterValue INSTALL_ROOT %*
	%DEBUG% "INSTALL_ROOT = '%INSTALL_ROOT%'"
	set "PLUGIN_Install_Dirname=%INSTALL_ROOT%"

	::### INSTALL_NAME (PLUGIN_Install_Name)						zlib-master
	%dk_call% dk_unset INSTALL_NAME
	%dk_call% dk_getParameterValue INSTALL_NAME %*
	%DEBUG% "INSTALL_NAME = '%INSTALL_NAME%'"
	set "PLUGIN_Install_Name=%INSTALL_NAME%"

	::### INSTALL_PATH (PLUGIN_Install_Path)						/c/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	%dk_call% dk_unset INSTALL_PATH
	%dk_call% dk_getParameterValue INSTALL_PATH %*
	%DEBUG% "INSTALL_PATH = '%INSTALL_PATH%'"
	set "PLUGIN_Install_Path=%INSTALL_PATH%"

	::### VERSION (PLUGIN_Version)									v1.3.1
	%dk_call% dk_unset VERSION
	%dk_call% dk_getParameterValue VERSION %*
	%DEBUG% "VERSION = '%VERSION%'"
	set "PLUGIN_Version=%VERSION%"

	::### BRANCH (PLUGIN.Branch)									master
	%dk_call% dk_unset BRANCH
	%dk_call% dk_getParameterValue BRANCH	%*
	%DEBUG% "BRANCH = '%BRANCH%'"
	set "PLUGIN.Branch=%BRANCH%"
	
	::### PLUGIN_Args												"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	%dk_call% dk_unset PLUGIN_Args
	set "PLUGIN_Args=%*"
	%DEBUG% "PLUGIN_Args = '%PLUGIN_Args%'"

	::### PLUGIN_Url												"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	%dk_call% dk_unset PLUGIN_Url
	set "PLUGIN_Url=%~1"
	%DEBUG% "PLUGIN_Url = '%PLUGIN_Url%'"
	
	::### PLUGIN_Id													ZLIB
	call :PLUGIN_Id

	::### PLUGIN_Install_Path										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	call :PLUGIN_Install_Path
	

	::#####################################################
	::############# PLUGIN.Target_Directries ##############
	::#####################################################

	::### PLUGIN_Tuple_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	set "PLUGIN_Tuple_Dir=%PLUGIN_Install_Path%/%Target_Tuple%"
	%DEBUG% "PLUGIN_Tuple_Dir = '%PLUGIN_Tuple_Dir%'"

	::### PLUGIN_Config_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set "PLUGIN_Config_Dir=%PLUGIN_Install_Path%/%Config_Path%"
	%DEBUG% "PLUGIN_Config_Dir = '%PLUGIN_Config_Dir%'"

	::### PLUGIN_Build_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set "PLUGIN_Build_Dir=%PLUGIN_Install_Path%/%Build_Path%"
	%DEBUG% "PLUGIN_Build_Dir = '%PLUGIN_Build_Dir%'"

	::### PLUGIN_Debug_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set "PLUGIN_Debug_Dir=%PLUGIN_Tuple_Dir%/%Debug_Dir%"
	%DEBUG% "PLUGIN_Debug_Dir = '%PLUGIN_Debug_Dir%'"

	::### PLUGIN_Release_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	set "PLUGIN_Release_Dir=%PLUGIN_Tuple_Dir%/%Release_Dir%"
	%DEBUG% "PLUGIN_Release_Dir = '%PLUGIN_Release_Dir%'"

	::### PLUGIN
	set "PLUGIN=%PLUGIN_Id%"
	%DEBUG% "PLUGIN = '%PLUGIN%'"
	
	::### Set the <PLUGIN_Id> variable to mirror %PLUGIN%
	::### All %PLUGIN.variables will be mirrored to the Plugin Import Name.  I.E.   $ZLIB.variables
	set "currentScope=1"
	for /F "tokens=* delims=" %%G in ('set PLUGIN') do (
		if defined currentScope endlocal
		set "line=%%G"
		set "!line!"
		set "!line:PLUGIN=%PLUGIN_Id%!"
	)
	
	::### %PLUGIN%
	set "%PLUGIN%=%PLUGIN_Install_Path%"
%endfunction%




::#####################
:PLUGIN_Install_Dirname
	if defined PLUGIN_Install_Dirname (%return%)
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
	set "PLUGIN_Install_Dirname=%DK3RDPARTY_DIR%"
	%DEBUG% "PLUGIN_Install_Dirname= '%PLUGIN_Install_Dirname%'"
%endfunction%

::#######################
:PLUGIN_Import_Name_Lower
	if defined PLUGIN_Import_Name_Lower (%return%)
	call :PLUGIN_Import_Name
	%dk_call% dk_toLower 	%PLUGIN_Import_Name% 	PLUGIN_Import_Name_Lower
	%DEBUG% "PLUGIN_Import_Name_Lower = '!PLUGIN_Import_Name_Lower!'"
%endfunction%

::#############
:PLUGIN_Version
	if defined PLUGIN_Version (%return%)
		
	call :PLUGIN_Url_Name_Lower
	call :PLUGIN_Import_Name_Lower

	if defined PLUGIN_Url_Name_Lower if defined PLUGIN_Import_Name_Lower (
		%dk_call% dk_replaceAll "%PLUGIN_Url_Name_Lower%" 	"%PLUGIN_Import_Name_Lower%" 	"" 	PLUGIN_Version
		rem if NOT defined PLUGIN_Version (set "PLUGIN_Version=%PLUGIN.TAG%")
		rem if NOT defined PLUGIN_Version (set "PLUGIN_Version=%PLUGIN.Branch%") 
	)
	%dk_call% dk_trimNonAlphaNumeric %PLUGIN_Version% PLUGIN_Version

	%DEBUG% "PLUGIN_Version = '%PLUGIN_Version%'"
%endfunction%

::##################
:PLUGIN_Install_Name
	if defined PLUGIN_Install_Name (%return%)
	call :PLUGIN_Import_Name
	call :PLUGIN_Version
	if defined PLUGIN_Import_Name if defined PLUGIN_Version (
		set "PLUGIN_Install_Name=%PLUGIN_Import_Name%-%PLUGIN_Version%"
	)
	if NOT defined PLUGIN_Install_Name (	
		set "PLUGIN_Install_Name=%PLUGIN_Import_Name%"
	)
	%DEBUG% "PLUGIN_Install_Name = '%PLUGIN_Install_Name%'"
%endfunction%

::##################
:PLUGIN_Url_Basename
	if defined PLUGIN_Url_Basename (%return%)
	%dk_call% dk_assertVar PLUGIN_Url
	%dk_call% dk_basename	%PLUGIN_Url%  PLUGIN_Url_Basename		&:: basename, filename
	%DEBUG% "PLUGIN_Url_Basename = '%PLUGIN_Url_Basename%'"
%endfunction%

::###################
:PLUGIN_Url_Extension
	if defined PLUGIN_Url_Extension (%return%)
	%dk_call% dk_assertVar PLUGIN_Url
	%dk_call% dk_dirname	%PLUGIN_Url%  PLUGIN_Url_Dirname		&:: dirname, directory
	%DEBUG% "PLUGIN_Url_Dirname = '%PLUGIN_Url_Dirname%'"
%endfunction%

::#################
:PLUGIN_Import_Name
	%DEBUG% "PLUGIN_Import_Name(%*)"
	
	if defined PLUGIN_Import_Name (%return%)
	call :PLUGIN_Import_Path
	if defined PLUGIN_Import_Path (
		%dk_call% dk_basename	!PLUGIN_Import_Path!	PLUGIN_Import_Name
		%DEBUG% "PLUGIN_Import_Name = '!PLUGIN_Import_Name!'"
		%return%
	)
	%dk_call% dk_includes "%PLUGIN_Url%" "https://github.com" && (
		%dk_call% dk_replaceAll 	%PLUGIN_Url% 		"/" 	";" 	PLUGIN_Url_List
		%dk_call% dk_listToArray 	"!PLUGIN_Url_List!" PLUGIN_Url_Array
		%dk_call% dk_arrayAt		PLUGIN_Url_Array	3				PLUGIN_Import_Name
		%DEBUG% "PLUGIN_Import_Name = '!PLUGIN_Import_Name!'"
		%return%
	) || (cmd /c exit /b 0)
%endfunction%

::####################
:PLUGIN_Url_Name
	if defined PLUGIN_Url_Name (%return%)
	call :PLUGIN_Url_Basename
	%dk_call% dk_removeExtension	%PLUGIN_Url_Basename%	PLUGIN_Url_Name			&:: name, file  (no extension)
	%DEBUG% "PLUGIN_Url_Name = '%PLUGIN_Url_Name%'"
%endfunction%

::####################
:PLUGIN_Url_Name_Lower
	if defined PLUGIN_Url_Name_Lower (%return%)
	call :PLUGIN_Url_Name
	%dk_call% dk_toLower 	%PLUGIN_Url_Name% 	PLUGIN_Url_Name_Lower
	%DEBUG% "PLUGIN_Url_Name_Lower = '%PLUGIN_Url_Name_Lower%'"
%endfunction%

::##################
:PLUGIN_Install_Path
	if defined PLUGIN_Install_Path (%return%)
	
	call :PLUGIN_Install_Dirname
	call :PLUGIN_Install_Name
	
	set "PLUGIN_Install_Path=%PLUGIN_Install_Dirname%/%PLUGIN_Install_Name%")
	%DEBUG% "PLUGIN_Install_Path = '%PLUGIN_Install_Path%'"
%endfunction%

::#################
:PLUGIN_Import_Path
	%DEBUG% "PLUGIN_Import_Path(%*)"
	if defined PLUGIN_Import_Path (%return%)
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"

	if defined PLUGIN_Import_Name (
		set "PLUGIN_Import_Path=!DKIMPORTS_DIR!/!PLUGIN_Import_Name!"
		%DEBUG% 	"PLUGIN_Import_Path = '!PLUGIN_Import_Path!'"
		%return%
	)
	
	rem	%dk_call% dk_getcwd
	%dk_call% dk_includes "%CURRENT_IMPORT:\=/%" "!DKIMPORTS_DIR:\=/!" && (
		set "PLUGIN_Import_Path=%CURRENT_IMPORT:\=/%"
		%DEBUG% 	"PLUGIN_Import_Path = '!PLUGIN_Import_Path!'"
		%return%
	) || (cmd /c exit /b 0)	
%endfunction%

::#######################
:PLUGIN_Import_Name_Upper
	if defined PLUGIN_Import_Name_Upper (%return%)
	
	call :PLUGIN_Import_Name
	%dk_call% dk_assertVar PLUGIN_Import_Name
	
	%dk_call% dk_toUpper	!PLUGIN_Import_Name!	PLUGIN_Import_Name_Upper
	%DEBUG% "PLUGIN_Import_Name_Upper = '%PLUGIN_Import_Name_Upper%'"
%endfunction%

::########
:PLUGIN_Id
	if defined PLUGIN_Id (%return%)
	
	call :PLUGIN_Import_Name_Upper
	%dk_call% dk_assertVar PLUGIN_Import_Name_Upper
	
	%dk_call% dk_convertToCIdentifier	%PLUGIN_Import_Name_Upper% 	PLUGIN_Id
	%DEBUG% "PLUGIN_Id = '%PLUGIN_Id%'"
	%dk_call% dk_assertVar PLUGIN_Id
%endfunction%




::########
:PRINTVARS
	%dk_call% dk_echo
	%dk_call% dk_echo
	%dk_call% dk_echo "################## PLUGIN.variables ##################"
	%dk_call% dk_echo "PLUGIN                               = '%PLUGIN%'"
	%dk_call% dk_echo "PLUGIN_Args                          = '%PLUGIN_Args%'"
	%dk_call% dk_echo "PLUGIN_Id                            = '%PLUGIN_Id%'"
	%dk_call% dk_echo "PLUGIN_Version                       = '%PLUGIN_Version%'"
	%dk_call% dk_echo "PLUGIN_Url                           = '%PLUGIN_Url%'"
	%dk_call% dk_echo "PLUGIN_Url_Basename                  = '%PLUGIN_Url_Basename%'"
	%dk_call% dk_echo "PLUGIN_Url_Name                      = '%PLUGIN_Url_Name%'"
	%dk_call% dk_echo "PLUGIN_Url_Extension                 = '%PLUGIN_Url_Extension%'"
	%dk_call% dk_echo "PLUGIN_Import_Dirname                = '%PLUGIN_Import_Dirname%'"
	%dk_call% dk_echo "PLUGIN_Import_Name                   = '%PLUGIN_Import_Name%'"
	%dk_call% dk_echo "PLUGIN_Import_Path                   = '%PLUGIN_Import_Path%'"
	%dk_call% dk_echo "PLUGIN_Install_Dirname               = '%PLUGIN_Install_Dirname%'"
	%dk_call% dk_echo "PLUGIN_Install_Name                  = '%PLUGIN_Install_Name%'"
	%dk_call% dk_echo "PLUGIN_Install_Path                  = '%PLUGIN_Install_Path%'"
	%dk_call% dk_echo "PLUGIN_Tuple_Dir                     = '%PLUGIN_Tuple_Dir%'"
	%dk_call% dk_echo "PLUGIN_Build_Dir                     = '%PLUGIN_Build_Dir%'"
	%dk_call% dk_echo "PLUGIN_Config_Dir                    = '%PLUGIN_Config_Dir%'"
	%dk_call% dk_echo "PLUGIN_Debug_Dir                     = '%PLUGIN_Debug_Dir%'"
	%dk_call% dk_echo "PLUGIN_Release_Dir                   = '%PLUGIN_Release_Dir%'"
	%dk_call% dk_echo
	%dk_call% dk_echo
	%dk_call% dk_echo "################## %PLUGIN_Id%_variables ##################"
	%dk_call% dk_echo "%PLUGIN%                          = '!%PLUGIN%!'"
	%dk_call% dk_echo "%PLUGIN%_Args                     = '!%PLUGIN%_Args!'"
	%dk_call% dk_echo "%PLUGIN%_Id                       = '!%PLUGIN%_Id!'"
	%dk_call% dk_echo "%PLUGIN%_Version                  = '!%PLUGIN%_Version!'"
	%dk_call% dk_echo "%PLUGIN%_Url                      = '!%PLUGIN%_Url!'"
	%dk_call% dk_echo "%PLUGIN%_Url_Basename             = '!%PLUGIN%_Url_Basename!'"
	%dk_call% dk_echo "%PLUGIN%_Url_Name                 = '!%PLUGIN%_Url_Name!'"
	%dk_call% dk_echo "%PLUGIN%_Url_Extension            = '!%PLUGIN%_Url_Extension!'"
	%dk_call% dk_echo "%PLUGIN%_Import_Dirname           = '!%PLUGIN%_Import_Dirname!'"
	%dk_call% dk_echo "%PLUGIN%_Import_Name              = '!%PLUGIN%_Import_Name!'"
	%dk_call% dk_echo "%PLUGIN%_Import_Path              = '!%PLUGIN%_Import_Path!'"
	%dk_call% dk_echo "%PLUGIN%_Install_Dirname          = '!%PLUGIN%_Install_Dirname!'"
	%dk_call% dk_echo "%PLUGIN%_Install_Name             = '!%PLUGIN%_Install_Name!'"
	%dk_call% dk_echo "%PLUGIN%_Install_Path             = '!%PLUGIN%_Install_Path!'"
	%dk_call% dk_echo "%PLUGIN%_Tuple_Dir                = '!%PLUGIN%_Tuple_Dir!'"
	%dk_call% dk_echo "%PLUGIN%_Build_Dir                = '!%PLUGIN%_Build_Dir!'"
	%dk_call% dk_echo "%PLUGIN%_Config_Dir               = '!%PLUGIN%_Config_Dir!'"
	%dk_call% dk_echo "%PLUGIN%_Debug_Dir                = '!%PLUGIN%_Debug_Dir!'"
	%dk_call% dk_echo "%PLUGIN%_Release_Dir              = '!%PLUGIN%_Release_Dir!'"
	%dk_call% dk_echo
%endfunction%





















::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	
	set "CURRENT_IMPORT=%DKIMPORTS_DIR%/msys2"
	%dk_call% dk_importVariables "https://repo.msys2.org/distrib/x86_64/msys2-base-x86_64-20241208.tar.xz"
	%dk_call% dk_importVariables PRINTVARS
	
	set "CURRENT_IMPORT=%DKIMPORTS_DIR%/git"
	%dk_call% dk_importVariables "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe" INSTALL_ROOT "%DKTOOLS_DIR%"
	%dk_call% dk_importVariables PRINTVARS
	
	set "CURRENT_IMPORT=%DKIMPORTS_DIR%/php-src"
	%dk_call% dk_importVariables "https://windows.php.net/downloads/releases/php-8.4.11-Win32-vs17-x64.zip"
	%dk_call% dk_importVariables PRINTVARS
%endfunction%
