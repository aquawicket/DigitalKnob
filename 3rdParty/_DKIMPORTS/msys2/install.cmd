@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


"%DKBATCH_DIR%\dk_cmakeEval.cmd" "include('%DKIMPORTS_DIR%/msys2/DKINSTALL.cmake')"

%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
cmake -E create_symlink %DK3RDPARTY_DIR%\libjpeg-turbo-main\Windows_X86_64\Debug\jconfig.h %DK3RDPARTY_DIR%\libjpeg-turbo-main\Windows_X86_64\Debug\jconfig.h