@echo off
call DK

:: https://stackoverflow.com/a/17584764


SET "var="&for /f "delims=0123456789" %%i in ("%1") do set var=%%i
if defined var (echo %1 NOT numeric) else (echo %1 numeric)