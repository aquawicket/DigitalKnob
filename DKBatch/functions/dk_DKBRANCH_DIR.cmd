@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
::if not defined dk_DKBRANCH_DIR (set "dk_DKBRANCH_DIR=1") else (goto:eof)

::####################################################################
::# dk_DKBRANCH_DIR()
::#
::#
:dk_DKBRANCH_DIR
    call dk_debugFunc 0 1
:: setlocal
	
    :: https://stackoverflow.com/a/33662275
    :: If the current folder matches the current branch set DKBRANCH. Otherwise, default to Development
    
	if "%~1" neq "" (
		set "DKBRANCH_DIR=%~1"
	) else (
		%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
		for %%I in (.) do set "FOLDER=%%~nxI"                          &rem get the current folder

		set "DKBRANCH=Development"                                     &rem set the default branch
	    rem	if not defined GIT_EXE %dk_call% dk_installGit
    	rem    if exist "%CD%\.git" (
    	rem        "%GIT_EXE%" branch | find "* %FOLDER%" > NUL & if ERRORLEVEL 0 (
    	rem            set "DKBRANCH=%FOLDER%"
    	rem        )
    	rem    )
		rem %dk_call% dk_printVar DKBRANCH
		set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\%DKBRANCH%"
	)		
	
	set "DKBASH_DIR=%DKBRANCH_DIR%\DKBash"
		set "DKBASH_FUNCTIONS_DIR=%DKBASH_DIR%\functions"
		set "DKBASH_FUNCTIONS_DIR_=%DKBASH_DIR%\functions\"
				
	if not defined DKBATCH_DIR set "DKBATCH_DIR=%DKBRANCH_DIR%\DKBatch"
		set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_DIR%\functions"
		set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_DIR%\functions\"
				
	set "DKC_DIR=%DKBRANCH_DIR%\DKC"
		set "DKC_FUNCTIONS_DIR=%DKC_DIR%\functions"
		set "DKC_FUNCTIONS_DIR_=%DKC_DIR%\functions\"
		
	set "DKCMAKE_DIR=%DKBRANCH_DIR%\DKCMake"
		set "DKCMAKE_FUNCTIONS_DIR=%DKCMAKE_DIR%\functions"
		set "DKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_DIR%\functions\"

	set "DKCPP_DIR=%DKBRANCH_DIR%\DKCpp"
		set "DKCPP_FUNCTIONS_DIR=%DKCPP_DIR%\functions"
		set "DKCPP_FUNCTIONS_DIR_=%DKCPP_DIR%\functions\"	
				
	set "DKCSHARP_DIR=%DKBRANCH_DIR%\DKCSharp"
		set "DKCSHARP_FUNCTIONS_DIR=%DKCSHARP_DIR%\functions"
		set "DKCSHARP_FUNCTIONS_DIR_=%DKCSHARP_DIR%\functions\"
				
	set "DKHTA_DIR=%DKBRANCH_DIR%\DKHta"
		set "DKHTA_FUNCTIONS_DIR=%DKHTA_DIR%\functions"
		set "DKHTA_FUNCTIONS_DIR_=%DKHTA_DIR%\functions\"
			
	set "DKHTML_DIR=%DKBRANCH_DIR%\DKHtml"
		set "DKHTML_FUNCTIONS_DIR=%DKHTML_DIR%\functions"
		set "DKHTML_FUNCTIONS_DIR_=%DKHTML_DIR%\functions\"
			
	set "DKJAVA_DIR=%DKBRANCH_DIR%\DKJava"
		set "DKJAVA_FUNCTIONS_DIR=%DKJAVA_DIR%\functions"
		set "DKJAVA_FUNCTIONS_DIR_=%DKJAVA_DIR%\functions\"
			
	set "DKJAVASCRIPT_DIR=%DKBRANCH_DIR%\DKJavascript"
		set "DKJAVASCRIPT_FUNCTIONS_DIR=%DKJAVASCRIPT_DIR%\functions"
		set "DKJAVASCRIPT_FUNCTIONS_DIR_=%DKJAVASCRIPT_DIR%\functions\"
		
	set "DKPHP_DIR=%DKBRANCH_DIR%\DKPhp"
		set "DKPHP_FUNCTIONS_DIR=%DKPHP_DIR%\functions"
		set "DKPHP_FUNCTIONS_DIR_=%DKPHP_DIR%\functions\"
		
	set "DKPOWERSHELL_DIR=%DKBRANCH_DIR%\DKPowershell"
		set "DKPOWERSHELL_FUNCTIONS_DIR=%DKPOWERSHELL_DIR%\functions"
		set "DKPOWERSHELL_FUNCTIONS_DIR_=%DKPOWERSHELL_DIR%\functions\"
			
	set "DKPYTHON_DIR=%DKBRANCH_DIR%\DKPython"
		set "DKPYTHON_FUNCTIONS_DIR=%DKPYTHON_DIR%\functions"
		set "DKPYTHON_FUNCTIONS_DIR_=%DKPYTHON_DIR%\functions\"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKBRANCH_DIR . . ."
	%dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_printVar DKBRANCH_DIR
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKBRANCH_DIR . . ."
	%dk_call% dk_DKBRANCH_DIR "C:\DK\Development"
	%dk_call% dk_printVar DKBRANCH_DIR 
%endfunction%
