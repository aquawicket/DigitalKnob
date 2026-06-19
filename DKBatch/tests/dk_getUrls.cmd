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


rem ############################################################################
::# dk_getUrls(search_dir, name_pattern, output_file)
::#
:dk_getUrls
%setlocal%
	if exist "%output_file%" (%dk_call% dk_delete "%output_file:/=\%")
	
	set "search_dir=%~1"
	set "name_pattern=%~2"
	set "output_file=%~3"

	echo Searching for URLs in %search_dir% and its subdirectories...
	echo Results will be saved to %output_file%
	
	

	::findstr /r /s /i "https://[a-zA-Z0-9./_?&=-]* " "%search_dir%\%name_pattern%" > "%output_file%"
	
	findstr /s /i "https://" "%search_dir%\%name_pattern%" > "%output_file%"

	echo Search complete.
	echo Found URLs are listed in %output_file%.

%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% %~dp0\dk_getUrls "C:\Users\Administrator\Desktop\aquawicket.com\SOCIAL_MEDIA\Messenger\messages\inbox\raineyharley__kwncku83q" *.html urls.txt
%endfunction%