@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::: prepareLineNumbers() ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
>nul 2>nul (
	call ../3rdParty/jrepl "(\x25#=\x25)\d*(\x25=#\x25)" "$1+ln+$2" /j /f "%~f1" /o "%~f1.new"
	fc /b "%~f1" "%~f1.new" && del "%~f1.new" || move /y "%~f1.new" "%~f1"
)