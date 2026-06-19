@rem shebang
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


rem ####################################################################
rem # dk_installPackage(package)
rem #
rem #		Reference: https://en.wikipedia.org/wiki/List_of_software_package_management_systems
rem #		Reference: https://en.wikipedia.org/wiki/Package_manager
rem #		Reference: https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg
rem #
:dk_installPackage
%setlocal%

	set "package=%~1"
	
	%dk_call% dk_debug "dk_installPackage %package% . . ."
	rem %dk_call% dk_validate pacman_exe %dk_call% dk_depend pacman

	%dk_call% dk_validate msys2_CacheDir %dk_call% dk_depend msys2
	rem # %dk_call% dk_mkdir "%msys2_CacheDir%"
	%dk_call% dk_assertPath msys2_CacheDir
	
	if EXIST "%msys2_CacheDir%/db.lck" (
		%dk_call% dk_delete "%msys2_CacheDir%/db.lck"
	)

	if defined Windows_X86_Clang (
		%dk_call% dk_validate pacman_exe %dk_call% dk_depend pacman
		set comand="!pacman_exe:/=\!" -S mingw-w64-clang-i686-%package% --needed --noconfirm --cachedir "%msys2_CacheDir%"
	
	) else if defined Windows_X86_64_Clang (
		%dk_call% dk_validate pacman_exe %dk_call% dk_depend pacman
		set comand="!pacman_exe:/=\!" -S mingw-w64-clang-x86_64-%package% --needed --noconfirm --cachedir "%msys2_CacheDir%"
	
	) else if defined Windows_Arm64_Clang (
		%dk_call% dk_validate pacman_exe %dk_call% dk_depend pacman
		set comand="!pacman_exe:/=\!" -S mingw-w64-clang-aarch64-%package% --needed --noconfirm --cachedir "%msys2_CacheDir%"
	
	) else if defined Windows_X86_Gcc (
		%dk_call% dk_validate pacman_exe %dk_call% dk_depend pacman
		set comand="!pacman_exe:/=\!" -S mingw-w64-i686-%package% --needed --noconfirm --cachedir "%msys2_CacheDir%"
	
	) else if defined Windows_X86_64_Gcc (
		%dk_call% dk_validate pacman_exe %dk_call% dk_depend pacman
		set comand="!pacman_exe:/=\!" -S mingw-w64-x86_64-%package% --needed --noconfirm --cachedir "%msys2_CacheDir%"
	
	) else if defined Windows_X86_64_Ucrt (
		%dk_call% dk_validate pacman_exe %dk_call% dk_depend pacman
		set comand="!pacman_exe:/=\!" -S mingw-w64-ucrt-x86_64-%package% --needed --noconfirm --cachedir "%msys2_CacheDir%"
	
	) else (
		%dk_call% dk_validate pacman_exe %dk_call% dk_depend pacman
		set comand="!pacman_exe:/=\!" -S %package% --needed --noconfirm --cachedir "%msys2_CacheDir%"
	)
	
	%dk_call% dk_debug "%comand%"

	%comand%

%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_installPackage zlib
%endfunction%