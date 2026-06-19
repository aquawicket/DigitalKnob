@echo off

echo #!sh.cmd
pause
rem Run as shell scripts batch files starting with the magic incantation
rem @#!sh %0.bat %*
rem See http://www.spinellis.gr/blog/20100112

rem (C) Copyright 2006-2010 Diomidis Spinellis - http://www.spinellis.gr

rem Permission to use, copy, and distribute this software and its
rem documentation for any purpose and without fee is hereby granted,
rem provided that the above copyright notice appear in all copies and that
rem both that copyright notice and this permission notice appear in
rem supporting documentation.

rem THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR IMPLIED
rem WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
rem MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

rem Check whether the script is located in the PATH
if "%~$PATH:1"=="" (
	rem Not found in PATH; try to run it as specified using the current
	rem directory or an absolute path
	sh %1 %2 %3 %4 %5 %6 %7 %8 %9
) else (
	rem Run the script from the path
	sh %~$PATH:1 %2 %3 %4 %5 %6 %7 %8 %9
)
