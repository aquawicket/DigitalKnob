@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../../../DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_install
::#
:dk_install
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
    if defined win_x86_host		(set "TCC_RT_DL=https://jpsoft.com/downloads/v32/tcc-rt.exe")
    if defined win_x86_64_host	(set "TCC_RT_DL=https://jpsoft.com/downloads/v32/tcc-rt.exe")
	if not defined TCC_RT_DL	(%dk_call% dk_error "TCC_RT_DL is invalid")
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %TCC_RT_DL% NAME tcc ROOT %DKTOOLS_DIR%
	
	%dk_call% dk_set TCC_RT_EXE "%TCC_RT%\tcc.exe"
	
	if exist "%TCC_RT_EXE%" (exit /b 0)
	%dk_call% dk_echo   
    %dk_call% dk_info "Installing tcc . . ."
    %dk_call% dk_download %TCC_RT_DL%
    
::	%dk_call% dk_nativePath %TCC_RT% TCC_RT_INSTALL_PATH
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_basename "%TCC_RT_DL%" TCC_RT_DL_FILE
	call "%DKDOWNLOAD_DIR%\%TCC_RT_DL_FILE%"
	::%dk_call% MSIExec /i "%DKDOWNLOAD_DIR%\tcc-rt.msi" INSTALLDIR="%TCC_RT_DIR%"
	
	::if NOT exist "%TCC_RT_EXE%" %dk_call% dk_error "cannot find TCC_RT_EXE:%TCC_RT_EXE%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_install
%endfunction%
