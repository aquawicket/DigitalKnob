<!-- :
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


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
