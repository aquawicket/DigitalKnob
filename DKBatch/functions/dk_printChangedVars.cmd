@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::################################################################################
::# dk_printChangedVars()
::#
::#    https://stackoverflow.com/a/41872317/688352
::#
:dk_printChangedVars
    call dk_debugFunc 0
 setlocal
	
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	
	if not exist %DKCACHE_DIR%\vars.tmp (
		set > %DKCACHE_DIR%\vars.tmp
	)
	
	echo:
	echo ################## Variable Changes ##################

	for /f "delims= eol==" %%c in ('set') do (
		for /f "delims==" %%A in ("%%c") do set "cname=%%A"
		set "%%same="
		set "%%bothExist="
		set "%%deleted="
		set "%%new="
		
		for /f "usebackq delims= eol==" %%o in ("%DKCACHE_DIR%\vars.tmp") do (	
			for /f "delims==" %%A in ("%%o") do set "oname=%%A"
		
			if "%%c"=="%%o" (
				set "%%same=1"
			) 
		
			if "!cname!"=="!oname!" (
				set "%%bothExist=1"
			) 
				
			if not defined !oname! (
				set "%%deleted=1"
			)
			
		)
		
		if not defined %%bothExist    set "%%new=1"

		rem echo !cname!  same:!%%same!    bothExist:!%%bothExist!    deleted:!%%deleted!      new:!%%new!
		
		rem ### NEW ###
		if defined %%new                              echo      NEW: %%c
		if not defined %%same if defined %%bothExist  echo MODIFIED: %%c
		if defined %%deleted                          echo  DELETED: %%c
		rem ### MODIFIED ###
		
		rem ### DELETED ###
		
		set "%%same="
		set "%%bothExist="
		set "%%deleted="
		set "%%new="
	)

	set "%%same="
	set "%%bothExist="
	set "%%deleted="
	set "%%new="
	set > %DKCACHE_DIR%\vars.tmp
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_delete "%DKCACHE_DIR%\vars.tmp"
	%dk_call% dk_printChangedVars
	
	set "TestVar=abc"
	%dk_call% dk_printChangedVars
	
	
	set "TestVar="
	%dk_call% dk_printChangedVars
	
%endfunction%
