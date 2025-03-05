@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=../../functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

:prepairVariable
	::echo prepairVariable IN '!%~1!'
	set "temp=!%~1!"
	::set "temp=!temp:%=%%!"
	set "temp=!temp:^^=^!"
	::set "temp=!temp:&=^&!"
	::set "temp=!temp:|=^|!"
	::set "temp=!temp:<=^<!"
	::set "temp=!temp:>=^>!"
	::set "temp=!temp:"=""!"
	::set "temp=!temp:"=!"
	::set "temp=!temp:"=^^"!"
	set "%~1=!temp!"
	::echo prepairVariable OUT '!%~1!'
%endfunction%