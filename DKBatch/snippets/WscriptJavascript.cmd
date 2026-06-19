@if (@X)==(@Y) @end /*


rem ###### BATCH SCRIPT ######
@echo off
	echo This is Batch script (cmd)
	echo.
	cscript.exe //nologo //E:jscript %0 %*
%endfunction%
*/


// ###### JAVASCRIPT ######
WScript.echo."This is javascript (WScript)");
