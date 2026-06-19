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
rem # dk_cacheVariable(varname [set]))
rem #
rem #
:dk_cacheVariable
rem %setlocal%
	
	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	set "DKCACHE=%DKCACHE_DIR%/DKCACHE"
	
	%dk_call% dk_fileVariable "%DKCACHE%" %*
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_cacheVariable DK.cmd "%DK.cmd%"
	%dk_call% dk_cacheVariable cmake.exe "%cmake.exe%"
	
	rem %dk_call% dk_validate cmake.exe %dk_call% dk_depend cmake.exe
	rem %dk_call% dk_cacheVariable cmake.exe
%endfunction%
