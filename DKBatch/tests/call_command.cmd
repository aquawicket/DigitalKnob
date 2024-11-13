:call_command <command> <args>
	call %1 && (
	  echo %1 Success
	  (call )
	) || (
	  echo %1 Failed
	)	
%endfunction%