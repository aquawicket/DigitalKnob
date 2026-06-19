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
rem # dk_fileToMatrix(path rtn_var)
rem #
rem #  Read lines of a file into an grid and echo them back
rem #
:dk_fileToMatrix
%setlocal%

	set "_file_=%~1"
	set "_file_=%_file_:/=\%"

	set /a _row_=0
	for /F "usebackq delims=" %%r in ("%_file_%") do (

		set /a _column_=0
		for %%c IN (%%r) do (
			set "%~2[!_row_!][!_column_!]=%%c"
			set /a _column_+=1
		)
		set /a _row_+=1
	)

	rem Return the grid to the calling scope
	set "_SCOPE_=%~n0"
	for /F "delims=" %%a in ('set %~2[') do (
		if "%_SCOPE_%" equ "%~n0" endlocal
		set "%%a"
	)
	
rem	endlocal & (
rem		for /F "delims=" %%a in ('set %~2[') do (
rem			set "%%a"
rem		)
rem	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

rem	%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
rem	%dk_call% dk_fileToMatrix "%DKBRANCH_DIR%\build_list.txt" MyGrid
	
	%dk_call% dk_selectFile
	%dk_call% dk_fileToMatrix "%dk_selectFile%" MyGrid

	rem %dk_call% dk_fileToMatrix "fileToGrid_TEST.txt" MyGrid

	rem print items individually
	%dk_call% dk_printVar MyGrid[0][0]
	%dk_call% dk_printVar MyGrid[1][1]
	%dk_call% dk_printVar MyGrid[2][2]
	%dk_call% dk_printVar MyGrid[3][3]
	%dk_call% dk_printVar MyGrid[4][4]
	%dk_call% dk_printVar MyGrid[5][5]
	%dk_call% dk_printVar MyGrid[6][6]
	%dk_call% dk_printVar MyGrid[7][7]
	%dk_call% dk_printVar MyGrid[8][8]
	%dk_call% dk_printVar MyGrid[9][9]

	rem print rows individually
	%dk_call% dk_printVar MyGrid[0]
	%dk_call% dk_printVar MyGrid[1]
	%dk_call% dk_printVar MyGrid[2]
	%dk_call% dk_printVar MyGrid[3]
	%dk_call% dk_printVar MyGrid[4]
	%dk_call% dk_printVar MyGrid[5]
	%dk_call% dk_printVar MyGrid[6]
	%dk_call% dk_printVar MyGrid[7]
	%dk_call% dk_printVar MyGrid[8]
	%dk_call% dk_printVar MyGrid[9]
%endfunction%
