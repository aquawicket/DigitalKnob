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
rem # dk_isCRLF(file)
rem #
rem #		Reference: https://stackoverflow.com/a/65616169
rem #
:dk_isCRLF
%setlocal%

	set "dk_isCRLF_1=%~1"
	set "dk_isCRLF_1=%dk_isCRLF_1:/=\%"
	set "_crlf_=%dk_isCRLF_1%.crlf"
	
	%dk_call% dk_validate find.exe %dk_call% dk_findFile find.exe
    call type "%dk_isCRLF_1%" | "%find.exe:/=\%" "" /v > "%_crlf_%"
	
	call :getSize "%dk_isCRLF_1%" size1
	call :getSize "%_crlf_%" size2
	call :getLineCount "%dk_isCRLF_1%" lines
	del "%_crlf_%"
	
	rem add 2 in case the file doesn't have a trailing newline, since find will add it
	set /a size1plus2=%size1%+2
    if "%size1plus2%" equ "%size2%" (
        if "%lines%" equ "2" (
            rem echo File uses LF line endings!
			set "dk_isCRLF=1"
        ) else (
            rem echo File uses CRLF or has no line endings!
			set "dk_isCRLF=0"
        )
    ) else (
        if %size1% lss %size2% (
            rem echo File uses LF line endings!
			set "dk_isCRLF=1"
        ) else (
            rem echo File uses CR+LF line endings!
			set "dk_isCRLF=0"
        )
    )
    
	:return
	endlocal & (
		set "dk_isCRLF=%dk_isCRLF%"
		set "dk_isCRLF_1=%dk_isCRLF_1%"
		set "findstr.exe=%findstr.exe%"
		set "find.exe=%find.exe%"
	)
	rem %dk_call% dk_debug "dk_isCRLF = %dk_isCRLF%"
	exit /b %dk_isCRLF%
%endfunction%

:getSize
    set %~2=%~z1
%endfunction%

:getLineCount
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	%dk_call% dk_validate find.exe %dk_call% dk_findFile find.exe
	for /f "usebackq" %%a in ('"%findstr.exe:/=\%" /R /N '^' '%~1' ^| "%find.exe:/=\%" /C ':'') do (
		set %~2=%%a
	)
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_isCRLF "%~f0" && (%dk_call% dk_debug "!dk_isCRLF_1! is CRLF") || (%dk_call% dk_debug "!dk_isCRLF_1! is NOT CRLF")
   
    %dk_call% dk_validate DKBASH_FUNCTIONS_DIR %dk_call% dk_DKBRANCH_DIR
    %dk_call% dk_isCRLF "%DKBASH_FUNCTIONS_DIR%/DK.sh" && (%dk_call% dk_debug "!dk_isCRLF_1! is CRLF") || (%dk_call% dk_debug "!dk_isCRLF_1! is NOT CRLF")
	
	echo test dk_isCRLF> dk_isCRLF_TEST.txt
	%dk_call% dk_isCRLF "dk_isCRLF_TEST.txt" && (%dk_call% dk_debug "!dk_isCRLF_1! is CRLF") || (%dk_call% dk_debug "!dk_isCRLF_1! is NOT CRLF")
	del dk_isCRLF_TEST.txt
%endfunction%
