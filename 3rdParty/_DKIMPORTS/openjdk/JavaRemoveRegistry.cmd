@echo off
call "..\..\..\DKBatch\functions\DK.cmd"

reg delete "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment" /f
