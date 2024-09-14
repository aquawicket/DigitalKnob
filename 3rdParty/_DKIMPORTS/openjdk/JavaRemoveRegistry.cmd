@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

reg delete "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment" /f
