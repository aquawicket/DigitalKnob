:: https://stackoverflow.com/a/43184105

:test_forCall
	if defined __callTest__ (
		set "startMethod=%__callTest__%" 
		set "__callTest__=" 
		goto test_forceCallB
	)
	
	set _f0=%~f0
	
	(
		2>nul (goto)
		call set "__callTest__=%%{[%random%""%random%]}%%"
		if defined __callTest__ (
			set "__callTest__=direct"
			"%_f0%" %*
		) else (
			set "__callTest__=call"
			call "%_f0%" %*
		)
	)
%endfunction%


:test_forceCallB
	echo test_forceCallB
    echo Method invocation is [ %startMethod% ]
%endfunction%
