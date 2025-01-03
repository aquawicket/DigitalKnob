@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_selectFolder(rtn_var)
::#
:dk_selectFolder
setlocal
	%dk_call% dk_debugFunc 1
    %dk_call% dk_assertPath "%systemroot%\system32\mshta.exe"
    for /f "usebackq delims=" %%i in (
        `@"%systemroot%\system32\mshta.exe" "javascript:var objShellApp = new ActiveXObject('Shell.Application');var Folder = objShellApp.BrowseForFolder(0, 'Select Folder:',1, '::{20D04FE0-3AEA-1069-A2D8-08002B30309D}');try {new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).Write(Folder.Self.Path)};catch (e){};close();" ^
        1^|more`
    ) do set "sFolderName=%%i"
    if not defined sFolderName (
        %dk_call% dk_echo "no folder selected"
        %return%
    )
    
    endlocal & set "%~1=%sFolderName%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_selectFolder myFolder
    %dk_call% dk_echo "myFolder = %myFolder%"
%endfunction%
