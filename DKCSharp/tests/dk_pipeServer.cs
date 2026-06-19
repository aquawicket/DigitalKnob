static void Main(string[] args)
{
	var namedPipeServer = new NamedPipeServerStream("TestPipe", PipeDirection.InOut, 1, PipeTransmissionMode.Byte);
	var streamReader = new StreamReader(namedPipeServer);
	namedPipeServer.WaitForConnection();

	var writer = new StreamWriter(namedPipeServer);
	writer.Write("Hello from c#");
	writer.Write((char)0);
	writer.Flush();
	namedPipeServer.WaitForPipeDrain();

	//Console.WriteLine($"read from pipe client: {streamReader.ReadLine()}");
	Console.WriteLine("read from pipe client: {streamReader.ReadLine()}");
	namedPipeServer.Dispose();
}