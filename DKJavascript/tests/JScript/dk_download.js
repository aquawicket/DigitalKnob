// https://stackoverflow.com/a/17224012/688352

//##################################################################################
//# dk_download(url, destination)
//#
//#
dk_download = function(url, destination){
	//var Source = WScript.Arguments.Item(0);
	//var Target = WScript.Arguments.Item(1);
	var Source = url;
	var Target = destination;
	
	var Object = WScript.CreateObject('MSXML2.XMLHTTP');

	Object.Open('GET', Source, false);
	Object.Send();

	if (Object.Status == 200){
		// Create the Data Stream
		var Stream = WScript.CreateObject('ADODB.Stream');

		// Establish the Stream
		Stream.Open();
		Stream.Type = 1; // adTypeBinary
		Stream.Write(Object.ResponseBody);
		Stream.Position = 0;

		// Create an Empty Target File
		var File = WScript.CreateObject('Scripting.FileSystemObject');
		if (File.FileExists(Target)){
			File.DeleteFile(Target);
		}

		// Write the Data Stream to the File
		Stream.SaveToFile(Target, 2); // adSaveCreateOverWrite
		Stream.Close();
	}
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function DKTEST(){
	//dk_debugFunc(0);
	
	dk_download("https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBuilder.js")
	dk_download("https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.js", "DKBuilder.js")
	//dk_download("https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.js", DKDOWNLOAD_DIR"+dk_download_batch_test/DKBuilder.sh")
}
