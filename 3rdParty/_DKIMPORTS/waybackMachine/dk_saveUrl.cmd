rem shebang
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

rem ############################################################################
::# dk_saveUrl()
::#
:dk_saveUrl
%setlocal%

	set url=%~1
	
	rem start "" https://web.archive.org/save/%_url_%
	
	::%dk_call% dk_httpStatus %url%
	::echo dk_httpStatus = %dk_httpStatus%
	::if %dk_httpStatus% gtr 299  if %dk_httpStatus% lss 400 		
	%dk_call% dk_getUrl %url% url

	%dk_call% dk_urlExists https://web.archive.org/web/%url% && (echo exists) || (
		echo %yellow% Archiving %url% to Wayack Machine
		%dk_call% curl.exe --silent --show-error --head --create-dirs --output nul https://web.archive.org/save/%url% >nul
	)
	
	%dk_call% dk_urlExists https://web.archive.org/web/%url% && (
		echo %green% Found https://web.archive.org/web/%url% %clr%
	) || (
		echo %red% Not Found https://web.archive.org/web/%url% %clr%
	)
	
	rem %dk_call% dk_download https://web.archive.org/web/%url%
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_inputBox
	%dk_call% dk_saveUrl %dk_inputBox%
	
	:: %dk_call% dk_saveUrl https://github.com/xiph/flac/releases/download/1.4.3/flac-1.4.3.tar.xz
%endfunction%