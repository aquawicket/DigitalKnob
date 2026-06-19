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
rem # dk_showFileLine(filepath, match_string)
rem # dk_showFileLine(filepath, line_number)
rem #
rem #
:dk_showFileLine
%setlocal%

	rem ###### Settings ######
	set header_bg_color=%bg_lblack%
	set header_text_color=%black%
	
	set margin_bg_color=%bg_black%
	set margin_text_color=%white%
	set bg_color=%bg_lwhite%
	set text_color=%black%
	
	set marghi_bg_color=%bg_lblack%
	set marghi_text_color=%lwhite%
	set hi-lite_bg_color=%bg_lred%
	set hi-lite_text_color=%black%
	
	
	set "_filepath_=%~f1"
	set "_filepath_=%_filepath_:/=\%"

    set /a "line=%~2" || for /f "delims=:" %%a in ('%SystemRoot%\System32\findstr.exe /n /c:"%~2" "%_filepath_%"') do set "line=%%a"
   
    echo.%header_bg_color%%header_text_color%[0K  File: %_filepath_%: !line!
    set /a n=1
    set /a min=!line!-15
    set /a max=!line!+15
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
    for /f "delims=" %%a in ('%findstr.exe% /n /r /c:"^" "%_filepath_%"') do (
        if !n! LSS !max! (
            if !n! GTR !min! (
                set str=%%a
                
                if !n! equ !line! (
					set str=!str::= %hi-lite_bg_color%%hi-lite_text_color%[0K    !
                    echo.%marghi_bg_color%%marghi_text_color% ^>  !str!
                ) else (
                    set str=!str::= %bg_color%%text_color%[0K    !
					echo.%margin_bg_color%%margin_text_color%   !str!%clr%
                )
            )
        )      
        set /a n+=1
    )
    echo.
	echo.
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

 
    %dk_call% dk_showFileLine "%~dp0\DK.cmd" 194
	pause
    %dk_call% dk_showFileLine "%~dp0\DK.cmd" "DKTEST"
%endfunction%
