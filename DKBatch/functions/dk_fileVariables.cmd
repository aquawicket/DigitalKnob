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
rem # dk_fileVariables(<file>)
rem #
:dk_fileVariables
	rem if NOT defined dk_fileVariables_PRINT_VARIABLES (set "dk_fileVariables_PRINT_VARIABLES=1")
%setlocal%

	set "_file_=%~1"
	set "_file_=%_file_:\=/%"
		
	rem ### Extract the file if missing
rem	%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR	
rem	set "DigitalKnob_tar_gz=%DKStorage_Dir%/DigitalKnob.tar.gz"
rem	if EXIST "%DigitalKnob_tar_gz%" (
rem		if NOT EXIST "%_file_%" (
rem			call set "tar_file=%%_file_:%DIGITALKNOB_DIR%/=%%"
rem			tar -zxvf "%DigitalKnob_tar_gz%" -C "%DKBRANCH_DIR%" %tar_file%
rem		)
rem	)
	
	rem ### Download the file if missing
rem	if NOT EXIST "%_file_%" (
rem		%dk_call% dk_assertVar DIGITALKNOB_DIR
rem		%dk_call% dk_assertVar DKHTTP_DIGITALKNOB_DIR
rem		set "dkhttp_file=!_file_:%DIGITALKNOB_DIR%=%DKHTTP_DIGITALKNOB_DIR%!"
rem		%dk_call% dk_download "!dkhttp_file!" "%_file_%"
rem	)

	if "%dk_fileVariables_PRINT_VARIABLES%" equ "1" (
		echo.
		%dk_call% dk_debug "------ %_file_% Parameters ------"
	)
	
	rem ### Remove comments from line
	for /f "usebackq tokens=*" %%G in ("%_file_:/=\%") do (
		for /f "delims=#" %%i in (" %%~G") do (set line=%%~i)
		(set line=!line:~1!)
		for /f "delims== tokens=1,2" %%Y in ("!line!") do (
			
			(%dk_call% dk_trim %%Y)
			(set var=!dk_trim:${=%%%!)
			(set var=!var:$ENV{=%%%!)
			(set var=!var:}=%%%!)
			(call set var=!var!)
			(set var=!var:\=/!)
			(call set var=!var!)
			
			(%dk_call% dk_trim %%Z)
			(set value=!dk_trim:${=%%%!)
			(set value=!value:$ENV{=%%%!)
			(set value=!value:}=%%%!)
			(call set value=!value!)
			(set value=!value:\=/!)
			
			
			
			(call set !var!=!value!)
			
			if "%dk_fileVariables_PRINT_VARIABLES%" equ "1" (
				call echo !var! = '%%!var!%%'
			)
			
			rem ######  MULTIPLE VARIBLES TO PARENT_SCOPE (part 1) ######
			rem ###  Setup the setlist for endlocal
			rem ###  If we want to pass a set of variables through endlocal, we can create a setlist.
			rem ###  * See below *
			for /F "delims=" %%G in ('set !var!') do (
				(set setlist=!setlist! "%%~G")
			)
		)
	)
	
	if "%dk_fileVariables_PRINT_VARIABLES%" equ "1" (
		%dk_call% dk_debug "----------------------------------"
		echo.
	)
	
	rem ######  MULTIPLE VARIBLES TO PARENT_SCOPE (part 2) ######
	rem ###  Now we have a setlist we can iterate through endlocal.
	rem ###  The setlist will set the variables in the parent scope
	set "_SCOPE_=%~n0"
	for %%G in (%setlist%) do (
		if "%_SCOPE_%" equ "%~n0" endlocal
		set %%~G
	)
%endfunction%

:printVar
	echo %blue%'%~1' = '!%~1!'%clr%
%endfunction%


rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
rem %setlocal%

	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	
	>"%DKCACHE_DIR:/=\%\dk_fileVariables_TEST.txt" (
		echo ### dk_fileVariables TEST ###
		echo varA=Value_of_varA
		echo varB=Value_of_varB_with_trailing_comment 	# with trailing comment
		echo varC=Value of varC with spaces
		echo varD=Value of varD padded with spaces 
	rem echo varE=\"Value of varE with value enclosed inquotes\"
	rem echo \"varF\"=Value of varF with varname enclosed in quotes
	rem echo \"varG=Value of varG with line enclosed in quotes\"
		echo varH=Value of varH
		echo varI=${varH}
		echo varJ=varK
		echo ${varJ}=Value of varK
		echo #varL=Value of varL Commented
		echo.
		echo ComSpec=${ComSpec}
		echo USERPROFILE=$ENV{USERPROFILE}
		echo SHELL=$ENV{SHELL}
		echo HOME=$ENV{HOME}
	)
	
	rem %dk_call% dk_fileAppend "%DKCACHE_DIR%/dk_fileVariables_TEST.txt"	cmd.exe=^&where cmd.exe
	rem >>"%DKCACHE_DIR%/dk_fileVariables_TEST.txt" (echo cmd.exe=^&where cmd.exe)

	
	%dk_call% dk_debug "############ Testing dk_fileVariables.cmake ############"
	set "dk_fileVariables_PRINT_VARIABLES=1"
	%dk_call% dk_fileVariables "%DKCACHE_DIR%/dk_fileVariables_TEST.txt"
	%dk_call% dk_echo "varA = %varA%"
	%dk_call% dk_echo "varB = %varB%"
	%dk_call% dk_echo "varC = %varC%"
	%dk_call% dk_echo "varD = %varD%"
	%dk_call% dk_echo "varH = %varH%"
	%dk_call% dk_echo "varI = %varI%"
	%dk_call% dk_echo "varJ = %varJ%"
	%dk_call% dk_echo "varK = %varK%"

%endfunction%

