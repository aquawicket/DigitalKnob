<!-- :
@echo off
@setlocal enableExtensions enableDelayedExpansion

(set \n=^
%=DO NOT ALTER THIS=%
)

::######## Pass batch variables into HTA
set "argv1=a b c"
set "argv2=1 2 3"
for /f "tokens=* delims=" %%a in ('echo %%argv1%%^;%%argv2%%^|mshta.exe "%~f0"') do (
    ::########## Pass Hta variable back to Batch
	set fromHta=%%a
)

echo The variable passed back from hta is '%fromHta%'

endlocal
pause
exit /b



<html>
<head><title>Vairiable transfer</title>
<HTA:APPLICATION>
</head>
	<body>
		
		<!--######### Pass batch variable to HTA ########################################-->
		<p>The argv = '{argv}'</p>
		<p>The argc = '{argc}'</p>
		<p>The argv[0] = '{argv[0]}'</p>
		<p>The argv[1] = '{argv[1]}'</p>
		<script language='javascript'>
			window.resizeTo(400,200);
			var input = new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(0);
			var argv=input.ReadLine();
			var argv=argv.split(";");
			var argc=argv.length;
			document.body.innerHTML = document.body.innerHTML.replace('{argv}', argv);
			document.body.innerHTML = document.body.innerHTML.replace('{argc}', argc);
			document.body.innerHTML = document.body.innerHTML.replace('{argv[0]}', argv[0]);
			document.body.innerHTML = document.body.innerHTML.replace('{argv[1]}', argv[1]);
		</script>	
		<!--#############################################################################-->
		
		
		<!--########## Pass Hta variable to Batch ########################################-->
		<script language='javascript' >
			function sendVar(){
				var fromHta=document.getElementById('fromHta').value;
				var fso= new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1);
				close(fso.Write(fromHta));
			}
		</script>
		<!--##############################################################################-->
		
		<input name='fromHta' size='16'></input>
		<button onclick='sendVar()'>Submit</button>
	</body>
</html>
