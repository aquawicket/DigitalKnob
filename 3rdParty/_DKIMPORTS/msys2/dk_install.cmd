@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_install()
::#
:dk_install
::setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_cmakeEval "dk_load(%DKIMPORTS_DIR%/gcc/DKMAKE.cmake)" "GCC_C_COMPILER;GCC_CXX_COMPILER"
	%dk_call% dk_assertVar GCC_C_COMPILER
	%dk_call% dk_assertVar GCC_CXX_COMPILER
	
	
	%endfunction%
	::###### CMD INSTALL DISABLED (DEBUG) ####
	::%dk_call% dk_set MSYS2_DL "https://github.com/msys2/msys2-installer/releases/download/2024-07-27/msys2-x86_64-20240727.exe"
	%dk_call% dk_getFileParam %~dp0\dkconfig.txt MSYS2_DL
	
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_importVariables %MSYS2_DL% IMPORT_PATH %DKIMPORTS_DIR%\msys2 ROOT %DK3RDPARTY_DIR%
	set	"MSYS2_DBPath=%MSYS2_DIR%/var/lib/pacman"
	set	"MSYS2_CacheDir=%MSYS2_DIR%/var/cache/pacman/pkg"
	set	"MSYS2_LogFile=%MSYS2_DIR%/var/log/pacman.log"
	set	"MSYS2_GPGDir=%MSYS2_DIR%/etc/pacman.d/gnupg"
	set	"MSYS2_BIN=%MSYS2%/usr/bin"
	set	"CLANGARM64_BIN=%MSYS2%/clangarm64/bin"
	set	"CLANG32_BIN=%MSYS2%/clang32/bin"
	set	"CLANG64_BIN=%MSYS2%/clang64/bin"
	set	"MINGW32_BIN=%MSYS2%/mingw32/bin"
	set	"MINGW64_BIN=%MSYS2%/mingw64/bin"	
	set	"UCRT64_BIN=%MSYS2%/ucrt64/bin"
	set	"MSYS2_MAKE_PROGRAM=%MSYS2_BIN%/make.exe"
	
	::############ Install ############
	if exist %MSYS2%\msys2.exe" (
		echo "msys2 already installed"
		%return%
	)
	%dk_call% dk_info "Installing %MSYS2_FOLDER%"
	%dk_call% dk_download %MSYS2_DL%
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	"%DKDOWNLOAD_DIR%\%MSYS2_DL_FILE%" install --root "%MSYS2%" --confirm-command
	
	%dk_call% dk_assertVar MSYS2
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_install
%endfunction%
