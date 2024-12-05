@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" set "DKBATCH_FUNCTIONS_DIR_=..\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::##################################################################################
::# base64\dk_encode(inputFile)
::# base64\dk_encode(inputFile, outputFile)
::#
::#    Encode input to base-64 output
::#    https://github.com/base64code/examples
::#
:dk_encode
    call dk_debugFunc 1 2
 setlocal
 
    set "inputFile=%~1"
    set "outputFile=%inputFile%.b64"
    if %__ARGC__% equ 2 set "outputFile=%~2"
    
    if not exist "%inputFile%" %dk_call% dk_error "%inputFile% not found"
    if exist "%outputFile%" %dk_call% dk_error "%outputFile% already exists and cannot be overwritten"
    
    certutil -encode -f "%inputFile%" "%outputFile%.tmp" 1>nul
    type "%outputFile%.tmp"|find /v "CERTIFICATE-----">"%outputFile%"
    del "%outputFile%.tmp"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    ::%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    ::set "input=%DKBRANCH_DIR%\DKBuilder.cmd"
    ::set "output=%DKBRANCH_DIR%\DKBuilder.cmd.b64"
    
    %dk_call% dk_selectFile input
    %dk_call% base64\dk_encode "%input%"
    ::%dk_call% base64\dk_encode "%input%" "test.b64"
%endfunction%
