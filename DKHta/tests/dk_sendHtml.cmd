<!-- :
rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


@setlocal enableExtensions enableDelayedExpansion

::######## Pass batch variable into HTA

::%dk_call% dk_setEx input "<div style='width:100px;height:100px;color:white;background-color:grey;'>test</div>"
::%dk_call% dk_setEx input "alert('success');"
%dk_call% dk_setEx input "window.resizeTo(500,400); document.body.innerHTML = document.body.innerHTML.replace('{DKCONTENT}', 'test');"

echo input = '!input!'
for /f "tokens=* delims=" %%A in ('echo "!input!"^|mshta.exe "%~f0"') do (
	echo %%A
)

pause
exit /b 0



<html>
<head><title>send html</title>
<HTA:APPLICATION>
</head>
	<body>
		<!--### Content ###-->
		{DKCONTENT}
		
		
		<script language='javascript'>
			var input = new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(0);
			//document.body.innerHTML = document.body.innerHTML.replace('{DKCONTENT}', input.ReadLine().slice(1, -1));
			
			//eval(str);
			var fn = Function(input.ReadLine().slice(1, -1));
			fn();
			
		</script>	
	</body>
</html>
