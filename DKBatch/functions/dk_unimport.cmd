@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem #########################################################################
rem # dk_unimport() LIBRARY APP
rem #
rem #	This is a flexable super function for importing just about anything into DigitalKnob
rem #	The idea is to provide a url or path and dk_unimport will do the rest. 
rem #
rem #	@url	- The online path of the .git or file to import
rem #
rem #	github GIT:	https://github.com/orginization/library.git		dkimportGit(url) #branch/tag #PATCH
rem #	github DL:	https://github.com/orginization/library			dkimportGit(url) #branch/tag #PATCH
rem #	lib url DL:	https://website.com/library.zip					dkimportDownload(url) #PATCH
rem #	exe url DL:	https://website.com/executable.exe 				dkimportDownload(url) #PATCH
rem #
rem #	TODO: https://cmake.org/cmake/help/latest/module/FetchContent.html 
rem #
:dk_unimport
rem %setlocal%
	
	%dk_call% dk_importVariables %*

	if NOT EXIST "!%CURRENT_PLUGIN%_Install_Path!" (
		echo !%CURRENT_PLUGIN%_Install_Name! NOT installed
		%return%
	)
	
	%dk_call% dk_delete "!%CURRENT_PLUGIN%_Install_Path!"
%endfunction%
	










rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	
	%dk_call% dk_uninstall git
	
	rem %dk_call% #dk_import "https://github.com/madler/zlib/archive/d4768283.zip"
	rem %dk_call% dk_import https://www.dependencywalker.com/depends22_x64.zip
%endfunction%