rem shebang
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


rem ############ plink ############
rem # https://www.chiark.greenend.org.uk/~sgtatham/putty
rem # https://the.earth.li/~sgtatham/putty/latest/wa64/plink.exe
rem # https://the.earth.li/~sgtatham/putty/latest/w32/plink.exe
rem # https://the.earth.li/~sgtatham/putty/latest/w64/plink.exe

:DKINSTALL
echo %green% ###### plink:%~nx0(%*) %clr%
rem %setlocal%

rem 	if not defined Windows_Host (
rem 		rem %dk_call% dk_disable plink
rem 		%return%
rem 	)
	

	%dk_call% dk_import || exit /b 0
	set "plink_exe=%plink%/plink.exe"
	echo dk_download = %dk_download%

	%dk_call% dk_copy "%dk_download%" "%plink_exe%"
%endfunction%


:DKTEST
	%dk_call% dk_validate plink %dk_call% dk_depend plink
%endfunction%