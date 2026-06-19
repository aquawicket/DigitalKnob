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


rem ############ wget ############
rem # https://www.gnu.org/software/wget
rem # https://cosmo.zip/pub/cosmos/bin/wget
rem #
:DKINSTALL
%setlocal%

	%dk_call% dk_validate wget_exe %dk_call% dk_depend wget
	
	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
	
	rem ###### wget options ######
	rem #	-r					recursive
	rem #	--no-parent			does not ascend to the parent; only downloads from the specified subdirectory and downwards hierarchy
	rem # --no-clobber
	rem # -l1					sets the maximum recursion depth to be 1
	
	rem # Backup the . association and set . to cmdfile
	FOR /F "tokens=*" %%g IN ('%ComSpec% /c ASSOC .') do (SET backup=%%g)
	if not defined backup (set "backup=.=")
	"%ComSpec%" /c assoc .=cmdfile
	
	%dk_start% "%wget_exe:/=\%" -r -l1 --no-parent --no-clobber --directory-prefix="%DKTOOLS_DIR%" https://www.dostips.com/forum/

	rem # restore . assoc backup
	"%ComSpec%" /c assoc %backup%

	rem use --timestamping  instead of --no-clobber to update files
%endfunction%
