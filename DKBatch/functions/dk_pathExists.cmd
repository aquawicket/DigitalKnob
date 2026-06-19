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
rem # dk_pathExists(>path> <rtn_var:Optional>)
rem #
rem #		Check if a case sensitive path exists
rem #
:dk_pathExists
	set "_dk_pathExists_CASE_SENSITIVE=1"
%setlocal%

	:init
	rem ###### Clear and set function variables ######
	set "currentScope=%~n0"
	for /F "delims==" %%a in ('set %~n0 2^>nul') do (
		set "%%a=NULL"
	)
	set %~n0_ARGC=0
	for %%x in (%*) do (
		set /A %~n0_ARGC+=1
		set %~n0_ARGV!%~n0_ARGC!=%%x
	)
	set "%~n0=false"
	if "%~1" equ "" (goto:return)
	rem ##############################################
	
	set "arg1=%~1"
	if defined %~1 (set "arg1=!%~1!")
	
	for %%G in ("%arg1%") do (set "_path_=%%~fG")
	
	if EXIST "%_path_%" (
		set "dk_pathExists=true"
	)
	
	echo %arg1:\=/%
	echo %_path_:\=/%
	if "%_dk_pathExists_CASE_SENSITIVE%" equ "1" (
		if "%arg1:\=/%" neq "%_path_:\=/%" (
			set "dk_pathExists=false"
		)
	)
    
	
	:return
	rem ########################################################
	for /F "tokens=1,2 delims==" %%a in ('set %~n0') do endlocal & (
		if "%currentScope%" equ "%~n0" endlocal
		if /i "%%b" equ "NULL" (set "%%a=") else (set "%%a=%%b")
	)
	exit /b !%~n0:false=1!
	rem ########################################################
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem ###### Using if return value
    echo.
    set "_path_=C:/Windows"
    %dk_call% dk_pathExists "%_path_%"
    if /i "%dk_pathExists%" equ "TRUE" (echo %dk_pathExists_ARGV1% EXISTS) else (call & echo %dk_pathExists_ARGV1% NOT FOUND)
	
    echo.
    set "_path_=C:/windows"
    %dk_call% dk_pathExists %_path_%
    if /i "%dk_pathExists%" equ "true" (echo %dk_pathExists_ARGV1% EXISTS) else (call & echo %dk_pathExists_ARGV1% NOT FOUND)
   
    echo.
    set "_path_=C:/windows"
    %dk_call% dk_pathExists _path_
    if /i "%dk_pathExists%" equ "TRUE" (echo %dk_pathExists_ARGV1% EXISTS) else (call & echo %dk_pathExists_ARGV1% NOT FOUND)

   
   
    rem ###### Using if ERRORLEVEL
    echo.
    set "_path_=C:/Windows"
    %dk_call% dk_pathExists "%_path_%"
    if NOT ERRORLEVEL 1 (echo %dk_pathExists_ARGV1% EXISTS) else (call & echo %dk_pathExists_ARGV1% NOT FOUND)
   
    echo.
    set "_path_=C:/NonExistent"
    %dk_call% dk_pathExists "%_path_%"
    if NOT ERRORLEVEL 1 (echo %dk_pathExists_ARGV1% EXISTS) else (call & echo %dk_pathExists_ARGV1% NOT FOUND)

   
   
    rem ###### Using && and || conditionals
    echo.
    set "_path_=C:/Windows"
    %dk_call% dk_pathExists "%_path_%" && (echo !dk_pathExists_ARGV1! EXISTS) || (call & echo !dk_pathExists_ARGV1! NOT FOUND)
   
    echo.
    set "_path_=C:/NonExistent"
    %dk_call% dk_pathExists "%_path_%" && (echo !dk_pathExists_ARGV1! EXISTS) || (call & echo !dk_pathExists_ARGV1! NOT FOUND)
%endfunction%