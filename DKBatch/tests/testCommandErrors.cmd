@echo off

<<<<<<< HEAD
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
=======
call :main
>>>>>>> Development

:true
	(call )
%endfunction%

:false
	(call)
<<<<<<< HEAD
=======
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

	%ComSpec% /k
>>>>>>> Development
%endfunction%