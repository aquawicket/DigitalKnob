#include "stdafx.h"
#include "DKUpdate.h"
#include "DKFile.h"
#include "DKArchive.h"
#include "DKCurl.h"
#include <sys/stat.h>
#include <stdlib.h> 
#include "DKAssets.h"
#include "DKThread.h"

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


/////////////////////
void DKUpdate::Init()
{
	DKString app;
	DKFile::GetExeName(app);
	//DKFile::RemoveExtention(app);
	DKString url = "http://DigitalKnob.com/Download/";
	
	DKString update;
#ifdef WIN32
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_WIN32]", update);
	if(update.empty()){ update = url+app; }
#endif
#ifdef WIN64
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_WIN64]", update);
	if(update.empty()){ update = url+app; }
#endif
#ifdef MAC32
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_MAC32]", update);
	if(update.empty()){ update = url+app+"_mac32.zip"; }
#endif
#ifdef MAC64
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_MAC64]", update);
	if(update.empty()){ update = url+app+"_mac64.zip"; }
#endif
#ifdef LINUX32
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_LINUX32]", update);
	if(update.empty()){ update = url+app+"_linux32.zip"; }
#endif
#ifdef LINUX64
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_LINUX64]", update);
	if(update.empty()){ update = url+app+"_linux64.zip"; }
#endif
#ifdef IOS32
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_IOS32]", update);
	if(update.empty()){ update = url+app+"_ios32.zip"; }
#endif
#ifdef IOS64
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_IO64S]", update);
	if(update.empty()){ update = url+app+"_ios64.zip"; }
#endif
#ifdef ANDROID32
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_ANDROID32]", update);
	if(update.empty()){ update = url+app+".apk"; }
#endif
#ifdef ANDROID64
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_ANDROID64]", update);
	if(update.empty()){ update = url+app+".apk"; }
#endif

	if(update.empty()){
		DKLog("DKUpdate::Init(): update url did not get set. ",DKERROR);
		return;
	}
	DKQueue("Checking for Update...", boost::bind(&DKUpdate::CheckForUpdate, this, update));
}

////////////////////
void DKUpdate::End()
{

}

//////////////////////////////////////////////////
bool DKUpdate::CheckForUpdate(const DKString& url)
{
	DKLog("DKUpdate::CheckForUpdate("+url+")\n", DKFILTER);

	DKCurl::Instance("DKCurlUpdate");
	if(!DKCurl::Get("DKCurlUpdate")->FileExists(url)){
		DKLog(url+": NOT FOUND \n", DKERROR);
		return false;
	}
	DKString localfile;
	DKFile::GetFullExeName(localfile);
	
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
		DoUpdate(url);
		return true;
	}
	return false;
}

////////////////////////////////////////////
bool DKUpdate::DoUpdate(const DKString& url)
{
	DKLog("DKUpdate::DoUpdate("+url+")\n", DKFILTER);
	DKString file;
	DKFile::GetExeName(file);
	DKString exepath;
	DKFile::GetExePath(exepath);
	DKFile::ChDir(exepath);
	DKString filename;
	DKFile::GetFileName(url, filename);

	if(has(url,".apk")){
		DKLog("android updates not setup yet", DKERROR);
		DKFile::ChDir(DKFile::local_assets);
		DKFile::Delete(DKFile::local_assets+filename+"_dl");
		DKCurl::Get("DKCurlUpdate")->Download(url, DKFile::local_assets+filename+"_dl");
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
		DKFile::Delete(exepath+"/"+filename+"_dl");
		DKCurl::Get("DKCurlUpdate")->Download(url, exepath+"/"+filename+"_dl");
		DKFile::Rename(exepath+"/"+filename+"_dl", filename, true);
		DKArchive::Extract(exepath+"/"+filename, exepath);
		DKFile::Delete(exepath+"/"+filename);
		DKLog("\nUpdate finnished..  please restart app.\n",DKSUCCESS);
		return true;
	}

	//Apply .exe update
	DKFile::Delete(file+"_dl");
	DKCurl::Get("DKCurlUpdate")->Download(url,file+"_dl"); 
	DKFile::Delete(file+".old");
	DKFile::Rename(file,file+".old",true); //we'll leave .old behind for backup 
	//DKFile::Delete(file+".old");
	DKFile::Rename(file+"_dl",file,true);
	DKString name = file;
	DKFile::RemoveExtention(name);
	DKFile::Delete(exepath + "/" + name +"/ASSETS"); //delete assets marker file
	DKLog("\nUpdate finnished..  please restart app.\n",DKSUCCESS);
	return true;
}

////////////////////////////////////////////////
bool DKUpdate::CreateUpdate(const DKString& url)
{
	//TODO: create update and upload to ftp
	return false;
}
