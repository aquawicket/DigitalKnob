




WScript.StdOut.Write("loaded DK.js \n");



if(typeof WScript === "object"){
	console.log("Using Windows Scriting Host")
	var WshShell = function(){ return new ActiveXObject("WScript.Shell"); }
	var Document = function(){ return new ActiveXObject("Msxml2.DOMDocument.6.0"); 
		objXMLDoc.async = false;
		objXMLDoc.setProperty("ProhibitDTD", false);
		objXMLDoc.validateOnParse = false;
		return objXMLDoc;
	}
	
	dk_download = function(url, destination){
		var filesystem = new FileSystem;
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
}

dk_func = function(url){
		var xmlHttpRequest = new XMLHttpRequest;
		xmlHttpRequest.open("GET", url, false);
		xmlHttpRequest.send();
		return xmlHttpRequest.responseText;
	}
	dk_source = function(url){ 
		(1, eval)(dk_func(url)); 
	};
