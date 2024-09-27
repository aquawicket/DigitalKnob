@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installTCC_RT()
::#
:dk_installTCC_RT
	call dk_debugFunc 0
	
	https://jpsoft.com/downloads/v32/tcc-rt.exe
	%dk_call% dk_validate HOST_TRIPLE "%dk_call% dk_HOST_TRIPLE"
    if "%HOST_OS%_%HOST_ARCH%"=="WIN_X86"     set "TCC_RT_DL=https://jpsoft.com/downloads/v32/tcc-rt.exe"
    if "%HOST_OS%_%HOST_ARCH%"=="WIN_X86_64"  set "TCC_RT_DL=https://jpsoft.com/downloads/v32/tcc-rt.exe"
	if not defined TCC_RT_DL %dk_call% dk_error "TCC_RT_DL is invalid"
	
	%dk_call% dk_basename %TCC_RT_DL% TCC_RT_DL_FILE
	%dk_call% dk_removeExtension %TCC_RT_DL_FILE% TCC_RT_FOLDER
	::%dk_call% dk_convertToCIdentifier %TCC_RT_FOLDER% TCC_RT_FOLDER
	%dk_call% dk_toLower %TCC_RT_FOLDER% TCC_RT_FOLDER
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_set TCC_RT_DIR "%DKTOOLS_DIR%\%TCC_RT_FOLDER%"
	
	
	%dk_call% dk_set TCC_RT_EXE "%TCC_RT_DIR%\tcc.exe"
	
	if exist "%TCC_RT_EXE%" goto:tcc_rt_installed
	%dk_call% dk_echo   
    %dk_call% dk_info "Installing tcc . . ."
    %dk_call% dk_download %TCC_RT_DL%
    
	%dk_call% dk_getNativePath %TCC_RT_DIR% TCC_RT_INSTALL_PATH
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% %command_string% "%DKDOWNLOAD_DIR%\%TCC_RT_DL_FILE%"
	::%dk_call% MSIExec /i "%DKDOWNLOAD_DIR%\tcc-rt.msi" INSTALLDIR="%TCC_RT_DIR%"
	
	::if NOT exist "%TCC_RT_EXE%" %dk_call% dk_error "cannot find TCC_RT_EXE:%TCC_RT_EXE%"
	:tcc_rt_installed
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_installTCC_RT
%endfunction%
