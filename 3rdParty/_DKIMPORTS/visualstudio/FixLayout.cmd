@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DIGITALKNOB_DIR"
start /wait %DKDOWNLOAD_DIR%\vs_Community.exe --layout "%DKDOWNLOAD_DIR%\digitalknob\Download\VisualStudio" --fix
