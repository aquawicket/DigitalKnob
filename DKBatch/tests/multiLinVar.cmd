@echo off
:: https://stackoverflow.com/a/62008572
setlocal EnableDelayedExpansion

::######## Original variable content ########
set out=
set NL=^


for /F "delims=" %%i in ('dir /b') do (
    if defined out set "out=!out!!NL!"
    set "out=!out!%%i"
)
echo:
echo:
echo ###### Original variable content ######
set out
::###########################################



::######## Modified variable content ########
set out=!out:^%NL%%NL%=^^^%NL%%NL%^%NL%%NL%!  &:: Replace every new-line by an escaped new-line
echo:
echo:
echo ###### Modified variable content #####
set out
::###########################################


::######### Actual variable content #########
rem /* Use a `for` meta-variable rather than a normal environment variable to
rem    pass the variable value beyond the `endlocal` barrier;
rem    a standard `for` loop can be used here, because there are not going to be
rem    wildcards `?` and `*` in the variable value since they have already been
rem    resolved by `dir`; `for /F` cannot be used here due to the new-lines: */
for %%j in ("!out!") do endlocal & set "data=%%~j"
echo:
echo:
echo ###### Actual variable content ###### &:: Do not use `echo` to show true content of variable:
set data
::###########################################


::######## Parsed variable content ##########
echo:
echo:
echo ###### Parsed variable content ######
echo %data%
::###########################################

pause
exit /B 0
