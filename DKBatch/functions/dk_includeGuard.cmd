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


rem if defined include_guard_dk_includeGuard (%return%) else set include_guard_dk_includeGuard=1
rem if not defined DKINIT_cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %* && exit /b %errorlevel%) & call :TEST_dk_includeGuard
rem ##################################################################################
rem # dk_includeGuard()
rem #
rem #
:dk_includeGuard
%setlocal%

    rem since batch calls scripts by file and NOT by function, there is no need to use include guards
   
rem  (
rem      setlocal DisableDelayedExpansion
rem      (goto) 2>nul
rem      call set parent=%%~0
rem      if "%parent%" neq "" (
rem          if defined include_guard_%parent% (
rem              rem echo %parent% is already included
rem              call %return%
rem          ) else (
rem              rem echo setting include_guard_%parent% to 1
rem              set include_guard_%parent%=1
rem          )
rem      )
rem  )
rem  echo THIS IS NEVER REACHED
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem (goto) 2>nul & call set caller=%%~0 & echo %caller%
   
    rem (goto) 2>nul & call set caller=%%~0 & echo %caller% & goto resume
    rem :resume
    rem echo :resume
%endfunction%
