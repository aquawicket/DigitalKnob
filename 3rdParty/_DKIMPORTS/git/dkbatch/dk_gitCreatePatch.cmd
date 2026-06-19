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
rem # dk_gitCreatePatch(fileA, fileB, patchFile)
rem #
rem #   FileA is the path/to/file to be patched.  it should contain the old data and should remain in it's required location.
rem #   FileB is the path/to/file that contains the new data. it can be anywhere.
rem #	  patchFile is the file created, it can be created to anywhere.
rem #
:dk_gitCreatePatch
 rem %setlocal%

    echo dk_gitCreatePatch %*
	
    %dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
    rem %dk_call% dk_chdir %DKBRANCH_DIR%
   
    %dk_call% dk_validate git.exe %dk_call% dk_depend git
	
	rem %dk_call% dk_chdir %~dp1
	rem %dk_call% dk_rename %~1 %~1.old
	rem %dk_call% dk_copy %~2 %~1 OVERWRITE
	rem set "fileA=%~nx1.old"
	rem set "fileB=%~nx1"
	rem "%git.exe%" diff --relative --no-index  --unified --default-prefix --output=%~3 %fileA% %fileB%
	rem %dk_call% dk_move %~1.old %~1 OVERWRITE
	
	%dk_call% dk_chdir %~dp1
	%dk_call% dk_copy %~2 %~1.patch OVERWRITE
	set "fileA=%~nx1"
	set "fileB=%~nx1.patch"
	"%git.exe%" -C %DKBRANCH_DIR% diff --relative --no-index --unified --default-prefix --output=%~3 %fileA% %fileB%
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_selectFile & set "fileA=!dk_selectFile!"
	%dk_call% dk_selectFile & set "fileB=!dk_selectFile!"
	%dk_call% dk_saveFile patchFile
	%dk_call% dk_gitCreatePatch "%fileA%" "%fileB%" "%patchFile%"

	rem %dk_call% dk_gitCreatePatch "%DKIMPORTS_DIR%/rmlui/CMakeLists.txt" "%DKIMPORTS_DIR%/rmlui/CMakeLists.txt.patch" "%DKIMPORTS_DIR%/rmlui/termux.patch"
%endfunction%
