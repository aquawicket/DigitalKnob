@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0

reg delete "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment" /f
