//BROWSER

var href = document.location.href;
href = href.replace("index.html","");
local_assets = href;

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
