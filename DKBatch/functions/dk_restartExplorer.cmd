@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::#####################################################################
::# dk_restartExplorer()
::#
::#   Something strange happend when this file is run.  Windows Exploerer will reload.
::#   And you close any open cmd processes.   But something stays residual, because any
::#	  dk scri[t ran after will invoke this again. I believe this ocours because after
::#   a script header runs DK.cmd, it continues after DK.cmd's execution completes.
::#   And since explorer has been restarted, it may be holding variables withing the
::#   new instance. Further investigation is required. 
::#
:dk_restartExplorer
setlocal
	%dk_call% dk_debugFunc 0

	::taskkill /im explorer.exe /f
	%dk_call% dk_killProcess explorer.exe
	
	::note: the /i switch will refresh the environment as well
	start /i explorer.exe
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_restartExplorer
%endfunction%
