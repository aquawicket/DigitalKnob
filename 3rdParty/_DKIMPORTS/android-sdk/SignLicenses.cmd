@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::call EndProcess java.exe
::call EndProcess adb.exe


%dk_call% dk_validatePath dk_DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
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
