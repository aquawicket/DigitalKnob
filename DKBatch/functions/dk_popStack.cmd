::call dk_includeGuard

::################################################################################
::# dk_popStack()
::#
::#
:dk_popStack
(
    (goto) 2>nul
	(goto) 2>nul 
    setlocal DisableDelayedExpansion  
	echo ~0 = %~0 
	echo * = %* 
    call set "caller=%%~0"
	echo caller = %caller%
	call set "args=%%*"
	echo args = %args%
    call set _caller=%%caller:~0,1%%
	echo _caller = %_caller%
    call set _caller=%%_caller::=%%
	echo _caller = %_caller%

	echo line56 & pause
    ::goto :dk_popStack || echo popstack call failed
	../functions/dk_popStack
)
echo NEVER REACHED
goto:eof