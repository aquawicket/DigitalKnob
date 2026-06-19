rem shebang
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


rem ################################################################################
rem # dk_gitApplyPatch(directory, patchFile)
rem #
rem #
:dk_gitApplyPatch
%setlocal%

	rem set "directory=%USERPROFILE:\=/%/Digital Knob/Development/3rdParty/rmlui-master"
	rem set "patchFile=%USERPROFILE:\=/%/Digital Knob/Development/3rdParty/rmlui-master/termux.patch"
	set directory=%~1
	set patchFile=%~2
	
	rem  NOTE: We must cd out of the .git local repository, or git apply wont work.
	%dk_call% dk_validate DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
	%dk_call% dk_chdir %DIGITALKNOB_DIR%
	
rem 	%dk_call% dk_validate git_patch_exe %dk_call% dk_depend git
rem 	"%git_patch_exe%" --directory=%directory% < %patchFile% --verbose --dry-run
	
	%dk_call% dk_validate git.exe %dk_call% dk_depend git
	%dk_call% git.exe -C %DKBRANCH_DIR% apply --verbose --no-index --unsafe-paths --directory=%directory% %patchFile%
	
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem %dk_call% dk_selectFolder
	rem %dk_call% dk_selectFile
    rem %dk_call% dk_gitApplyPatch "%dk_selectFolder%" "%dk_selectFile%"
	
	set "directory=%USERPROFILE:\=/%/Digital Knob/Development/3rdParty/rmlui-master"
	set "patchFile=%USERPROFILE:\=/%/Digital Knob/Development/3rdParty/_DKIMPORTS/rmlui/termux.patch"
    %dk_call% dk_gitApplyPatch "%directory%" "%patchFile%"

%endfunction%
