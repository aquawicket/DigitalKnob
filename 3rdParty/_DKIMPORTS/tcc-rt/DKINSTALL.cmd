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


rem ####################################################################
rem # DKINSTALL
rem #
:DKINSTALL
%setlocal%
	
rem 	%dk_call% dk_fileVariables "%~dp0/dkconfig.txt"
rem 	if NOT defined tcc-rt_Import	(%dk_call% dk_error "tcc-rt_Import is invalid")
	
rem 	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
rem 	%dk_call% dk_importVariables %tcc-rt_Import% NAME tcc-rt INSTALL_ROOT %DKTOOLS_DIR%
	
	%dk_call% dk_import
	
	%dk_call% dk_assertVar tcc-rt
	set "tcc_exe=%tcc-rt%/tcc.exe"
	
	if EXIST "%tcc-rt_exe%" (
		%dk_call% dk_notice "tcc-rt_exe:'%tcc-rt_exe%' already found"
		goto:return
	)
	
	%dk_call% dk_echo  
    %dk_call% dk_info "Installing tcc . . ."
	call "%tcc-rt_Download%" /qn APPDIR="%tcc-rt:/=\%"
	
	
	rem  UNINSTALL
	rem MsiExec.exe /uninstall {B11E65DB-66DF-4987-9D13-014EFC915DF2} /quiet
	
	
	rem if NOT EXIST "%tcc-rt_exe%" %dk_call% dk_error "cannot find tcc-rt_exe:'%tcc-rt_exe%'"
	
	:return
	endlocal & (
		set "tcc_exe=%tcc_exe%"
	)	
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_validate tcc-rt %dk_call% dk_depend tcc-rt
	%dk_call% dk_debug "tcc_exe = %tcc_exe%"
%endfunction%
