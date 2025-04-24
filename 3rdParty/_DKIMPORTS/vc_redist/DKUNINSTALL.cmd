@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::# https://docs.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-160#visual-studio-2015-2017-2019-and-2022
::#
::# https://aka.ms/vs/16/release/vc_redist.x86.exe
::# https://softmany.com/microsoft-visual-c-redistributable-package/download/
::#
::# VCRUNTIME140.dll


::####################################################################
::# DKUNINSTALL
::#
:DKUNINSTALL
setlocal enableDelayedExpansion
    %dk_call% dk_debugFunc 0
	
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	
	::###### 32Bit ######
	::set "VCCOMP140_X86_DLL=C:/Windows/SysWOW64/vcomp140.dll"
	::set "VCCOMP140_X86_DEBUG_DLL=C:/Windows/SysWOW64/vcomp140d.dll"
	set "VCRUNTIME140_X86_DLL=C:/Windows/SysWOW64/vcruntime140.dll"
	set "VCRUNTIME140_X86_DEBUG_DLL=C:/Windows/SysWOW64/vcruntime140d.dll"
	
	rem OR if exist "%VCRUNTIME140_X86_DEBUG_DLL%" (
	if exist "%VCRUNTIME140_X86_DLL%" (
		%dk_call% dk_basename %VC_REDIST_X86_IMPORT%
		%dk_call% dk_info "Uninstalling Visual C Redistributable - !dk_basename!"
		%dk_call% dk_download "!VC_REDIST_X86_IMPORT!"
		%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
		"!DKDOWNLOAD_DIR!/!dk_basename!" /uninstall /quiet /norestart
	)
	
	
	
	::###### 64Bit ######
	::set "VCCOMP140_X86_64_DLL=C:/Windows/System32/vcomp140.dll"
	::set "VCCOMP140_X86_64_DEBUG_DLL=C:/Windows/System32/vcomp140d.dll"
	set "VCRUNTIME140_X86_64_DLL=C:/Windows/System32/vcruntime140.dll"
	set "VCRUNTIME140_X86_64_DEBUG_DLL=C:/Windows/System32/vcruntime140d.dll"
	
	rem OR if exist "%VCRUNTIME140_X86_64_DEBUG_DLL%" (
	if exist "%VCRUNTIME140_X86_64_DLL%" (
		%dk_call% dk_basename %VC_REDIST_X86_64_IMPORT%
		%dk_call% dk_info "Uninstalling Visual C Redistributable - !dk_basename!"
		%dk_call% dk_download "!VC_REDIST_X86_64_IMPORT!"
		%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
		"!DKDOWNLOAD_DIR!/!dk_basename!" /uninstall /quiet /norestart
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKUNINSTALL
%endfunction%