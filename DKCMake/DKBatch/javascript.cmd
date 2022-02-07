@if (@X)==(@Y) @end /* 


:: ******* BATCH SCRIPT HERE *********
%DKBATCH%
@echo off
echo:
echo This is windows batch script
echo:
cscript //nologo //E:jscript %0 %*
exit /b



********* Javascript Here **********/
WScript.Echo("This is javascript");
//var fso = new ActiveXObject("Scripting.FileSystemObject");
//WScript.Echo(fso.FolderExists("C:\\windows").toString());
//fso = null;
  