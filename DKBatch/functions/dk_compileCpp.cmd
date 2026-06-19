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
rem # dk_compileCpp(<filepath>, optional:<appname>)
rem #
rem #
:dk_compileCpp
%setlocal%

    set "filepath=%~1"
	
    set "appname=%~2"
    if NOT defined appname (set "appname=temp")
   
    %dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
    %dk_call% dk_validate GXX_EXE %dk_call% dk_depend gcc
   
    rem gcc -o [executable_name] [source_file].c
    %GXX_EXE% -o %appname% -static "%filepath:/=\%"
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    set "MSYSTEM=CLANG64"
    %dk_call% dk_validate DKCPP_APPS_DIR %dk_call% dk_DKBRANCH_DIR
    %dk_call% dk_compileCpp "%DKCPP_APPS_DIR%/HelloWorld/main.cpp"
%endfunction%
