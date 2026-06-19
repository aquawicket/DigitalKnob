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


rem #########################################################################
rem # dk_gitBranchName(repo_url rtn_var)
rem #
rem #	Return the name of the head branch from a git repository
rem #
rem #	@repo_url	- The git url
rem #	@rtn_var	- Returns the name of the head branch
rem #
rem #	https://stackoverflow.com/a/31919435
rem #
:dk_gitBranchName
%setlocal%
	
	rem ### repo_url
	if "%repo_url%" equ "" (set "repo_url=%~1")
	if "%repo_url%" equ "" (set "repo_url=ssh://u108565871@access912915170.webspace-data.io/~/DigitalKnob/Development.git")
	
	
	%dk_call% dk_validate git.exe %dk_call% dk_depend git		
	%dk_call% dk_exec %git.exe% ls-remote %repo_url% heads/*
	set "dk_gitBranchName=%dk_exec%"
	
	:return
	endlocal & (
		set "dk_gitBranchName=%dk_gitBranchName%"
		if "%~2" neq "" (
			set "%~2=%dk_gitBranchName%"
		) else (
			echo %dk_gitBranchName%
		)
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	
	rem %dk_call% dk_gitBranchName "ssh://u108565871@access912915170.webspace-data.io/~/DigitalKnob/Development.git"
	%dk_call% dk_gitBranchName
	%dk_call% dk_debug "dk_gitBranchName = %dk_gitBranchName%"
%endfunction%