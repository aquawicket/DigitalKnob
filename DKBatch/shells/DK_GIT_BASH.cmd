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
%dk_call% dk_validate GIT "%dk_call% dk_installGit"
%dk_call% dk_assertPath GIT
set "PATH=%GIT%\bin;%PATH%"

%dk_call% dk_commandToVariable "%GIT%\bin\bash.exe --version" BASH_VERSION
%dk_call% dk_info "############ DK_GIT_BASH: git-bash environment ############"
%dk_call% dk_info "##"
%dk_call% dk_info "##   %BASH_VERSION%"
%dk_call% dk_info "##   PATH = %GIT%\bin"
%dk_call% dk_info "##"
"%GIT%\bin\bash.exe"