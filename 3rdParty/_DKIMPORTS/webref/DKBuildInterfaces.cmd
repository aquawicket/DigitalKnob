@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

set "NODE_DIR=%DK3RDPARTY_DIR%\nodejs-node-v19.8.1-win-x64"
set "NPM_EXE=%NODE_DIR%\npm.cmd"
set "NODE_EXE=%NODE_DIR%\node.exe"


::call %NPM_EXE% init
::call %NPM_EXE% install glob --save

%NODE_EXE% DKBuildInterfaces.js
pause