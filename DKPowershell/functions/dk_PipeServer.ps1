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
			
			$userName = $pipeReader.ReadLine()
			"Connected to $pipeName $userName"
			
			while ($pipeServer.isConnected) {
				$msg = $pipeReader.ReadLine()
				if($msg -eq 'exit'){ 
					$pipeWriter.WriteLine("Disconnect");
					break; 
				}
				
				"Client: $msg"
				if($pipeServer.isConnected){
					$pipeWriter.WriteLine("Server: $msg");
				}
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