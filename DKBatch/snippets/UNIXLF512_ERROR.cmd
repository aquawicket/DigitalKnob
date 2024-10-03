@echo off

goto:UNIX_LF512_ERROR
echo ***************************************************************************************************************************************************************************
echo ***************************************************************************************************************************************************************************
echo *********************************************************************************************************************************************************:UNIX_LF512_ERROR 
echo ### UNIX_LF512_ERROR ###
echo When batch files use Unix line feeds, goto lables will cause errors when on a 512 barrier
echo This happens if the distance between the current file position and the next label a multiple of 512 characters
exit /b
:UNIX_LF512_ERROR

echo No Error
echo This file must use Unix line endings to reproduce the error