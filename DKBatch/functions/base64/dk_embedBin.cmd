@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" set "DKBATCH_FUNCTIONS_DIR_=..\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::##################################################################################
::# base64::dk_embedBin(inputFile)
::# base64::dk_embedBin(inputFile, outputFile)
::#
::#    https://stackoverflow.com/a/19596027/688352
::#
:dk_embedBin
    call dk_debugFunc 1 2
 setlocal
	
    set "inputFile=%~1"
	set "inputFilename=%~nx1"
	set "outputFile=%~nx1.cmd"
    if %__ARGC__% equ 2 set "outputFile=%~2"
    
    if not exist "%inputFile%" %dk_call% dk_error "%inputFile% not found"
	if exist "%outputFile%" del %outputFile%
    :: if exist "%outputFile%" %dk_call% dk_error "%outputFile% already exists and cannot be overwritten"
    
	set "tempCmd=%inputFile%.tmp"
	(
	echo ;;;===,,,@echo off
	echo ;;;===,,,echo decoding . . .
	echo ;;;===,,,findstr /v "^;;;===,,," "%%~f0" ^> %inputFilename%
	echo ;;;===,,,%inputFilename%
	echo ;;;===,,,exit /b

	) >"%tempCmd%"
	
    copy /a %tempCmd% + /b %inputFile% /b %outputFile%
	del %tempCmd%
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    ::%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    ::set "input=%DKBRANCH_DIR%\DKBuilder.cmd"
    ::set "output=%DKBRANCH_DIR%\DKBuilder.cmd.b64"
	
    %dk_call% dk_selectFile input
    %dk_call% dk_embedBin "%input%"
	
    ::%dk_call% base64::dk_encode "%input%" "test.b64"
%endfunction%
