//BROWSER

var href = document.location.href;
href = href.replace("index.html","");
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

var hostname = DKFile_GetSetting(local_assets+"settings.txt", "[HOSTNAME]");
if(!hostname){ hostname = document.location.hostname; }
if(!hostname){ hostname = "digitalknob.com"; }

var pathname = DKFile_GetSetting(local_assets+"settings.txt", "[PATHNAME]");
if(!pathname){ pathname = document.location.pathname; }
if(pathname.indexOf("/index.html") > -1){ pathname = "/DKDatabase/"; }

var protocol = document.location.protocol;
online_assets = "http://"+hostname+pathname;
if(protocol != "file:"){
	local_assets = "http://"+hostname+pathname;
}

appfilename = pathname.replace("/","");
appfilename = appfilename.replace("/","");

var absolutepath = ajaxGetUrl(online_assets+"/DKFile/DKFile.php?GetAbsolutePath="+pathname);
//if(absolutepath){online_assets = absolutepath;}

DKLog("href: "+href+"\n", DKINFO);
DKLog("hostname: "+hostname+"\n", DKINFO);
DKLog("pathname: "+pathname+"\n", DKINFO);
DKLog("protocol: "+protocol+"\n", DKINFO);
DKLog("appfilename: "+appfilename+"\n", DKINFO);
DKLog("local_assets: "+local_assets+"\n", DKINFO);
DKLog("online_assets: "+online_assets+"\n", DKINFO);
DKLog("absolutepath: "+absolutepath+"\n", DKINFO);


////////////////////////
function DKAssets_Init()
{

}

///////////////////////////////
function DKAssets_LocalAssets()
{
	return local_assets;
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
