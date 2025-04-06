@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../../../DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_uninstall()
::#
:dk_uninstall
setlocal
	%dk_call% dk_debugFunc 0
	
	echo:
	echo ### Uninstalling visualstudio ###
	"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\setup.exe" uninstall --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools"
	
	echo:
	echo ### Uninstalling visualstudio_installer ###
	"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\setup.exe" /uninstall
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
    call :dk_uninstall
%endfunction%
