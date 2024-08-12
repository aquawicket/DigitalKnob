@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_downloadDK()
::#
::#
:dk_downloadDK
	call dk_debugFunc 0
	
	%dk_call% dk_download "https://github.com/aquawicket/DigitalKnob/archive/refs/heads/Development.zip"
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_downloadDK
goto:eof
