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
	::%dk_call% dk_echo "PLUGIN.IMPORT_PATH = %PLUGIN.IMPORT_PATH%"
	
	::### PLUGIN.IMPORT_ROOT										/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	if not defined PLUGIN.IMPORT_ROOT (	
		%dk_call% dk_dirname			%PLUGIN.IMPORT_PATH%		PLUGIN.IMPORT_ROOT
	)
	::%dk_call% dk_echo "PLUGIN.IMPORT_ROOT = %PLUGIN.IMPORT_ROOT%"
	
	::### PLUGIN.IMPORT_NAME										zlib
	if not defined PLUGIN.IMPORT_NAME (
		dk_call dk_basename				%PLUGIN.IMPORT_PATH%		PLUGIN.IMPORT_NAME
	)
	::%dk_call% dk_echo "PLUGIN.IMPORT_NAME = %PLUGIN.IMPORT_NAME%"
	
	::### PLUGIN.IMPORT_NAME_Upper
	%dk_call% dk_toUpper				%PLUGIN.IMPORT_NAME%		PLUGIN.IMPORT_NAME_Upper
	::%dk_call% dk_echo "PLUGIN.IMPORT_NAME_Upper = %PLUGIN.IMPORT_NAME_Upper%"
	
	::### PLUGIN.IMPORT_NAME_Alphanumeric
	%dk_call% dk_convertToCIdentifier	%PLUGIN.IMPORT_NAME_Upper% 	PLUGIN.IMPORT_NAME_Alphanumeric
	%dk_call% dk_echo "PLUGIN.IMPORT_NAME_Alphanumeric = %PLUGIN.IMPORT_NAME_Alphanumeric%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_chdir "%DKIMPORTS_DIR%/git"
	%dk_call% dk_importVariables "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe" IMPORT_NAME git INSTALL_ROOT "%DKTOOLS_DIR%"
	::### Import hashtable #################
	:: 		 ####### TODO #######
	::######################################
	
	%dk_call% dk_echo
	%dk_call% dk_echo "IMPORT_ROOT                     = %IMPORT_ROOT%"
	%dk_call% dk_echo "IMPORT_NAME                     = %IMPORT_NAME%"
	%dk_call% dk_echo "IMPORT_PATH                     = %IMPORT_PATH%"
	%dk_call% dk_echo "INSTALL_ROOT                    = %INSTALL_ROOT%"
	%dk_call% dk_echo "INSTALL_NAME                    = %INSTALL_NAME%"
	%dk_call% dk_echo "INSTALL_PATH                    = %INSTALL_PATH%"
	%dk_call% dk_echo "VERSION                         = %VERSION%"
	%dk_call% dk_echo "BRANCH                          = %BRANCH%"
	%dk_call% dk_echo "TAG                             = %TAG%"
	%dk_call% dk_echo
	%dk_call% dk_echo "PLUGIN.ARGS                     = %PLUGIN.ARGS%"
	%dk_call% dk_echo "PLUGIN.ID                       = %PLUGIN.ID%"
	%dk_call% dk_echo "PLUGIN.IMPORT_ROOT              = %PLUGIN.IMPORT_ROOT%"
	%dk_call% dk_echo "PLUGIN.IMPORT_NAME              = %PLUGIN.IMPORT_NAME%"
	%dk_call% dk_echo "PLUGIN.IMPORT_PATH              = %PLUGIN.IMPORT_PATH%"
	%dk_call% dk_echo "PLUGIN.INSTALL_ROOT             = %PLUGIN.INSTALL_ROOT%"
	%dk_call% dk_echo "PLUGIN.INSTALL_NAME             = %PLUGIN.INSTALL_NAME%"
	%dk_call% dk_echo "PLUGIN.INSTALL_PATH             = %PLUGIN.INSTALL_PATH%"
	%dk_call% dk_echo "PLUGIN.VERSION                  = %PLUGIN.VERSION%"
	%dk_call% dk_echo "PLUGIN.BRANCH                   = %PLUGIN.BRANCH%"
	%dk_call% dk_echo "PLUGIN.TAG                      = %PLUGIN.TAG%"
	%dk_call% dk_echo
	%dk_call% dk_echo "PLUGIN.URL                      = %PLUGIN.URL%"
	%dk_call% dk_echo "PLUGIN.URL_Filename             = %PLUGIN.URL_Filename%"
	%dk_call% dk_echo "PLUGIN.URL_File                 = %PLUGIN.URL_File%"
	%dk_call% dk_echo "PLUGIN.URL_Extension            = %PLUGIN.URL_Extension%"
	%dk_call% dk_echo "PLUGIN.URL_List                 = %PLUGIN.URL_List%"
	%dk_call% dk_echo "PLUGIN.URL_Array                = %PLUGIN.URL_Array%"
	%dk_call% dk_echo "PLUGIN.URL_Length               = %PLUGIN.URL_Length%"
	%dk_call% dk_echo
	%dk_call% dk_echo "PLUGIN.GIT                      = %PLUGIN.GIT%"
	%dk_call% dk_echo "PLUGIN.GIT_NAME                 = %PLUGIN.GIT_NAME%"
	%dk_call% dk_echo
	%dk_call% dk_echo "PLUGIN.IMPORT                   = %PLUGIN.IMPORT%"
	%dk_call% dk_echo "PLUGIN.IMPORT_NAME_Lower        = %PLUGIN.IMPORT_NAME_Lower%"
	%dk_call% dk_echo "PLUGIN.IMPORT_NAME_Upper        = %PLUGIN.IMPORT_NAME_Upper%"	
	%dk_call% dk_echo "PLUGIN.IMPORT_NAME_Alphanumeric = %PLUGIN.IMPORT_NAME_Alphanumeric%"
	%dk_call% dk_echo
	%dk_call% dk_echo "PLUGIN.Build_Dir                = %PLUGIN.Build_Dir%"
	%dk_call% dk_echo "PLUGIN.Config_Dir               = %PLUGIN.Config_Dir%"
	%dk_call% dk_echo "PLUGIN.Debug_Dir                = %PLUGIN.Debug_Dir%"
	%dk_call% dk_echo "PLUGIN.Release_Dir              = %PLUGIN.Release_Dir%"
	%dk_call% dk_echo "PLUGIN.Tuple_Dir                = %PLUGIN.Tuple_Dir%"
	%dk_call% dk_echo
	%dk_call% dk_echo "GIT.ARGS                        = %GIT.ARGS%"	
%endfunction%
