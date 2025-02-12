@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\")
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

%dk_call% dk_validate DK3RDPARTY_DIR     "%dk_call% dk_DK3RDPARTY_DIR"
%dk_call% dk_validate DKTOOLS_DIR        "%dk_call% dk_DKTOOLS_DIR"
%dk_call% dk_validate COSMO_C_COMPILER   "call %DK3RDPARTY_DIR%\_DKIMPORTS\cosmocc\dk_install.cmd"
%dk_call% dk_validate COSMO_CXX_COMPILER "call %DK3RDPARTY_DIR%\_DKIMPORTS\cosmocc\dk_install.cmd"

@RD /S /Q "build"

set "PATH=%DK3RDPARTY_DIR%\msys2-x86_64-20240727\usr\bin;%PATH%"
set "BASH_EXE=%DK3RDPARTY_DIR%\msys2-x86_64-20240727\usr\bin\bash.exe"
%dk_call% dk_replaceAll "%DKTOOLS_DIR%\cmake-3.29.5-windows-x86_64\bin\cmake"          "\" "/" CMAKE_EXE
%dk_call% dk_replaceAll "%DK3RDPARTY_DIR%\_DKIMPORTS\cosmocc\cosmo_toolchain.cmake"    "\" "/" CMAKE_TOOLCHAIN_FILE
%dk_call% dk_replaceAll "%DKSCRIPT_DIR%\build"                                         "\" "/" CMAKE_BINARY_DIR
%dk_call% dk_replaceAll "%DKSCRIPT_DIR%"                                               "\" "/" CMAKE_SOURCE_DIR

::###### Configure helloWorld ######
%BASH_EXE% -c "%CMAKE_EXE% -G ""MSYS Makefiles"" -DCMAKE_TOOLCHAIN_FILE=%CMAKE_TOOLCHAIN_FILE% -B%CMAKE_BINARY_DIR% -S%CMAKE_SOURCE_DIR%" --debug-trycompile


::###### Build helloWorld ######
%BASH_EXE% -c "%CMAKE_EXE% --build %CMAKE_BINARY_DIR% --verbose"


::###### Execute helloWorld ######
echo:
echo:
%DKSCRIPT_DIR%\build\helloWorld.com
 
pause