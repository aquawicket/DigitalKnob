@echo off &setlocal DisableDelayedExpansion

call strlen_init.cmd

set "string=Hello, World!"

set "length="
%@strlen% string length
echo %length%

pause