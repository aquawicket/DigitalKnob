@echo off

:main	
	call call_command :true 
	call call_command :false

	cmd /k
goto:eof

:call_command <command> <args>
	call %1 && (
	  echo Success
	  (call )
	) || (
	  echo Failed
	)
goto:eof

:true
	(call )
goto:eof

:false
	(call)
goto:eof