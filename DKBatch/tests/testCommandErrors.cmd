@echo off

call :main

:true
	(call )
%endfunction%

:false
	(call)
%endfunction%

:call_command <command> <args>
	call :%~1 && (
	  echo Success
	  (call )
	) || (
	  echo Failed
	)
%endfunction%

:main	
	call call_command :true 
	call call_command :false

	%COMSPEC% /k
%endfunction%