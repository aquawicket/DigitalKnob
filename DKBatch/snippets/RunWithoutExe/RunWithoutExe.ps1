# https://stackoverflow.com/questions/77075489/powershell-run-executable-without-extension
# Define a function which executes any file
function RunWithoutExe ($filePath) {
	Write-Host "RunWithoutExe(${filePath})";
	
	$processStartInfo = New-Object System.Diagnostics.ProcessStartInfo;
	$processStartInfo.FileName = $filePath;
	#$processStartInfo.RedirectStandardInput = $ture;
	#$processStartInfo.RedirectStandardError = $true;
	#$processStartInfo.RedirectStandardOutput = $true;
	$processStartInfo.UseShellExecute = $false;
	$processStartInfo.Arguments = "";
	
	$process = New-Object System.Diagnostics.Process;
	$process.StartInfo = $processStartInfo;
	$process.Start() | Out-Null;
	#Do Other Stuff Here....
	$process.WaitForExit();
	return $process.ExitCode;
}


### HelloWorld1.exe ###
Write-Host "### HelloWorld.exe ###";
Write-Host "";
RunWithoutExe "$(get-location)/HelloWorld.exe";

### HelloWorld.foo ###
Write-Host "### HelloWorld.foo ###";
Write-Host "";
RunWithoutExe "$(get-location)/HelloWorld.foo";

### HelloWorld.txt ###
Write-Host "### HelloWorld.txt ###";
Write-Host "";
RunWithoutExe "$(get-location)/HelloWorld.txt";

### HelloWorld ###
Write-Host "### HelloWorld ###";
Write-Host "";
RunWithoutExe "$(get-location)/HelloWorld";


Read-Host;