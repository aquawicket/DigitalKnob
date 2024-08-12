@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_arrayToSpliced(array, start, deleteCount, item1, item2, /* …, */ itemN)
::#
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_tospliced
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/toSpliced
::#
:dk_arrayToSpliced
	call dk_debugFunc 2
	
	%dk_call% dk_todo "dk_arrayToSpliced"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_todo
goto:eof
