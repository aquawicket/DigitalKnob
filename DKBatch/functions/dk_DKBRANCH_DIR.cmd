@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DKBRANCH_DIR()
::#
::#
:dk_DKBRANCH_DIR
    call dk_debugFunc 0
:: setlocal
  
    :: https://stackoverflow.com/a/33662275
    :: If the current folder matches the current branch set DKBRANCH. Otherwise, default to Development
    
    if not defined DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
    for %%I in (.) do set "FOLDER=%%~nxI"                          &:: get the current folder

    set "DKBRANCH=Development"                                     &:: set the default branch
    if not defined GIT_EXE %dk_call% dk_installGit
    if exist "%CD%\.git" (
        "%GIT_EXE%" branch | find "* %FOLDER%" > NUL & if ERRORLEVEL 0 (
            set "DKBRANCH=%FOLDER%"
        )
    )
	
	::%dk_call% dk_printVar DKBRANCH
	
	set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\%DKBRANCH%"
	::%dk_call% dk_printVar DKBRANCH_DIR
	
		set "DK3RDPARTY_DIR=%DKBRANCH_DIR%\3rdParty"
		::%dk_call% dk_printVar DK3RDPARTY_DIR
			set "DKIMPORTS_DIR=%DK3RDPARTY_DIR%\_DKIMPORTS"
			::%dk_call% dk_printVar DKIMPORTS_DIR
		
		set "DKAPPS_DIR=%DKBRANCH_DIR%\DKApps"
		::%dk_call% dk_printVar DKAPPS_DIR
		
		set "DKBASH_DIR=%DKBRANCH_DIR%\DKBash"
		::%dk_call% dk_printVar DKBASH_DIR
			set "DKBASH_FUNCTIONS_DIR=%DKBASH_DIR%\functions"
			::%dk_call% dk_printVar DKBASH_FUNCTIONS_DIR
			set "DKBASH_FUNCTIONS_DIR_=%DKBASH_DIR%\functions\"
			::%dk_call% dk_printVar DKBASH_FUNCTIONS_DIR_
			
		set "DKBATCH_DIR=%DKBRANCH_DIR%\DKBatch"
		::%dk_call% dk_printVar DKBATCH_DIR
			set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_DIR%\functions"
			::%dk_call% dk_printVar DKBATCH_FUNCTIONS_DIR
			set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_DIR%\functions\"
			::%dk_call% dk_printVar DKBATCH_FUNCTIONS_DIR_
			
		set "DKC_DIR=%DKBRANCH_DIR%\DKC"
		::%dk_call% dk_printVar DKC_DIR
			set "DKC_FUNCTIONS_DIR=%DKC_DIR%\functions"
			::%dk_call% dk_printVar DKC_FUNCTIONS_DIR
			set "DKC_FUNCTIONS_DIR_=%DKC_DIR%\functions\"
			::%dk_call% dk_printVar DKC_FUNCTIONS_DIR_
		
		set "DKCMAKE_DIR=%DKBRANCH_DIR%\DKCMake"
		::%dk_call% dk_printVar DKCMAKE_DIR
			set "DKCMAKE_FUNCTIONS_DIR=%DKCMAKE_DIR%\functions"
			::%dk_call% dk_printVar DKCMAKE_FUNCTIONS_DIR
			set "DKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_DIR%\functions\"
			::%dk_call% dk_printVar DKCMAKE_FUNCTIONS_DIR_
			
		set "DKCPP_DIR=%DKBRANCH_DIR%\DKCpp"
		::%dk_call% dk_printVar DKCPP_DIR
			set "DKCPP_FUNCTIONS_DIR=%DKCPP_DIR%\functions"
			::%dk_call% dk_printVar DKCPP_FUNCTIONS_DIR
			set "DKCPP_FUNCTIONS_DIR_=%DKCPP_DIR%\functions\"
			::%dk_call% dk_printVar DKCPP_FUNCTIONS_DIR_
			
		set "DKCSHARP_DIR=%DKBRANCH_DIR%\DKCSharp"
		::%dk_call% dk_printVar DKCSHARP_DIR
			set "DKCSHARP_FUNCTIONS_DIR=%DKCSHARP_DIR%\functions"
			::%dk_call% dk_printVar DKCSHARP_FUNCTIONS_DIR
			set "DKCSHARP_FUNCTIONS_DIR_=%DKCSHARP_DIR%\functions\"
			::%dk_call% dk_printVar DKCSHARP_FUNCTIONS_DIR_
			
		set "DKHTA_DIR=%DKBRANCH_DIR%\DKHta"
		::%dk_call% dk_printVar DKHTA_DIR
			set "DKHTA_FUNCTIONS_DIR=%DKHTA_DIR%\functions"
			::%dk_call% dk_printVar DKHTA_FUNCTIONS_DIR
			set "DKHTA_FUNCTIONS_DIR_=%DKHTA_DIR%\functions\"
			::%dk_call% dk_printVar DKHTA_FUNCTIONS_DIR_
		
		set "DKHTML_DIR=%DKBRANCH_DIR%\DKHta"
		::%dk_call% dk_printVar DKHTML_DIR
			set "DKHTML_FUNCTIONS_DIR=%DKHTML_DIR%\functions"
			::%dk_call% dk_printVar DKHTML_FUNCTIONS_DIR
			set "DKHTML_FUNCTIONS_DIR_=%DKHTML_DIR%\functions\"
			::%dk_call% dk_printVar DKHTML_FUNCTIONS_DIR_
		
		set "DKJAVA_DIR=%DKBRANCH_DIR%\DKJava"
		::%dk_call% dk_printVar DKJAVA_DIR
			set "DKJAVA_FUNCTIONS_DIR=%DKJAVA_DIR%\functions"
			::%dk_call% dk_printVar DKJAVA_FUNCTIONS_DIR
			set "DKJAVA_FUNCTIONS_DIR_=%DKJAVA_DIR%\functions\"
			::%dk_call% dk_printVar DKJAVA_FUNCTIONS_DIR_
		
		set "DKJAVASCRIPT_DIR=%DKBRANCH_DIR%\DKJavascript"
		::%dk_call% dk_printVar DKJAVASCRIPT_DIR
			set "DKJAVASCRIPT_FUNCTIONS_DIR=%DKJAVASCRIPT_DIR%\functions"
			::%dk_call% dk_printVar DKJAVASCRIPT_FUNCTIONS_DIR
			set "DKJAVASCRIPT_FUNCTIONS_DIR_=%DKJAVASCRIPT_DIR%\functions\"
			::%dk_call% dk_printVar DKJAVASCRIPT_FUNCTIONS_DIR_
		
		set "DKPHP_DIR=%DKBRANCH_DIR%\DKPhp"
		::%dk_call% dk_printVar DKPHP_DIR
			set "DKPHP_FUNCTIONS_DIR=%DKPHP_DIR%\functions"
			::%dk_call% dk_printVar DKPHP_FUNCTIONS_DIR
			set "DKPHP_FUNCTIONS_DIR_=%DKPHP_DIR%\functions\"
			::%dk_call% dk_printVar DKPHP_FUNCTIONS_DIR_
			
		set "DKPOWERSHELL_DIR=%DKBRANCH_DIR%\DKPowershell"
		::%dk_call% dk_printVar DKPOWERSHELL_DIR
			set "DKPOWERSHELL_FUNCTIONS_DIR=%DKPOWERSHELL_DIR%\functions"
			::%dk_call% dk_printVar DKPOWERSHELL_FUNCTIONS_DIR
			set "DKPOWERSHELL_FUNCTIONS_DIR_=%DKPOWERSHELL_DIR%\functions\"
			::%dk_call% dk_printVar DKPOWERSHELL_FUNCTIONS_DIR_
		
		set "DKPYTHON_DIR=%DKBRANCH_DIR%\DKPython"
		::%dk_call% dk_printVar DKPYTHON_DIR
			set "DKPYTHON_FUNCTIONS_DIR=%DKPYTHON_DIR%\functions"
			::%dk_call% dk_printVar DKPYTHON_FUNCTIONS_DIR
			set "DKPYTHON_FUNCTIONS_DIR_=%DKPYTHON_DIR%\functions\"
			::%dk_call% dk_printVar DKPYTHON_FUNCTIONS_DIR_
			
		set "DKPLUGINS_DIR=%DKBRANCH_DIR%\DKPlugins"
		::%dk_call% dk_printVar DKPLUGINS_DIR
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_DKBRANCH_DIR
%endfunction%