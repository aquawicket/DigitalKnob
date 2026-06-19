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


rem #####################################################################
rem # dk_delete(path)
rem #
rem #
:dk_delete
%setlocal%
	
	set "dk_delete_ARGV1=%~1"

rem	%dk_call% dk_realpath "%dk_delete_ARGV1%"
rem	if NOT EXIST "%dk_realpath%" (
rem      %dk_call% dk_warning "dk_delete dk_realpath:'%dk_realpath%' NOT FOUND"
rem      %return%
rem  )
	
   	if NOT EXIST "%dk_delete_ARGV1%" (
		%dk_call% dk_warning "dk_delete dk_delete_ARGV1:'%dk_delete_ARGV1%' NOT FOUND"
        %return%
	)

	rem # rd	Removes (deletes) a directory.
	rem # /S	Removes all directories and files in the specified directory in addition to the directory itself.  Used to remove a directory tree.
	rem # /Q	Quiet mode, do not ask if ok to remove a directory tree with /S
	if EXIST "%dk_delete_ARGV1%\*" ("%ComSpec%" /c rd /S /Q "%dk_delete_ARGV1:/=\%")
	
	rem # del		Deletes one or more files.
	rem # /F		Force deleting of read-only files.
	rem # /Q		Quiet mode, do not ask if ok to delete on global wildcard.
	if EXIST "%dk_delete_ARGV1%" ("%ComSpec%" /c del /F /Q "%dk_delete_ARGV1:/=\%")
	
	rem ### wait for delete
	:wait
	if EXIST "%dk_delete_ARGV1%" (
		echo waiting for %dk_delete_ARGV1% to be deleted . . .
		ping.exe -n 2 127.0.0.1>nul 
		goto:wait
	)
	
	
    if EXIST "%dk_delete_ARGV1%" (
        %dk_call% dk_error "dk_delete failed to remove dk_delete_ARGV1:'%dk_delete_ARGV1%'"
        exit /b 1
    )

rem exit /b 0
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
    %dk_call% dk_fileWrite "%DKCACHE_DIR%/removeMe.file" "created file to test dk_delete"
    %dk_call% dk_delete "%DKCACHE_DIR%/removeMe.file"
    pause
exit /b 0
%endfunction%
