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


::####### vc_redist ######
::# https://docs.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-160#visual-studio-2015-2017-2019-and-2022
::# https://aka.ms/vs/16/release/vc_redist.x86.exe
::# https://softmany.com/microsoft-visual-c-redistributable-package/download/
::#
:DKINSTALL
%setlocal% enableDelayedExpansion
	
	%dk_call% dk_fileVariables "%~dp0/dkconfig.txt"
	echo vc_redist_Windows_X86_Import = %vc_redist_Windows_X86_Import%
	echo vc_redist_Windows_X86_64_Import = !vc_redist_Windows_X86_64_Import!
	::###### 32Bit ######
	set "VCCOMP140_X86_DLL=%SystemRoot:\=/%/SysWOW64/vcomp140.dll"
	set "VCCOMP140_X86_DEBUG_DLL=%SystemRoot:\=/%/SysWOW64/vcomp140d.dll"
	set "VCRUNTIME140_X86_DLL=%SystemRoot:\=/%/SysWOW64/vcruntime140.dll"
	set "VCRUNTIME140_X86_DEBUG_DLL=%SystemRoot:\=/%/SysWOW64/vcruntime140d.dll"
	if NOT EXIST "%VCCOMP140_X86_DLL%" if NOT EXIST "%VCCOMP140_X86_DEBUG_DLL%" (
		%dk_call% dk_basename %vc_redist_Windows_X86_Import%
		%dk_call% dk_info "Installing Visual C Redistributable - !dk_basename!"
		%dk_call% dk_download "!vc_redist_Windows_X86_Import!"
		rem %dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
		rem "!DKDOWNLOAD_DIR!/!dk_basename!" /install /quiet /norestart
		"!dk_download!" /install /quiet /norestart
	)
	
	::###### 64Bit ######
	set "VCCOMP140_X86_64_DLL=%SystemRoot:\=/%/System32/vcomp140.dll"
	set "VCCOMP140_X86_64_DEBUG_DLL=%SystemRoot:\=/%/System32/vcomp140d.dll"
	set "VCRUNTIME140_X86_64_DLL=%SystemRoot:\=/%/System32/vcruntime140.dll"
	set "VCRUNTIME140_X86_64_DEBUG_DLL=%SystemRoot:\=/%/System32/vcruntime140d.dll"
	if NOT EXIST "%VCCOMP140_X86_64_DLL%" if NOT EXIST "%VCCOMP140_X86_64_DEBUG_DLL%" (
		%dk_call% dk_basename %vc_redist_Windows_X86_64_Import%
		%dk_call% dk_info "Installing Visual C Redistributable - !dk_basename!"
		%dk_call% dk_download "!vc_redist_Windows_X86_64_Import!"
		::%dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
		"!dk_download!" /install /quiet /norestart
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% DKINSTALL
%endfunction%