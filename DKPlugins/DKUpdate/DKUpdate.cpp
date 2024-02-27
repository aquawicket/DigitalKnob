/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DKArchive/DKArchive.h"
#include "DKAssets/DKAssets.h"
#include "DKCurl/DKCurl.h"
#include "DKThread/DKThread.h"
#include "DKUpdate/DKUpdate.h"

//WARNING_DISABLE
#include <stdlib.h> 
#include <sys/stat.h>
//WARNING_ENABLE


//////////////////////////////////////
//     Default update files
// win_x86     - http://DigitalKnob.com/Download/DKApp.exe
// win63     - http://DigitalKnob.com/Download/DKApp_64.exe
// mac_x86     - http://DigitalKnob.com/Download/DKApp_mac_x86.zip
// mac_x86_64     - http://DigitalKnob.com/Download/DKApp_mac_x86_64.zip
// linux_x86   - http://DigitalKnob.com/Download/DKApp_linux_x86.zip
// linux_x86_64   - http://DigitalKnob.com/Download/DKApp_linux_x86_64.zip
// ios_arm32     - http://DigitalKnob.com/Download/DKApp_ios_arm32.zip
// ios_arm64     - http://DigitalKnob.com/Download/DKApp_ios_arm64.zip
// iossim_x86  - http://DigitalKnob.com/Download/DKApp_iossim_x86.zip
// iossim_x86_64  - http://DigitalKnob.com/Download/DKApp_iossim_x86_64.zip
// android_arm32 - http://DigitalKnob.com/Download/DKApp.apk
// android_arm64 - http://DigitalKnob.com/Download/DKApp_64.apk

DKString DKUpdate::url;

bool DKUpdate::Init(){
	DKDEBUGFUNC();	
	DKClass::DKCreate("DKUpdateJS");
	DKClass::DKCreate("DKUpdateV8");

	DKString app;
	DKFile::GetExeName(app);
	//DKFile::RemoveExtention(app);
	DKString downloads = "http://DigitalKnob.com/Download/";
	
#if WIN_X86
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_WIN_X86]", url);
	if(url.empty()){ url = downloads+app; }
#endif
#if WIN_X86_64
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_WIN_X86_64]", url);
	if(url.empty()){ url = downloads+app; }
#endif
#if MAC_X86
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_MAC_X86]", url);
	if(url.empty()){ url = downloads+app+"_mac_x86.zip"; }
#endif
#if MAC_X86_64
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_MAC_X86_64]", url);
	if(url.empty()){ url = downloads+app+"_mac_x86_64.zip"; }
#endif
#ifdef LINUX_X86
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_LINUX_X86]", url);
	if(url.empty()){ url = downloads+app+"_linux_x86.zip"; }
#endif
#if LINUX_X86_64
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_LINUX_X86_64]", url);
	if(url.empty()){ url = downloads+app+"_linux_x86_64.zip"; }
#endif
#if IOS_ARM32
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_IOS_ARM32]", url);
	if(url.empty()){ url = downloads+app+"_ios_arm32.zip"; }
#endif
#if IOS_ARM64
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_IOS_ARM64]", url);
	if(url.empty()){ url = downloads+app+"_ios_arm64.zip"; }
#endif
#if ANDROID_ARM32
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_ANDROID_ARM32]", url);
	if(url.empty()){ url = downloads+app+".apk"; }
#endif
#if ANDROID_ARM64
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[UPDATE_ANDROID_ARM64]", url);
	if(url.empty()){ url = downloads+app+".apk"; }
#endif

	if(url.empty())
		return DKERROR("DKUpdate::Init(): update url did not get set\n");
	
	//DKQueue("Checking for Update...", boost::bind(&DKUpdate::CheckForUpdate, this, url));
	return true;
}

bool DKUpdate::End(){
	DKDEBUGFUNC();	
	return true;
}

bool DKUpdate::CheckForUpdate(){
	DKDEBUGFUNC();
	DKCurl::Instance("DKCurlUpdate");
	if(!DKCurl::Get("DKCurlUpdate")->FileExists(url))
		return DKERROR(url+": NOT FOUND\n");
	DKString localfile;
	DKFile::GetExePath(localfile);
	
#if ANDROID
	localfile = DKFile::local_assets+"ASSETS";
#endif

	DKString lctime;
	if(!DKFile::GetLocalModifiedDate(localfile, lctime))
		return false;
	DKString lmtime;
	if(!DKFile::GetLocalModifiedDate(localfile, lmtime))
		return false; 
	DKString stime;
	//if(!DKFile::GetServerModifiedDate(url, stime)){ return false; }
	if(!DKCurl::Instance("DKCurlUpdate")->FileDate(url, stime))
		return false;
	char* pEnd;
	unsigned long long i_stime = strtoull(stime.c_str(), &pEnd, 10);
	char* pEnd2;
	unsigned long long i_lctime = strtoull(lctime.c_str(), &pEnd2, 10);
	char* pEnd3;
	unsigned long long i_lmtime = strtoull(lmtime.c_str(), &pEnd3, 10);
	
	//You have 1 hour to (zip and) upload the file after it's built
	i_stime -= 6000;

	if(i_stime > i_lctime || i_stime > i_lmtime){
		DKINFO("Update Available\n");
		//DoUpdate();
		return true;
	}
	DKINFO("No Update Available\n");
	return false;
}

bool DKUpdate::CreateUpdate(){
	DKDEBUGFUNC();	
	//TODO: create update and upload to ftp
	return false;
}

bool DKUpdate::DoUpdate(){
	DKDEBUGFUNC();
	DKString file;
	DKFile::GetExeName(file);
	DKString apppath;
	DKFile::GetAppPath(apppath);
	DKFile::ChDir(apppath);
	DKString filename;
	DKFile::GetFileName(url, filename);

	if(has(url,".apk")){
		DKERROR("android updates not setup yet\n");
		DKFile::ChDir(DKFile::local_assets);
		DKFile::Delete(DKFile::local_assets+filename+"_dl");
		if(!DKCurl::Get("DKCurlUpdate")->Download(url, DKFile::local_assets+filename+"_dl"))
			return false;
		DKFile::Rename(DKFile::local_assets+filename+"_dl", filename, true);
		DKFile::Delete(DKFile::local_assets+"ASSETS"); //reload assets
#if ANDROID
		//FIXME - does not seem to work. correct path?
		//CallJavaFunction("InstallPackage", DKApp::datapath+filename);
#endif
		DKINFO("Downloaded apk file to: "+DKFile::local_assets+filename+"\n");
		return false;
	}

	//Apply .zip update
	if(has(url,".zip")){
		DKFile::Delete(apppath+"/"+filename+"_dl");
		if(!DKCurl::Get("DKCurlUpdate")->Download(url, apppath+"/"+filename+"_dl"))
			return false;
		DKFile::Rename(apppath+"/"+filename+"_dl", filename, true);
		DKArchive::Extract(apppath+"/"+filename, apppath);
		DKFile::Delete(apppath+"/"+filename);
		DKINFO("\nUpdate finnished..  please restart app.\n");
		return true;
	}

	//Apply .exe update
	DKFile::Delete(file+"_dl");
	if(!DKCurl::Get("DKCurlUpdate")->Download(url,file+"_dl"))
		return false;
	DKFile::Delete(file+".old");
	DKFile::Rename(file,file+".old",true); //we'll leave .old behind for backup 
	//DKFile::Delete(file+".old");
	DKFile::Rename(file+"_dl",file,true);
	DKString name = file;
	DKFile::RemoveExtention(name);
	DKFile::Delete(apppath + "/" + name +"/ASSETS"); //delete assets marker file
	DKINFO("\nUpdate finnished..  please restart app\n");
	return true;
}

bool DKUpdate::UpdatePlugin(const DKString& url){
	DKDEBUGFUNC(url);
	//TODO - recursive plugin file downloading
	
	//ok, here we are going to copy the url to the assets folder
	//I.E.   digitalknob.com/TradePost/DKBrowser  ->  c:/digitalknob/Development/DKApps/TradePost/DKBrowser

	//first check that the url exists
	DKCurl::Instance("DKCurlUpdate");
	if(!DKCurl::Get("DKCurlUpdate")->FileExists(url))
		return DKERROR("DKUpdate::UpdatePlugin("+url+"): the url does not exist\n");
	DKINFO("DKUpdate::UpdatePlugin("+url+"): we found it!\n");

	//now we have to find the folder relative to http://digitalknob.com/DKFile/DKFile.php
	//I.E:  http://digitalknob.com/TradePost/TradePost = ../../TradePost/TradePost
	//I.E:  http://digitalknob.com/DKInputTest/DKNotePad = ../../DKInputTest/DKNotePad
	//I.E:  http://digitalknob.com/Digitalknob/DKFpsTest = ../../Digitalknob/DKFpsTest

	if(!has(url, "http://digitalknob.com/"))
		return DKERROR("DKUpdate::UpdatePlugin("+url+"): Plugins can only be obtained from digitalknob.com\n");
	
	DKString url2 = url;
	replace(url2, "http://digitalknob.com/", "../../");
	DKString new_url = "http://digitalknob.com/Digitalknob/DKFile/DKFile.php?DirectoryContents="+url2;
	DKINFO("new_url = "+new_url+"\n");
	DKString output;
	if(!DKCurl::Get("DKCurlUpdate")->HttpToString(new_url, output))
		return DKERROR("DKUpdate::UpdatePlugin("+url+"): HttpToString failed\n");
	
	DKINFO("HttpToString = "+output+"\n");

	if(!has(output,"..,"))
		return DKERROR("DKUpdate::UpdatePlugin("+url+"): HttpToString() did not return a directory list\n");

	DKStringArray arry;
	toStringArray(arry, output, ",");
	replace(url2, "../../", "");
	for(unsigned int i=0; i<arry.size(); i++){
		arry[i] = "http://digitalknob.com/"+url2+"/"+arry[i];
		DKINFO("arry["+toString(i)+"] = "+arry[i]+"\n");
	}

	//now we need to get the download directory and create the folder if it does not exist
	//just take the last / in url2 the end of the string for the plugin name.
	std::string::size_type found = url2.find_last_of("/");
	DKINFO("found = "+toString(found)+"\n");

	DKString plugin = url2.substr(found+1, url2.size());
	DKINFO("Plugin name is "+plugin+"\n");

	//now get the assets path of this process
	DKString plugin_path = DKFile::local_assets+plugin;
	DKINFO("local plugin path = "+plugin_path+"\n");
	DKFile::MakeDir(plugin_path);

	//now transfer the arry to plugin path
	for(unsigned int i=1; i<arry.size(); i++){
		if(!DKCurl::Get("DKCurlUpdate")->Download(arry[i], plugin_path))
			return DKERROR("DKUpdate::UpdatePlugin("+url+"): DKCurl::Download("+arry[i]+") failed\n");
	}
	return true;
}
