//BROWSER

var appfilename;
var local_assets;
var online_assets;

function DKFile_GetExeName(){ DKLog("DKFile_GetExeName(): not available for javascript", DKERROR); }
function DKFile_GetModifiedTime(){ DKLog("DKFile_GetModifiedTime(): not available for javascript", DKERROR); }
function DKFile_CopyFolder(src,dst,overwrite,recursive){DKLog("DKFile_CopyDirectory(): not available for javascript", DKERROR); return; }
function DKFile_MkDir(){ DKLog("DKFile_MkDir(): not available for javascript", DKERROR); }
function DKFile_ChDir(){ DKLog("DKFile_ChDir(): not available for javascript", DKERROR); }
function DKFile_GetFullExeName(){ DKLog("DKFile_GetFullExeName(): not available for javascript", DKERROR); }
function DKFile_GetShortName(){ DKLog("DKFile_GetShortName(): not available for javascript", DKERROR); }

//////////////////////
function DKFile_Init()
{
	
}

///////////////////////////
function UrlExists(url, fn)
{
	//url = "file:///"+url;
	//DKLog("UrlExists("+url+") \n", DKDEBUG);
	DKLog("AJAX SEND: "+url);
	
	var request = "";
	try {
        request = new XMLHttpRequest();
    }catch(e){}
    try {
        request = new ActiveXObject("Msxml3.XMLHTTP");
    }catch(e){}
    try {
        request = new ActiveXObject("Msxml2.XMLHTTP.6.0");
    }catch(e){}
    try {
        request = new ActiveXObject("Msxml2.XMLHTTP.3.0");
    }catch(e){}
    try {
        request = new ActiveXObject("Msxml2.XMLHTTP");
    }catch(e){}
    try {
        request = new ActiveXObject("Microsoft.XMLHTTP");
    }catch(e){}
	if(!request){
		DKLog("AJAX ERROR: Error creating request object", DKERROR);
		return;// false;
	}

	request.onreadystatechange=function(){
		if(request.readyState==4){
			if(request.status==200 || request.status==0){
				//output.value = request.responseText;
				DKLog(url+" status: "+request.status);
				fn && fn(true);
				//return;// true;
			}
			else{
				DKLog("AJAX ERROR: "+request.statusText, DKERROR); //report error
				DKLog(url+" status: "+request.status, DKERROR);
				fn && fn(false);
				//return;// false;
			}
		}
	}
	
	//try{ 
		request.open("HEAD",url); 
		request.send(); 
	//}
	//catch(err){
		//output.value = "";
	//	return;// false;
	//}
	//return;// true;
}

////////////////////////////////
function DKFile_Exists(path, fn)
{
	DKLog("DKFile_Exists("+path+") \n", DKDEBUG);
	if(!path){ return false; }
	
	UrlExists(path, function(rval){
		fn && fn(rval);
	});
}

////////////////////////////////
function DKFile_VerifyPath(path)
{
	return true;
	DKLog("DKFile_VerifyPath("+path+")\n", DKDEBUG);
	if(!path){ return false; }
	
	DKLog("DKFile_VerifyPath("+path+"): checking "+path+"\n", DKDEBUG);
	if(DKFile_Exists(path)){ 
		DKLog("DKFile_VerifyPath("+path+"): Found "+path+"\n", DKSUCCESS);
		return path;
	}
	
	var assets = DKAssets_LocalAssets();
	DKLog("DKFile_VerifyPath("+path+"): checking "+assets+path+"\n", DKDEBUG);
	if(DKFile_Exists(assets+path)){
		DKLog("DKFile_VerifyPath("+path+"): Found "+assets+path+"\n", DKSUCCESS);
		return assets+path;
	}	
	
	DKLog("DKFile_VerifyPath("+path+") Cannot find "+path+" \n", DKERROR);
	return false;
}

////////////////////////////
function DKFile_PrintFiles()
{
	return ajaxGetUrl(online_assets+"/DKFile/DKFile.php?PrintFiles=1");
}

/////////////////////////////////
function DKFile_GetFilename(path)
{
	//DKLog("DKFile_GetFilename("+path+") \n", DKDEBUG);
	if(!path){ return; }
	var n = path.lastIndexOf("/");
	var out = path.substring(n+1,path.length);
	//DKLog("DKFile_GetFileName("+path+") -> "+out+"\n", DKDEBUG)
	return path.substring(n+1,path.length);
}

////////////////////////////////////
function DKFile_SaveFile(path, data)
{
	DKLog("DKFile_SaveFile("+path+", data) \n");
	//var send = phpurl;
	//if(realpath){
		//var filename = DKFile_GetFilename(path);
		//path = realpath+path;
	//}
	//path = path.replace(datapath, realpath);
	//path = path.replace(online_assets, realpath);
	//path = realpath+path;
	
	//DKLog("DKFile_SaveFile: "+path+"\n");
	send = online_assets+"/DKFile/DKFile.php?SaveFile=";
	send += path;
	send += "&data="
	send += data;
	var response = ajaxGetUrl(send);
	DKLog(response);
	
	//FIXME
	//if(response.indexOf("DKERROR") != -1){
	//	return false;
	//}
	DKLog("Saved file: "+path+"\n");
	
	return true;
}

///////////////////////////////////////
function DKFile_GetSetting(file, param)
{
	//DKLog("DK_GetSetting("+file+", "+param+") \n", DKDEBUG);
	//file is ignored in browser. We use cookie instead.
	if(!file){
		return getCookie(param);
	}
	else{
		//If the variable looks like this: [VARIABLE]
		//then we return everything up to the next [VARIABLE] or to the end of the file.
		var str = DK_FileToString(file);
		if(!str){ return ""; }
		if(param.indexOf("[") != -1 && param.indexOf("]") != -1 ){
			var begin = str.indexOf(param);
			if(begin == -1){ return ""; }

			var start = str.indexOf("]", begin);
			var end = str.indexOf("[",start);
			if(end == -1){end = str.length;}

			var out = str.substr(start+1, end-start-1);

			replace(out,"\r","");
			replace(out,"\n"," ");
			out = out.trim();
			//DKLog("DK_GetSetting("+file+", "+param+") -> "+out+"\n", DKDEBUG);
			return out;
		}

		//If the variable looks like this:  VARIABLE 
		//then we return the rest of the line
		var string = param + " ";
		var begin = str.indexOf(string,0);
		if(begin == -1){return "";}
		var start = str.indexOf(" ",begin);
		var end = str.indexOf("\n",start);

		var out = filestring.substr(start+1, end-start-1);
		replace(out,"\r","");
		replace(out,"\n","");
		out = out.trim();
		//DKLog("DK_GetSetting("+file+", "+param+") -> "+out+"\n", DKDEBUG);
		return out;
	}
}

//////////////////////////////////////////////
function DKFile_SetSetting(file, param, value)
{
	//DKLog("DKFile_SetSetting("+file+", "+param+", "+value+") \n", DKDEBUG);
	//file is ignored in browser. We use cookie instead.
	if(!file){
		setCookie(param, value, 9999);
	}
	else{
		var path = file;
		//if(!DKAssets::VerifyPath(path)){ return false;}

		var filestring = DKFile_FileToString(path);
		if(!filestring){ return false; }

		//If the variable looks like this: [VARIABLE]
		//then we return everything up to the next [VARIABLE] or to the end of the file.
		if(param.indexOf("[") != -1 && param.indexOf("]") != -1){
			var begin = filestring.indexOf(param);
			if(begin == -1){
				filestring = filestring.concat("\n" + param + " " + value); //create entry
				DKFile_StringToFile(filestring, path);
				DKLog("WROTE: "+filestring+" TO: "+path+" \n", DKSUCCESS);
				return true;
			}
			var start = filestring.indexOf("]", begin);
			var end = filestring.indexOf("[", start);
			if(end == -1){end = filestring.length;}

			var out = " "+value+"\n";
			var oldstr = filestring.substr(start+1, end-start-1);
			filestring = replace(filestring, oldstr, out); 
			DKFile_StringToFile(filestring,path);
			DKLog("WROTE: "+filestring+" TO: "+path+" \n", DKSUCCESS);
			return true;
		}

		//If the variable looks like this:  VARIABLE 
		//then we return the rest of the line
		var string = setting + " ";

		var begin = filestring.indexOf(string,0);
		if(temp == -1){
			filestring = filestring.concat("\n" + setting + " " + value); //create entry
			DKFile_StringToFile(filestring,file);
			DKLog("WROTE: "+filestring+" TO: "+file+" \n", DKSUCCESS);
			return true;
		}
		var start = filestring.indexOf(" ", begin);
		var end = filestring.indexOf("\n",start);

		var oldstr = filestring.substr(start+1, end-start-1);
		filestring.replace(filestring, oldstr, value); 
		DKFile_StringToFile(filestring,file);
	
		DKLog("WROTE: "+filestring+" TO: "+file+" \n", DKSUCCESS);
		return true;
	}
}

/////////////////////////////////
function DKFile_FileToString(url)
{
	DKLog("DKFile_FileToString("+url+") \n");
	var path = DKFile_VerifyPath(url);
	if(!path){ return; }
	if(url.indexOf("http") > -1 && url.indexOf("digitalknob.com") == -1){
		return ajaxGetUrl("http://cors.io/?u="+url);
	}
	return ajaxGetUrl(url);
}

////////////////////////////////////////
function DKFile_StringToFile(data, path)
{
	//DKLog("DKFile_StringToFile("+data+", "+path+") \n", DKDEBUG);
	data = replace(data, ": ", ":");
	data = replace(data, "; ", ";");
	data = replace(data, ", ", ",");
	data = replace(data, " ", "%20");
	data = replace(data, "'", "%27");
	data = replace(data, "\n", "%0A");
	//DKLog("StringToFile("+data+", "+path+") \n", DKDEBUG);
	DKFile_SaveFile(path, data);
}

///////////////////////////
function DKFile_GetDrives()
{
	DKLog("DKFile_GetDrives(): not available for javascript \n", DKERROR);
	return "";
}

//////////////////////////////////////
function DKFile_DirectoryContents(url)
{
	DKLog("DKFile_DirectoryContents("+url+") \n", DKDEBUG);
	if(url.indexOf(":") > -1){ return; }
	if(!online_assets){
		DKLog("DKFile_DirectoryContents(url): online_assets not set!\n", DKERROR)
	}
	DKLog("DKFile_DirectoryContents("+url+") \n", DKDEBUG);
	//var assets = DKAssets_LocalAssets();
	//url = url.replace(assets, online_assets);
	//var path = DKFile_VerifyPath(url);
	//if(!path){ return 0; }
	send = online_assets+"/DKFile/DKFile.php?DirectoryContents="+url;
	DKLog("ajaxGetUrl("+send+") \n", DKDEBUG);
	var result = ajaxGetUrl(send);
	return result;
}

////////////////////////////////////
function DKFile_GetAbsolutePath(url)
{
	if(!url){ url = "/"; }
	//DKLog("DKFile_GetAbsolutePath("+url+") \n", DKDEBUG);
	send = online_assets+"/DKFile/DKFile.php?GetAbsolutePath="+url;
	var result = ajaxGetUrl(send);
	//result = result.replace(datapath,"");
	
	//DKLog("DKFile_GetAbsolutePath("+url+") -> "+result+"\n", DKDEBUG);
	return result;
}

////////////////////////////////////////////////
function DKFile_GetRelativePath(apath, datapath)
{
	//if(!url){ url = "/"; }
	DKLog("DKFile_GetRelativePath("+apath+","+datapath+") \n", DKDEBUG);
	//apath = apath.replace("/home/content/a/q/u/aquawicket1/html/DigitalKnob.com/DKApp/","");
	//send = online_assets+"/DKFile/DKFile.php?GetRelativePath="+url;
	//var result = ajaxGetUrl(send);
	//DKLog("DKFile_GetRelativePath("+url+") -> "+result+"\n", DKDEBUG);
	return apath;
}

////////////////////////////////
function DKFile_IsDirectory(url)
{
	send = online_assets+"/DKFile/DKFile.php?IsDirectory="+url;
	var result = ajaxGetUrl(send);
	//DKLog("DKFile_IsDirectory("+url+") ->"+result+"\n", DKDEBUG);
	if(result == "0"){ return false; }
	return true;
}

////////////////////////////////
function DKFile_GetExtention(url)
{
	var n = url.lastIndexOf(".");
	var out = url.substring(n+1,url.length);
	return out;
}

///////////////////////////
function DKFile_Delete(url)
{
	DKLog("Deleting: "+url+"\n");
	send = online_assets+"/DKFile/DKFile.php?Delete="+url;
	var result = ajaxGetUrl(send);
	return result;
}
