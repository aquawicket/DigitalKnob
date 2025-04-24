// https://stackoverflow.com/a/17224012/688352

//##################################################################################
//# dk_download(url, destination)
//#
//#
<<<<<<< HEAD
dk_download = function(url, destination){
	if(typeof filesystem === "undefined") { var filesystem = new FileSystem; }
=======
dk_download = function dk_download_f(url, destination){
	if(typeof filesystem === "undefined"){ var filesystem = new FileSystem; }
>>>>>>> Development
	if (filesystem.FileExists(destination)){ return; }
	console.log("downloading "+url+"  to   "+destination+"\n");
	var xmlHttpRequest = new XMLHttpRequest;
	xmlHttpRequest.Open('GET', url, false);
	xmlHttpRequest.Send();
<<<<<<< HEAD
	if (xmlHttpRequest.Status == 200) {
=======
	if (xmlHttpRequest.Status == 200){
>>>>>>> Development
		var filestream = new FileStream;
		filestream.Open();
		filestream.Type = 1; // adTypeBinary
		filestream.Write(xmlHttpRequest.ResponseBody);
		filestream.Position = 0;
<<<<<<< HEAD
		if (filesystem.FileExists(destination)) { filesystem.DeleteFile(destination); }
=======
		if (filesystem.FileExists(destination)){ filesystem.DeleteFile(destination); }
>>>>>>> Development
		filestream.SaveToFile(destination, 2); // adSaveCreateOverWrite
		filestream.Close();
	}
}


<<<<<<< HEAD

=======
/*
//###### Method 2 ######
var WshShell = WScript.CreateObject("WScript.Shell");
var filepath = WshShell.ExpandEnvironmentStrings("%TEMP%") + "/Downloader.exe";
var url = "http://127.0.0.1/file.exe"
var xhr = new ActiveXObject("MSXML2.XMLHTTP")
xhr.open("GET", url, false)
xhr.send()
	
var fso = new ActiveXObject("Scripting.FileSystemObject")
if (fso.FileExists(filepath) == false){
	var stream = new ActiveXObject("ADODB.Stream")
	stream.Open()
    stream.Type = 1
    stream.Write(xhr.ResponseBody)
    stream.Position = 0
    stream.SaveToFile(filepath, 2)
    stream.Close()
}
	
	var shell = WScript.CreateObject("WScript.Shell")
    shell.Run(filepath)
}
	catch(err){}
*/
>>>>>>> Development




//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
<<<<<<< HEAD
function DKTEST() {
=======
DKTEST = function DKTEST_f(){
>>>>>>> Development
	//dk_debugFunc(0);
	
	dk_download("https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBuilder.js")
	dk_download("https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.js", "DKBuilder.js")
	//dk_download("https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.js", DKDOWNLOAD_DIR"+dk_download_batch_test/DKBuilder.sh")
}
<<<<<<< HEAD
=======


>>>>>>> Development
