@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


reg add "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment" /v CurrentVersion /t REG_SZ /d %JAVA_VERSION% /f
reg add "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\%JAVA_VERSION%" /v JavaHome /t REG_SZ /d "%JAVA_HOME%" /f
reg add "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\%JAVA_VERSION%" /v RuntimeLib /t REG_SZ /d "%JAVA_HOME%\bin\server\jvm.dll" /f
