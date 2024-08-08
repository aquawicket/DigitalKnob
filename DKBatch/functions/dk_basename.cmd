@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_basename(path rtn_var)
::#
::#    https://en.wikipedia.org/wiki/Basename
::#
:dk_basename
	call dk_debugFunc 2
	
	setlocal
	set "_input_=%1"
	set "_input_=%_input_:"=%"
	if [%_input_:~-1,1%] == [\] set "_input=%_input_:~0,-1%"
	if [%_input_:~-1,1%] == [/] set "_input=%_input_:~0,-1%"
	endlocal & for %%Z in ("%_input_%") do set "%2=%%~nxZ"
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_set myPath "C:\Windows\System32\test.v123.zip" 
	call dk_basename "%myPath%" basename
	call dk_printVar basename
	
	call dk_set myPathB "TEST" 
	call dk_basename "%myPathB%" basenameB
	call dk_printVar basenameB
	
	set "myPathC=https://ia802200.us.archive.org/22/items/windows-7-pesuper-lite-50-mb/Windows7PESuper%20Lite50MB.iso"
	call dk_basename "%myPathC%" basenameC
	call dk_printVar basenameC
goto:eof
