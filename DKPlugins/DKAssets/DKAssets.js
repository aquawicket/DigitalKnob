//BROWSER
DKLog("Loaded DKAssets.js\n");

var href = document.location.href;
if(href.indexOf("?") > -1){
	href = href.substr(0, href.lastIndexOf("?")+1);
}
href = href.substr(0, href.lastIndexOf("/")+1);
local_assets = href;


var log_debug = DKFile_GetSetting(local_assets+"settings.txt", "[LOG_DEBUG]");
if(log_debug == "ON"){ LOG_DEBUG = true; }

var log_info = DKFile_GetSetting(local_assets+"settings.txt", "[LOG_INFO]");
if(log_info == "OFF"){ LOG_INFO = false; }

var log_warnings = DKFile_GetSetting(local_assets+"settings.txt", "[LOG_WARNINGS]");
if(log_warnings == "OFF"){ LOG_WARNINGS = false; }

var log_errors = DKFile_GetSetting(local_assets+"settings.txt", "[LOG_ERRORS]");
if(log_errors == "OFF"){ LOG_ERRORS = false; }

var log_file = DKFile_GetSetting(local_assets+"settings.txt", "[LOG_FILE]");
if(log_file == "ON"){ LOG_FILE = true; }

LOG_SHOW = DKFile_GetSetting(local_assets+"settings.txt", "[LOG_SHOW]");
LOG_HIDE = DKFile_GetSetting(local_assets+"settings.txt", "[LOG_HIDE]");

var log_lines = DKFile_GetSetting(local_assets+"settings.txt", "[LOG_LINES]");
if(log_lines == "ON"){ LOG_LINES = true; }

var hostname = DKFile_GetSetting(local_assets+"settings.txt", "[HOSTNAME]");
if(!hostname){ hostname = document.location.hostname; }
if(!hostname){ hostname = "digitalknob.com"; }

var pathname = DKFile_GetSetting(local_assets+"settings.txt", "[PATHNAME]");
if(!pathname){ pathname = document.location.pathname; }
if(pathname.lastIndexOf("DKApps") > 0){
	pathname = pathname.substring(pathname.lastIndexOf("DKApps")+6, pathname.lastIndexOf("assets"));
}
if(pathname.lastIndexOf(".com") > 0){
	pathname = pathname.substr(pathname.lastIndexOf(".com"));
}
pathname = pathname.replace("index.html", "");
//if(pathname.indexOf("/index.html") > -1){ pathname = "/DKDatabase/"; }

var protocol = document.location.protocol;
online_assets = protocol+"//"+hostname+pathname;
if(protocol != "file:"){
	local_assets = protocol+"//"+hostname+pathname;
}

appfilename = pathname.replace("/","");
appfilename = appfilename.replace("/","");

if(DK_GetBrowser() != "CEF"){
	var absolutepath = ajaxGetUrl(online_assets+"/DKFile/DKFile.php?GetAbsolutePath="+pathname);
	absolutepath = absolutepath.replace("//","/");
}
else{
	absolutepath = online_assets;
}
//if(absolutepath){online_assets = absolutepath;}

DKLog("href: "+href+"\n");
DKLog("hostname: "+hostname+"\n");
DKLog("pathname: "+pathname+"\n");
DKLog("protocol: "+protocol+"\n");
DKLog("appfilename: "+appfilename+"\n");
DKLog("local_assets: "+local_assets+"\n");
DKLog("online_assets: "+online_assets+"\n");
DKLog("absolutepath: "+absolutepath+"\n");

DKLog("LOG_DEBUG: "+LOG_DEBUG+"\n");
DKLog("LOG_INFO: "+LOG_INFO+"\n");
DKLog("LOG_WARNINGS: "+LOG_WARNINGS+"\n");
DKLog("LOG_ERRORS: "+LOG_ERRORS+"\n");
DKLog("LOG_FILE: "+LOG_FILE+"\n");
DKLog("LOG_SHOW: "+LOG_SHOW+"\n");
DKLog("LOG_HIDE: "+LOG_HIDE+"\n");


////////////////////////
function DKAssets_Init()
{

}

if(DK_GetBrowser() != "CEF"){
	///////////////////////////////
	function DKAssets_LocalAssets()
	{
		return local_assets;
	}
}

////////////////////////////////
function DKAssets_OnlineAssets()
{
	return online_assets;
}

////////////////////////////
function DKAssets_Protocol()
{
	return protocol;
}

////////////////////////////////
function DKAssets_AbsolutePath()
{
	return absolutepath;
}
