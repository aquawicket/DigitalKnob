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


rem ##################################################################################
rem # dk_move(from, to)
rem #
rem # Move/Rename a file or directory to another location/name
rem #
rem # @from	   - The source path to move or rename
rem # @to		 - The destination path to move or rename to
rem # OVERWRITE   - if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
rem #
:dk_move
%setlocal%

	set "_from_=%~1"
	set "_to_=%~2"
	if /i "%~3" equ "OVERWRITE" ( set "OVERWRITE=1" ) else ( set "OVERWRITE=0" )
	
	%dk_call% dk_info "Moving '%_from_%' to '%_to_%'"
	
	if NOT EXIST "%_from_%" ( %dk_call% dk_error "dk_move: %_from_% NOT found" )
	
	if EXIST "%_to_%" (
		if "%OVERWRITE%" neq "1" (
			%dk_call% dk_error "dk_rename Cannot move file. Destiantion exists and OVERWRITE is NOT set"
		)
		%dk_call% dk_delete "%_to_%"
	)

	rem the base directory of the %to% path must EXIST.	
	%dk_call% dk_dirname "%_to_%" _parent_dir_
	%dk_call% dk_debug "_parent_dir_ = %_parent_dir_%"
	%dk_call% dk_mkdir "%_parent_dir_%"

	move /Y "%_from_:/=\%" "%_to_:/=\%"

	rem TODO
	rem [ ? = "success" ]
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
	%dk_call% dk_move "%USERPROFILE:\=/%/Digital Knob/download/cmake-3.29.5-windows-x86_64.zip_EXTRACTED/cmake-3.29.5-windows-x86_64" "%USERPROFILE:\=/%/DigitalKnob/DKTools/cmake-3.29.5-windows-x86_64" OVERWRITE
	pause
	%dk_call% dk_validate DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR	
	%dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
	%dk_call% dk_fileWrite %DKDOWNLOAD_DIR%/moveMe.file "dk_move test"
	%dk_call% dk_move %DKDOWNLOAD_DIR%/moveMe.file %DIGITALKNOB_DIR%/iWasMoved.txt OVERWRITE
	
	%dk_call% dk_fileWrite moveMe.file "dk_move test"
	%dk_call% dk_move moveMe.file iWasMoved.txt OVERWRITE
	
	%dk_call% dk_mkdir %DKDOWNLOAD_DIR%/moveMe
%endfunction%

	%dk_call% dk_move %DKDOWNLOAD_DIR%/moveMe %DIGITALKNOB_DIR%/iWasMoved OVERWRITE
	
	%dk_call% dk_mkdir moveMe
	%dk_call% dk_move moveMe iWasMoved OVERWRITE
%endfunction%
