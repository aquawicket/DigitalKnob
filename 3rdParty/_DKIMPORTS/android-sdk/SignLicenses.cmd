@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\")
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::%dk_call% EndProcess java.exe
::%dk_call% EndProcess adb.exe

::%dk_call% dk_validatePath DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
::%dk_call% "%DKIMPORTS_DIR%\openjdk-8\registerJDK.cmd"

%dk_call% dk_validatePath DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
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
) > "%DKCACHE_DIR%\file-y.txt"

%dk_call% dk_validatePath DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
set "SDKMANAGER=%DK3RDPARTY_DIR%\android-sdk\cmdline-tools\latest\bin\sdkmanager.bat"

::%dk_call% dk_assertPath SDKMANAGER
if not exist "%SDKMANAGER%" (%return%)

"%SDKMANAGER%" --licenses < "%DKCACHE_DIR%\file-y.txt"
::"%SDKMANAGER%" --licenses

::if exist "%DKIMPORTS_DIR%\openjdk\registerJDK.cmd" (%dk_call% "%DKIMPORTS_DIR%\openjdk\registerJDK.cmd")
