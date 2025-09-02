@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	set "CURRENT_IMPORT=%~dp0"
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"

	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	%dk_call% dk_assertVar msys2_%Host_Tuple%_Import
	
	%dk_call% dk_importVariables !msys2_%Host_Tuple%_Import!
	%dk_call% dk_assertVar msys2
	%dk_call% dk_assertVar msys2_Url

	set "msys2=%msys2%"
	set	"msys2_DBPath=%msys2%/var/lib/pacman"
	set	"msys2_CacheDir=%msys2%/var/cache/pacman/pkg"
	set	"msys2_LogFile=%msys2%/var/log/pacman.log"
	set	"msys2_GPGDir=%msys2%/etc/pacman.d/gnupg"
	set	"msys2_BIN=%msys2%/usr/bin"
	set	"CLANGARM64_BIN=%msys2%/clangarm64/bin"
	set	"CLANG32_BIN=%msys2%/clang32/bin"
	set	"CLANG64_BIN=%msys2%/clang64/bin"
	set	"MINGW32_BIN=%msys2%/mingw32/bin"
	set	"MINGW64_BIN=%msys2%/mingw64/bin"	
	set	"UCRT64_BIN=%msys2%/ucrt64/bin"
	set	"msys2_MAKE_PROGRAM=%msys2%/make.exe"
	if EXIST "%msys2%/msys2.exe" (
		%dk_call% dk_notice "msys2 already installed"
		%return%
	)
		
	::############ Install ############
	%dk_call% dk_echo
	%dk_call% dk_info "Installing %msys2_Url_Filename%. . ."
	%dk_call% dk_download %msys2_Url%
	%dk_call% dk_smartExtract "%dk_download%" "%msys2%"
	::"%dk_download%" install --root "%msys2%" --confirm-command
	
	::%dk_call% dk_import %msys2_Url%
	
	%dk_call% dk_assertPath msys2

%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%
