set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
set "NODE_DIR=%DIGITALKNOB_DIR%\Development\3rdParty\nodejs-node-v19.8.1-win-x64"
set "NPM_EXE=%NODE_DIR%\npm.cmd"
set "NODE_EXE=%NODE_DIR%\node.exe"


::call %NPM_EXE% init
::call %NPM_EXE% install glob --save

%NODE_EXE% DKBuildInterfaces.js
pause