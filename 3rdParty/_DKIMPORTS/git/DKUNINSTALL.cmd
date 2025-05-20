@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::%dk_call% dk_source dk_convertToCIdentifier
::%dk_call% dk_source dk_basename
::%dk_call% dk_source dk_removeExtension
::%dk_call% dk_source dk_toLower
::%dk_call% dk_source dk_validate
::####################################################################
::# DKUNINSTALL
::#
::#
:DKUNINSTALL
%%setlocal%%
    %dk_call% dk_debugFunc 0
 
    %dk_call% dk_validate Host_Tuple	"%dk_call% dk_Host_Tuple"
    ::if defined Windows_Arm32_Host		(set "GIT_IMPORT=")
    ::if defined Windows_Arm64_Host		(set "GIT_IMPORT=")
    if defined Windows_X86_Host			(set "GIT_IMPORT=https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-32-bit.7z.exe")
    if defined Windows_X86_64_Host		(set "GIT_IMPORT=https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe")
    if not defined GIT_IMPORT				(%dk_call% dk_error "GIT_IMPORT is invalid")
	
::  %dk_call% dk_basename %GIT_IMPORT% GIT_IMPORT_FILE
::  %dk_call% dk_removeExtension %GIT_IMPORT_FILE% GIT_FOLDER
::	%dk_call% dk_removeExtension %GIT_FOLDER% GIT_FOLDER
::  %dk_call% dk_convertToCIdentifier %GIT_FOLDER% GIT_FOLDER
::  %dk_call% dk_toLower %GIT_FOLDER% GIT_FOLDER
    %dk_call% dk_importVariables %GIT_IMPORT%
	
	:: https://stackoverflow.com/questions/15769263/how-does-git-dir-work-exactly
	::### DO NOT USE GIT_DIR ###
	if defined GIT_DIR (%dk_call% dk_fatal "ERROR: GIT_DIR should not be set.")
	::### DO NOT USE GIT_DIR ###
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	set "GIT=%DKTOOLS_DIR%\%GIT_FOLDER%"

	::FIXME: kill git.exe process
    %dk_call% dk_delete "%GIT%"
        
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	
	::### Uninstall Context Menu ###
	%dk_call% %DKIMPORTS_DIR%\git\dk_uninstallGitContextMenu.cmd

	::### Uninstall File Associations ###
	%dk_call% %DKIMPORTS_DIR%\git\dk_uninstallGitFileAssociations.cmd
	
	::### Remove PATH variable
	:: TODO
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%%setlocal%%
	%dk_call% dk_debugFunc 0
	
    %dk_call% DKUNINSTALL
%endfunction%
