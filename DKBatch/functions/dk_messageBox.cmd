@echo off
set "ENABLE_dk_log=0"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

call dk_set VERSION_dk_messageBox 3
::################################################################################
::# dk_messageBox(<title> rtn_var <message>)
::#
::#
:dk_messageBox
    call dk_debugFunc 3
 setlocal  
 
    set "title=%~1"
    set "message=%~3"
    
    if %VERSION_dk_messageBox% equ 1 goto messageBox_1
    if %VERSION_dk_messageBox% equ 2 goto messageBox_2 
    if %VERSION_dk_messageBox% equ 3 goto messageBox_3
    if %VERSION_dk_messageBox% equ 4 goto messageBox_4 
    if %VERSION_dk_messageBox% equ 5 goto messageBox_5 
    if %VERSION_dk_messageBox% equ 6 goto messageBox_6 
    
    :messageBox_1 
        mshta javascript:alert("%message%");close();
        echo errorlevel = %errorlevel%
    %endfunction%    
        
    :messageBox_2
        :: https://learn.microsoft.com/en-us/dotnet/api/microsoft.visualbasic.msgboxstyle?view=net-8.0
        mshta.exe vbscript:Execute("MsgBox ""%message%"", vbOkCancel, ""%title%""")(window.close)
        echo errorlevel = %errorlevel%
    %endfunction%
        
    :messageBox_3
        :: https://stackoverflow.com/a/12523614
        :: https://www.vbsedit.com/html/f482c739-3cf9-4139-a6af-3bde299b8009.asp
        
        :: buttons
        set OK=0
        set OK_Cancel=1
        set Abort_Retry_Ignore=2
        set Yes_No_Cancel=3
        set Yes_No=4
        set Retry_Cancel=5
        
        :: icon
        set dk_stop=16
        set Stop=16
        set Question=32
        set Exclamation=48
        set Information=64
        
        set Timeout=0
        
        echo set WshShell = WScript.CreateObject("WScript.Shell") > %tmp%\tmp.vbs
        echo WScript.Quit (WshShell.Popup( "%message%" ,"%Timeout%" ,"%title%", %Abort_Retry_Ignore% + %Exclamation%)) >> %tmp%\tmp.vbs
        cscript /nologo %tmp%\tmp.vbs
        if %errorlevel%==1  (echo OK)
        if %errorlevel%==2  (echo Cancel)
        if %errorlevel%==3  (echo Abort)
        if %errorlevel%==4  (echo Retry)
        if %errorlevel%==5  (echo Ignore)
        if %errorlevel%==6  (echo Yes)
        if %errorlevel%==7  (echo No)
        if %errorlevel%==-1 (echo Timeout)
        set rtn_var=%errorlevel%
        del %tmp%\tmp.vbs
        ::if "%~3" neq "" set "%3=%errorlevel%"
        set "%2=%rtn_var%"
    %endfunction%
        
    :messageBox_4
        :: with dk_powershell
        %dk_call% dk_powershell [Reflection.Assembly]::LoadWithPartialName("""System.Windows.Forms""");[Windows.Forms.MessageBox]::show("""%~1""", """My PopUp Message Box""")
        echo errorlevel = %errorlevel%
    %endfunction%
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal

    %dk_call% dk_messageBox messageBox_result "MessageBox Title" "Testing dk_messageBox"
    echo messageBox_result = %messageBox_result%
    if %messageBox_result%==1  (echo You Clicked OK)
    if %messageBox_result%==2  (echo You Clicked Cancel)
    if %messageBox_result%==3  (echo You Clicked Abort)
    if %messageBox_result%==4  (echo You Clicked Retry)
    if %messageBox_result%==5  (echo You Clicked Ignore)
    if %messageBox_result%==6  (echo You Clicked Yes)
    if %messageBox_result%==7  (echo You Clicked No)
    if %messageBox_result%==-1 (echo The message timed out)
%endfunction%
    