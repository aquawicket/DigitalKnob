call dk_includeGuard

::################################################################################
::# dk_printStack()
::#
::#
:dk_printStack () {
	call dk_debugFunc
	
	echo DKSTACK_length = %DKSTACK_length%
	set /a frame=0
	
	:dk_printStack_Loop
	if defined DKSTACK[%frame%].FILE ( 
		call set "stack_line= %%DKSTACK[%frame%].FILE%%"
		call set "stack_line= %%stack_line%%,    %%DKSTACK[%frame%].FUNCTION%%"
		call set "stack_line= %%stack_line%%,    %%DKSTACK[%frame%].ARGS%%"
		call dk_echo %clr% %%%stack_line%%
	
        set /a frame+=1
        GOTO :dk_printStack_Loop 
    )
	echo done
	
goto:eof