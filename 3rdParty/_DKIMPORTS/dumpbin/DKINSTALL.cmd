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


rem ############ dumpbin ############
rem # https://github.com/Delphier/dumpbin/releases/download/v14.40.33811/dumpbin-14.40.33811-x64.zip
rem #
:DKINSTALL
%setlocal%

	rem set "dumpbin_exe=%ProgramFiles:\=/%/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.30.30705/bin/Hostx86/x86/dumpbin.exe"
	%dk_call% dk_import
	set "dumpbin_exe=%dumpbin%/dumpbin.exe"
	
	
	:return
	rem %dk_call% dk_firewallAllow "%dumpbin_exe%"
	endlocal & (
		set "dumpbin_exe=%dumpbin_exe%"
	)
	rem %dk_call% dk_debug "dumpbin_exe=%dumpbin_exe%"
%endfunction%

