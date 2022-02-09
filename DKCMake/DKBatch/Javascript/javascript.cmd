@if (@X)==(@Y) @end /* 


:: ******* BATCH SCRIPT HERE *********
%DKBATCH%
@echo off
echo This is Batch script (.bat)
echo:
cscript //nologo //E:jscript %0 %*
%DKEND%
exit /b



********* Javascript Here **********/
WScript.Echo("This is javascript (WScript)");
//var fso = new ActiveXObject("Scripting.FileSystemObject");
//WScript.Echo(fso.FolderExists("C:\\windows").toString());
//fso = null;
  