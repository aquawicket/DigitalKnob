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


rem ####################################################################
rem # dk_getUrl(<url> <ret:optional>)
rem #
:dk_getUrl
%setlocal%

	set "dk_getUrl=%~1"
	%dk_call% dk_validate curl.exe %dk_call% dk_findFile curl.exe
	
	for /f "tokens=*" %%a in ('"%curl.exe:/=\%" --silent --show-error --head --output nul --write-out "%%{redirect_url}" "%dk_getUrl%"') do (
		if "%%a" neq "" (set dk_getUrl=%%~a)
	)

	:return
	endlocal & (
		(set "dk_getUrl=%dk_getUrl%")
		if "%~2" neq "" (
			(set "%~2=%dk_getUrl%")
		) else (
			rem echo "%dk_getUrl%"
		)
	)

%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set "echox=echo."%CUB%"

	set "url=http://www.google.com/index.html"
	%dk_call% dk_getUrl "%url%"
	%echox% url:'%url%' dk_getUrl:'%dk_getUrl%'
	
	set "url=http://www.nonexisting.com/nofile.no"
	%dk_call% dk_getUrl "%url%"
	%echox% url:'%url%' dk_getUrl:'%dk_getUrl%'
	
	set "url=https://aka.ms/vs/16/release/VC_redist.x86.exe"
	%dk_call% dk_getUrl "%url%"
	%echox% url:'%url%' dk_getUrl:'%dk_getUrl%'
	
	set "url=https://dotnet.microsoft.com/en-us/download/dotnet-framework/thank-you/net35-sp1-offline-installer"
	%dk_call% dk_getUrl "%url%"
	%echox% url:'%url%' dk_getUrl:'%dk_getUrl%'
	
	set "url=https://github.com/git-for-windows/git/releases/download/v2.46.2.windows.1/PortableGit-2.46.2-64-bit.7z.exe"
	%dk_call% dk_getUrl "%url%"
	%echox% url:'%url%' dk_getUrl:'%dk_getUrl%'

%endfunction%
