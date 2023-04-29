set "DIGITALKNOB=C:\Users\%USERNAME%\digitalknob"
set "NODE_DIR=%DIGITALKNOB%\DK\3rdParty\nodejs-node-v19.8.1-win-x64"
set "NPM_EXE=%NODE_DIR%\npm.cmd"
set "NODE_EXE=%NODE_DIR%\node.exe"

%NODE_EXE% DKBuildInterfaces.js