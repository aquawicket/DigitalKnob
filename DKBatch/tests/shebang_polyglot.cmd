#!/usr/bin/env bash
echo off & echo ; wait ; echo -ne "\e[1A\e[K" # > NUL
echo ; function goto { true; } ; function rem { true; } ; echo -ne "\e[1A\e[K\e[1A\e[K" # > NUL
goto startbatch
echo running in bash
exit
:startbatch
echo [6A[K[1B[K[1B[K[1B[K[1B[K[1B[K[6A
echo running in cmd
pause
exit /B
