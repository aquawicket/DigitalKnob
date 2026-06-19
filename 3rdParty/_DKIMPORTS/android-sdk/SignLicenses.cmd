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


rem %dk_call% EndProcess java.exe
rem %dk_call% EndProcess adb.exe

rem %dk_call% dk_validatePath DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
rem %dk_call% "%DKIMPORTS_DIR%/openjdk-8/registerJDK.cmd"

%dk_call% dk_validatePath DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
rem  https://stackoverflow.com/a/48539058/688352
(
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
) > "%DKCACHE_DIR%/file-y.txt"

%dk_call% dk_validatePath DK3RDPARTY_DIR %dk_call% dk_DK3RDPARTY_DIR
set "SDKMANAGER=%DK3RDPARTY_DIR%/android-sdk/cmdline-tools/latest/bin/sdkmanager.bat"

rem %dk_call% dk_assertPath SDKMANAGER
if NOT EXIST "%SDKMANAGER%" (%return%)

"%SDKMANAGER%" --licenses < "%DKCACHE_DIR%/file-y.txt"
rem "%SDKMANAGER%" --licenses

rem if EXIST "%DKIMPORTS_DIR%/openjdk/registerJDK.cmd" (%dk_call% "%DKIMPORTS_DIR%/openjdk/registerJDK.cmd")
