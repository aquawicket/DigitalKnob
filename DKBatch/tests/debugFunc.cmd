@echo off
::setlocal enableDelayedExpansion

if not defined cmdlvl (set /a cmdlvl=0)

:debugFunc
(
    rem (goto) 2>nul
	(goto) 2>nul
	
	echo cmdlvl = %cmdlvl%
	echo _0 = %_0%
	rem echo a0 = %a0%
	rem echo d0 = %d0%
	echo f0 = %f0%
	echo n0 = %n0%
	echo p0 = %p0%
	rem echo s0 = %s0%
	rem echo t0 = %t0%
	rem echo x0 = %x0%
	rem echo z0 = %z0%
	echo ALL = %ALL%
	echo myvar = %myVar%
	
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
	
	call echo cmdlvl = %%cmdlvl%%
	call echo _0 = %%_0%%
	rem call echo a0 = %%a0%%
	rem call echo d0 = %%d0%%
	call echo f0 = %%f0%%
	call echo n0 = %%n0%%
	call echo p0 = %%p0%%
	rem call echo s0 = %%s0%%
	rem call echo t0 = %%t0%%
	rem call echo x0 = %%x0%%
	rem call echo z0 = %%z0%%
	call echo ALL = %%ALL%%
	call echo myvar = %%myVar%%
)
exit /b 0
