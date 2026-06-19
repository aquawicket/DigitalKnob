@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ##############################################################################################################
rem # dk_messageBox(text, caption, flags, timeout)
rem #
rem #
:dk_messageBox
%setlocal%

	rem ###### dk_messageBox() Settinge ######
	if NOT defined dk_messageBox_VERSION (
		%dk_call% dk_set dk_messageBox_VERSION 4
	)
	rem ######################################

	if "%~1" equ "" (set "text=chose a selection") 	else (set "text=%~1")
	if "%~2" equ "" (set "caption=dk_messageBox") 	else (set "caption=%~2")
	if "%~3" equ "" (set /a "flags=0") 				else (set /a "flags=%~3")
	if "%~4" equ "" (set /a "timeout=0") 			else (set /a "timeout=%~4")
	echo text = %text%
	echo caption = %caption%
	echo flags = %flags%
	echo timeout = %timeout%

    if %dk_messageBox_VERSION%==1 goto messageBox_1
    if %dk_messageBox_VERSION%==2 goto messageBox_2
    if %dk_messageBox_VERSION%==3 goto messageBox_3
    if %dk_messageBox_VERSION%==4 goto messageBox_4
    if %dk_messageBox_VERSION%==5 goto messageBox_5
    if %dk_messageBox_VERSION%==6 goto messageBox_6
   
    :messageBox_1
		%dk_call% dk_validate mshta.exe %dk_call% dk_findFile mshta.exe
        %mshta.exe% javascript:alert("%text%");close();
        endlocal & set dk_messageBox=!errorlevel!
    %return%   
       
    :messageBox_2
        rem https://learn.microsoft.com/en-us/dotnet/api/microsoft.visualbasic.msgboxstyle?view=net-8.0
		rem https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/msgbox-constants
        %dk_call% dk_validate mshta.exe %dk_call% dk_findFile mshta.exe
		%mshta.exe% vbscript:Execute("MsgBox ""%text%"", %flags%, ""%caption%""")(window.close)
        endlocal & set dk_messageBox=!errorlevel!
    %return%
       
    :messageBox_3
        rem https://stackoverflow.com/a/12523614
        rem https://www.vbsedit.com/html/f482c739-3cf9-4139-a6af-3bde299b8009.asp
       
		%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
        >"%DKCACHE_DIR%/dk_messageBox.vbs" echo set WshShell = WScript.CreateObject("WScript.Shell") 
		
		set "command=WScript.Quit (WshShell.Popup("%text%", %timeout%, "%caption%", %flags%))"
		>>"%DKCACHE_DIR%/dk_messageBox.vbs" echo %command%
		
		%dk_call% dk_validate cscript.exe %dk_call% dk_findFile cscript.exe
		"%cscript.exe%" //nologo "%DKCACHE_DIR%/dk_messageBox.vbs"
        endlocal & (
			set dk_messageBox=!errorlevel!
		)
		rem %dk_call% dk_delete "%DKCACHE_DIR%/dk_messageBox.vbs"
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
   
		rem %dk_call% dk_exec powershell.exe -Command "[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); [Windows.Forms.MessageBox]::show('%text%', '%caption%', %buttons%, %icon%, %defaultButton%, %options%);"
		%dk_call% dk_evalPowershell "[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); [Windows.Forms.MessageBox]::show('%text%', '%caption%', %buttons%, %icon%, %defaultButton%, %options%);"
		
		endlocal & (
			set dk_messageBox=%dk_evalPowershell%
		)

%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

rem 16, 256, 4096, 65536, 1048576, 16777216

	rem	### option_0 [16] (MessageBoxButtons) ###
rem	set "OKOnly=0"					&rem OK button only (default)
rem	set "OKCancel=1"				&rem OK and Cancel buttons
rem	set "AbortRetryIgnore=2"		&rem Abort, Retry, and Ignore buttons
rem	set "YesNoCancel=3"				&rem Yes, No, and Cancel buttons
rem	set "YesNo=4"					&rem Yes and No buttons
rem	set "RetryCancel=5"				&rem Retry and Cancel buttons
rem	set "CancelTryContinue=6"		&rem Specifies that the message box contains Cancel, Try Again, and Continue buttons
	rem	### option_1 [256] (MessageBoxIcon) ###
rem	set "None=0"					&rem No Icon (default)
rem	set "Critical=16"				&rem Critical message
rem	set "Question=32"				&rem Warning query
rem	set "Exclamation=48"			&rem Warning message
rem	set "Information=64"			&rem Information message
	rem	### option_2 [4096] (MessageBoxDefaultButton) ###
rem	set "DefaultButton1=0"			&rem First button is default (default)
rem	set "DefaultButton2=256"		&rem Second button is default
rem	set "DefaultButton3=512"		&rem Third button is default
rem	set "DefaultButton4=768"		&rem Fourth button is default
	rem	### option_3 [65536] (MessageBoxOptions) ###
rem	set "ApplicationModal=0"		&rem Application modal message box (default)
rem	set "SystemModal=4096"			&rem System modal message box
rem	set "MsgBoxHelpButton=16384"	&rem Adds Help button to the message box
	rem ### option_4 [1048576] (HelpNavigator) ###
rem	set "MsgBoxSetForeground=65536"	&rem Specifies the message box window as the foreground window
rem	set "RightAlign=524288"			&rem Text is right aligned
	rem ### option_5 [16777216] (UNICODE) ###
rem	set "RtlReading=1048576"		&rem Specifies text should appear as right-to-left reading on Hebrew and Arabic systems
	
rem	set /a "style=2+32+512+524288"
	
	set "text=dk_messageBox message"
    set "caption=dk_messageBox Title"
    set /a "flags=3+32+256+16384+524288+1048576"
	set "timeout=0"
	
	%dk_call% dk_messageBox "%text%" "%caption%" "%flags%" "%timeout%"
	
	rem	### result ###
rem	set /a "OK=1"		&rem OK button pressed
rem	set /a "Cancel=2"	&rem Cancel button pressed
rem	set /a "Abort=3"	&rem Abort button pressed
rem	set /a "Retry=4"	&rem Retry button pressed
rem	set /a "Ignore=5"	&rem Ignore button pressed
rem	set /a "Yes=6"		&rem Yes button pressed
rem	set /a "No=7"		&rem No button pressed
	
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
    