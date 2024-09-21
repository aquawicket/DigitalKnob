@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::call EndProcess java.exe
::call EndProcess adb.exe

call "%DKIMPORTS_DIR%\openjdk-8u41\registerJDK.cmd"

set "SDKMANAGER=%DK3RDPARTY_DIR%\android-sdk\cmdline-tools\latest\bin\sdkmanager.bat

:: https://stackoverflow.com/a/48539058/688352
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
) > file-y.txt

%SDKMANAGER% --licenses < file-y.txt
::%SDKMANAGER% --licenses

call "%DKIMPORTS_DIR%\jdk\registerJDK.cmd" 
