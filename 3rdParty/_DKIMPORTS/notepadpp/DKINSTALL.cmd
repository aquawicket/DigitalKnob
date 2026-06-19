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
rem # DKINSTALL()
rem #
:DKINSTALL
%setlocal%
	
	%dk_call% dk_import
	
	set "notepadpp_exe=%notepadpp%/notepad++.exe"
	
	rem ### Add Dark Mode ###
	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_copy "%DKIMPORTS_DIR%/notepadpp/config.xml" "%notepadpp%/config.xml" OVERWRITE
	%dk_call% dk_copy "%DKIMPORTS_DIR%/notepadpp/shortcuts.xml" "%notepadpp%/shortcuts.xml" OVERWRITE
	
	rem ### Add Context Menu ###
	%dk_call% dk_depend notepadpp/contextMenu
	
	rem ### Add File Associations ###
	rem %dk_call% dk_depend notepadpp/fileAssoc
	
	:return
	endlocal & (
		"set notepadpp_exe=%notepadpp_exe%"
	)
	
%endfunction%	
	
	
	
	
	
rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_validate notepadpp %dk_call% dk_depend notepadpp
%endfunction%	
	
	
rem 	%dk_call% dk_fileVariables "%~dp0/dkconfig.txt"
rem 	%dk_call% dk_validate Host_Tuple %dk_call% dk_Host_Tuple
rem 	set "notepadpp_Import=!notepadpp_%Host_Tuple%_Import!"
rem 	%dk_call% dk_assertVar notepadpp_Import
rem 	
rem 	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
rem 	%dk_call% dk_importVariables %notepadpp_Import% ROOT %DKTOOLS_DIR%
rem 	
rem 	rem %dk_call% dk_set notepadpp_DIR "%DKTOOLS_DIR%/%notepadpp_FOLDER%"
rem 	%dk_call% dk_set notepadpp_exe "%notepadpp%/notepad++.exe"
rem 	
rem 	if EXIST "%notepadpp_exe%" (goto installed)
rem 	
rem 	%dk_call% dk_echo  
rem   %dk_call% dk_info "Installing notepad++ . . ."
rem 	%dk_call% dk_download %notepadpp_Import%
rem 	%dk_call% dk_smartExtract "%dk_download%" "%notepadpp%"
rem 	%dk_call% dk_assertPath notepadpp_exe
rem 	:installed
rem 	
rem 	rem ### Add Dark Mode ###
rem 	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
rem 	%dk_call% dk_copy "%DKIMPORTS_DIR%/notepadpp/dark_config.xml" "%notepadpp%/config.xml" OVERWRITE
rem 	
rem 	rem ### Add Context Menu ###
rem 	%dk_call% dk_depend notepadpp/contextMenu"
rem 	
rem 	rem ### Add File Associations ###
rem 	rem %dk_call% dk_depend notepadpp/fileAssoc
rem %endfunction%
