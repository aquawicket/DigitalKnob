#if 0 // 2>NUL & GOTO :startbatch
COMPILER_OPTIONS="-g -Wall -Wextra --std=c99 -O1";THIS_FILE="$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")";OUT_FILE="/tmp/build-cache/$THIS_FILE";mkdir -p "$(dirname "$OUT_FILE")";test "$THIS_FILE" -ot "$OUT_FILE" || $(which clang || which gcc) $COMPILER_OPTIONS -xc "$THIS_FILE" -o "$OUT_FILE" || exit;exec "$OUT_FILE" "$@"
:startbatch
@echo off
setlocal enableextensions enabledelayedexpansion
md %TEMP%%~p0 2>NUL
rem Use xcopy to test if this file is newer than the cached executable.
for /f %%i in ('xcopy %0 %TEMP%%~pnx0.exe /D /Y /Q') do set copied=%%i
if "%copied:~0,1%" neq "0" (
  rem Search for Visual Studio env vars. These are set globally if VS <2017 is installed.
  for /L %%i in (60,10,140) DO (
    set "vs=VS%%i%COMNTOOLS"
    if defined !vs! (
      set "vsfound=!vs!"
    )
  )
)
if "%copied:~0,1%" neq "0" ( 
  rem If cl.exe is already in the PATH, use it. Otherwise, look for VS 2017, then older versions.
  for %%X in (cl.exe) do (set FOUND_COMPILER=%%~$PATH:X)
  if not defined FOUND_COMPILER (
    rem Look for VS 2017 using its start menu link, because Microsoft has broken every other reasonable way of finding it.
    set "VS_START_MENU=%ProgramData%\Microsoft\Windows\Start Menu\Programs\Visual Studio 2017.lnk"
    if exist !VS_START_MENU! (
      rem Use "wmic" tool to extract the devenv.exe path from the .lnk file, then run vcvars64.bat
      for /f "delims=" %%I in ('wmic path win32_shortcutfile where "name='!VS_START_MENU:\=\\!'" get target /value') do for /f "delims=" %%# in ("%%~I") do set "%%~#"
      pushd
      call "!target!\..\..\..\VC\Auxiliary\Build\vcvars64.bat" >NUL 2>NUL
      popd
    ) else (
      if not defined vsfound (
        echo Could not find a Visual Studio installation.
        exit /b 1
      )
      if not exist "!%vsfound%!vsvars32.bat" (
        echo Your Visual Studio does not have a vsvars32.bat
      )
      call "!%vsfound%!vsvars32.bat" >NUL 2>NUL
      for %%X in (cl.exe) do (set FOUND_COMPILER=%%~$PATH:X)
      if not defined FOUND_COMPILER (
        echo Could not find a Visual Studio installation with a C compiler.
        exit /b 1
      )
    )
  )
  cl /nologo /TC /Fe:%TEMP%%~pnx0.exe %0 >NUL 2>NUL || exit /B %ERRORLEVEL%
)
%TEMP%%~pnx0.exe %*
exit /B
#endif

#include <stdio.h>

int main(int argc, char **argv) {
  printf("Hello world!\n");
  return 0;
}
