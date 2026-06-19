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
rem # dk_httpHeader(<url> <ret:optional>)
rem #
rem #
:dk_httpHeader
%setlocal%
	
	%dk_call% dk_validate curl.exe %dk_call% dk_findFile curl.exe
	
	set "dk_httpHeader="
	for /f "tokens=*" %%a in ('"%curl.exe:/=\%" --silent --head --fail --remove-on-error "%~1"') do (
		(set dk_httpHeader=!dk_httpHeader!%%a\n)
	)

	:return
	endlocal & (
		set "dk_httpHeader=%dk_httpHeader%"
	)

%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_echo
	set "url=https://github.com/git-for-windows/git/releases/download/v2.46.2.windows.1/PortableGit-2.46.2-64-bit.7z.exe"
	%dk_call% dk_httpHeader "%url%"
	%dk_call% dk_echo "###### HEADER: %url% ######"
	%dk_call% dk_echo "%dk_httpHeader%"

%endfunction%
		
	%dk_call% dk_echo
	set "url=http://www.google.com/index.html"
	%dk_call% dk_httpHeader "%url%"
	%dk_call% dk_echo "###### HEADER: %url% ######"
	%echox% %dk_httpHeader%
	
	%dk_call% dk_echo
	set "url=http://www.nonexisting.com/nofile.no"
	%dk_call% dk_httpHeader "%url%"
	%dk_call% dk_echo "###### HEADER: %url% ######"
	%echox% %dk_httpHeader%
	
	%dk_call% dk_echo
	set "url=https://aka.ms/vs/16/release/VC_redist.x86.exe"
	%dk_call% dk_httpHeader "%url%"
	%dk_call% dk_echo "###### HEADER: %url% ######"
	%echox% %dk_httpHeader%
	
	%dk_call% dk_echo
	set "url=https://download.visualstudio.microsoft.com/download/pr/b635098a-2d1d-4142-bef6-d237545123cb/2651b87007440a15209cac29634a4e45/dotnetfx35.exe"
	%dk_call% dk_httpHeader "%url%"
	%dk_call% dk_echo "###### HEADER: %url% ######"
	%echox% %dk_httpHeader%

%endfunction%
