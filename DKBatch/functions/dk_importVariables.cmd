@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
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
	::set "DEBUG=call dk_call dk_debug"
	

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
	%dk_call% dk_unset PLUGIN.Args
	%dk_call% dk_unset PLUGIN.Build_Dir
	%dk_call% dk_unset PLUGIN.Config_Dir
	%dk_call% dk_unset PLUGIN.Debug_Dir
	%dk_call% dk_unset PLUGIN.Id
	%dk_call% dk_unset PLUGIN.Import.Dirname
	%dk_call% dk_unset PLUGIN.Import.Name
	%dk_call% dk_unset PLUGIN.Import.Name_Lower
	%dk_call% dk_unset PLUGIN.Import.Name_Upper
	%dk_call% dk_unset PLUGIN.Import.Path
	%dk_call% dk_unset PLUGIN.Install.Dirname
	%dk_call% dk_unset PLUGIN.Install.Name
	%dk_call% dk_unset PLUGIN.Install.Path
	%dk_call% dk_unset PLUGIN.Release_Dir
	%dk_call% dk_unset PLUGIN.Tuple_Dir
	%dk_call% dk_unset PLUGIN.Url
	%dk_call% dk_unset PLUGIN.Url.Basename
	%dk_call% dk_unset PLUGIN.Url.Extension
	%dk_call% dk_unset PLUGIN.Url.Name
	%dk_call% dk_unset PLUGIN.Url.Name_Lower
	%dk_call% dk_unset PLUGIN.Version





																	::###### EXAMPLE ######
	::### IMPORT_ROOT (PLUGIN.Import.Dirname)						/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	%dk_call% dk_unset IMPORT_ROOT
	%dk_call% dk_getParameterValue IMPORT_ROOT %*
	%DEBUG% "IMPORT_ROOT = '%IMPORT_ROOT%'"
	set "PLUGIN.Import.Dirname=%IMPORT_ROOT%"
	
	::### IMPORT_NAME (PLUGIN.Import.Name)							zlib
	%dk_call% dk_unset IMPORT_NAME
	%dk_call% dk_getParameterValue IMPORT_NAME %*
	%DEBUG% "IMPORT_NAME = '%IMPORT_NAME%'"
	set "PLUGIN.Import.Name=%IMPORT_NAME%"

	::### IMPORT_PATH (PLUGIN.Import.Path)							/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	%dk_call% dk_unset IMPORT_PATH
	%dk_call% dk_getParameterValue IMPORT_PATH %*
	%DEBUG% "IMPORT_PATH = '%IMPORT_PATH%'"
	set "PLUGIN.Import.Path=%IMPORT_PATH%"

	::### INSTALL_ROOT (PLUGIN.Install.Dirname)						/c/Users/Administrator/DigitalKnob/Development/3rdParty
	%dk_call% dk_unset INSTALL_ROOT
	%dk_call% dk_getParameterValue INSTALL_ROOT %*
	%DEBUG% "INSTALL_ROOT = '%INSTALL_ROOT%'"
	set "PLUGIN.Install.Dirname=%INSTALL_ROOT%"

	::### INSTALL_NAME (PLUGIN.Install.Name)						zlib-master
	%dk_call% dk_unset INSTALL_NAME
	%dk_call% dk_getParameterValue INSTALL_NAME %*
	%DEBUG% "INSTALL_NAME = '%INSTALL_NAME%'"
	set "PLUGIN.Install.Name=%INSTALL_NAME%"

	::### INSTALL_PATH (PLUGIN.Install.Path)						/c/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	%dk_call% dk_unset INSTALL_PATH
	%dk_call% dk_getParameterValue INSTALL_PATH %*
	%DEBUG% "INSTALL_PATH = '%INSTALL_PATH%'"
	set "PLUGIN.Install.Path=%INSTALL_PATH%"

	::### VERSION (PLUGIN.Version)									v1.3.1
	%dk_call% dk_unset VERSION
	%dk_call% dk_getParameterValue VERSION %*
	%DEBUG% "VERSION = '%VERSION%'"
	set "PLUGIN.Version=%VERSION%"

	::### BRANCH (PLUGIN.Branch)									master
	%dk_call% dk_unset BRANCH
	%dk_call% dk_getParameterValue BRANCH	%*
	%DEBUG% "BRANCH = '%BRANCH%'"
	set "PLUGIN.Branch=%BRANCH%"
	
	::### PLUGIN.Args												"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	%dk_call% dk_unset PLUGIN.Args
	set "PLUGIN.Args=%*"
	%DEBUG% "PLUGIN.Args = '%PLUGIN.Args%'"

	::### PLUGIN.Url												"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	%dk_call% dk_unset PLUGIN.Url
	set "PLUGIN.Url=%~1"
	%DEBUG% "PLUGIN.Url = '%PLUGIN.Url%'"
	
	::### PLUGIN.Id													ZLIB
	call :PLUGIN.Id

	::### PLUGIN.Install.Path										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	call :PLUGIN.Install.Path
	

	::#####################################################
	::############# PLUGIN.Target_Directries ##############
	::#####################################################

	::### PLUGIN.Tuple_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	set "PLUGIN.Tuple_Dir=%PLUGIN.Install.Path%/%Target_Tuple%"
	%DEBUG% "PLUGIN.Tuple_Dir = '%PLUGIN.Tuple_Dir%'"

	::### PLUGIN.Config_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set "PLUGIN.Config_Dir=%PLUGIN.Install.Path%/%Config_Path%"
	%DEBUG% "PLUGIN.Config_Dir = '%PLUGIN.Config_Dir%'"

	::### PLUGIN.Build_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set "PLUGIN.Build_Dir=%PLUGIN.Install.Path%/%Build_Path%"
	%DEBUG% "PLUGIN.Build_Dir = '%PLUGIN.Build_Dir%'"

	::### PLUGIN.Debug_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	set "PLUGIN.Debug_Dir=%PLUGIN.Tuple_Dir%/%Debug_Dir%"
	%DEBUG% "PLUGIN.Debug_Dir = '%PLUGIN.Debug_Dir%'"

	::### PLUGIN.Release_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	set "PLUGIN.Release_Dir=%PLUGIN.Tuple_Dir%/%Release_Dir%"
	%DEBUG% "PLUGIN.Release_Dir = '%PLUGIN.Release_Dir%'"

	::### PLUGIN
	set "PLUGIN=%PLUGIN.Id%"
	%DEBUG% "PLUGIN = '%PLUGIN%'"
	
	::### Set the <PLUGIN.Id> variable to mirror %PLUGIN%
	::### All %PLUGIN.variables will be mirrored to the Plugin Import Name.  I.E.   $ZLIB.variables
	set "currentScope=1"
	for /F "tokens=* delims=" %%G in ('set PLUGIN') do (
		if defined currentScope endlocal
		set "line=%%G"
		set "!line!"
		set "!line:PLUGIN=%PLUGIN.Id%!"
	)
	
	::### %PLUGIN%
	set "%PLUGIN%=%PLUGIN.Install.Path%"
%endfunction%


::#####################
:PLUGIN.Install.Dirname
	if defined PLUGIN.Install.Dirname (%return%)
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
	set "PLUGIN.Install.Dirname=%DK3RDPARTY_DIR%"
	%DEBUG% "PLUGIN.Install.Dirname= '%PLUGIN.Install.Dirname%'"
%endfunction%

::#######################
:PLUGIN.Import.Name_Lower
	if defined PLUGIN.Import.Name_Lower (%return%)
	call :PLUGIN.Import.Name
	%dk_call% dk_toLower 	%PLUGIN.Import.Name% 	PLUGIN.Import.Name_Lower
	%DEBUG% "PLUGIN.Import.Name_Lower = '!PLUGIN.Import.Name_Lower!'"
%endfunction%

::#############
:PLUGIN.Version
	if defined PLUGIN.Version (%return%)
		
	call :PLUGIN.Url.Name_Lower
	call :PLUGIN.Import.Name_Lower

	if defined PLUGIN.Url.Name_Lower if defined PLUGIN.Import.Name_Lower (
		%dk_call% dk_replaceAll "%PLUGIN.Url.Name_Lower%" 	"%PLUGIN.Import.Name_Lower%" 	"" 	PLUGIN.Version
		rem if not defined PLUGIN.Version (set "PLUGIN.Version=%PLUGIN.TAG%")
		rem if not defined PLUGIN.Version (set "PLUGIN.Version=%PLUGIN.Branch%") 
	)
	%dk_call% dk_trimNonAlphaNumeric %PLUGIN.Version% PLUGIN.Version

	%DEBUG% "PLUGIN.Version = '%PLUGIN.Version%'"
%endfunction%

::##################
:PLUGIN.Install.Name
	if defined PLUGIN.Install.Name (%return%)
	call :PLUGIN.Import.Name
	call :PLUGIN.Version
	if defined PLUGIN.Import.Name if defined PLUGIN.Version (
		set "PLUGIN.Install.Name=%PLUGIN.Import.Name%-%PLUGIN.Version%"
	)
	if not defined PLUGIN.Install.Name (	
		set "PLUGIN.Install.Name=%PLUGIN.Import.Name%"
	)
	%DEBUG% "PLUGIN.Install.Name = '%PLUGIN.Install.Name%'"
%endfunction%

::##################
:PLUGIN.Url.Basename
	if defined PLUGIN.Url.Basename (%return%)
	%dk_call% dk_assertVar PLUGIN.Url
	%dk_call% dk_basename	%PLUGIN.Url%  PLUGIN.Url.Basename		&:: basename, filename
	%DEBUG% "PLUGIN.Url.Basename = '%PLUGIN.Url.Basename%'"
%endfunction%

::###################
:PLUGIN.Url.Extension
	if defined PLUGIN.Url.Extension (%return%)
	%dk_call% dk_assertVar PLUGIN.Url
	%dk_call% dk_dirname	%PLUGIN.Url%  PLUGIN.Url.Dirname		&:: dirname, directory
	%DEBUG% "PLUGIN.Url.Dirname = '%PLUGIN.Url.Dirname%'"
%endfunction%

::#################
:PLUGIN.Import.Name
	if defined PLUGIN.Import.Name (%return%)
	call :PLUGIN.Import.Path
	if defined PLUGIN.Import.Path (
		%dk_call% dk_basename	!PLUGIN.Import.Path!	PLUGIN.Import.Name
		%DEBUG% "PLUGIN.Import.Name = '!PLUGIN.Import.Name!'"
		%return%
	)
	%dk_call% dk_includes "%PLUGIN.Url%" "https://github.com" && (
		%dk_call% dk_replaceAll 	%PLUGIN.Url% 		"/" 	";" 	PLUGIN.Url.List
		%dk_call% dk_listToArray 	"!PLUGIN.Url.List!" PLUGIN.Url.Array
		%dk_call% dk_arrayAt		PLUGIN.Url.Array	3				PLUGIN.Import.Name
		%DEBUG% "PLUGIN.Import.Name = '!PLUGIN.Import.Name!'"
		%return%
	) || (cmd /c exit /b 0)
%endfunction%

::####################
:PLUGIN.Url.Name
	if defined PLUGIN.Url.Name (%return%)
	call :PLUGIN.Url.Basename
	%dk_call% dk_removeExtension	%PLUGIN.Url.Basename%	PLUGIN.Url.Name			&:: name, file  (no extension)
	%DEBUG% "PLUGIN.Url.Name = '%PLUGIN.Url.Name%'"
%endfunction%

::####################
:PLUGIN.Url.Name_Lower
	if defined PLUGIN.Url.Name_Lower (%return%)
	call :PLUGIN.Url.Name
	%dk_call% dk_toLower 	%PLUGIN.Url.Name% 	PLUGIN.Url.Name_Lower
	%DEBUG% "PLUGIN.Url.Name_Lower = '%PLUGIN.Url.Name_Lower%'"
%endfunction%

::##################
:PLUGIN.Install.Path
	if defined PLUGIN.Install.Path (%return%)
	
	call :PLUGIN.Install.Dirname
	call :PLUGIN.Install.Name
	
	set "PLUGIN.Install.Path=%PLUGIN.Install.Dirname%/%PLUGIN.Install.Name%")
	%DEBUG% "PLUGIN.Install.Path = '%PLUGIN.Install.Path%'"
%endfunction%

::#################
:PLUGIN.Import.Path
	if defined PLUGIN.Import.Path (%return%)
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"

	if defined PLUGIN.Import.Name (
		set "PLUGIN.Import.Path=!DKIMPORTS_DIR!/!PLUGIN.Import.Name!"
		%DEBUG% 	"PLUGIN.Import.Path = '!PLUGIN.Import.Path!'"
		%return%
	)
	
	rem	%dk_call% dk_getcwd
	%dk_call% dk_includes "%CURRENT_IMPORT%" "!DKIMPORTS_DIR!" && (
		set "PLUGIN.Import.Path=%CURRENT_IMPORT%"
		%DEBUG% 	"PLUGIN.Import.Path = '!PLUGIN.Import.Path!'"
		%return%
	) || (cmd /c exit /b 0)	
%endfunction%

::#######################
:PLUGIN.Import.Name_Upper
	if defined PLUGIN.Import.Name_Upper (%return%)
	
	call :PLUGIN.Import.Name
	%dk_call% dk_assertVar PLUGIN.Import.Name
	
	%dk_call% dk_toUpper	!PLUGIN.Import.Name!	PLUGIN.Import.Name_Upper
	%DEBUG% "PLUGIN.Import.Name_Upper = '%PLUGIN.Import.Name_Upper%'"
%endfunction%

::########
:PLUGIN.Id
	if defined PLUGIN.Id (%return%)
	
	call :PLUGIN.Import.Name_Upper
	%dk_call% dk_assertVar PLUGIN.Import.Name_Upper
	
	%dk_call% dk_convertToCIdentifier	%PLUGIN.Import.Name_Upper% 	PLUGIN.Id
	%DEBUG% "PLUGIN.Id = '%PLUGIN.Id%'"
	%dk_call% dk_assertVar PLUGIN.Id
%endfunction%




::########
:PRINTVARS
	%dk_call% dk_echo
	%dk_call% dk_echo
	%dk_call% dk_echo "################## PLUGIN.variables ##################"
	%dk_call% dk_echo "PLUGIN                               = '%PLUGIN%'"
	%dk_call% dk_echo "%PLUGIN%                            = '!%PLUGIN%!'"
	%dk_call% dk_echo "PLUGIN.Args                          = '%PLUGIN.Args%'"
	%dk_call% dk_echo "PLUGIN.Id                            = '%PLUGIN.Id%'"
	%dk_call% dk_echo "PLUGIN.Version                       = '%PLUGIN.Version%'"
	%dk_call% dk_echo "PLUGIN.Url                           = '%PLUGIN.Url%'"
	%dk_call% dk_echo "PLUGIN.Url.Basename                  = '%PLUGIN.Url.Basename%'"
	%dk_call% dk_echo "PLUGIN.Url.Name                      = '%PLUGIN.Url.Name%'"
	%dk_call% dk_echo "PLUGIN.Url.Extension                 = '%PLUGIN.Url.Extension%'"
	%dk_call% dk_echo "PLUGIN.Import.Dirname                = '%PLUGIN.Import.Dirname%'"
	%dk_call% dk_echo "PLUGIN.Import.Name                   = '%PLUGIN.Import.Name%'"
	%dk_call% dk_echo "PLUGIN.Import.Path                   = '%PLUGIN.Import.Path%'"
	%dk_call% dk_echo "PLUGIN.Install.Dirname               = '%PLUGIN.Install.Dirname%'"
	%dk_call% dk_echo "PLUGIN.Install.Name                  = '%PLUGIN.Install.Name%'"
	%dk_call% dk_echo "PLUGIN.Install.Path                  = '%PLUGIN.Install.Path%'"
	%dk_call% dk_echo "PLUGIN.Tuple_Dir                     = '%PLUGIN.Tuple_Dir%'"
	%dk_call% dk_echo "PLUGIN.Build_Dir                     = '%PLUGIN.Build_Dir%'"
	%dk_call% dk_echo "PLUGIN.Config_Dir                    = '%PLUGIN.Config_Dir%'"
	%dk_call% dk_echo "PLUGIN.Debug_Dir                     = '%PLUGIN.Debug_Dir%'"
	%dk_call% dk_echo "PLUGIN.Release_Dir                   = '%PLUGIN.Release_Dir%'"
	%dk_call% dk_echo
	%dk_call% dk_echo
	%dk_call% dk_echo "################## %PLUGIN.Id%.variables ##################"
	%dk_call% dk_echo "%PLUGIN.Id%                          = '!%PLUGIN.Id%!'"
	%dk_call% dk_echo "%PLUGIN.Id%.Args                     = '!%PLUGIN.Id%.Args!'"
	%dk_call% dk_echo "%PLUGIN.Id%.Id                       = '!%PLUGIN.Id%.Id!'"
	%dk_call% dk_echo "%PLUGIN.Id%.Version                  = '!%PLUGIN.Id%.Version!'"
	%dk_call% dk_echo "%PLUGIN.Id%.Url                      = '!%PLUGIN.Id%.Url!'"
	%dk_call% dk_echo "%PLUGIN.Id%.Url.Basename             = '!%PLUGIN.Id%.Url.Basename!'"
	%dk_call% dk_echo "%PLUGIN.Id%.Url.Name                 = '!%PLUGIN.Id%.Url.Name!'"
	%dk_call% dk_echo "%PLUGIN.Id%.Url.Extension            = '!%PLUGIN.Id%.Url.Extension!'"
	%dk_call% dk_echo "%PLUGIN.Id%.Import.Dirname           = '!%PLUGIN.Id%.Import.Dirname!'"
	%dk_call% dk_echo "%PLUGIN.Id%.Import.Name              = '!%PLUGIN.Id%.Import.Name!'"
	%dk_call% dk_echo "%PLUGIN.Id%.Import.Path              = '!%PLUGIN.Id%.Import.Path!'"
	%dk_call% dk_echo "%PLUGIN.Id%.Install.Dirname          = '!%PLUGIN.Id%.Install.Dirname!'"
	%dk_call% dk_echo "%PLUGIN.Id%.Install.Name             = '!%PLUGIN.Id%.Install.Name!'"
	%dk_call% dk_echo "%PLUGIN.Id%.Install.Path             = '!%PLUGIN.Id%.Install.Path!'"
	%dk_call% dk_echo "%PLUGIN.Id%.Tuple_Dir                = '!%PLUGIN.Id%.Tuple_Dir!'"
	%dk_call% dk_echo "%PLUGIN.Id%.Build_Dir                = '!%PLUGIN.Id%.Build_Dir!'"
	%dk_call% dk_echo "%PLUGIN.Id%.Config_Dir               = '!%PLUGIN.Id%.Config_Dir!'"
	%dk_call% dk_echo "%PLUGIN.Id%.Debug_Dir                = '!%PLUGIN.Id%.Debug_Dir!'"
	%dk_call% dk_echo "%PLUGIN.Id%.Release_Dir              = '!%PLUGIN.Id%.Release_Dir!'"
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
	
	pause
%endfunction%
