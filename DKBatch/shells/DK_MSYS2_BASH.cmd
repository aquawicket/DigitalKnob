@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" set "DKBATCH_FUNCTIONS_DIR_=%CD%\..\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
:: git-sh-bash environment
::
:: ###### PATH ######
:: C:\Users\Administrator\digitalknob\DKTools\git-portable-2.46.2-64-bit\bin
::
:: ###### EXECUTABLES ######
:: bash.exe
:: git.exe
:: sh.exe
::
%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
%dk_call% dk_validate MSYS2 "%dk_call% %DKIMPORTS_DIR%\msys2\dk_install.cmd"


%dk_call% dk_assertPath MSYS2
set "PATH=%MSYS2%\usr\bin;%PATH%"

%dk_call% dk_commandToVariable "%MSYS2%\bash.exe --version" BASH_VERSION
%dk_call% dk_info "############ DK_MSYS2_BASH: msys2-bash environment ############"
%dk_call% dk_info "##"
%dk_call% dk_info "##   %BASH_VERSION%"
%dk_call% dk_info "##   PATH = %MSYS2%"
%dk_call% dk_info "##"
"%MSYS2%\bash.exe"