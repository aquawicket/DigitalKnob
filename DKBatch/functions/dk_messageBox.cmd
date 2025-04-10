@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

%dk_call% dk_set VERSION_dk_messageBox 4
::##############################################################################################################
::# dk_messageBox(text, caption, flags, timeout)
::#
::#
:dk_messageBox
setlocal
    %dk_call% dk_debugFunc 2 7

	if "%~1" equ "" (set "text=chose a selection") 	else (set "text=%~1")
	if "%~2" equ "" (set "caption=dk_messageBox") 		else (set "caption=%~2")
	if "%~3" equ "" (set /a "flags=0") 				else (set /a "flags=%~3")
	if "%~4" equ "" (set /a "timeout=0") 				else (set /a "timeout=%~4")
	echo text = %text%
	echo caption = %caption%
	echo flags = %flags%
	echo timeout = %timeout%

    if %VERSION_dk_messageBox%==1 goto messageBox_1
    if %VERSION_dk_messageBox%==2 goto messageBox_2 
    if %VERSION_dk_messageBox%==3 goto messageBox_3
    if %VERSION_dk_messageBox%==4 goto messageBox_4 
    if %VERSION_dk_messageBox%==5 goto messageBox_5 
    if %VERSION_dk_messageBox%==6 goto messageBox_6 
    
    :messageBox_1 
        mshta javascript:alert("%text%");close();
        endlocal & set dk_messageBox=!errorlevel!
    %return%    
        
    :messageBox_2
        :: https://learn.microsoft.com/en-us/dotnet/api/microsoft.visualbasic.msgboxstyle?view=net-8.0
		:: https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/msgbox-constants
        mshta.exe vbscript:Execute("MsgBox ""%text%"", %flags%, ""%caption%""")(window.close)
        endlocal & set dk_messageBox=!errorlevel!
    %return%
        
    :messageBox_3
        :: https://stackoverflow.com/a/12523614
        :: https://www.vbsedit.com/html/f482c739-3cf9-4139-a6af-3bde299b8009.asp
        
		%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
        echo set WshShell = WScript.CreateObject("WScript.Shell") > %DKCACHE_DIR%/dk_messageBox.vbs
		
		set "command=WScript.Quit (WshShell.Popup("%text%", %timeout%, "%caption%", %flags%))"
		echo %command% >> %DKCACHE_DIR%/dk_messageBox.vbs
		
		%dk_call% dk_validate CSCRIPT_EXE "%dk_call% dk_CSCRIPT_EXE"
		"%CSCRIPT_EXE%" //nologo %DKCACHE_DIR%/dk_messageBox.vbs
        endlocal & set dk_messageBox=!errorlevel!
		::%dk_call% dk_delete "%DKCACHE_DIR%/dk_messageBox.vbs"
    %return%
        
    :messageBox_4
		set /a options=6
		set /a multiplyer=16
		set /a div=1
		set /a lmod=0
		for /l %%x in (1, 1, %options%) do (
			(set /a lmod=!mod!)
			(set /a div=!div!*!multiplyer!)
			(set /a mod=!flags! %% !div!)
			(set /a option_%%x=!mod!-!lmod!)
			echo option_%%x = !option_%%x!
		)
		set "buttons=%option_1%"
		set "icon=%option_2%"
		set "defaultButton=%option_3%"
		set "options=%option_5%"

        %dk_call% dk_powershell "[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms');${env:dk_commandToVariable} = [Windows.Forms.MessageBox]::show('%text%', '%caption%', %buttons%, %icon%, %defaultButton%, %options%);"
        endlocal & set dk_messageBox=!dk_powershell!
    %return%
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

:: 16, 256, 4096, 65536, 1048576, 16777216

::	::### option_0 [16] (MessageBoxButtons) ###
::	set "OKOnly=0"					&:: OK button only (default)
::	set "OKCancel=1"				&:: OK and Cancel buttons
::	set "AbortRetryIgnore=2"		&:: Abort, Retry, and Ignore buttons
::	set "YesNoCancel=3"				&:: Yes, No, and Cancel buttons
::	set "YesNo=4"					&:: Yes and No buttons
::	set "RetryCancel=5"				&:: Retry and Cancel buttons
::	set "CancelTryContinue=6"		&:: Specifies that the message box contains Cancel, Try Again, and Continue buttons
::	::### option_1 [256] (MessageBoxIcon) ###
::	set "None=0"					&:: No Icon (default)
::	set "Critical=16"				&:: Critical message
::	set "Question=32"				&:: Warning query
::	set "Exclamation=48"			&:: Warning message
::	set "Information=64"			&:: Information message
::	::### option_2 [4096] (MessageBoxDefaultButton) ###
::	set "DefaultButton1=0"			&:: First button is default (default)
::	set "DefaultButton2=256"		&:: Second button is default
::	set "DefaultButton3=512"		&:: Third button is default
::	set "DefaultButton4=768"		&:: Fourth button is default
::	::### option_3 [65536] (MessageBoxOptions) ###
::	set "ApplicationModal=0"		&:: Application modal message box (default)
::	set "SystemModal=4096"			&:: System modal message box
::	set "MsgBoxHelpButton=16384"	&:: Adds Help button to the message box
::  ::### option_4 [1048576] (HelpNavigator) ###
::	set "MsgBoxSetForeground=65536"	&:: Specifies the message box window as the foreground window
::	set "RightAlign=524288"			&:: Text is right aligned
::  ::### option_5 [16777216] (UNICODE) ###
::	set "RtlReading=1048576"		&:: Specifies text should appear as right-to-left reading on Hebrew and Arabic systems
	
::	set /a "style=2+32+512+524288"
	
	set "text=dk_messageBox message"
    set "caption=dk_messageBox Title"
    set /a "flags=3+32+256+16384+524288+1048576"
	set "timeout=0"
	
	%dk_call% dk_messageBox "%text%" "%caption%" "%flags%" "%timeout%"
	
::	::### result ###
::	set /a "OK=1"		&:: OK button pressed
::	set /a "Cancel=2"	&:: Cancel button pressed
::	set /a "Abort=3"	&:: Abort button pressed
::	set /a "Retry=4"	&:: Retry button pressed
::	set /a "Ignore=5"	&:: Ignore button pressed
::	set /a "Yes=6"		&:: Yes button pressed
::	set /a "No=7"		&:: No button pressed
	
	echo dk_messageBox = %dk_messageBox%
    if "%dk_messageBox%" equ "1"  (echo You Clicked OK)
    if "%dk_messageBox%" equ "2"  (echo You Clicked Cancel)
    if "%dk_messageBox%" equ "3"  (echo You Clicked Abort)
    if "%dk_messageBox%" equ "4"  (echo You Clicked Retry)
    if "%dk_messageBox%" equ "5"  (echo You Clicked Ignore)
    if "%dk_messageBox%" equ "6"  (echo You Clicked Yes)
    if "%dk_messageBox%" equ "7"  (echo You Clicked No)
    if "%dk_messageBox%" equ "-1" (echo The message timed out)
%endfunction%
    