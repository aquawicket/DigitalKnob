@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	if NOT DEFINED DK.cmd (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	call "%%DK.cmd:/=\%%" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ############################################################################
rem # dk_absolutePath(path)
rem #
rem #
:dk_absolutePath
%setlocal%

	if "%~1" equ "" (%return%)
	set "dk_absolutePath="
rem	if EXIST "%~1"          		(set dk_absolutePath=%~1			& goto:return)
	if EXIST "%~dpnx1"         		(set "dk_absolutePath=%~dpnx1"		& goto:return)
	for %%X in (%PATHEXT%) do (
		if EXIST "%~1%%X"       	(set "dk_absolutePath=%~f1%%X"		& goto:return)
	)
	if EXIST "%~$PATH:1"    		(set "dk_absolutePath=%~$PATH:1"	& goto:return)
	for %%X in (%PATHEXT%) do (
		for %%N in (%~1%%X) do (
			if EXIST "%%~$PATH:N"   (set "dk_absolutePath=%%~$PATH:N"	& goto:return)
		)
	)
	
	:return
	for %%a in ("%dk_absolutePath%") do (
		set "dk_absolutePath=%%~dpnxa"
	)
	
rem	for %%i in ("%dk_absolutePath%") do set attribute=%%~ai
rem	set attribute=%attribute:~8,1%
rem	if "%attribute%" == "l" (
rem		%dk_call% dk_error ":dk_absolutePath:'%dk_absolutePath%' is a symlink"
rem	) 

	endlocal & (
		set "dk_absolutePath=%dk_absolutePath%"
		if "%~2" neq "" (set "%~2=%dk_absolutePath%")
	)
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_absolutePath cmd.exe cmd.exe
	%dk_call% dk_debug "cmd.exe = %cmd.exe%"
	
	%dk_call% dk_absolutePath tar.exe tar.exe
	%dk_call% dk_debug "tar.exe = %tar.exe%"
%endfunction%

