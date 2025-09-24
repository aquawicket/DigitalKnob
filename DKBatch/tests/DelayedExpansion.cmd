@echo off
echo %~0(%*)

set "DE=1"
setlocal enableDelayedExpansion
set PRINT_DE_VAR_A=if ^!DE^! equ 1 (echo ^!DE^! equ 1) else (echo ^!DE^! neq 1)
set PRINT_DE_VAR_B=if "^!DE^!" equ "1" (echo "^!DE^!" equ "1") else (echo "^!DE^!" neq "1")
set PRINT_DE_VAR_C=if "!!DE!!" equ "1" (echo "3" equ "1") else (echo "3" neq "1")
set PRINT_DE_VAR_D=if !!DE!! equ 1 (echo 4 equ 1) else (echo 4 neq 1)
set PRINT_DE_STATUS=if ^!DE^! neq 1 (echo disabled_1) else if "^!DE^!" equ "1" (echo enabled_1) else if "!!DE!!" neq "1" (echo enabled_2) else (echo disabled_2)

echo(
setlocal enableDelayedExpansion
echo ENABLED
%PRINT_DE_VAR_A%
%PRINT_DE_VAR_B%
%PRINT_DE_VAR_C%
%PRINT_DE_VAR_D%
%PRINT_DE_STATUS%
echo DE = %DE% = !DE!

echo(
setlocal disableDelayedExpansion
echo DISABLED
%PRINT_DE_VAR_A%
%PRINT_DE_VAR_B%
%PRINT_DE_VAR_C%
%PRINT_DE_VAR_D%
%PRINT_DE_STATUS%
echo DE = %DE% = !DE!

echo(
setlocal enableDelayedExpansion
echo ENABLED
%PRINT_DE_VAR_A%
%PRINT_DE_VAR_B%
%PRINT_DE_VAR_C%
%PRINT_DE_VAR_D%
%PRINT_DE_STATUS%
echo DE = %DE% = !DE!

pause