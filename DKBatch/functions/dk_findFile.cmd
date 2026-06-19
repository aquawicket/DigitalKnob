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
rem # dk_findFile(file search_path rtn_var:optional)
rem #
rem #	Search for a file. The search order is.
rem #		0. Search 'search_path" if provided
rem #   	1. Search local path
rem # 		2. Search local path with PATHEXT
rem #       3. Search PATH directories
rem #		4. Search PATH directories with PATHEXT
rem #		5. Search USERPROFILE
rem #		6. Search SystemRoot 
rem #
:dk_findFile
%setlocal%
	rem echo dk_findFile

	if "%~1" equ "" (%return:echo.[31mreturn UNDEFINED&pause&exit/b1%=%)
	set "search_path=%~2"
	set "search_path=%search_path:/=\%"
	if "%search_path:~-1%" equ "\" set "search_path=%search_path:~0,-1%"

	if "%~x1" neq "" (
		set "extensions=%~x1"
	) else (
		set "extensions=.cmd;%PATHEXT%"
	)
	
	set "dk_findFile="
	if EXIST "%~dpnx1"				(set "dk_findFile=%~dpnx1"		& goto:return)
	for %%X in (%extensions%) do (
		if EXIST "%~1%%X"			(set "dk_findFile=%~f1%%X"		& goto:return)
	)
	if EXIST "%~$PATH:1"			(set "dk_findFile=%~$PATH:1"	& goto:return)
	for %%X in (%extensions%) do (
		for %%N in (%~1%%X) do (
			if EXIST "%%~$PATH:N"	(set "dk_findFile=%%~$PATH:N"	& goto:return)
		)
	)

	if not defined dk_findFile if DEFINED search_path (
			for %%X in (%extensions%) do (
				rem echo searching "%search_path:/=\%" for %~nx1 . . .
				rem for /F "delims=" %%G IN ('dir /b/s/a:-d "%search_path:/=\%\%~nx1" 2^>nul') do (
				echo searching "%search_path:/=\%" for %~n1%%X . . .
				for /F "delims=" %%G IN ('dir /b/s/a:-d "%search_path:/=\%\%~n1%%X" 2^>nul') do (
					if %%~zG neq 0 (
						rem echo %%~dpnxG %%~zG
						rem set "dk_findFile=%%~dpnxG"
						echo %%~dpnG%%X %%~zG bytes
						set "dk_findFile=%%~dpnG%%X"
						goto:return
					)
				)
			)
		) else if not defined dk_findFile (
			echo searching "%SystemDrive%/" for %~nx1 . . .
			for /F "delims=" %%G IN ('dir /b/s/a:-d "%SystemDrive%\%~nx1" 2^>nul') do (
				if %%~zG neq 0 (
					echo %%~dpnxG %%~zG bytes
					set "dk_findFile=%%~dpnxG"
					goto:return
				)
			)
		)
		
	

	:return
	for %%A in ("%dk_findFile%") do (set "dk_findFile=%%~dpnxA")
	endlocal & (
		set "%~1=%dk_findFile%"
		if "%~3" neq "" (set "%~3=%dk_findFile%")
	)
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_findFile "cmd.exe" "%SystemRoot:\=/%/System32"
	%dk_call% dk_debug "dk_findFile = %dk_findFile%"
	
	%dk_call% dk_findFile "tar.exe" "%SystemRoot:\=/%/System32"
	%dk_call% dk_debug "dk_findFile = %dk_findFile%"
	
	%dk_call% dk_findFile "winget.exe" "%SystemDrive:\=/%"
	%dk_call% dk_debug "dk_findFile = %dk_findFile%"
	
	%dk_call% dk_findFile "RtkBtManServ.exe" "%SystemRoot:\=/%"
	%dk_call% dk_debug "dk_findFile = %dk_findFile%"
%endfunction%
