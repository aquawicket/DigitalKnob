@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"

	set "MSYS2_IMPORT=!Msys2_%Host_Tuple%_Import!"

	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
	::%dk_call% dk_importVariables %MSYS2_IMPORT% IMPORT_PATH %DKIMPORTS_DIR%\msys2 ROOT %DK3RDPARTY_DIR%
	%dk_call% dk_importVariables https://repo.msys2.org/distrib/x86_64/msys2-base-x86_64-20241208.tar.xz NAME msys2
	%dk_call% dk_assertVar MSYS2

	set	"MSYS2_DBPath=%MSYS2%/var/lib/pacman"
	set	"MSYS2_CacheDir=%MSYS2%/var/cache/pacman/pkg"
	set	"MSYS2_LogFile=%MSYS2%/var/log/pacman.log"
	set	"MSYS2_GPGDir=%MSYS2%/etc/pacman.d/gnupg"
	set	"MSYS2_BIN=%MSYS2%/usr/bin"
	set	"CLANGARM64_BIN=%MSYS2%/clangarm64/bin"
	set	"CLANG32_BIN=%MSYS2%/clang32/bin"
	set	"CLANG64_BIN=%MSYS2%/clang64/bin"
	set	"MINGW32_BIN=%MSYS2%/mingw32/bin"
	set	"MINGW64_BIN=%MSYS2%/mingw64/bin"	
	set	"UCRT64_BIN=%MSYS2%/ucrt64/bin"
	set	"MSYS2_MAKE_PROGRAM=%MSYS2%/make.exe"
	
	if exist "%MSYS2%/msys2.exe" (%return%)
	::############ Install ############
	%dk_call% dk_info "Installing %MSYS2_FOLDER%"
	%dk_call% dk_download %MSYS2_IMPORT%
	"%dk_download%" install --root "%MSYS2%" --confirm-command
	
	%dk_call% dk_assertPath MSYS2
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%
