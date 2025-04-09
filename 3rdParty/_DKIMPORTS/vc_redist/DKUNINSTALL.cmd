@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../../../DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

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
	
	::### 32Bit ###
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_getFileParam "%DKIMPORTS_DIR%/vc_redist/dkconfig.txt" VC_REDIST_X86_IMPORT
	::set "VCCOMP140_X86_DLL=C:/Windows/SysWOW64/vcomp140.dll"
	::set "VCCOMP140_X86_DEBUG_DLL=C:/Windows/SysWOW64/vcomp140d.dll"
	::set "VCRUNTIME140_X86_DLL=C:/Windows/SysWOW64/vcruntime140.dll"
	::set "VCRUNTIME140_X86_DEBUG_DLL=C:/Windows/SysWOW64/vcruntime140d.dll"
	::### INSTALL ###
	::if not exist "%VCCOMP140_X86_DLL%" if not exist "%VCCOMP140_X86_DEBUG_DLL%" (
		%dk_call% dk_basename %VC_REDIST_X86_IMPORT%
		%dk_call% dk_info "Installing Visual C Redistributable - !dk_basename!"
		%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
		%dk_call% dk_download "!VC_REDIST_X86_IMPORT!"
		"!DKDOWNLOAD_DIR!/!dk_basename!" /uninstall /quiet /norestart 	&rem /log $ENV{DK3RDPARTY_DIR}/vc_redist_install_log.txt
	::)
	
	::### 64Bit ###
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_getFileParam "%DKIMPORTS_DIR%/vc_redist/dkconfig.txt" VC_REDIST_X86_64_IMPORT
	::set "VCCOMP140_X86_64_DLL=C:/Windows/System32/vcomp140.dll"
	::set "VCCOMP140_X86_64_DEBUG_DLL=C:/Windows/System32/vcomp140d.dll"
	::set "VCRUNTIME140_X86_64_DLL=C:/Windows/System32/vcruntime140.dll"
	::set "VCRUNTIME140_X86_64_DEBUG_DLL=C:/Windows/System32/vcruntime140d.dll"
	::### INSTALL ###
	::if not exist "%VCCOMP140_X86_64_DLL%" if not exist "%VCCOMP140_X86_64_DEBUG_DLL%" (
		%dk_call% dk_basename %VC_REDIST_X86_64_IMPORT%
		%dk_call% dk_info "Installing Visual C Redistributable - !dk_basename!"
		%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
		%dk_call% dk_download "!VC_REDIST_X86_64_IMPORT!"
		"!DKDOWNLOAD_DIR!/!dk_basename!" /uninstall /quiet /norestart 	&rem /log $ENV{DK3RDPARTY_DIR}/vc_redist_install_log.txt
	::)

%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	call :DKUNINSTALL
%endfunction%