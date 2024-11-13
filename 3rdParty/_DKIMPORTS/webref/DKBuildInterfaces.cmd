@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

%dk_call% dk_validate DK3RDPARTY_DIR "dk_DKBRANCH_DIR"
set "NODE_DIR=%DK3RDPARTY_DIR%\nodejs-node-v19.8.1-win-x64"
set "NPM_EXE=%NODE_DIR%\npm.cmd"
set "NODE_EXE=%NODE_DIR%\node.exe"


::call %NPM_EXE% init
::call %NPM_EXE% install glob --save

%NODE_EXE% DKBuildInterfaces.js
pause