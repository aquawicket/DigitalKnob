@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_takeOwnership(path)
::#
::#
:dk_takeOwnership
    call dk_debugFunc 1
 setlocal
	
	set "path=%~1"

	powershell.exe -windowstyle hidden -command "$Y = ($null | choice).Substring(1,1); Start-Process cmd -ArgumentList ('/c takeown /f \"%path%\" /r /d ' + $Y + ' && icacls \"%path%\" /grant *S-1-3-4:F /t /c /l /q & pause') -Verb runAs"

%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_takeOwnership %DIGITALKNOB_DIR%
%endfunction%
