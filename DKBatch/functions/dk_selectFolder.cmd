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


rem ################################################################################
rem # dk_selectFolder(<rtn_var>:optional)
rem #
:dk_selectFolder
%setlocal%
	
	%dk_call% dk_validate mshta.exe  %dk_call% dk_findFile mshta.exe
    %dk_call% dk_assertPath mshta.exe
	
	rem ### dk_selectFolder_js ###
	rem set dk_selectFolder_js=var objShellApp = new ActiveXObject('Shell.Application');var Folder = objShellApp.BrowseForFolder(0, 'Select Folder:',1, '::{20D04FE0-3AEA-1069-A2D8-08002B30309D}');try {new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).Write(Folder.Self.Path)};catch (e){};close();
	
	rem ### dk_selectFolder_js ###
	%dk_call% dk_validate DKJAVASCRIPT_FUNCTIONS_DIR %dk_call% dk_DKBRANCH_DIR
	for /F "usebackq delims=" %%r in ("%DKJAVASCRIPT_FUNCTIONS_DIR%/dk_selectFolder.js") do (
		set dk_selectFolder_js=!dk_selectFolder_js!%%r
	)
	
    for /f "usebackq delims=" %%i in (
		`@"%mshta.exe:/=\%" "javascript:%dk_selectFolder_js%" ^
		1^|more`
    ) do set "dk_selectFolder=%%i"
	
	:return
	endlocal & (
		set "dk_selectFolder=%dk_selectFolder:\=/%"
		if "%~1" neq "" (set "%~1=%dk_selectFolder:\=/%")
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_selectFolder myFolder
	%dk_call% dk_debug "dk_selectFolder = '%dk_selectFolder%'"
    %dk_call% dk_debug "myFolder = '%myFolder%'"
%endfunction%
