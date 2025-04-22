@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


if not defined cmdlvl (set /a cmdlvl=0)

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
