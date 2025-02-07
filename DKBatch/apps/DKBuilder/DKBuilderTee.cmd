@echo off

::if not exist "%DKBATCH_FUNCTIONS_DIR_%" set DKBATCH_FUNCTIONS_DIR_=..\..\..\functions/
set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR_:/=\%"
echo DKBATCH_FUNCTIONS_DIR_ = %DKBATCH_FUNCTIONS_DIR_%
set "logfile=DKBuilder_%DATE%_%TIME%.log"
set "logfile=%logfile: =_%"
set "logfile=%logfile:/=_%"
set "logfile=%logfile::=_%"
echo logfile = %logfile%
DKBuilder.cmd | %DKBATCH_FUNCTIONS_DIR_%dk_tee.cmd %logfile%