@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
set "NODE_DIR=%DK3RDPARTY_DIR%\nodejs-node-v19.8.1-win-x64"
set "NPM_EXE=%NODE_DIR%\npm.cmd"
set "NODE_EXE=%NODE_DIR%\node.exe"


::%dk_call% %NPM_EXE% init
::%dk_call% %NPM_EXE% install glob --save

%NODE_EXE% DKBuildInterfaces.js
pause