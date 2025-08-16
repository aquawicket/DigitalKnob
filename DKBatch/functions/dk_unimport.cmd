@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::#########################################################################
::# dk_unimport() LIBRARY APP
::#
::#	This is a flexable super function for importing just about anything into DigitalKnob
::#	The idea is to provide a url or path and dk_unimport will do the rest. 
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
:dk_unimport
::%setlocal%
	%dk_call% dk_debugFunc 0 99
	
	::set "Import.Path=%CD:\=/%"
	if not defined CURRENT_IMPORT (set "CURRENT_IMPORT=%CD:\=/%")
	set "Import.Path=%CURRENT_IMPORT%"
	%dk_call% dk_assertPath "%Import.Path%/dkconfig.txt"
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
	
	%dk_call% dk_delete "%PLUGIN.Install.Path%"
%endfunction%
	










::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_uninstall git
	
	::%dk_call% #dk_import "https://github.com/madler/zlib/archive/d4768283.zip"
	::%dk_call% dk_import https://www.dependencywalker.com/depends22_x64.zip
%endfunction%