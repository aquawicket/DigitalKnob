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
rem # dk_chars()
rem #
rem #	Reference:	https://www.gaijin.at/en/infos/ascii-ansi-character-table
rem #
:dk_chars
%setlocal%

	rem Set codepage to 437
	for /f "tokens=*" %%a in ('chcp') do for %%b in (%%a) do set "cp=%%~nb"
	mode con cp select=437 >nul
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe

	:CreateFile
		if exist 1_255.chr (goto:End_CreateFile)
		echo generateChars_CreateFile
		type nul >"t.tmp"
		set "bytes= "
		for /l %%N in (1 1 255) do (
			makecab /d compress=off /d reserveperfoldersize=%%N /d reserveperdatablocksize=0 "t.tmp" "t1.tmp" >nul
			type "t1.tmp" | ((for /l %%N in (1 1 38) do pause)>nul&%findstr.exe% "^">"t2.tmp")
			<t2.tmp set /p "char%%N="
			set "bytes=!bytes!!char%%N!"
		)
		mode con cp select=%cp% >nul
		del "t.tmp" "t1.tmp" "t2.tmp"
		
		set "prompt= "
		if "!prompt!" neq "" (
			cmd /d /k < nul> 1_255.chr
		)
		<nul set /p "=!bytes:~1!" >>1_255.chr
	:End_CreateFile
	
	:LoadCharVars
		if defined char254 (goto:End_LoadCharVars)
		echo generateChars_LoadCharVars
		<1_255.chr set /p "chars="
		for /l %%N in (0 1 255) do (
			set char%%N=!chars:~%%N,1!
		)
	:End_LoadCharVars
	
	:PropagateChars
		echo generateChars_PropagateChars
		set "_SCOPE_=%~n0"
		for /F "delims=" %%a in ('set char') do (
			if "%_SCOPE_%" equ "%~n0" endlocal
			set "%%a"
		)
	:End_PropagateChars	
	
rem	:PrintChars
rem		for /l %%N in (0 1 255) do (
rem			if %%N equ 27 (
rem				echo char%%N = ESC
rem			) else (
rem				call echo char%%N = %%char%%N%%
rem			)
rem		)
rem	:End_PrintChars
%endfunction%










rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	if not defined char255 (
		call :dk_chars
	)
	
	for /l %%N in (0 1 255) do (
		if %%N neq 32 if %%N neq 33 if %%N neq 34 (
			%dk_call% dk_cacheVariable char%%N !char%%N!
		)
		if %%N equ 27 (
			echo char%%N = ESC
		) else (
			call echo char%%N = %%char%%N%%
		)
	)
	
	echo %char27%[92m green %char27%[0m
%endfunction%
