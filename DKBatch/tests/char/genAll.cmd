@echo Off
::### https://ss64.com/nt/syntax-genchr.html

:genAll
	setlocal enableDelayedExpansion

	rem Set codepage to 437
	for /f "tokens=*" %%a in ('chcp') do for %%b in (%%a) do set "cp=%%~nb"
	mode con cp select=437 >nul

	rem Create file 0.chr containing a single null byte (0x00).
	rem A null byte can only be written to a file.
	rem It cannot be read into a variable	
rem  echo generating 0.chr . . .	
::	cmd /u /c set/p"=a"<nul >1_255.chr
::	copy /y 1_255.chr+nul 1_255.chr >nul
::	type 1_255.chr |(pause>nul&findstr "^" >t1.tmp)
::	copy /y t1.tmp /a 0.chr /b >nul

    echo generating 1_255.chr . . .	
	type nul >"t.tmp"
	set "bytes= "
	for /l %%N in (1 1 255) do (
rem		if %%N neq 26 (
			makecab /d compress=off /d reserveperfoldersize=%%N /d reserveperdatablocksize=0 "t.tmp" "t1.tmp" >nul
			type "t1.tmp" | ((for /l %%N in (1 1 38) do pause)>nul&findstr "^">"t2.tmp")
			<t2.tmp set /p "chr%%N="
			set "bytes=!bytes!!chr%%N!"
rem		) else (
rem			cmd /d /c copy /y nul + nul /a t2.tmp /a >nul
rem			<t2.tmp set /p "chr%%N="
rem			set "bytes=!bytes!!chr%%N!"
rem		)
	)
	mode con cp select=%cp% >nul
	del "t.tmp" "t1.tmp" "t2.tmp"

	::### Create 0_255.chr containing all 256 byte codes
	rem copy 0.chr 0_255.chr >nul
	rem <nul set /p "=!bytes:~1!" >>1_255.chr
	
	::### Create 1_255.chr starting with 1 space to account for the unprintable NUL(0) character 
	set "prompt= "
	if "!prompt!" neq "" (
		cmd /d /k < nul> 1_255.chr
	)
	<nul set /p "=!bytes:~1!" >>1_255.chr

exit /b 0

