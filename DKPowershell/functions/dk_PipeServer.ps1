if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_pipeServer_ps1){ $dk_pipeServer_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_pipeServer()
#
#
function GLOBAL:dk_pipeServer() {
	dk_debugFunc 0;
	
	$pipeName = "TestPipe"
	while ($true) {
		$pipeServer = New-Object System.IO.Pipes.NamedPipeServerStream($pipeName)
		try {
			while ($true) {
				"Waiting for connection on '$pipeName'"
				$pipeServer.WaitForConnection()
				"Connection established"
				
				$pipeReader = New-Object System.IO.StreamReader($pipeServer)
				$pipeWriter = New-Object System.IO.StreamWriter($pipeServer)
				$pipeWriter.AutoFlush = $true
				
				"Connected to $pipeName $userName"
				$pipeWriter.WriteLine("Connected");
				#$userName = $pipeReader.ReadLine()
				
				
				while ($pipeServer.isConnected) {
					$msg = $pipeReader.ReadLine()
					if($msg -eq 'exit'){ 
						$pipeWriter.WriteLine("Disconnect");
						break; 
					}
					
					"Client: $msg"
					#if($pipeServer.isConnected){
						$pipeWriter.WriteLine("Server: $msg");
					#}
				}	
				
				$pipeServer.Disconnect()
				"Disconnected"
			}
		}
		catch{
			Write-Host "ERROR: $_"
		}
		finally {
			$pipeServer.Dispose()
		}
	}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_pipeServer;
}