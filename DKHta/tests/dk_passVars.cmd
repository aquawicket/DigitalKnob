<!-- :
@echo off
@setlocal enableExtensions enableDelayedExpansion

::######## Pass batch variable into HTA
set "fromBatch=a b c"
for /f "tokens=* delims=" %%a in ('echo %%fromBatch%%^|mshta.exe "%~f0"') do (
    ::########## Pass Hta variable back to Batch 
	set fromHta=%%a 
)

echo The variable passed back from hta is '!fromHta!'

endlocal
pause
exit /b



<html>
<head><title>Vairiable transfer</title>
<HTA:APPLICATION>
</head>
	<body>
		
		<!--######### Pass batch variable to HTA ########################################-->
		<p>The variable send from batch is '{fromBatch}'</p>	
		<script language='javascript'>
			window.resizeTo(400,200);
			var input = new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(0);
			var line=input.ReadLine();
			document.body.innerHTML = document.body.innerHTML.replace('{fromBatch}', line);
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
