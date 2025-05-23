@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


%dk_call% dk_validate DK3RDPARTY_DIR     	"%dk_call% dk_DK3RDPARTY_DIR"
%dk_call% dk_validate DKTOOLS_DIR        	"%dk_call% dk_DKTOOLS_DIR"
%dk_call% dk_validate COSMO_C_COMPILER   	"call %DK3RDPARTY_DIR%\_DKIMPORTS\cosmocc\DKINSTALL.cmd"
%dk_call% dk_validate COSMO_CXX_COMPILER 	"call %DK3RDPARTY_DIR%\_DKIMPORTS\cosmocc\DKINSTALL.cmd"

@RD /S /Q "build"

set "BASH_EXE=%DK3RDPARTY_DIR:/=\%\msys2-x86_64-20240727\usr\bin\bash.exe"
set "CMAKE_EXE=%DKTOOLS_DIR:\=/%/cmake-3.29.5-windows-x86_64/bin/cmake"
set "CMAKE_TOOLCHAIN_FILE=%DK3RDPARTY_DIR:\=/%/_DKIMPORTS/cosmocc/cosmo_toolchain.cmake"
set "CMAKE_SOURCE_DIR=%DKSCRIPT_DIR:\=/%"
set "CMAKE_BINARY_DIR=%DKSCRIPT_DIR:\=/%/build"


::###### Configure helloWorld ######
%BASH_EXE% -c "%CMAKE_EXE% -G ""MSYS Makefiles"" -DCMAKE_TOOLCHAIN_FILE=%CMAKE_TOOLCHAIN_FILE% -B%CMAKE_BINARY_DIR% -S%CMAKE_SOURCE_DIR%"


::###### Build helloWorld ######
%BASH_EXE% -c "%CMAKE_EXE% --build %CMAKE_BINARY_DIR% --verbose"


::###### Execute helloWorld ######
echo:
echo:
%DKSCRIPT_DIR%\build\helloWorld.com
 
pause