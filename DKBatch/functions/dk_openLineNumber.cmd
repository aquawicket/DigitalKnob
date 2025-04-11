@echo off 
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*) 
 
::############################################################################ 
::# dk_openLineNumber(file, lineno) 
::# 
::# 
:dk_openLineNumber 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 2
 
	set "NOTEPADPP_EXE=C:/Program Files/Notepad++/notepad++.exe"
	start "" "%NOTEPADPP_EXE%" "%~1" -n%~2
%endfunction% 
 
 
 
 
 
 
 
 
 
 
 
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
:DKTEST 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 0 
  
	%dk_call% dk_openLineNumber "C:/Users/Administrator/digitalknob/Development/README.md" 23
%endfunction% 
 
