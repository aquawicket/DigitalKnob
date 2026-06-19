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


rem ########### msys2 ###########
rem # https://www.msys2.org
rem # https://silentinstallhq.com/msys2-silent-install-how-to-guide
rem # https://repo.msys2.org/distrib/x86_64/msys2-base-x86_64-20241208.tar.xz
rem #
:DKINSTALL
%setlocal%
	
	%dk_call% dk_import
	
	set	"msys2_DBPath=%msys2%/var/lib/pacman"
	rem set	"msys2_CacheDir=%msys2%/var/cache/pacman/pkg"
	set	"msys2_LogFile=%msys2%/var/log/pacman.log"
	set	"msys2_GPGDir=%msys2%/etc/pacman.d/gnupg"
	set "msys2_dirmngr_exe=%msys2%/usr/bin/dirmngr.exe"
	rem set	"msys2_BIN=%msys2%/usr/bin"
	rem set	"CLANGARM64_BIN=%msys2%/clangarm64/bin"
	rem set	"CLANG32_BIN=%msys2%/clang32/bin"
	rem set	"CLANG64_BIN=%msys2%/clang64/bin"
	rem set	"MINGW32_BIN=%msys2%/mingw32/bin"
	rem set	"MINGW64_BIN=%msys2%/mingw64/bin"	
	rem set	"UCRT64_BIN=%msys2%/ucrt64/bin"
		
	%dk_call% dk_firewallAllow "%msys2_dirmngr_exe%"
		
	%dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
	set "msys2_CacheDir=%DKDOWNLOAD_DIR%/msys2/var/cache/pacman/pkg"
	%dk_call% dk_mkdir "%msys2_CacheDir%"
	
	%dk_call% dk_mkdir "%DKDOWNLOAD_DIR%/msys2"
	%dk_call% dk_copy "%DKHttp_DKDownload_Dir:file:///=%/msys2" "%DKDOWNLOAD_DIR%/msys2"
		
	endlocal & (
		set "msys2=%msys2%"
		set	"msys2_DBPath=%msys2_DBPath%"
		set	"msys2_CacheDir=%msys2_CacheDir%"
		set	"msys2_LogFile=%msys2_LogFile%"
		set	"msys2_GPGDir=%msys2_GPGDir%"
		set "msys2_dirmngr_exe=%msys2_dirmngr_exe%"
		rem set	"msys2_BIN=%msys2%/usr/bin"
		rem set	"CLANGARM64_BIN=%msys2%/clangarm64/bin"
		rem set	"CLANG32_BIN=%msys2%/clang32/bin"
		rem set	"CLANG64_BIN=%msys2%/clang64/bin"
		rem set	"MINGW32_BIN=%msys2%/mingw32/bin"
		rem set	"MINGW64_BIN=%msys2%/mingw64/bin"	
		rem set	"UCRT64_BIN=%msys2%/ucrt64/bin"
	)
	rem %dk_call% dk_debug "msys2 = %msys2%"
%endfunction%	
	
	
	
	
	

