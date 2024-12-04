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

%dk_call% dk_commandToVariable "%GIT_EXE% --version" GIT_VERSION
%dk_call% dk_echo "############ DK_GIT: git environment ############"
%dk_call% dk_echo "##"
%dk_call% dk_echo "##    %GIT_VERSION%"
              echo ##    Run:  git ^<args^>
%dk_call% dk_echo "##"