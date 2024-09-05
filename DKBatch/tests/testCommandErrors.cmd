@echo off

:main	
	call call_command :true 
	call call_command :false

	cmd /k
%endfunction%

:call_command <command> <args>
	call %1 && (
	  echo Success
	  (call )
	) || (
	  echo Failed
	)
%endfunction%

:true
	(call )
%endfunction%

:false
	(call)
%endfunction%