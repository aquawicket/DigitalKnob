// https://stackoverflow.com/a/17224012/688352

//##################################################################################
//# dk_download(url, destination)
//#
//#
dk_download = function(url, destination){
	if(typeof filesystem === "undefined") { var filesystem = new FileSystem; }
	if (filesystem.FileExists(destination)){ return; }
	console.log("downloading "+url+"  to   "+destination+"\n");
	var xmlHttpRequest = new XMLHttpRequest;
	xmlHttpRequest.Open('GET', url, false);
	xmlHttpRequest.Send();
	if (xmlHttpRequest.Status == 200) {
		var filestream = new FileStream;
		filestream.Open();
		filestream.Type = 1; // adTypeBinary
		filestream.Write(xmlHttpRequest.ResponseBody);
		filestream.Position = 0;
		if (filesystem.FileExists(destination)) { filesystem.DeleteFile(destination); }
		filestream.SaveToFile(destination, 2); // adSaveCreateOverWrite
		filestream.Close();
	}
}







//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function DKTEST() {
	//dk_debugFunc(0);
	
	dk_download("https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBuilder.js")
	dk_download("https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.js", "DKBuilder.js")
	//dk_download("https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.js", DKDOWNLOAD_DIR"+dk_download_batch_test/DKBuilder.sh")
}
