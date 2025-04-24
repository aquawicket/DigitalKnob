@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
set "CYGWIN=%DK3RDPARTY_DIR%\cygwin-setup-x86_64"

%dk_call% dk_validate DKIMPORT_DIR "%dk_call% dk_DKIMPORT_DIR"

::/cygdrive/c/Users/Administrator/digitalknob/Development/3rdParty/_DKIMPORTS/cygwin/crosstool-ng-build.sh
set "CROSSTOOL_NG_BUILD_SH=%DKIMPORT_DIR%/cygwin/crosstool-ng-build.sh")
set "CROSSTOOL_NG_BUILD_SH=%CROSSTOOL_NG_BUILD_SH:C:\=/cygdrive/c/%")
%CYGWIN%\bin\bash.exe --login -c '%CROSSTOOL_NG_BUILD_SH:\=/%'