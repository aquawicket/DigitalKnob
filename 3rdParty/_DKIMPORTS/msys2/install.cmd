@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

%DKBATCH_DIR%\dk_cmakeEval.cmd "include('%DKIMPORTS_DIR%/msys2/DKMAKE.cmake')"

cmake -E create_symlink %DK3RDPARTY_DIR%\libjpeg-turbo-main\win_x86_64\Debug\jconfig.h %DK3RDPARTY_DIR%\libjpeg-turbo-main\win_x86_64\Debug\jconfig.h