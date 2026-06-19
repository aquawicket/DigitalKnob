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


if NOT defined cmdlvl (set /a cmdlvl=0)

:debugFunc
(
    rem (goto) 2>nul
	(goto) 2>nul
	
	call dumpvariables
	
	call set /a "cmdlvl=%%cmdlvl%%+1"
	call set "_0=%%~0"
	call set "a0=%%~a0"
	call set "d0=%%~d0"
	call set "f0=%%~f0"
	call set "n0=%%~n0"
	call set "p0=%%~p0"
	call set "s0=%%~s0"
	call set "t0=%%~t0"
	call set "x0=%%~x0"
	call set "z0=%%~z0"
	call set "ALL=%%*"
	
rem	call echo cmdlvl = %%cmdlvl%%
rem	call echo _0 = %%_0%%
rem	rem call echo a0 = %%a0%%
rem	rem call echo d0 = %%d0%%
rem	call echo f0 = %%f0%%
rem	call echo n0 = %%n0%%
rem	call echo p0 = %%p0%%
rem	rem call echo s0 = %%s0%%
rem	rem call echo t0 = %%t0%%
rem	rem call echo x0 = %%x0%%
rem	rem call echo z0 = %%z0%%
rem	call echo ALL = %%ALL%%
rem	call echo myvar = %%myVar%%
)
exit /b 0
