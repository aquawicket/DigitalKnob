@echo off 
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*) 
 
::############################################################################ 
::# dk_evalDKJavascript() 
::# 
::# 
:dk_evalDKJavascript 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 0 
 
	set "CSCRIPT_EXE=C:/Windows/System32/cscript.exe"
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	echo %~1 > "%DKCACHE_DIR%/dk_evalJavascript_TEMP.js"
	
	::############ DKJavascript function call ############
	set DKCOMMAND=%ComSpec% /c %CSCRIPT_EXE% //D //E:javascript //H:CScript //I //NoLogo //X "%DKCACHE_DIR%/dk_evalJavascript_TEMP.js";
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_evalDKJavascript=%dk_exec%"
	)

%endfunction% 
 
 
 
 
 
 
 
 
 
 
 
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
:DKTEST 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 0 
  
	%dk_call% dk_evalDKJavascript "WScript.Echo('testing dk_evalDKJavascript');"
%endfunction% 
 
