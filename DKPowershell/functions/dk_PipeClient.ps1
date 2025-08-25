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
			$send = Read-Host "`:> "
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