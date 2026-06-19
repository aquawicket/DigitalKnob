@echo off

:main
	call :firstNbytes "C:\Users\Administrator\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" "1"
	call :firstNbytes "C:\Users\Administrator\Digital Knob\DKTools\git-portable-2.46.2-64-bit\git-cmd.exe" "2727"
	call :firstNbytes "%SystemRoot%\System32\cleanmgr.exe" "3"
	pause
exit /b 0


:firstNbytes
	setlocal enableDelayedExpansion
	set "_file_=%~1"
	set "_byte_count_=%~2"
	
	REM OpenTextFile opens any file as a binary stream; f.read(n) reads the first n bytes of that stream
rem	echo Set fso=CreateObject("Scripting.FileSystemObject") > some.vbs
rem	echo Set f=fso.OpenTextFile("%file%"):buf=f.Read(16):f.Close >> some.vbs
rem	echo WScript.echo Hex(ASCb(mid(buf,1,1))) ^& "," ^& Hex(ASCb(mid(buf,2,1))) ^& "," ^& Hex(ASCb(mid(buf,3,1))) >> some.vbs
rem	for /f "tokens=1-20 delims=," %%A in ('cscript //nologo some.vbs') do (
rem	   set bytes=0%%A 0%%B 0%%C 0%%D 0%%E 0%%F 0%%G 0%%H 0%%I 0%%J 0%%K 0%%L 0%%M 0%%N 0%%O 0%%P
rem	)
rem	echo %bytes%
	
	>"%~dpn0.js" (
		echo.var argc = WScript.Arguments.length;
		echo.var argv = [];
		echo.for ^(var i = 0; i^<argc; i++^){ argv.push^(WScript.Arguments.Item^(i^)^); }
		echo.
		echo.var _file_ = argv[0];
		echo.var _byte_count_ = argv[1];
		echo.
		echo.String.prototype.hexEncode = function hexEncode^(^){
		echo.	var hex, i;
		echo.	var result = "";
		echo.	for ^(i=0; i^<this.length; i++^) {
		echo.		hex = this.charCodeAt^(i^).toString^(16^);
		echo.		result += ^("0"+hex.toUpperCase^(^)^).slice^(-2^)+",";
		echo.	}
		echo.	return result;
		echo.}
		echo. 
		echo.var fso = new ActiveXObject^('Scripting.FileSystemObject'^);
		echo.var f=fso.OpenTextFile^(_file_, 1, false^);
		echo.buf=f.Read^(_byte_count_^);
		rem echo.f.Close();
		echo.WScript.echo^(buf.hexEncode^(^)^);
	)
	set /a i=0
	for /f %%A in ('cscript.exe /nologo /e:javascript "%~dpn0.js" "%_file_:\=/%" %_byte_count_%') do (
		set "bytes=%%A"
		for %%Z in (%%A) do (
			echo !i! = %%Z
			set /a i+=1
		)
	)
	
	echo %bytes:,= %

pause
	
exit /b 0