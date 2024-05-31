@echo off

echo 0 = %~0
echo * = %*

@if not "%*" == "" (goto:run_cmake_file)
echo Associating .cmake files with DKCmake_Batch_Wrapper . . .
@FTYPE dk_cmake=cmd /c call "%~0" "%%1" %*
@assoc .cmake=dk_cmake
@pause
@exit
:run_cmake_file




set "DIGITALKNOB_DIR=C:\Users\aquawicket\digitalknob"
set "DKTOOLS_DIR=%DIGITALKNOB_DIR%\DKTools"
set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\Development"
set "DKCMAKE_DIR=%DKBRANCH_DIR%\DKCMake"
set "CMAKE_EXE=C:\Users\aquawicket\digitalknob\DKTools\cmake_3_29_0_windows_x86_64\bin\cmake.exe"

cd %DKCMAKE_DIR%\functions
%CMAKE_EXE% -P %1

pause