@if (@X)==(@Y) @end /* 


:: ###### BATCH SCRIPT ######
@echo off
	echo This is Batch script (cmd)
	echo:
	cscript //nologo //E:jscript %0 %*
goto:eof
*/


// ###### JAVASCRIPT ######
WScript.Echo("This is javascript (WScript)");