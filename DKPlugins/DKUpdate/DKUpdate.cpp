#include "DK/stdafx.h"
#include <stdlib.h> 
#include <sys/stat.h>
#include "DK/DKFile.h"
#include "DKArchive/DKArchive.h"
#include "DKAssets/DKAssets.h"
#include "DKCurl/DKCurl.h"
#include "DKThread/DKThread.h"
#include "DKUpdate/DKUpdate.h"

//////////////////////////////////////
//     Default update files
// win32     - http://DigitalKnob.com/Download/DKApp.exe
// win63     - http://DigitalKnob.com/Download/DKApp_64.exe
// mac32     - http://DigitalKnob.com/Download/DKApp_mac32.zip
// mac64     - http://DigitalKnob.com/Download/DKApp_mac64.zip
// linux32   - http://DigitalKnob.com/Download/DKApp_linux32.zip
// linux64   - http://DigitalKnob.com/Download/DKApp_linux64.zip
// ios32     - http://DigitalKnob.com/Download/DKApp_ios32.zip
// ios64     - http://DigitalKnob.com/Download/DKApp_ios64.zip
// iossim32  - http://DigitalKnob.com/Download/DKApp_iossim32.zip
// iossim64  - http://DigitalKnob.com/Download/DKApp_iossim64.zip
// android32 - http://DigitalKnob.com/Download/DKApp.apk
// android64 - http://DigitalKnob.com/Download/DKApp_64.apk

DKString DKUpdate::url;

/////////////////////
bool DKUpdate::Init()
{
	DKLog("DKUpdate::Init()\n", DKDEBUG);
	
	DKClass::DKCreate("DKUpdateJS");
	DKClass::DKCreate("DKUpdateV8");

	DKString app;
	DKFile::GetExeName(app);
	//DKFile::RemoveExtention(app);
	DKString downloads = "http://DigitalKnob.com/Download/";
	
#ifdef WIN32
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_WIN32]", url);
	if(url.empty()){ url = downloads+app; }
#endif
#ifdef WIN64
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_WIN64]", url);
	if(url.empty()){ url = downloads+app; }
#endif
#ifdef MAC32
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_MAC32]", url);
	if(url.empty()){ url = downloads+app+"_mac32.zip"; }
#endif
#ifdef MAC64
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_MAC64]", url);
	if(url.empty()){ url = downloads+app+"_mac64.zip"; }
#endif
#ifdef LINUX32
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_LINUX32]", url);
	if(url.empty()){ url = downloads+app+"_linux32.zip"; }
#endif
#ifdef LINUX64
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_LINUX64]", url);
	if(url.empty()){ url = downloads+app+"_linux64.zip"; }
#endif
#ifdef IOS32
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_IOS32]", url);
	if(url.empty()){ url = downloads+app+"_ios32.zip"; }
#endif
#ifdef IOS64
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_IO64S]", url);
	if(url.empty()){ url = downloads+app+"_ios64.zip"; }
#endif
#ifdef ANDROID32
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_ANDROID32]", url);
	if(url.empty()){ url = downloads+app+".apk"; }
#endif
#ifdef ANDROID64
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_ANDROID64]", url);
	if(url.empty()){ url = downloads+app+".apk"; }
#endif

	if(url.empty()){
		DKLog("DKUpdate::Init(): update url did not get set. ",DKERROR);
		return false;
	}
	
	//DKQueue("Checking for Update...", boost::bind(&DKUpdate::CheckForUpdate, this, url));
	return true;
}

////////////////////
bool DKUpdate::End()
{
	return true;
}

///////////////////////////////
bool DKUpdate::CheckForUpdate()
{
	DKLog("DKUpdate::CheckForUpdate()\n", DKINFO);

	DKCurl::Instance("DKCurlUpdate");
	if(!DKCurl::Get("DKCurlUpdate")->FileExists(url)){
		DKLog(url+": NOT FOUND \n", DKERROR);
		return false;
	}
	DKString localfile;
	DKFile::GetExePath(localfile);
	
#ifdef ANDROID
	localfile = DKFile::local_assets+"ASSETS";
#endif

	DKString lctime;
	if(!DKFile::GetLocalModifiedDate(localfile, lctime)){ return false; }

	DKString lmtime;
	if(!DKFile::GetLocalModifiedDate(localfile, lmtime)){ return false; }
   
	DKString stime;
	//if(!DKFile::GetServerModifiedDate(url, stime)){ return false; }
	if(!DKCurl::Instance("DKCurlUpdate")->FileDate(url, stime)){ return false; }
	
	char* pEnd;
	unsigned long long i_stime = strtoull(stime.c_str(), &pEnd, 10);
	char* pEnd2;
	unsigned long long i_lctime = strtoull(lctime.c_str(), &pEnd2, 10);
	char* pEnd3;
	unsigned long long i_lmtime = strtoull(lmtime.c_str(), &pEnd3, 10);
	
	//You have 1 hour to (zip and) upload the file after it's built
	i_stime -= 6000;

	if(i_stime > i_lctime || i_stime > i_lmtime){
		DKLog("Update Available \n", DKINFO);
		//DoUpdate();
		return true;
	}
	DKLog("No Update Available \n", DKINFO);
	return false;
}

/////////////////////////////
bool DKUpdate::CreateUpdate()
{
	//TODO: create update and upload to ftp
	return false;
}

/////////////////////////
bool DKUpdate::DoUpdate()
{
	DKLog("DKUpdate::DoUpdate("+url+")\n", DKDEBUG);
	DKString file;
	DKFile::GetExeName(file);
	DKString apppath;
	DKFile::GetAppPath(apppath);
	DKFile::ChDir(apppath);
	DKString filename;
	DKFile::GetFileName(url, filename);

	if(has(url,".apk")){
		DKLog("android updates not setup yet", DKERROR);
		DKFile::ChDir(DKFile::local_assets);
		DKFile::Delete(DKFile::local_assets+filename+"_dl");
		if(!DKCurl::Get("DKCurlUpdate")->Download(url, DKFile::local_assets+filename+"_dl")){
			return false;
		}
		DKFile::Rename(DKFile::local_assets+filename+"_dl", filename, true);
		DKFile::Delete(DKFile::local_assets+"ASSETS"); //reload assets
#ifdef ANDROID
		//FIXME - does not seem to work. correct path?
		//CallJavaFunction("InstallPackage", DKApp::datapath+filename);
#endif
		DKLog("Downloaded apk file to: "+DKFile::local_assets+filename+"\n", DKINFO);
		return false;
	}

	//Apply .zip update
	if(has(url,".zip")){
		DKFile::Delete(apppath+"/"+filename+"_dl");
		if(!DKCurl::Get("DKCurlUpdate")->Download(url, apppath+"/"+filename+"_dl")){
			return false;
		}
		DKFile::Rename(apppath+"/"+filename+"_dl", filename, true);
		DKArchive::Extract(apppath+"/"+filename, apppath);
		DKFile::Delete(apppath+"/"+filename);
		DKLog("\nUpdate finnished..  please restart app.\n", DKINFO);
		return true;
	}

	//Apply .exe update
	DKFile::Delete(file+"_dl");
	if(!DKCurl::Get("DKCurlUpdate")->Download(url,file+"_dl")){
		return false;
	}
	DKFile::Delete(file+".old");
	DKFile::Rename(file,file+".old",true); //we'll leave .old behind for backup 
	//DKFile::Delete(file+".old");
	DKFile::Rename(file+"_dl",file,true);
	DKString name = file;
	DKFile::RemoveExtention(name);
	DKFile::Delete(apppath + "/" + name +"/ASSETS"); //delete assets marker file
	DKLog("\nUpdate finnished..  please restart app.\n", DKINFO);
	return true;
}

////////////////////////////////////////////////
bool DKUpdate::UpdatePlugin(const DKString& url)
{
	//ok, here we are going to copy the url to the assets folder
	//I.E.   digitalknob.com/TradePost/DKBrowser  ->  c:/digitalknob/DKApps/TradePost/DKBrowser

	//first check that the url exists
	DKCurl::Instance("DKCurlUpdate");
	if(!DKCurl::Get("DKCurlUpdate")->FileExists(url)){
		DKLog("DKUpdate::UpdatePlugin("+url+"): the url does not exist\n", DKERROR);
		return false;
	}
	//DKLog("DKUpdate::UpdatePlugin("+url+"): we found it!\n", DKINFO);

	DKString url2 = "/DKDebug";
	DKString new_url = "http://digitalknob.com/Digitalknob/DKFile/DKFile.php?DirectoryContents="+url2;
	DKLog("new_url = "+new_url+"\n", DKINFO);
	DKString output;
	if(!DKCurl::Get("DKCurlUpdate")->HttpToString(new_url, output)){
		DKLog("DKUpdate::UpdatePlugin("+url+"): HttpToString failed\n", DKERROR);
		return false;
	}
	DKLog("HttpToString = "+output+"\n", DKINFO);
	return false;
}
