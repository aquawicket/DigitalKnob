@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=../")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::##################################################################################
::# Base64::dk_decode(inputFile)
::# Base64::dk_decode(inputFile, outputFile)
::#
::#    Decode base-64 input to output
::#    https://github.com/base64code/examples
::#
:dk_decode
setlocal
	%dk_call% dk_debugFunc 1 2
	
    set "inputFile=%~1"
    %dk_call% dk_removeExtension %inputFile% outputFile
    %dk_call% dk_printVar outputFile
    if "%~2" neq "" set "outputFile=%~2"
    %dk_call% dk_printVar outputFile
    
    if not exist "%inputFile%" %dk_call% dk_error "%inputFile% not found"
    if exist "%outputFile%" %dk_call% dk_error "%outputFile% already exists and cannot be overwritten"
    
    certutil -decode "%inputFile:/=\%" "%outputFile:/=\%"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
    
    %dk_call% dk_selectFile
    %dk_call% Base64::dk_decode "%dk_selectFile%"

%endfunction%
