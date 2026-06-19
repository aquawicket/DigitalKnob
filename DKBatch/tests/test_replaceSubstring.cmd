rem  https://stackoverflow.com/a/13222794/688352
rem  https://stackoverflow.com/a/39141462/688352
@echo off


:main
	
	set "inputA=1234567890"
	set "replaceA=12345"
	set "withA=00000"
	echo inputA = %inputA%
	call:replace_substring %inputA% %replaceA% %withA% outputA
	echo outputA = %outputA%
	
	set "variableB=red white blue"
	set "replaceB=blue"
	set "withB=purple"
	echo variableB = %variableB%
	call:replace_in_variable variableB %replaceB% %withB%
	echo variableB = %variableB%

	pause
%endfunction%





:replace_substring <input> <replace> <with> rtn_var
   set "input_string=%1"
   call set "%4=%%input_string:%2=%3%%"
  
   rem set "replace=%2"
   rem call set "%4=%%input:%replace%=%with%%%"
  
   rem set "with=%3"
   rem call set "%4=%%input:%2=%with%%%"
  
   rem set "output=%4"
   rem call set "output=%%input:%replace%=%with%%%"
%endfunction%

:replace_in_variable <variable> <replace> <with>
   set "var_name=%~1"
   call set "__variable__=%%%var_name%%%"
   call set "%1=%%__variable__:%2=%3%%"
%endfunction%