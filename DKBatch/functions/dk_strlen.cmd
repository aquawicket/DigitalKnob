@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"


::####################################################################
::# dk_strlen(string_var rtn_var)
::#
::#
:dk_strlen
	call dk_debugFunc 2
	
	setlocal
	set "s=#!%~1!"
	set "len=0"
	for %%N in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
		if "!s:~%%N,1!" neq "" (
			set /a "len+=%%N"
			set "s=!s:~%%N!"
		)
	)
	endlocal & set "%2=%len%"
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_set _demo "some example string"
	call dk_strlen _demo _length
	call dk_info "String is %_length% characters long"
goto:eof
