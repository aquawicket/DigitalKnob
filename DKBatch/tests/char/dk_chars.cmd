@echo Off
::### https://ss64.com/nt/syntax-genchr.html

:main
::setlocal enableDelayedExpansion
	if not defined char37 (
		call :dk_chars
	)
	
	for /l %%N in (0 1 255) do (
		if %%N equ 27 (
			echo char%%N = ESC
		) else (
			call echo char%%N = %%char%%N%%
		)
	)
	

	echo %char27%[92m green %char27%[0m
	pause
exit /b 0


:dk_chars
setlocal enableDelayedExpansion

	rem Set codepage to 437
	for /f "tokens=*" %%a in ('chcp') do for %%b in (%%a) do set "cp=%%~nb"
	mode con cp select=437 >nul

	:CreateFile
		if exist 1_255.chr (goto:End_CreateFile)
		echo generateChars_CreateFile
		type nul >"t.tmp"
		set "bytes= "
		for /l %%N in (1 1 255) do (
			makecab /d compress=off /d reserveperfoldersize=%%N /d reserveperdatablocksize=0 "t.tmp" "t1.tmp" >nul
			type "t1.tmp" | ((for /l %%N in (1 1 38) do pause)>nul&findstr "^">"t2.tmp")
			<t2.tmp set /p "char%%N="
			set "bytes=!bytes!!char%%N!"
		)
		mode con cp select=%cp% >nul
		del "t.tmp" "t1.tmp" "t2.tmp"
		
		set "prompt= "
		if "!prompt!" neq "" (
			cmd /d /k < nul> 1_255.chr
		)
		<nul set /p "=!bytes:~1!" >>1_255.chr
	:End_CreateFile
	
	:LoadCharVars
		if defined char254 (goto:End_LoadCharVars)
		echo generateChars_LoadCharVars
		<1_255.chr set /p "chars="
		for /l %%N in (0 1 255) do (
			set char%%N=!chars:~%%N,1!
		)
	:End_LoadCharVars
	
	:PropagateChars
		echo generateChars_PropagateChars
		set "_SCOPE_=%~n0"
		for /F "delims=" %%a in ('set char') do (
			if "%_SCOPE_%" equ "%~n0" endlocal
			set "%%a"
		)
	:End_PropagateChars	
	
	:PrintChars
		for /l %%N in (0 1 255) do (
			if %%N equ 27 (
				echo char%%N = ESC
			) else (
				call echo char%%N = %%char%%N%%
			)
		)
	:End_PrintChars
exit /b 0

