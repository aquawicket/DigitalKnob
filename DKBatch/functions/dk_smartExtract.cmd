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


rem ##################################################################################
rem # dk_smartExtract(src, dest)
rem #
rem #
:dk_smartExtract
%setlocal%

	set "src=%~1"
	%dk_call% dk_assertFile "%src%"
	set "dest=%~2"

	%dk_call% dk_realpath "%src%" src_realpath
	%dk_call% dk_debug "src_realpath = %src_realpath%"
	
	%dk_call% dk_dirname "%src_realpath%" src_dirname
	%dk_call% dk_debug "src_dirname = %src_dirname%"
	
	%dk_call% dk_basename "%src_realpath%" src_basename
	%dk_call% dk_debug "src_basename = %src_basename%"
	
	%dk_call% dk_basename "%src_basename%" src_folder
	%dk_call% dk_debug "src_folder = %src_folder%"
	
	set "src_extractPath=%src_dirname%/%src_basename%_EXTRACTED"
	%dk_call% dk_debug "src_extractPath = %src_extractPath%"
	
	%dk_call% dk_realpath "%dest%" dest_realpath
	%dk_call% dk_debug "dest_realpath = %dest_realpath%"
	
	%dk_call% dk_dirname "%dest_realpath%" dest_dirname
	%dk_call% dk_debug "dest_dirname = %dest_dirname%"
	
	%dk_call% dk_basename "%dest_realpath%" dest_folder
	%dk_call% dk_debug "dest_folder = %dest_folder%"

	%dk_call% dk_extract "%src_realpath%" "%src_extractPath%"
	
	%dk_call% dk_getDirectories "%src_extractPath:\=/%"
	
    %dk_call% Array/dk_length dk_getDirectories
	set "dir_count=%dk_length%"
	
	%dk_call% dk_getFiles "%src_extractPath:\=/%"
	
    %dk_call% Array/dk_length dk_getFiles
	set "file_count=%dk_length%"

    if %dir_count% equ 1 (
		if %file_count% equ 0 (
			rem rename/move EXTRACTED/root folder to dest path"
			%dk_call% dk_move "%dk_getDirectories[0]%" "%dest_realpath%" OVERWRITE
			if EXIST "%src_extractPath%" (%dk_call% dk_delete "%src_extractPath%")
			goto:eof
		)
    )

    rem rename/move EXTRACTED folder to dest path"
	%dk_call% dk_move "%src_extractPath%" "%dest_realpath%" OVERWRITE
	if EXIST "%src_extractPath%" (%dk_call% dk_delete "%src_extractPath%")
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem set "MSYS2_URL=https://repo.msys2.org/distrib/x86_64/msys2-base-x86_64-20241208.tar.xz"
	rem %dk_call% dk_validate DK3RDPARTY_DIR	%dk_call% dk_DK3RDPARTY_DIR
	rem set "MSYS2=%DK3RDPARTY_DIR%/msys2-base-x86_64-20241208"
	rem %dk_call% dk_download %MSYS2_URL%
	rem %dk_call% dk_smartExtract "%dk_download%" "%msys2%"
	
	%dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
	%dk_call% dk_download "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-x86_64.zip" "%DKDOWNLOAD_DIR%/cmake-3.29.5-windows-x86_64.zip"
	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%/cmake-3.29.5-windows-x86_64.zip" "%DKTOOLS_DIR%/cmake-3.29.5-windows-x86_64"
	
	rem %dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
	rem %dk_call% dk_download "https://github.com/libsdl-org/SDL/archive/refs/tags/release-2.26.1.zip" "%DKDOWNLOAD_DIR%/sdl-release-2.26.1.zip"
	rem %dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%/sdl-release-2.26.1.zip" "%DKDOWNLOAD_DIR%/sdl-release-2.26.1"
	
	rem %dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
	rem %dk_call% dk_download "https://newcontinuum.dl.sourceforge.net/project/lzmautils/xz-5.4.6.tar.gz" "%DKDOWNLOAD_DIR%/xz-5.4.6.tar.gz"
    rem %dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%/xz-5.4.6.tar.gz" "%DKDOWNLOAD_DIR%/xz-5.4.6"
%endfunction%