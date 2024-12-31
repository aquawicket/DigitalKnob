@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_takeOwnership(path)
::#
::#
:dk_takeOwnership
    %dk_call% dk_debugFunc 1
 setlocal
	
	set "_path_=%~1"
	set "_path_=%_path_:/=\%"

	::%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
	::"%POWERSHELL_EXE%" -windowstyle hidden -command "$Y = ($null | choice).Substring(1,1); Start-Process cmd -ArgumentList ('/c takeown /f \"%_path_%\" /r /d ' + $Y + ' && icacls \"%path%\" /grant *S-1-3-4:F /t /c /l /q & pause') -Verb runAs"
	%ComSpec% /c "C:\Windows\System32\takeown.exe" /f "%_path_%"

%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
	
	%dk_call% dk_takeOwnership "%DIGITALKNOB_DIR%"
%endfunction%
