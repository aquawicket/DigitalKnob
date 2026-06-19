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
rem # dk_copy(from, to)
rem #
rem # copy a file or directory to another location
rem #
rem # @from       - The source path to copy
rem # @to         - The destination path to copy to
rem # OVERWRITE   - if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
rem #
:dk_copy
%setlocal%

	(set "_from_=%~1")
	(set "_to_=%~2")
	if /i "%~3" equ "OVERWRITE" (set "OVERWRITE=1") else (set "OVERWRITE=0")

	%dk_call% dk_debug "Copying '%_from_%' to '%_to_%'"

	if NOT EXIST "%_from_%" (%dk_call% dk_error "_from_:'%_from_%' NOT found")

	if EXIST "%_to_%" (
		if "%OVERWRITE%" neq "1" (
			%dk_call% dk_error "dk_copy Cannot copy file. Destiantion already exists and OVERWRITE is NOT set"
		) else (
			%dk_call% dk_delete "%_to_%"
		)
	)

	rem the base directory of the %to% path must EXIST.   
	%dk_call% dk_dirname "%_to_%"
	%dk_call% dk_mkdir "%dk_dirname%"

	%dk_call% dk_validate xcopy.exe 	%dk_call% dk_findFile xcopy.exe
	if EXIST "%_from_:/=\%\*" (
		echo D|"%xcopy.exe:/=\%" "%_from_:/=\%" "%_to_:/=\%" /S /E /H /Y 1>nul
	) else (
		echo F|"%xcopy.exe:/=\%" "%_from_:/=\%" "%_to_:/=\%" /H /Y 1>nul
	)

	if NOT EXIST "%_to_%" (%dk_call% dk_error "dk_copy failed: '%_to_%' NOT FOUND")
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	echo DKCACHE_DIR = %DKCACHE_DIR%

	rem ### Test file copy ###
	echo dk_copy test> "%DKCACHE_DIR:/=\%\copyMe.file"
	%dk_call% dk_copy "%DKCACHE_DIR%/copyMe.file" "%DKCACHE_DIR%/iWasCopied.txt"

	rem ### Test Folder copy ###
	mkdir "%DKCACHE_DIR:/=\%\copyMe"
	%dk_call% dk_copy "%DKCACHE_DIR%/copyMe" "%DKCACHE_DIR%/iWasCopied"
	
	rem ### Test file copy w/ OVERWRITE ###
	echo dk_copy test> "%DKCACHE_DIR:/=\%\copyMe.file"
	%dk_call% dk_copy "%DKCACHE_DIR%/copyMe.file" "%DKCACHE_DIR%/iWasCopied.txt" OVERWRITE

	rem ### Test Folder copy w/ OVERWRITE ###
	mkdir "%DKCACHE_DIR:/=\%\copyMe"
	%dk_call% dk_copy "%DKCACHE_DIR%/copyMe" "%DKCACHE_DIR%/iWasCopied" OVERWRITE
	
	rem ### Test file copy without OVERWRITE ###
	echo dk_copy test> "%DKCACHE_DIR:/=\%\copyMe.file"
	%dk_call% dk_copy "%DKCACHE_DIR%/copyMe.file" "%DKCACHE_DIR%/iWasCopied.txt"

	rem ### Test Folder copy without OVERWRITE ###
	mkdir "%DKCACHE_DIR:/=\%\copyMe"
	%dk_call% dk_copy "%DKCACHE_DIR%/copyMe" "%DKCACHE_DIR%/iWasCopied"
%endfunction%
