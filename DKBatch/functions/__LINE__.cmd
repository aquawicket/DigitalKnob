@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::############################################################################
::# __LINE__(frame)
::#
:__LINE__
setlocal
    %dk_call% dk_debugFunc

 
    if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
    ::set /a _FRAME_+=1
	::call dk_return "%BATCH_LINENO[%_FRAME_%]%"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    ::prepareLineNumbers
	set "JREPL=%DKBATCH_DIR%\3rdParty\JREPL.BAT"
	if not exist %JREPL% %dk_call% dk_error "__LINE__ requires JREPL.BAT"
    >nul 2>nul (
	  call %JREPL% "(\x25#=\x25)\d*(\x25=#\x25)" "$1+ln+$2" /j /f "%~f0" /o "%~f0.new"
      fc /b "%~f0" "%~f0.new" && del "%~f0.new" || move /y "%~f0.new" "%~f0"
    )

    echo line %#=%32%=#%
    echo line %#=%35%=#%

    for %%G in ( 1 2 3) DO (
       echo Within loop iteration %%G: line %#=%39%=#%
       echo Within loop iteration %%G: line %#=%40%=#%
    )
%endfunction%
