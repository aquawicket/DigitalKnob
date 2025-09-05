@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####### vc_redist ######
::# https://docs.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-160#visual-studio-2015-2017-2019-and-2022
::# https://aka.ms/vs/16/release/vc_redist.x86.exe
::# https://softmany.com/microsoft-visual-c-redistributable-package/download/
::#
:DKINSTALL
%setlocal% enableDelayedExpansion
    %dk_call% dk_debugFunc 0
	
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	echo vc_redist_Windows_X86_Import = %vc_redist_Windows_X86_Import%
	echo vc_redist_Windows_X86_64_Import = !vc_redist_Windows_X86_64_Import!
	::###### 32Bit ######
	set "VCCOMP140_X86_DLL=%windir:\=/%/SysWOW64/vcomp140.dll"
	set "VCCOMP140_X86_DEBUG_DLL=%windir:\=/%/SysWOW64/vcomp140d.dll"
	set "VCRUNTIME140_X86_DLL=%windir:\=/%/SysWOW64/vcruntime140.dll"
	set "VCRUNTIME140_X86_DEBUG_DLL=%windir:\=/%/SysWOW64/vcruntime140d.dll"
	if NOT EXIST "%VCCOMP140_X86_DLL%" if NOT EXIST "%VCCOMP140_X86_DEBUG_DLL%" (
		%dk_call% dk_basename %vc_redist_Windows_X86_Import%
		%dk_call% dk_info "Installing Visual C Redistributable - !dk_basename!"
		%dk_call% dk_download "!vc_redist_Windows_X86_Import!"
		rem %dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
		rem "!DKDOWNLOAD_DIR!/!dk_basename!" /install /quiet /norestart
		"!dk_download!" /install /quiet /norestart
	)
	
	::###### 64Bit ######
	set "VCCOMP140_X86_64_DLL=%windir:\=/%/System32/vcomp140.dll"
	set "VCCOMP140_X86_64_DEBUG_DLL=%windir:\=/%/System32/vcomp140d.dll"
	set "VCRUNTIME140_X86_64_DLL=%windir:\=/%/System32/vcruntime140.dll"
	set "VCRUNTIME140_X86_64_DEBUG_DLL=%windir:\=/%/System32/vcruntime140d.dll"
	if NOT EXIST "%VCCOMP140_X86_64_DLL%" if NOT EXIST "%VCCOMP140_X86_64_DEBUG_DLL%" (
		%dk_call% dk_basename %vc_redist_Windows_X86_64_Import%
		%dk_call% dk_info "Installing Visual C Redistributable - !dk_basename!"
		%dk_call% dk_download "!vc_redist_Windows_X86_64_Import!"
		::%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
		"!dk_download!" /install /quiet /norestart
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%