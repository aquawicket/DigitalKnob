@echo off
:dk_call2_FUNC
	setlocal enableDelayedExpansion
	echo.
	echo %ESC%[35m:dk_call2_FUNC^> '%*'%ESC%[39m
	%* && (
		echo %ESC%[32mOK%ESC%[39m
		echo.
	) || (
		echo %ESC%[31mERROR:!errorlevel! @ %~nx0 ^>%*
		echo.
	)
:dk_call2_FUNC_END
exit /b