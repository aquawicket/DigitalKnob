<!-- :
@echo off
@setlocal enableextensions enabledelayedexpansion

::######## Pass batch variable into HTA
set "fromBatch=Value from Batch"
for /f "tokens=* delims=" %%a in ('echo %%fromBatch%%^|mshta.exe "%~f0"') do (
    ::########## Pass Hta variable back to Batch 
	set fromHta=%%a 
)

echo The variable passed back from hta is "!fromHta!"

endlocal
pause
exit /b


<html>
<head><title>Vairiable transfer</title>
<HTA:APPLICATION>
</head>
	<body>
		
		<!--######### Pass batch variable into HTA ######################################-->
		<p>The variable pass in from batch is '{fromBatch}'</p>	
		<script language='javascript'>
			window.resizeTo(400,200);
			var input= new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(0);
			var line=input.ReadLine();
			document.body.innerHTML = document.body.innerHTML.replace('{fromBatch}', line);
		</script>	
		<!--#############################################################################-->
		
		
		<!--########## Pass Hta variable back to Batch ###################################-->
		<script language='javascript' >
			function pipePass(){
				var fromHta=document.getElementById('fromHta').value;
				var fso= new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1);
				close(fso.Write(fromHta));
			}
		</script>
		<!--##############################################################################-->
		
		<input name='fromHta' size='16'></input>
		<button onclick='pipePass()'>Submit</button>
	</body>
</html>
