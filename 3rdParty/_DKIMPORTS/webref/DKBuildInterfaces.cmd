@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
set "NODE_DIR=%DK3RDPARTY_DIR%\nodejs-node-v19.8.1-win-x64"
set "npm_exe=%NODE_DIR%\npm.cmd"
set "node_exe=%NODE_DIR%\node.exe"


::%dk_call% %npm_exe% init
::%dk_call% %npm_exe% install glob --save

%node_exe% DKBuildInterfaces.js
pause