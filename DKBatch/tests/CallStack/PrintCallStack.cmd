@echo off

:PrintCallStack
	echo:
	echo ############ CALLSTACK ############
	for /l %%x in (1, 1, 100) do (
		(set /a num=100-%%x)
		if defined STACK_!num! (
			call echo !num!: %%STACK_!num!%%
		)
	)
	echo:
exit /b 0