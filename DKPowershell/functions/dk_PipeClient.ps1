if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_pipeClient_ps1){ $dk_pipeClient_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_pipeClient()
#
#
function GLOBAL:dk_pipeClient() {
	dk_debugFunc 0;

	$pipeName = "TestPipe"
	while ($true) {
		$pipeClient = new-object System.IO.Pipes.NamedPipeClientStream('.', $pipeName, [System.IO.Pipes.PipeDirection]::InOut)
		$pipeReader = $pipeWriter = $null
		try {
			$userName = Read-Host "Enter a username"
			$pipeClient.Connect()
			"Connected to $pipeName Server"

			$pipeReader = new-object System.IO.StreamReader($pipeClient)
			$pipeWriter = new-object System.IO.StreamWriter($pipeClient)
			$pipeWriter.AutoFlush = $true

			$pipeWriter.WriteLine("$userName")

			while ($pipeClient.isConnected) {
				$send = Read-Host " "
				$pipeWriter.WriteLine($send)
					
				$get = $pipeReader.ReadLine()
				if($get -eq 'Disconnect'){ break; }
				$get
			}
			"Disconnected"
		}
		catch{
			Write-Host "ERROR: $_"
		}
		finally {
			$pipeClient.Dispose()
		}
	}
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_pipeClient;
}