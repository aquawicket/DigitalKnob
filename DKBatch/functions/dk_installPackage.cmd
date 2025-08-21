@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

%dk_call% dk_debug "dk_installPackage(%*)"

::####################################################################
::# dk_installPackage(package)
::#
::#		Reference: https://en.wikipedia.org/wiki/List_of_software_package_management_systems
::#		Reference: https://en.wikipedia.org/wiki/Package_manager
::#		Reference: https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg
::#
:dk_installPackage
%setlocal%
	%dk_call% dk_debugFunc 1

	::# %~1 = package

	set "package=%~1"

	::### Msys2 ###
	%dk_call% dk_validate PACMAN_EXE "%dk_call% dk_depend pacman"
	%dk_call% dk_assertPath "%PACMAN_EXE%" 

	if EXIST "%MSYS2_CacheDir%/db.lck" (
		%dk_call% dk_delete "%MSYS2_CacheDir%/db.lck"
	)
	::# %dk_call% dk_mkdir "%MSYS2_CacheDir%"
	%dk_call% dk_assertPath MSYS2_CacheDir

	if defined Windows_X86_Clang (
		set comand="%PACMAN_EXE%" -S mingw-w64-clang-i686-%package% --needed --noconfirm --cachedir "%MSYS2_CacheDir%"		&rem CLANG32
	) else if defined Windows_X86_64_Clang (
		set comand="%PACMAN_EXE%" -S mingw-w64-clang-x86_64-%package% --needed --noconfirm --cachedir "%MSYS2_CacheDir%"	&rem CLANG64
	) else if defined Windows_Arm64_Clang (
		set comand="%PACMAN_EXE%" -S mingw-w64-clang-aarch64-%package% --needed --noconfirm --cachedir "%MSYS2_CacheDir%"	&rem CLANGARM64
	) else if defined Windows_X86_Gcc (
		set comand="%PACMAN_EXE%" -S mingw-w64-i686-%package% --needed --noconfirm --cachedir "%MSYS2_CacheDir%"			&rem MINGW32
	) else if defined Windows_X86_64_Gcc (
		set comand="%PACMAN_EXE%" -S mingw-w64-x86_64-%package% --needed --noconfirm --cachedir "%MSYS2_CacheDir%"			&rem MINGW64
	) else if defined Windows_X86_64_Ucrt (
		set comand="%PACMAN_EXE%" -S mingw-w64-ucrt-x86_64-%package% --needed --noconfirm --cachedir "%MSYS2_CacheDir%"		&rem UCRT64
	) else (
		set comand="%PACMAN_EXE%" -S %package% --needed --noconfirm --cachedir "%MSYS2_CacheDir%"							&rem MSYS (DEFAULT)
	)
	%dk_call% dk_echo "!comand!"
	%dk_call% dk_exec !comand!
	%return%

%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_installPackage zlib
%endfunction%