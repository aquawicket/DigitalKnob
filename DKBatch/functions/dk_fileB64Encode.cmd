@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0


::##################################################################################
::# dk_fileB64Encode(inputFile)
::# dk_fileB64Encode(inputFile, outputFile)
::#
::#    Encode input to base-64 output
::#    https://github.com/base64code/examples
::#
:dk_fileB64Encode
 setlocal
    call dk_debugFunc 1 2
    
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
 setlocal
    call dk_debugFunc 0
    
    ::%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_validateBranch"
    ::set "input=%DKBRANCH_DIR%\DKBuilder.cmd"
    ::set "output=%DKBRANCH_DIR%\DKBuilder.cmd.b64"
    
    %dk_call% dk_selectFile input
    %dk_call% dk_fileB64Encode "%input%"
    ::%dk_call% dk_fileB64Encode "%input%" "test.b64"
%endfunction%
