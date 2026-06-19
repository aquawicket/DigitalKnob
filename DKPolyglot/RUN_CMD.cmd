@echo off 


cmd < "DKPolyglot" >nul
rem call :dk_callFileLabel DKPolyglot :main
pause





:dk_callFileLabel
setlocal enableDelayedExpansion

	set "_file_=%~1"
	set "_name_=%~n1"
	set "_label_=%~2"
	set "_label_=:%_label_::=%"
	
	::echo %_file_% %_label_%
	
	set "dk_callFileLabel_TEMP=%_name_%_%_label_::=%.cmd"

	>"%dk_callFileLabel_TEMP%" (
		echo.@echo off 
		echo.
		echo.call %_label_%
		echo.exit /b %%errorlevel%%
		echo.
		echo.%_label_%
		rem echo.setlocal enableDelayedExpansion
		echo.
		echo.	%_file_:/=\%
		echo.
		echo.%%endfunction%%
		echo.
	)
	
	call "%dk_callFileLabel_TEMP:/=\%"
	del "%dk_callFileLabel_TEMP:/=\%"
%endfunction%