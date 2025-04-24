@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_selectFolder(<rtn_var>:optional)
::#
:dk_selectFolder
setlocal
	%dk_call% dk_debugFunc 1
	
	set "MSHTA_EXE=%systemroot:\=/%/system32/mshta.exe"
    %dk_call% dk_assertPath MSHTA_EXE
	
    for /f "usebackq delims=" %%i in (
        `@"%MSHTA_EXE%" "javascript:var objShellApp = new ActiveXObject('Shell.Application');var Folder = objShellApp.BrowseForFolder(0, 'Select Folder:',1, '::{20D04FE0-3AEA-1069-A2D8-08002B30309D}');try {new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).Write(Folder.Self.Path)};catch (e){};close();" ^
        1^|more`
    ) do set "dk_selectFolder=%%i"
	
    if not defined dk_selectFolder (
        %dk_call% dk_echo "no folder selected"
        dk_return
    )
    
    endlocal & (
		set "dk_selectFolder=%dk_selectFolder:\=/%"
		if not "%~1" equ "" (set "%~1=%dk_selectFolder:\=/%")
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_selectFolder myFolder
	%dk_call% dk_echo "dk_selectFolder = '%dk_selectFolder%'"
    %dk_call% dk_echo "myFolder = '%myFolder%'"
%endfunction%
