<<<<<<< HEAD
@echo off

ctfmon.exe
reg add HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run /t REG_SZ /v ctfmon /d C:\Windows\System32\ctfmon.exe /f
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


ctfmon.exe
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Run /t REG_SZ /v ctfmon /d %WINDIR%\System32\ctfmon.exe /f
>>>>>>> Development
