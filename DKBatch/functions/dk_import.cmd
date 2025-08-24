@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::#########################################################################
::# dk_import() LIBRARY APP
::#
::#	This is a flexable super function for importing just about anything into DigitalKnob
::#	The idea is to provide a url or path and dk_import will do the rest. 
::#
::#	@url	- The online path of the .git or file to import
::#
::#	github GIT:	https://github.com/orginization/library.git		dkimportGit(url) #branch/tag #PATCH
::#	github DL:	https://github.com/orginization/library			dkimportGit(url) #branch/tag #PATCH
::#	lib url DL:	https://website.com/library.zip					dkimportDownload(url) #PATCH
::#	exe url DL:	https://website.com/executable.exe 				dkimportDownload(url) #PATCH
::#
::#	TODO: https://cmake.org/cmake/help/latest/module/FetchContent.html 
::#
:dk_import
::%setlocal%
	%dk_call% dk_debugFunc 0 99
	
	::set "Import.Path=%CD:\=/%"
	if NOT defined CURRENT_IMPORT (set "CURRENT_IMPORT=%CD:\=/%")
	set "Import.Path=%CURRENT_IMPORT%"
	::%dk_call% dk_assertPath "%Import.Path%/dkconfig.txt"
	%dk_call% dk_getFileParams "%Import.Path%/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	%dk_call% dk_basename %Import.Path% Import.Name
	
	%dk_call% dk_getParameterValue APP %*
	if defined APP (
		%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
		set "INSTALL_ROOT=INSTALL_ROOT !DKTOOLS_DIR!"
	)
	%dk_call% dk_assertVar %Import.Name%_%Host_Tuple%_Import
	%dk_call% dk_importVariables !%Import.Name%_%Host_Tuple%_Import! %INSTALL_ROOT%
	if EXIST "%PLUGIN.Install.Path%" (
		echo %PLUGIN.Install.Name% already installed
		%return%
	)
	%dk_call% dk_download %PLUGIN.Url%
	
	%dk_call% dk_getExtension %PLUGIN.Url% PLUGIN.Url.Extension
	if "%PLUGIN.Url.Extension%" equ ".7z"		(set "FileType=Archive")
	if "%PLUGIN.Url.Extension%" equ ".bz"		(set "FileType=Archive")
	if "%PLUGIN.Url.Extension%" equ ".bz2" 		(set "FileType=Archive")
	if "%PLUGIN.Url.Extension%" equ ".gz" 		(set "FileType=Archive")
	if "%PLUGIN.Url.Extension%" equ ".rar" 		(set "FileType=Archive")
	if "%PLUGIN.Url.Extension%" equ ".sfx.exe" 	(set "FileType=Archive")
	if "%PLUGIN.Url.Extension%" equ ".tar" 		(set "FileType=Archive")
	if "%PLUGIN.Url.Extension%" equ ".tar.gz" 	(set "FileType=Archive")
	if "%PLUGIN.Url.Extension%" equ ".tgz" 		(set "FileType=Archive")
	if "%PLUGIN.Url.Extension%" equ ".xz" 		(set "FileType=Archive")
	if "%PLUGIN.Url.Extension%" equ ".zip" 		(set "FileType=Archive")
	
	if "%FileType%" equ "Archive" (
		%dk_call% dk_smartExtract "%dk_download%" "%PLUGIN.Install.Path%"
	)

%endfunction%
	
	set "url=%~1"
	%dk_call% dk_allButFirstArgs %*
	set ARGN=%dk_allButFirstArgs%
	::%dk_call% dk_getParameter NO_HALT REMOVE
	
	%dk_call% dk_importVariables %url% %ARGN%
	%dk_call% dk_assertVar CURRENT_PLUGIN

::	if "%DKOFFLINE%" neq "1" (
::		rem ###### Import from Git Repository ######
::		%dk_call% dk_getExtension %url% extension
::		if "!extension!" equ ".git" (
::			
::			%dk_call% dk_depend git
::			
::			if NOT EXIST "!%CURRENT_PLUGIN%_DIR!/.git" (
::				%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
::				%dk_call% dk_chdir "%DK3RDPARTY_DIR%"
::				if EXIST "!%CURRENT_PLUGIN%_DIR!" (
::					%dk_call% dk_delete(!%CURRENT_PLUGIN%_DIR!)
::				) else (
::					%dk_call% dk_mkdir(!%CURRENT_PLUGIN%_DIR!)
::				)
::				%dk_call% dk_chdir !%CURRENT_PLUGIN%_DIR!
::				%dk_call% dk_command %GIT_EXE% clone !%CURRENT_PLUGIN%_URL! !%CURRENT_PLUGIN%_DIR!
::			)
::			%dk_call% dk_chdir !%CURRENT_PLUGIN%_DIR!
::			%dk_call% dk_exec %GIT_EXE% checkout -- .
::			%dk_call% dk_exec %GIT_EXE% checkout !%CURRENT_PLUGIN%_BRANCH!)
::			%dk_call% dk_exec %GIT_EXE% pull
::			if defined %CURRENT_PLUGIN%_TAG (
::				%dk_call% dk_exec %GIT_EXE% checkout !{%CURRENT_PLUGIN%_TAG!
::			)
::			
::		rem ###### Import from Download File ######
::		) else (
			%dk_call% dk_debug "CURRENT_PLUGIN = %CURRENT_PLUGIN%"
			%dk_call% dk_debug "%CURRENT_PLUGIN%_IMPORT_NAME = !%CURRENT_PLUGIN%_IMPORT_NAME!"
			%dk_call% dk_verbose "%dk_call% dk_install !%CURRENT_PLUGIN%_IMPORT_NAME! %ARGN%"
			
			::%dk_call% dk_install %CURRENT_PLUGIN% %ARGN% %NO_HALT%
::		)
::	)
	
	::%dk_call% dk_getParameter PATCH %ARGV%
	::%dk_call% dk_getParameter PATCH
	if defined PATCH (
		%dk_call% dk_patch !%CURRENT_PLUGIN%_IMPORT_NAME! !%CURRENT_PLUGIN%_DIR!
	)
	
%endfunction%














::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_depend git
	
	::%dk_call% #dk_import "https://github.com/madler/zlib/archive/d4768283.zip"
	::%dk_call% dk_import https://www.dependencywalker.com/depends22_x64.zip
%endfunction%