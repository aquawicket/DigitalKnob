@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

reg delete "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment" /f
