#include "stdafx.h"
#include "DKCreator.h"
#include "DKFile.h"
#include "DKUtil.h"
#include "DKOsInfo.h"
#include "DKThread.h"
#include "DKXml.h"
#include "DKCurl.h"
#include "DKWidget.h"
#include "DKArchive.h"

//////////////////////
void DKCreator::Init()
{
#ifdef WIN32
	DKString dkpath = DKFile::GetSetting(DKApp::datapath+"settings.txt", "[DKPATH_WIN]");
	if(dkpath.empty()){ dkpath = "C:/digitalknob"; } //default
	AddToGrid("DKPATH", dkpath);
	AddToGrid("DKPLUGINS", dkpath+"/DKPlugins");
	AddToGrid("DKLIBS", dkpath+"/DKPlugins/3rdParty");
	AddToGrid("DKDL", dkpath+"/Download");
	DKString vc2013 = "C:/Program Files (x86)/MSBuild/12.0/Bin/MSBuild.exe";
	DKString vc2013_sn;
	DKFile::GetShortName(vc2013, vc2013_sn);
	AddToGrid("VC2013_EXE", vc2013_sn);
	DKFile::MakeDir(GetGrid("DKPATH"));
	DKFile::MakeDir(GetGrid("DKDL"));
#endif
#ifdef MAC
	DKString dkpath = DKFile::GetSetting(DKApp::datapath+"settings.txt", "[DKPATH_MAC]");
	if(dkpath.empty()){ dkpath = "/Users/aquawicket/Desktop/digitalknob"; } //default
	AddToGrid("DKPATH", dkpath);
	AddToGrid("DKPLUGINS", dkpath+"/DKPlugins");
	AddToGrid("DKLIBS", dkpath+"/DKPlugins/3rdParty");
	AddToGrid("DKDL", dkpath+"/Download");
	DKFile::MakeDir(GetGrid("DKPATH"));
	DKFile::MakeDir(GetGrid("DKDL"));
#endif
#ifdef LINUX
	DKString dkpath = DKFile::GetSetting(DKApp::datapath+"settings.txt", "[DKPATH_LINUX]");
	if(dkpath.empty()){ dkpath = "/home/aquawicket/Desktop/digitalknob"; } //default
	AddToGrid("DKPATH", dkpath);
	AddToGrid("DKPLUGINS", dkpath+"/DKPlugins");
	AddToGrid("DKLIBS", dkpath+"/DKPlugins/3rdParty");
	AddToGrid("DKDL", dkpath+"/Download");
	DKFile::MakeDir(GetGrid("DKPATH"));
	DKFile::MakeDir(GetGrid("DKDL"));
#endif
#ifdef ANDROID
	DKString dkpath = DKFile::GetSetting(DKApp::datapath+"settings.txt", "[DKPATH_ANDROID]");
	if(dkpath.empty()){ dkpath = DKApp::datapath+"SVN"; } //default
	AddToGrid("DKPATH", dkpath);
	AddToGrid("DKPLUGINS", dkpath+"/DKPlugins");
	AddToGrid("DKLIBS", dkpath+"/DKPlugins/3rdParty");
	AddToGrid("DKDL", dkpath+"/Download");
	DKFile::MakeDir(GetGrid("DKPATH"));
	DKFile::MakeDir(GetGrid("DKDL"));
#endif
#ifdef IOS
	DKString dkpath = DKFile::GetSetting(DKApp::datapath+"settings.txt", "[DKPATH_IOS]");
	if(dkpath.empty()){ dkpath = DKApp::datapath+"SVN"; } //default
	AddToGrid("DKPATH", dkpath);
	AddToGrid("DKPLUGINS", dkpath+"/DKPlugins");
	AddToGrid("DKLIBS", dkpath+"/DKPlugins/3rdParty");
	AddToGrid("DKDL", dkpath+"/Download");
	DKFile::MakeDir(GetGrid("DKPATH"));
	DKFile::MakeDir(GetGrid("DKDL"));
#endif

	//we can register non DKWidget classes too ;)
	RegisterEvent("DKCreator", "NewApp", &DKCreator::OnEvent, this); 
	RegisterEvent("DKCreator", "GenerateTemplate", &DKCreator::OnEvent, this);
	RegisterEvent("DKCreator", "SvnUpdate", &DKCreator::OnEvent, this);
	RegisterEvent("DKCreator", "SvnCommit", &DKCreator::OnEvent, this);
	RegisterEvent("DKCreator", "BuildApp", &DKCreator::OnEvent, this);
	RegisterEvent("DKCreator", "RebuildApp", &DKCreator::OnEvent, this);
	RegisterEvent("DKCreator", "CopyAssets", &DKCreator::OnEvent, this);
	RegisterEvent("DKCreator", "RunApp", &DKCreator::OnEvent, this);
	RegisterEvent("DKCreator", "BuildLibraries", &DKCreator::OnEvent, this);
	RegisterEvent("DKCreator", "BuildLib", &DKCreator::OnEvent, this);
	RegisterEvent("DKCreator", "GenerateTemplate", &DKCreator::OnEvent, this);

	// Register c++ functions to be called by string
	// Use: DKString result = DKClass::CallFunc("class::function", "data"); 
	DKClass::RegisterFunc("DKCreator::GetAppList", &DKCreator::GetAppList, this);
	DKClass::RegisterFunc("DKCreator::GetAppPath", &DKCreator::GetAppPath, this);
	DKClass::RegisterFunc("DKCreator::GetLibList", &DKCreator::GetLibList, this);
}

///////////////////////////////////////
void DKCreator::OnEvent(DKEvent* event)
{
	if(DKWidget::Type(event,"NewApp")){
		NewApp(event->GetValue());
	}
	if(DKWidget::Type(event,"SvnUpdate")){
		DKQueue("Svn Update", boost::bind(&DKCreator::SvnUpdate, this));
	}
	if(DKWidget::Type(event,"SvnCommit")){
		DKQueue("Svn Commit", boost::bind(&DKCreator::SvnCommit, this));
	}
	if(DKWidget::Type(event,"BuildApp")){
		DKString value = event->GetValue();
		DKStringArray arry;
		toStringArray(arry, value, ",");
		DKQueue("BuildApp "+arry[0]+" "+arry[1]+" "+arry[2], boost::bind(&DKCreator::BuildApp, this, arry[0], arry[1], arry[2]));
		
	}
	if(DKWidget::Type(event,"RebuildApp")){
		DKString value = event->GetValue();
		DKStringArray arry;
		toStringArray(arry, value, ",");
		DKQueue("RebuildApp "+arry[0]+" "+arry[1]+" "+arry[2], boost::bind(&DKCreator::RebuildApp, this, arry[0], arry[1], arry[2]));
	}
	if(DKWidget::Type(event,"CopyAssets")){
		DKString value = event->GetValue();
		DKStringArray arry;
		toStringArray(arry, value, ",");
		DKQueue("CopyAssets "+arry[0]+" "+arry[1]+" "+arry[2], boost::bind(&DKCreator::CopyAssets, this, arry[0], arry[1], arry[2]));
	}
	if(DKWidget::Type(event,"RunApp")){
		DKString value = event->GetValue();
		DKStringArray arry;
		toStringArray(arry, value, ",");
		DKCreator::RunApp(arry[0], arry[1], arry[2]);
	}
	if(DKWidget::Type(event,"BuildLibraries")){
		DKString value = event->GetValue();
		DKStringArray arry;
		toStringArray(arry, value, ",");
		DKQueue("BuildAllLibs "+arry[0]+" "+arry[1], boost::bind(&DKCreator::BuildLibs, this, arry[0], arry[1]));
	}
	if(DKWidget::Type(event,"BuildLib")){
		DKString value = event->GetValue();
		DKStringArray arry;
		toStringArray(arry, value, ",");
		DKQueue("BuildLib "+arry[0]+" "+arry[1]+" "+arry[2], boost::bind(&DKCreator::BuildLib, this, arry[0], arry[1], arry[2]));
	}
	if(DKWidget::Type(event,"GenerateTemplate")){
		DKString file = event->GetValue();
		DKCreator::GenerateTemplate(file);
	}
}

///////////////////////////////////////////
void DKCreator::NewApp(const DKString& app)
{
	DKString dk = GetGrid("DKPATH");
	DKString dkplugins = GetGrid("DKPLUGINS");
	if(!DKFile::Exists(dk+"/MyApps/")){
		DKFile::MakeDir(dk+"/MyApps/");
	}
	if(DKFile::Exists(dk+"/MyApps/"+app)){
		DKLog(app+" folder already exists. \n",DKWARN);
		//return false;
		return;
	}

	DKString apppath = dk+"/MyApps/"+app;
	DKFile::MakeDir(apppath);

	/// Import any missing template files
	DKFile::Copy(dkplugins+"/DKApp", apppath, false, true); 
}

///////////////////////////////////////////
bool DKCreator::OSCheck(const DKString& os)
{
	if(os.empty()){
		DKLog("Please select an Operating System.\n",DKERROR);
		return false;
	}

	//DKLog("DKCreator::OSCheck("+os+")\n");

	if(has(os,"WIN32")){ // Windows x86
		#if !defined(WIN32) && !defined(WIN64)
 			DKLog("Windows x86 binaries must be build from a Window Operating System.\n",DKERROR);
			return false;
		#endif
			return true;
	}
	if(has(os,"WIN64")){ // Windows x64
		#if !defined(WIN32) && !defined(WIN64)
			DKLog("Windows x64 binaries  must be build from a Window x64 Operating System.\n",DKERROR);
			return false;
		#endif
			return true;
	}
	if(has(os,"MAC")){ //Mac
		#if !defined(MAC)
			DKLog("Mac OSX binaries  must be build from a Mac Operating System.\n",DKERROR);
			return false;
		#endif
			return true;
	}
	if(has(os,"IOS")){ //iOS
		#if !defined(MAC)
			DKLog("iOS binaries  must be build from a Mac Operating System.\n",DKERROR);
			return false;
		#endif
			return true;
	}
	if(has(os,"IOSSIMULATOR")){ //iOS
		#if !defined(MAC)
			DKLog("iOS simulator binaries  must be build from a Mac Operating System.\n",DKERROR);
			return false;
		#endif
			return true;
	}
	if(has(os,"ANDROID")){ //Android
		#if !defined(WIN32) && !defined(WIN64)
			DKLog("Android binaries  must be build from a Window Operating System.\n",DKERROR);
			return false;
		#endif
			return true;
	}
	if(has(os,"LINUX")){ //Linux
		#if !defined(LINUX)
			DKLog("Linux binaries  must be build from a Linux Operating System.\n",DKERROR);
			return false;
		#endif
			return true;
	}

	DKLog("OSCheck(): Unhandled error! \n", DKERROR);
	return false;
}


///////////////////////////////////////////////
bool DKCreator::VerifyTools(const DKString& os)
{
	if(!OSCheck(os)){ return false; }

	if(!DKFile::Exists(DKApp::datapath+"DKCreator/TOOLS.dkxml")){
		DKLog(DKApp::datapath+"DKCreator/TOOLS.dkxml not found! \n", DKERROR);
		return false;
	}

	DKXml xml;
	xml.LoadDocument(DKApp::datapath+"DKCreator/TOOLS.dkxml");
	DKString toolsstring = xml.GetNodeValue(os);

	if(toolsstring.empty()){
		DKLog("Cannot get tools list from TOOLS.dkxml \n", DKERROR);
		return false;
	}

	DKStringArray tools;
	toStringArray(tools, toolsstring, " ");
	
	//remove unfound files
	for(unsigned int i=0; i<tools.size(); ++i){
		if(!DKFile::Exists(DKApp::datapath+"DKCreator/"+tools[i])){
			tools.erase(tools.begin()+i);
			i--;
		}
	}

	if(tools == DKStringArray(0)){
		DKLog("VerifyTools(): tools array is NULL! \n", DKERROR);
		return false;
	}
	
	//Work with the tools array
	for(unsigned int i = 0; i<tools.size(); ++i){
		VerifyTool(os,tools[i]);
	}

	return true;
}

////////////////////////////////////////////////////////////////////
bool DKCreator::VerifyTool(const DKString& os, const DKString& file)
{
	DKLog("DKCreator::VerifyTool("+os+", "+file+")\n", DKDEBUG);

	DKString workingOS;
	GetSystemOS(workingOS);

	if(!DKFile::Exists(DKApp::datapath+"DKCreator/"+file)){
		DKLog(DKApp::datapath+"DKCreator/"+file+" not found! \n", DKERROR);
		return false;
	}

	DKXml xml;
	xml.LoadDocument(DKApp::datapath+"DKCreator/"+file);

	//// Verify
	DKString verify;

	verify = xml.GetNodeValue("/"+workingOS+"/VERIFY");
	if(verify.empty()){
		verify = xml.GetNodeValue("/VERIFY");
	}
	if(verify.empty()){
		DKLog("We can't seem to find a <VERIFY> tag or variable\n", DKINFO);
		return false;
	}

	ReplaceVariables(workingOS,verify);

	if(!DKFile::Exists(verify)){
		DKCreator::InstallTool(os, file);
	}
	
	if(!DKFile::Exists(verify)){
		DKLog("Error installing "+file+"\n", DKERROR);
		return false;
	}

	//add exe to grid
	DKString exe;
	exe = xml.GetNodeValue("/"+workingOS+"/EXE");
	if(exe.empty()){
		exe = xml.GetNodeValue("/EXE");
	}

	if(!exe.empty()){
		DKString tool = file;
		DKFile::RemoveExtention(tool);
		DKString shortname;
		DKFile::GetShortName(exe, shortname);
		AddToGrid(tool+"_EXE",shortname);
	}

	DKLog("Found "+file+"\n", DKINFO);
	return true;
}

///////////////////////////////////////////////////
bool DKCreator::VerifyLibraries(const DKString& os)
{
	if(!OSCheck(os)){ return false; }

	if(!DKFile::Exists(DKApp::datapath+"DKCreator/LIBRARIES.dkxml")){
		DKLog(DKApp::datapath+"DKCreator/LIBRARIES.dkxml not found! \n", DKERROR);
		return false;
	}

	DKXml xml;
	xml.LoadDocument(DKApp::datapath+"DKCreator/LIBRARIES.dkxml");

	//// Verify
    
	DKString libraries;
	libraries = xml.GetNodeValue("/LIBRARIES");
	if(libraries.empty()){
		DKLog("Cannot get library list from LIBRARIES.dkxml \n", DKERROR);
		return false;
	}

	DKStringArray libs;
	toStringArray(libs, libraries, " ");
	
	//remove unfound files
	for(unsigned int i=0; i<libs.size(); ++i){
		if(!DKFile::Exists(DKApp::datapath+"DKCreator/"+libs[i])){
			libs.erase(libs.begin()+i);
			i--;
		}
	}

	if(libs == DKStringArray(0)){
		DKLog("VerifyLibraries():  libraries array is NULL! \n", DKERROR);
		return false;
	}
	
	//Work with the library array
	for(unsigned int i = 0; i<libs.size(); ++i){
		VerifyLibrary(os,libs[i]);
	}

	return true;
}

///////////////////////////////////////////////////////////////////////
bool DKCreator::VerifyLibrary(const DKString& os, const DKString& file)
{
	DKLog("DKCreator::VerifyLibrary("+os+", "+file+")\n", DKDEBUG);

	if(!DKFile::Exists(DKApp::datapath+"DKCreator/"+file)){
		DKLog(DKApp::datapath+"DKCreator/"+file+" not found! \n", DKERROR);
		return false;
	}

	DKXml xml;
	xml.LoadDocument(DKApp::datapath+"DKCreator/"+file);

	//// Verify
	DKString verify;
	verify = xml.GetNodeValue("/"+os+"/VERIFY");
	if(verify.empty()){
		verify = xml.GetNodeValue("/VERIFY");	
	}
	if(verify.empty()){
		DKLog("We can't seem to find a <VERIFY> tag or variable\n", DKINFO);
		return false;	
	}

	ReplaceVariables(os,verify);

	if(!DKFile::Exists(verify)){
		DKCreator::InstallLibrary(os, file);
	}

	//DKLog("Found "+file+"\n"); //Lib is installed
	return true;
}

/////////////////////////////////////////////////////////////////////
bool DKCreator::InstallTool(const DKString& os, const DKString& file)
{
	DKLog("DKCreator::InstallTool("+os+", "+file+")\n", DKDEBUG);

	DKString workingOS;
	GetSystemOS(workingOS);

	RunScriptNode(DKApp::datapath+"DKCreator/"+file, "INSTALL", workingOS);
	return true;
}

////////////////////////////////////////////////////////////////////////
bool DKCreator::InstallLibrary(const DKString& os, const DKString& file)
{
	DKLog("DKCreator::InstallLibrary("+os+", "+file+")\n", DKDEBUG);

	RunScriptNode(DKApp::datapath+"DKCreator/"+file, "INSTALL", os);

	//Install a marker file to signal the library instalation is valid.
	DKXml xml;
	xml.LoadDocument(DKApp::datapath+"DKCreator/"+file);

	//// libpath
	DKString libpath;
    libpath = xml.GetNodeValue("/"+os+"/PATH");
	if(libpath.empty()){
		libpath = xml.GetNodeValue("/PATH");
	}
	if(libpath.empty()){
		DKLog("We can't seem to find a <PATH> tag or variable\n", DKINFO);
		return false;
	}
	ReplaceVariables(os,libpath);

	//DKFile::CreateFile(libpath+"/dk");

	DKString libname;
	DKFile::GetFileName(libpath, libname);

	return true;
}

/////////////////////////////////////////////////////
bool DKCreator::PatchLibrary(const DKString& libpath)
{
	DKString lib = libpath;
	DKFile::GetFileName(libpath, lib);
	DKLog("DKCreator::PatchLibrary("+lib+")\n", DKDEBUG);
	DKString libs = GetGrid("DKLIBS");
	DKFile::CopyDirectory(libs+"/_patches/"+lib, libs+"/"+lib, true, true);
	return true;
}

/////////////////////////////////////////////////////////////////////
void DKCreator::AddToGrid(const DKString& str1, const DKString& str2)
{
	//TODO - replace this with std::map
	DKStringArray temp;
	temp.push_back(str1);
	temp.push_back(str2);
	datagrid.push_back(temp);
}

///////////////////////////////////////////////////
DKString DKCreator::GetGrid(const DKString& string)
{
	//TODO - replace this with std::map
	//search grid for string and return the next string in the vector
	for(unsigned int i=0; i<datagrid.size(); ++i){
		for(unsigned int b=0; b<datagrid[i].size(); ++b){
			if(datagrid[i][b].compare(string) == 0){
				return datagrid[i][b+1];
			}
		}
	}
	DKLog("Error: GetGrid() "+string+" not found in the grid. \n", DKWARN);
	return "";
}

///////////////////////////////////////////////////////////////////////////////////////
bool DKCreator::BuildLib(const DKString& lib, const DKString& os, const DKString& type)
{
	if(!OSCheck(os)){return false;}
	VerifyTools(os);
	VerifyLibrary(os,lib);
	DKLog("*******  Building "+lib+" for "+os+" - "+type+" ********\n", DKINFO);
	DKCreator::MakeLib(lib,os,type);
    DKLog("\nDone building libraries.\n",DKINFO);
	return true;
}

///////////////////////////////////////////////////////////////////
bool DKCreator::BuildLibs(const DKString& os, const DKString& type)
{
	if(!OSCheck(os)){return false;}
	VerifyTools(os);
	DKLog("*******  Building Libraries for "+os+" ********\n", DKINFO);
	if(!OSCheck(os)){ return false; }
	if(!DKFile::Exists(DKApp::datapath+"DKCreator/LIBRARIES.dkxml")){
		DKLog(DKApp::datapath+"DKCreator/LIBRARIES.dkxml not found! \n", DKERROR);
		return false;
	}

	DKXml xml;
	xml.LoadDocument(DKApp::datapath+"DKCreator/LIBRARIES.dkxml");

	DKString libraries;
	libraries = xml.GetNodeValue("/LIBRARIES");
    if(libraries.empty()){
		DKLog("Cannot get library list from LIBRARIES.dkxml \n", DKERROR);
		return false;
	}

	DKStringArray libs;
	toStringArray(libs, libraries, " ");
	
	//remove unfound files
	for(unsigned int i=0; i<libs.size(); ++i){
		if(!DKFile::Exists(DKApp::datapath+"DKCreator/"+libs[i])){
			libs.erase(libs.begin()+i);
			i--;
		}
	}

	if(libs == DKStringArray(0)){
		DKLog("DKCreator::BuildLibs():  libraries array is NULL! \n", DKERROR);
		return false;
	}

	//Work with the library array
	for(unsigned int i=0; i<libs.size(); ++i){
		VerifyLibrary(os,libs[i]);
		DKLog("verified "+libs[i], DKINFO);
		//DKQueue("Compile " + libs[i], boost::bind(&DKCreator::MakeLib, this, libs[i], os, type));
		DKCreator::MakeLib(libs[i], os, type);
	}

    DKLog("\nDone queueing libraries.\n",DKINFO);
	return true;
}

// TODO:
// Rebuild simply removes build files and asset files already provided by the repository in MakeApp().
// How about we remove all svn "un-versioned" files. 
// If it's not under svn control, delete it, MakeApp will replace missing files. 
//
/////////////////////////////////////////////////////////////////////////////////////////
bool DKCreator::RebuildApp(const DKString& app, const DKString& os, const DKString& type)
{
	if (!OSCheck(os)){ return false; }
	DKString apppath;
	if(!GetAppPath(app, apppath)){ return false; }
	VerifyTools(os);
	//VerifyLibraries(os);

	DKLog("*******  Rebuilding " + app + " for " + os + " - "+type+ " ********\n", DKINFO);

	DKString dk = GetGrid("DKPATH");

	//Remove all unversioned files
	//DKFile::ChDir(apppath);
	//DKUtil::Execute("for /f \"usebackq tokens=2*\" %i in (`svn status ^| findstr /r \"^\?\"`) do svn delete --force \"%i %j\"");
	
	// Remove core DK files
	DKFile::Delete(apppath + "/CMakeLists.txt");
	DKFile::Delete(apppath + "/Android.h");

	//need to unload any running dll's here
	//DKVideo::unloaddlls();

	DKFile::RemoveDirectory(apppath + "/assets/DK");
	
	if (same(os, "WIN32")){
		DKString path = apppath + "/win32";
		DKStringArray files;
		DKFile::GetDirectoryContents(path, files);
		for (unsigned int i = 0; i<files.size(); ++i){
			if (!DKFile::IsDirectory(path + "/" + files[i].c_str())){ //Folders
				DKFile::Delete(path + "/" + files[i]);
			}
		}
		DKFile::RemoveDirectory(path + "/CMakeFiles");
		DKFile::RemoveDirectory(path + "/DKCreator.dir");
		DKFile::RemoveDirectory(path + "/ZERO_CHECK.dir");
	}

	if (same(os, "WIN64")){
		DKString path = apppath + "/win64";
		DKStringArray files;
		DKFile::GetDirectoryContents(path, files);
		for (unsigned int i = 0; i<files.size(); ++i){
			if (!DKFile::IsDirectory(path + "/" + files[i].c_str())){ //Folders
				DKFile::Delete(path + "/" + files[i]);
			}
		}
		DKFile::RemoveDirectory(path + "/CMakeFiles");
		DKFile::RemoveDirectory(path + "/DKCreator.dir");
		DKFile::RemoveDirectory(path + "/ZERO_CHECK.dir");
	}

	if (same(os, "MAC")){
		DKFile::RemoveDirectory(apppath + "/mac");
	}
	if (same(os, "IOS")){
		DKFile::RemoveDirectory(apppath + "/ios");
	}
	if (same(os, "IOSSIMULATOR")){
		DKFile::RemoveDirectory(apppath + "/ios-simulator");
	}
	if (same(os, "LINUX")){
		DKString path = apppath + "/linux";
		DKStringArray files;
		DKFile::GetDirectoryContents(path, files);
		for (unsigned int i = 0; i<files.size(); ++i){
			if (!DKFile::IsDirectory(path + "/" + files[i].c_str())){ //Folders
				DKFile::Delete(path + "/" + files[i]);
			}
		}
		DKFile::RemoveDirectory(path + "/CMakeFiles");
		DKFile::RemoveDirectory(path + "/DKCreator.dir");
		DKFile::RemoveDirectory(path + "/ZERO_CHECK.dir");
	}
	if (same(os, "ANDROID")){
		DKFile::RemoveDirectory(apppath + "/android");
	}

	GetDKAssets(app, os, true);
	MakeApp(app, os, type);
	return true;
}

///////////////////////////////////////////////////////////////////////////////////////
bool DKCreator::BuildApp(const DKString& app, const DKString& os, const DKString& type)
{
	DKLog("DKCreator::BuildApp("+app+","+os+")\n", DKDEBUG);
	if(!OSCheck(os)){return false;}
	VerifyTools(os);
	//VerifyLibraries(os);
		
	DKLog("*******  Building "+app+" for "+os+" - "+type+" ********\n", DKINFO);

	GetDKAssets(app, os, false);
	DKCreator::MakeApp(app, os, type);
	
	return true;
}

///////////////////////////////////////////////////////////////////////////
bool DKCreator::CreateAssetsHeader(const DKString& app, const DKString& os)
{
	if(same(os,"ANDROID")){
		return false; //Android puts it's assets into the APK file, no need for assets.h
	}
	DKString apppath;
	if(!GetAppPath(app, apppath)){ return false; }

	DKLog("Recreating assets package file ... \n", DKWARN);
	DKString dk = GetGrid("DKPATH");
	
#ifdef WIN32
	DKArchive::Compress(apppath+"/assets", apppath+"/assets.zip");
#else
	//FIXME - assets get too big for the heap to compile
	//DKAssets::PackageAssets(apppath + "/assets", apppath + "/assets.h");
#endif
	return true;
}

/////////////////////////////////////////////////////////////////////////////////////////
bool DKCreator::CopyAssets(const DKString& app, const DKString& os, const DKString& type)
{
	if(!OSCheck(os)){return false;}
	DKString apppath;
	if(!GetAppPath(app, apppath)){ return false; }
	DKString dk = GetGrid("DKPATH");

	DKLog("Copying assets . . .\n", DKINFO);
	
	if(same(os,"WIN32")){
		DKFile::MakeDir(apppath+"/win32");
		if(same(type,"Debug") || same(type, "ALL")){
			DKFile::MakeDir(apppath+"/win32/Debug");
			DKFile::MakeDir(apppath+"/win32/Debug/"+app);
			DKFile::Copy(apppath+"/assets", apppath+"/win32/Debug/"+app, true, true);
			DKFile::Copy(apppath+"/icons/windows/icon.ico", apppath+"/win32/Debug/"+app+"/icon.ico", true, true);
		}
		if(same(type,"Release") || same(type, "ALL")){
			DKFile::MakeDir(apppath+"/win32/Release");
			DKFile::MakeDir(apppath+"/win32/Release/"+app);
			DKFile::Copy(apppath+"/assets", apppath+"/win32/Release/"+app, true, true);
			DKFile::Copy(apppath+"/icons/windows/icon.ico", apppath+"/win32/Release/"+app+"/icon.ico", true, true);
		}
		return true;
	}

	if(same(os,"WIN64")){
		DKFile::MakeDir(apppath+"/win64");
		if(same(type,"Debug") || same(type, "ALL")){
			DKFile::MakeDir(apppath+"/win64/Debug");
			DKFile::MakeDir(apppath+"/win64/Debug/"+app);
			DKFile::Copy(apppath+"/assets", apppath+"/win64/Debug/"+app, true, true);
			DKFile::Copy(apppath+"/icons/windows/icon.ico", apppath+"/win64/Debug/"+app+"/icon.ico", true, true);
		}
		if(same(type,"Release") || same(type, "ALL")){
			DKFile::MakeDir(apppath+"/win64/Release");
			DKFile::MakeDir(apppath+"/win64/Release/"+app);
			DKFile::Copy(apppath+"/assets", apppath+"/win64/Release/"+app, true, true);
			DKFile::Copy(apppath+"/icons/windows/icon.ico", apppath+"/win64/Release/"+app+"/icon.ico", true, true);
		}
		return true;
	}

	if(same(os,"MAC")){
		DKFile::MakeDir(apppath+"/mac");
		if(same(type,"Debug") || same(type, "ALL")){
			DKFile::MakeDir(apppath+"/mac/Debug");
			DKFile::MakeDir(apppath+"/mac/Debug/"+app+".app/Contents/Resources");
			DKFile::Copy(apppath+"/assets", apppath+"/mac/Debug/"+app+".app/Contents/MacOS", true, true);
			DKFile::Copy(apppath+"/icons/mac/logo.icns", apppath+"/mac/Debug/"+app+".app/Contents/Resources/logo.icns", true, true);
		}
		if(same(type,"Release") || same(type, "ALL")){
			DKFile::MakeDir(apppath+"/mac/Release");
			DKFile::MakeDir(apppath+"/mac/Release/"+app+".app/Contents/Resources");
			DKFile::Copy(apppath+"/assets", apppath+"/mac/Release/"+app+".app/Contents/MacOS", true, true);
			DKFile::Copy(apppath+"/icons/mac/logo.icns", apppath+"/mac/Release/"+app+".app/Contents/Resources/logo.icns", true, true);
		}
		//Update info.plist file
		DKLog("Updating info.plist . . .\n", DKINFO);
		if(same(type,"Debug") || same(type, "ALL")){
			DKString plist;
			if(!DKFile::FileToString(apppath+"/mac/Debug/"+app+".app/Contents/info.plist",plist)){
				DKLog("DKFile::FileToString(info.plist) failed! \n", DKERROR);
			}
			replace(plist, "<key>CFBundleIconFile</key>", "");
			replace(plist, "<string>logo</string>", "");
			replace(plist, "<dict>","<dict><key>CFBundleIconFile</key><string>logo</string>");
			DKFile::StringToFile(plist, apppath+"/mac/Debug/"+app+".app/Contents/info.plist");
		}
		
		if(same(type,"Release") || same(type, "ALL")){
			DKString plist;
			if(!DKFile::FileToString(apppath+"/mac/Release/"+app+".app/Contents/info.plist",plist)){
				DKLog("DKFile::FileToString(info.plist) failed! \n", DKERROR);
			}
			replace(plist, "<key>CFBundleIconFile</key>", "");
			replace(plist, "<string>logo</string>", "");
			replace(plist, "<dict>","<dict><key>CFBundleIconFile</key><string>logo</string>");
			DKFile::StringToFile(plist, apppath+"/mac/Release/"+app+".app/Contents/info.plist");
		}
		return true;
	}

	if(same(os,"IOS")){	
		DKFile::MakeDir(apppath+"/ios");
		if(same(type,"Debug") || same(type, "ALL")){
			DKFile::MakeDir(apppath+"/ios/Debug");
			DKFile::MakeDir(apppath+"/ios/Debug/"+app+".app");
			DKFile::Copy(apppath+"/assets", apppath+"/ios/Debug/"+app+".app", true, true);
			DKFile::Copy(apppath+"/icons/ios", apppath+"/ios/Debug/"+app+".app", true, true);
		}
		if(same(type,"Release") || same(type, "ALL")){
			DKFile::MakeDir(apppath+"/ios/Release");
			DKFile::MakeDir(apppath+"/ios/Release/"+app+".app");
			DKFile::Copy(apppath+"/assets", apppath+"/ios/Release/"+app+".app", true, true);
			DKFile::Copy(apppath+"/icons/ios", apppath+"/ios/Release/"+app+".app", true, true);
		}
		
	//Update info.plist file
		/*
		DKLog("Updating info.plist . . .\n");
		DKString plist;
		if(!DKFile::FileToString(apppath+"/ios/Debug/"+app+".app/Contents/info.plist",plist)){
			DKLog("DKFile::FileToString() failed! \n", DKERROR);
		}
        replace(plist, "<key>CFBundleIconFile</key>", "");
        replace(plist, "<string>logo</string>", "");
        replace(plist, "<dict>","<dict><key>CFBundleIconFile</key><string>logo</string>");
		DKFile::StringToFile(plist, apppath+"/ios/Debug/"+app+".app/Contents/info.plist");
		DKFile::StringToFile(plist, apppath+"/ios/Release/"+app+".app/Contents/info.plist");
		*/

		return true;
	}

	if(same(os,"IOSSIMULATOR")){	
		DKFile::MakeDir(apppath+"/ios-simulator");
		if(same(type,"Debug") || same(type, "ALL")){
			DKFile::MakeDir(apppath+"/ios-simulator/Debug");
			DKFile::MakeDir(apppath+"/ios-simulator/Debug/"+app+".app");
			DKFile::Copy(apppath+"/assets", apppath+"/ios-simulator/Debug/"+app+".app", true, true);
			DKFile::Copy(apppath+"/icons/ios", apppath+"/ios-simulator/Debug/"+app+".app", true, true);
		}
		if(same(type,"Release") || same(type, "ALL")){
			DKFile::MakeDir(apppath+"/ios-simulator/Release");
			DKFile::MakeDir(apppath+"/ios-simulator/Release/"+app+".app");
			DKFile::Copy(apppath+"/assets", apppath+"/ios-simulator/Release/"+app+".app", true, true);
			DKFile::Copy(apppath+"/icons/ios", apppath+"/ios-simulator/Release/"+app+".app", true, true);
		}

		//Update info.plist file
		/*
		DKLog("Updating info.plist . . .\n");
		DKString plist;
		if(!DKFile::FileToString(apppath+"/ios-simulator/Debug/"+app+".app/Contents/info.plist",plist)){
			DKLog("DKFile::FileToString() failed! \n", DKERROR);
		}
        replace(plist, "<key>CFBundleIconFile</key>", "");
        replace(plist, "<string>logo</string>", "");
        replace(plist, "<dict>","<dict><key>CFBundleIconFile</key><string>logo</string>");
		DKFile::StringToFile(plist, apppath+"/ios-simulator/Debug/"+app+".app/Contents/info.plist");
		DKFile::StringToFile(plist, apppath+"/ios-simulator/Release/"+app+".app/Contents/info.plist");
		*/

		return true;
	}

	if(same(os,"ANDROID")){
		DKFile::MakeDir(apppath+"/android");
		if(same(type,"Debug") || same(type, "ALL")){
			DKFile::MakeDir(apppath+"/android/Debug");
			DKFile::Copy(apppath+"/assets", apppath+"/android/Debug/assets", true, true);
			DKFile::Copy(apppath+"/icons/android", apppath+"/android/Debug/res", true, true);
		}
		if(same(type,"Release") || same(type, "ALL")){
			DKFile::MakeDir(apppath+"/android/Release");
			DKFile::Copy(apppath+"/assets", apppath+"/android/Release/assets", true, true);
			DKFile::Copy(apppath+"/icons/android", apppath+"/android/Release/res", true, true);
		}

		/// OpenGL 1
		/*
		DKLog("Creating Directoriess . . .\n");
		DKFile::MakeDir(apppath+"/android-GL1");
		DKFile::MakeDir(apppath+"/android-GL1/Debug");
		DKFile::MakeDir(apppath+"/android-GL1/Release");
			
		//copy assets
		DKLog("Copying assets . . .\n");
		DKFile::Copy(apppath+"/assets", apppath+"/android-GL1/Debug/assets", true);
		DKFile::Copy(apppath+"/assets", apppath+"/android-GL1/Release/assets", true);

		//copy icons
		DKLog("Copying icon . . .\n");
		DKFile::Copy(apppath+"/icons/android", apppath+"/android-GL1/Debug/res", true);
		DKFile::Copy(apppath+"/icons/android", apppath+"/android-GL1/Release/res", true);

		*/

		return true;
	}

	// TODO - linux icons
	if(same(os,"LINUX")){
		DKFile::MakeDir(apppath+"/linux");
		if(same(type,"Debug") || same(type, "ALL")){
			DKFile::MakeDir(apppath+"/linux/Debug");
			DKFile::MakeDir(apppath+"/linux/Debug/"+app+"-Data");
			DKFile::Copy(apppath+"/assets", apppath+"/linux/Debug/"+app+"-Data", true, true);
		}
		if(same(type,"Release") || same(type, "ALL")){
			DKFile::MakeDir(apppath+"/linux/Release");
			DKFile::MakeDir(apppath+"/linux/Release/"+app+"-Data");
			DKFile::Copy(apppath+"/assets", apppath+"/linux/Release/"+app+"-Data", true, true);
		}
		return true;
	}

	DKLog("Could not copy assets! \n", DKERROR);
	return false;
}

/////////////////////////////////////////////////////////////////////////////////////
bool DKCreator::RunApp(const DKString& app, const DKString& os, const DKString& type)
{
	if(!OSCheck(os)){return false;}
	DKString apppath;
	if(!GetAppPath(app, apppath)){ return false; }
	DKString buildtype = type;
	if(same(buildtype,"ALL")){ buildtype = "Release"; }
	
	DKString dk = GetGrid("DKPATH");

	if(same(os,"WIN32")){
		if(DKFile::Exists(apppath+"/win32/"+buildtype+"/"+app+".exe")){
			DKUtil::Run(apppath+"/win32/"+buildtype+"/"+app+".exe");
			return true;
		}
	}
	if(same(os,"WIN64")){
		if(DKFile::Exists(apppath+"/win64/"+buildtype+"/"+app+"_64.exe")){
			DKUtil::Run(apppath+"/win64/"+buildtype+"/"+app+"_64.exe");
			return true;
		}
	}
	
	DKLog("DKCreator::RunApp(): Not implemented for "+os+" \n", DKERROR);
	return false;
}

/////////////////////////////////////////////////////////
bool DKCreator::UpdateAndroidAppName(const DKString& app)
{
	if(same(app, "DKApp")){ return true; }
	DKString apppath;
	if(!GetAppPath(app, apppath)){ return false; }
	
	DKLog("Updating Android App name in files...\n", DKINFO);

	DKString dk = GetGrid("DKPATH");
	
	DKString android_H;
	DKFile::FileToString(apppath+"/Android.h", android_H);
	replace(android_H, "_DKApp_", "_"+app+"_");
	replace(android_H, "\"DKApp\"", "\""+app+"\"");
	DKFile::StringToFile(android_H, apppath+"/Android.h");

	DKString androidManifest;
	DKFile::FileToString(apppath+"/android/Debug/AndroidManifest.xml", androidManifest);
	replace(androidManifest, "DKApp", app);
	DKFile::StringToFile(androidManifest, apppath+"/android/Debug/AndroidManifest.xml");
	DKFile::Copy(apppath+"/android/Debug/AndroidManifest.xml", apppath+"/android/Release/AndroidManifest.xml", true, true);

	DKString stringsxml;
	DKFile::FileToString(apppath+"/android/Debug/res/values/strings.xml", stringsxml);
	replace(stringsxml, "DKApp", app);
	DKFile::StringToFile(stringsxml, apppath+"/android/Debug/res/values/strings.xml");
	DKFile::Copy(apppath+"/android/Debug/res/values/strings.xml", apppath+"/android/Release/res/values/strings.xml", true, true);

	DKString ui_layout_gles;
	DKFile::FileToString(apppath+"/android/Debug/res/layout/ui_layout_gles.xml", ui_layout_gles);
	replace(ui_layout_gles, "DKApp", app);
	DKFile::StringToFile(ui_layout_gles, apppath+"/android/Debug/res/layout/ui_layout_gles.xml");
	DKFile::Copy(apppath+"/android/Debug/res/layout/ui_layout_gles.xml", apppath+"/android/Release/res/layout/ui_layout_gles.xml", true, true);

	DKFile::Rename(apppath+"/android/Debug/src/DigitalKnob/DKApp", apppath+"/android/Debug/src/DigitalKnob/"+app, true);
	DKFile::Rename(apppath+"/android/Release/src/DigitalKnob/DKApp", apppath+"/android/Release/src/DigitalKnob/"+app, true);

	DKString dkandroid;
	DKFile::FileToString(apppath+"/android/Debug/src/DigitalKnob/"+app+"/DKAndroid.java", dkandroid);
	replace(dkandroid, "DKApp", app);
	DKFile::StringToFile(dkandroid, apppath+"/android/Debug/src/DigitalKnob/"+app+"/DKAndroid.java");
	DKFile::Copy(apppath+"/android/Debug/src/DigitalKnob/"+app+"/DKAndroid.java", apppath+"/android/Release/src/DigitalKnob/"+app+"/DKAndroid.java", true, true);

	DKString dkmain;
	DKFile::FileToString(apppath+"/android/Debug/src/DigitalKnob/"+app+"/DKMain.java", dkmain);
	replace(dkmain, "DKApp", app);
	DKFile::StringToFile(dkmain, apppath+"/android/Debug/src/DigitalKnob/"+app+"/DKMain.java");
	DKFile::Copy(apppath+"/android/Debug/src/DigitalKnob/"+app+"/DKMain.java", apppath+"/android/Release/src/DigitalKnob/"+app+"/DKMain.java", true, true);

	DKString eglview;
	DKFile::FileToString(apppath+"/android/Debug/src/DigitalKnob/"+app+"/EGLview.java", eglview);
	replace(eglview, "DKApp", app);
	DKFile::StringToFile(eglview, apppath+"/android/Debug/src/DigitalKnob/"+app+"/EGLview.java");
	DKFile::Copy(apppath+"/android/Debug/src/DigitalKnob/"+app+"/EGLview.java", apppath+"/android/Release/src/DigitalKnob/"+app+"/EGLview.java", true, true);

	return true;
}

/////////////////////////////////
bool DKCreator::BuildEVERYTHING()
{
	// Holy molly, let's blow the computer up for 2 days :D
	DKLog("\n\n ##### Building ALL Libraries for ALL operating systems ##### \n\n", DKINFO);
	//BuildLibs("Windows 32");
	//BuildLibs("Windows 64");
	//BuildLibs("Mac");
	//BuildLibs("iOS");
	//BuildLibs("Android");
	//BuildLibs("Linux");

	DKLog("\n\n ##### Building ALL Apps for ALL operating systems ##### \n\n", DKINFO);
	DKString OS;
	DKStringArray applist;
	DKString* cast = static_cast<DKString*>(GetAppList(""));
	DKString temp = *cast;
	toStringArray(applist, temp, ",");
	for(int i=0;i<7;++i){
		if(i==0){OS = "WIN32";}
		if(i==1){OS = "WIN64";}
		if(i==2){OS = "MAC";}
		if(i==3){OS = "IOS";}
		if(i==4){OS = "IOSSIMULATOR";}
		if(i==5){OS = "ANDROID";}
		if(i==6){OS = "LINUX";}
		for(unsigned int b=0;b<applist.size();++b){
			BuildApp(applist[b],OS,"ALL");
		}
	}
	DKLog("\n\nFINNISHED BUILDING EVERYTHING!\n\n",DKINFO);
	return true;
}

///////////////////////////
void DKCreator::SvnUpdate()
{
	DKString workingOS;
	GetSystemOS(workingOS);
	VerifyTool(workingOS, "SUBVERSION.dktool");
	DKString dk = GetGrid("DKPATH");
	DKString svn = GetGrid("SUBVERSION_EXE");

	//DigitalKnob SVN
	DKString address = DKFile::GetSetting(DKApp::datapath+"settings.txt", "[SVN]");
	if(address.empty()){ 
		DKLog("[SVN] not set in settings.txt file \n", DKERROR); 
		//return error; 
	};
	DKLog("SVN Cleanup . . . . .\n", DKINFO);
	DKUtil::Execute(svn+" cleanup "+dk);
	DKLog("SVN Update . . . . .\n", DKINFO);
	DKUtil::Execute(svn+" checkout "+address+" "+dk);

	//User SVN
	DKString mysvn = DKFile::GetSetting(DKApp::datapath+"settings.txt", "[MYSVN]");
	if(mysvn.empty()){ 
		//DKString error = "[MYSVN] not set in settings.txt file \n";
		DKLog("[MYSVN] not set in settings.txt file \n", DKWARN); 
		return; 
	};
	DKFile::MakeDir(dk+"/MyApps");
	DKLog("SVN Cleanup . . . . .\n", DKINFO);
	DKUtil::Execute(svn+" cleanup "+dk+"/MyApps");
	DKLog("SVN Update . . . . .\n", DKINFO);
	DKUtil::Execute(svn+" checkout --force "+mysvn+" "+dk+"/MyApps");
	
	//return "SvnUpdate";
}

///////////////////////////
void DKCreator::SvnCommit()
{
	DKString workingOS;
	GetSystemOS(workingOS);
	VerifyTool(workingOS, "SUBVERSION.dktool");

	DKString dk = GetGrid("DKPATH");
	DKString svn = GetGrid("SUBVERSION_EXE");

	DKLog("SVN Cleanup . . . . .\n", DKINFO);
	DKUtil::Execute(svn+" cleanup " + dk);
	DKLog("SVN Commit . . . . .\n", DKINFO);
	DKUtil::Execute(svn+" commit -m update "+dk);

	DKString mysvn = DKFile::GetSetting(DKApp::datapath+"settings.txt", "[MYSVN]");
	if(mysvn.empty()){ 
		//DKString error = "DKERROR: [MYSVN] not set in settings.txt file \n";
		DKLog("[MYSVN] not set in settings.txt file \n", DKWARN);
		return; 
	};
	if(DKFile::Exists(dk+"/MyApps")){
		DKLog("SVN Cleanup . . . . .\n", DKINFO);
		DKUtil::Execute(svn+" cleanup " + dk+"/MyApps");
		DKLog("SVN Commit . . . . .\n", DKINFO);
		DKUtil::Execute(svn+" commit -m update "+dk+"/MyApps");
	}

	//return "SvnCommit";
}

/////////////////////////////////////
void* DKCreator::GetAppList(DKString)
{
	DKString dk = GetGrid("DKPATH");

	//Digitalknob repository
	DKStringArray paths;
	DKFile::GetDirectoryContents(dk+"/Apps", paths);
	for(unsigned int i=0; i<paths.size(); ++i){
		if(has(paths[i],".svn") || has(paths[i],"..") || same(paths[i],".")){
			paths.erase(paths.begin()+i,paths.begin()+i+1);
			--i; //don't forget this
		}
	}

	//Personal repository
	DKStringArray paths2;
	DKFile::GetDirectoryContents(dk+"/MyApps", paths2);
	for(unsigned int i=0; i<paths2.size(); ++i){
		if(has(paths2[i],".svn") || has(paths2[i],"..") || same(paths2[i],".")){
			paths2.erase(paths2.begin()+i,paths2.begin()+i+1);
			--i; //don't forget this
		}
	}

	DKStringArray final;
	final.reserve( paths.size() + paths2.size() ); // preallocate memory
	final.insert( final.end(), paths.begin(), paths.end() );
	final.insert( final.end(), paths2.begin(), paths2.end() );

	DKString string;
	for(unsigned int i=0; i<final.size(); ++i){
		string += final[i];
		if(i < final.size()-1){
			string += ",";
		}
	}
	return static_cast<void*>(new DKString(string));
}

/////////////////////////////////////
void* DKCreator::GetLibList(DKString)
{
	if(!DKFile::Exists(DKApp::datapath+"DKCreator/LIBRARIES.dkxml")){
		DKLog(DKApp::datapath+"DKCreator/LIBRARIES.dkxml not found! \n", DKERROR);
		return static_cast<void*>(new DKString(""));
	}

	DKXml xml;
	xml.LoadDocument(DKApp::datapath+"DKCreator/LIBRARIES.dkxml");

	DKString libraries;

    libraries = xml.GetNodeValue("/LIBRARIES");
	if(libraries.empty()){
		DKLog("Cannot get library list from LIBRARIES.dkxml \n", DKERROR);
		return static_cast<void*>(new DKString(""));
	}

	DKStringArray libs;
	toStringArray(libs, libraries, " ");
	
	//remove unfound files
	for(unsigned int i=0; i<libs.size(); ++i){
		if(!DKFile::Exists(DKApp::datapath+"DKCreator/"+libs[i])){
			libs.erase(libs.begin()+i);
			i--;
		}
	}

	if(libs == DKStringArray(0)){
		DKLog("DKCreator::BuildLibs():  libraries array is NULL! \n", DKERROR);
		return static_cast<void*>(new DKString(""));
	}

	//Work with the library array
	DKString liblist = "";
	for(unsigned int i=0; i<libs.size(); ++i){
		liblist += libs[i]+",";
	}

	return static_cast<void*>(new DKString(liblist));
}

/////////////////////////////////////////
void* DKCreator::GetAppPath(DKString app)
{
	DKString string;
	GetAppPath(app, string);
	return static_cast<void*>(new DKString(string));
}

///////////////////////////////////////////////////////////////
bool DKCreator::GetAppPath(const DKString& app, DKString& path)
{
	if(app.empty()){ return false; }
	DKString dk = GetGrid("DKPATH");

	if(DKFile::Exists(dk+"/MyApps/"+app) ){
		path = dk+"/MyApps/"+app;
	}
	else if(DKFile::Exists(dk+"/DKApps/"+app) ){
		path = dk+"/DKApps/"+app;
	}
	else{
		DKLog("Cannot find App \n",DKERROR);
		return false;
	}
	return true;
}

////////////////////////////////////////////////
void DKCreator::GenerateTemplate(DKString& file)
{
	if(file.empty()){ return; }
	DKLog("Generate code files for "+ file +"\n", DKINFO);
	DKString libpath = GetGrid("DKLIBS");
	if(libpath.empty()){ return; }

	/// Generate Javascript File ///
	DKString the_path;
	GetAppPath(DKWidget::GetValue("AppList"), the_path);
	the_path += "/assets/";
	DKString classname = file;
	replace(classname,".html","");

	replace(file, ".html", ".js");
	if(!DKFile::Exists(the_path+file)){
		DKString("Creating... "+the_path+file);
		DKFile::Copy(libpath+"/DigitalKnob/Templates/MyWidget.js", the_path+file, false, false);

		DKString filedata;
		DKFile::FileToString(the_path+file, filedata);
		replace(filedata, "MyWidget", classname);
		DKFile::StringToFile(filedata, the_path+file);
	}

	/*
	/// Generate C++ files ///
	replace(file, ".js", ".h");
	replace(the_path, "assets/", "");
	replace(the_path, "assets\\", "");
	if(!DKFile::Exists(the_path+file)){
		DKString("Creating... "+the_path+file);
		DKFile::Copy(libpath+"/DigitalKnob/Templates/MyWidget.h", the_path+file, false, false);

		DKString filedata;
		DKFile::FileToString(the_path+file, filedata);
		replace(filedata, "MyWidget", classname);
		DKFile::StringToFile(filedata, the_path+file);
	}

	replace(file, ".h", ".cpp");
	if(!DKFile::Exists(the_path+file)){
		DKString("Creating... "+the_path+file);
		DKFile::Copy(libpath+"/DigitalKnob/Templates/MyWidget.cpp", the_path+file, false, false);

		DKString filedata;
		DKFile::FileToString(the_path+file, filedata);
		replace(filedata, "MyWidget", classname);
		DKFile::StringToFile(filedata, the_path+file);
	}
	*/
}

//////////////////////////////////////////////////////////////////////
bool DKCreator::ReplaceVariables(const DKString& os, DKString& string)
{
	//This will find all the ${VARIABLES} in the string and replace with the datagrid info.
	DKString dk = GetGrid("DKPATH");
	int found = 1;

	while(found!=std::string::npos){
		found = string.find("${");
		if(found!=std::string::npos){
			int end = string.find("}",found);
			if(end==std::string::npos){
				DKLog("DKCreator::ReplaceVariables() failed! \n", DKERROR);
				return false;
			}

			DKString variable = string.substr(found+2,end-found-2);

			if(same(variable,"DKLIBS")){
				string.replace(found,end-found+1,GetGrid("DKLIBS"));
			}
			else if(same(variable,"DKPATH")){
				string.replace(found,end-found+1,GetGrid("DKPATH"));
			}
			else if(same(variable,"DKDL")){
				string.replace(found,end-found+1,GetGrid("DKDL"));
			}
			else if(same(variable,"CMAKE_EXE")){
				string.replace(found,end-found+1,GetGrid("CMAKE_EXE"));
			}
			else if(same(variable,"VC2008_EXE")){
				string.replace(found,end-found+1,GetGrid("VC2008_EXE"));
			}
			else if(same(variable,"VC2013_EXE")){
				string.replace(found,end-found+1,GetGrid("VC2013_EXE"));
			}
			else if(same(variable,"XCODE_EXE")){
				string.replace(found,end-found+1,GetGrid("XCODE_EXE"));
			}
			else if(same(variable,"GNUMAKE_EXE")){
				string.replace(found,end-found+1,GetGrid("GNUMAKE_EXE"));
			}
			else if(same(variable,"ANDROID_NDK_EXE")){
				string.replace(found,end-found+1,GetGrid("ANDROID_NDK_EXE"));
			}
			else if(same(variable,"WINDOWS_SDK_EXE")){
				string.replace(found,end-found+1,GetGrid("WINDOWS_SDK_EXE"));
			}
			else{

				//check the grid first
				if(!same(GetGrid(variable),"")){
					string.replace(found,end-found+1,GetGrid(variable));
				}
				else{
					DKXml xml;
					if(!xml.LoadDocument(DKApp::datapath+"DKCreator/"+variable+".dklib")){
						if(!xml.LoadDocument(DKApp::datapath+"DKCreator/"+variable+".dktool")){
							DKLog("Could not find file to load variable "+variable+" \n", DKERROR);
							continue;
						}
					}

					//// Path
					DKString path;
					path = xml.GetNodeValue("/"+os+"/PATH");
					DKString shortname;

					if(path.empty()){
						path = xml.GetNodeValue("/PATH");  //check global tag then
						if(path.empty()){ //we should have a variable by now
							DKLog("We can't seem to find a <PATH> tag or variable\n", DKINFO);
							return false;
						}
						else{
							Trim(path);
							if(DKFile::GetShortName(path, shortname)){
								ReplaceVariables(os,shortname);
							}
							else{
								ReplaceVariables(os,path);
							}
						}
					}
	
					if(shortname.empty()){
						string.replace(found, end - found + 1, path);
						AddToGrid(variable, path);
					}
					else{
						string.replace(found, end - found + 1, shortname);
						AddToGrid(variable, shortname);
					}
				}
			
			}
		}
	}
	return true;
}

////////////////////////////////////////////////////////
bool DKCreator::CopyFiles(const DKStringArray& filelist)
{
	if(filelist == DKStringArray(0)){return true;}

	for(unsigned int i = 0; i<filelist.size(); ++i){
		DKFile::Copy(filelist[i],filelist[i+1],true, true);
		++i;
	}
	return true;
}

////////////////////////////////////////////////////////////////////////////////////
bool DKCreator::GetDKAssets(const DKString& app, const DKString& os, bool overwrite)
{
	DKString apppath;
	if(!GetAppPath(app,apppath)){ return false; }
	DKString dk = GetGrid("DKPATH");
	DKString dkplugins = GetGrid("DKPLUGINS");
	DKFile::Copy(dkplugins+"/DKApp", apppath, false, true); //LOOK - overwrite false happens here for a reason.
	//DKFile::Copy(dkplugins+"/DKApp/assets/DK", apppath+"/assets/DK", overwrite, true);
	
	//If a digitalknob/DKPlugins/DKModule folder has anything other than .h and .app files
	//import them into TheApp/assets/DKModule
	/*
	DKStringArray folders;
	DKFile::GetDirectoryContents(dkplugins, folders);
	for(unsigned int i=0; i < folders.size(); ++i){
		if(DKFile::IsDirectory(dkplugins+"/"+folders[i]) && 
		   has(folders[i],"DK") &&
		   !same(folders[i],"DKApp")){
			DKStringArray files;
			DKFile::GetDirectoryContents(dkplugins+"/"+folders[i], files);
			for(unsigned int b=0; b < files.size(); ++b){
				DKString ext;
				DKFile::GetExtention(dkplugins+"/"+folders[i]+"/"+files[b], ext);
				if(!same(ext,".h") && 
				   !same(ext,".cpp") &&
				   !same(ext,".mm") &&
				   !same(ext,".plist") &&
				   !same(ext,".rc") &&
				   !same(files[b],"CMakeLists.txt") &&
				   !DKFile::IsDirectory(dkplugins+"/"+folders[i]+"/"+files[b])){
					if(!DKFile::Exists(apppath+"/assets/"+folders[i])){
							DKFile::MakeDir(apppath+"/assets/"+folders[i]);
					}
					DKFile::Copy(dkplugins+"/"+folders[i]+"/"+files[b], apppath+"/assets/"+folders[i]+"/"+files[b], overwrite, false);
				}
			}
		}
	}
	*/
	return false;
}

// TODO
// MakeApp() should do what it says. Run the build script for the app only
// anything else should be moved up into BuildApp()
//////////////////////////////////////////////////////////////////////////////////////
bool DKCreator::MakeApp(const DKString& app, const DKString& os, const DKString& type)
{
	DKString apppath;
	if(!GetAppPath(app, apppath)){ return false; }
	
	DKString dk = GetGrid("DKPATH");
	DKString dkplugins = GetGrid("DKPLUGINS");
	DKString cmake = GetGrid("CMAKE_EXE");

	//TODO - use script to build app
	//DKXml xml;
	//xml.LoadDocument(DKApp::datapath+"DKApp.dk");

	if(same(os,"WIN32")){
#if !defined(WIN64)
		DKLog("\n Marking .old files . . .\n", DKINFO);
		if (same(type, "Debug") || same(type, "ALL")){
			DKFile::Rename(apppath + "/win32/Debug/" + app + ".exe", apppath + "/win32/Debug/" + app + ".exe" + ".old", true);
			DKFile::Rename(apppath + "/win32/Debug/" + app + ".pdb", apppath + "/win32/Debug/" + app + ".pdb" + ".old", true);
		}
		if (same(type, "Release") || same(type, "ALL")){
			DKFile::Rename(apppath + "/win32/Release/" + app + ".exe", apppath + "/win32/Release/" + app + ".exe" + ".old", true);
			DKFile::Rename(apppath + "/win32/Release/" + app + ".pdb", apppath + "/win32/Release/" + app + ".pdb" + ".old", true);
		}
#endif
		/*
		DKString vs2008 = GetGrid("VC2008_EXE");
		DKFile::MakeDir(apppath+"/win32");
		DKFile::ChDir(apppath+"/win32");
		DKUtil::System(cmake+" -G \"Visual Studio 9 2008\" -DWIN_32=ON -DCMAKE_SKIP_RPATH=ON "+apppath);
		DKUtil::System(vs2008+" "+apppath+"/win32/"+app+".sln /p:Configuration=Debug");
		DKUtil::System(vs2008+" "+apppath+"/win32/"+app+".sln /p:Configuration=Release");
		*/

		DKString vs2013 = GetGrid("VC2013_EXE");
		DKFile::MakeDir(apppath+"/win32");
		DKFile::ChDir(apppath+"/win32");
		DKUtil::Execute(cmake+" -G \"Visual Studio 12 2013\" -DWIN_32=ON -DCMAKE_SKIP_RPATH=ON "+apppath);
		CreateAssetsHeader(app, os); //Recreate the assets.zip file
		if (same(type, "Debug") || same(type, "ALL")){
			DKUtil::Execute(vs2013 + " " + apppath + "/win32/" + app + ".sln /p:Configuration=Debug");
		}
		if (same(type, "Release") || same(type, "ALL")){
			DKUtil::Execute(vs2013 + " " + apppath + "/win32/" + app + ".sln /p:Configuration=Release");
		}

		/*
		//MSYS
		DKFile::MakeDir(apppath+"/win32");
		DKFile::ChDir(apppath+"/win32");
		DKString gnumake = GetGrid("GNUMAKE_EXE");
		DKString cmakestring = "cd "+apppath+"/win32; "+cmake+" -G \"MSYS Makefiles\" -DWIN_32bit=ON "+apppath;
		DKLog(cmakestring);
		DKFile::SetClipboard(cmakestring);
		DKLog("\n\nPASTE THE CLIPBOARD INTO THE MSYS SHELL, then make and exit\n");
		DKUtil::System("C:/MinGW/msys/1.0/msys.bat");
		*/

		//CopyAssets(app,os);
	}
	if (same(os, "WIN64")){
#ifdef WIN64
		//if(same(app,"DKCreator")){
		DKLog("\n Marking .old files . . .\n", DKINFO);
		if (same(type, "Debug") || same(type, "ALL")){
			DKFile::Rename(apppath+"/win64/Debug/"+app+".exe", apppath+"/win64/Debug/"+app+".exe"+".old", true);
			DKFile::Rename(apppath+"/win64/Debug/"+app+".pdb", apppath+"/win64/Debug/"+app+".pdb"+".old", true);
		}
		if (same(type, "Release") || same(type, "ALL")){
			DKFile::Rename(apppath+"/win64/Release/"+app+".exe", apppath+"/win64/Release/"+app+".exe"+".old", true);
			DKFile::Rename(apppath + "/win64/Release/" + app + ".pdb", apppath + "/win64/Release/" + app + ".pdb" + ".old", true);
		}
		//}
#endif
		/*
		DKString vs2008 = GetGrid("VC2008_EXE");
		DKFile::MakeDir(apppath+"/win64");
		DKFile::ChDir(apppath+"/win64");
		DKUtil::System(cmake+" -G \"Visual Studio 9 2008 Win64\" -DWIN_64=ON "+apppath);
		DKLog("\n Building "+app+" . . .\n");
		DKUtil::System(vs2008+" "+apppath+"/win64/"+app+".sln /p:Configuration=Debug");
		DKUtil::System(vs2008+" "+apppath+"/win64/"+app+".sln /p:Configuration=Release");
		*/

		DKString vs2013 = GetGrid("VC2013_EXE");
		DKFile::MakeDir(apppath+"/win64");
		DKFile::ChDir(apppath+"/win64");
		DKUtil::Execute(cmake+" -G \"Visual Studio 12 2013 Win64\" -DWIN_64=ON "+apppath);
		CreateAssetsHeader(app, os); //Recreate the assets.zip file

		if (same(type, "Debug") || same(type, "ALL")){
			DKUtil::Execute(vs2013 + " " + apppath + "/win64/" + app + ".sln /p:Configuration=Debug");
		}
		if (same(type, "Release") || same(type, "ALL")){
			DKUtil::Execute(vs2013 + " " + apppath + "/win64/" + app + ".sln /p:Configuration=Release");
		}

		//CopyAssets(app,os);
	}

	if(same(os,"MAC")){
		DKString xcode = GetGrid("XCODE_EXE");
		DKFile::MakeDir(apppath+"/mac");
		DKFile::ChDir(apppath+"/mac");
		DKUtil::Execute(cmake+" -G \"Xcode\" -DMAC=ON "+apppath);
		//CreateAssetsHeader(app, os); //Recreate the assets.h file (LINUX,MAC)
		if (same(type, "Debug") || same(type, "ALL")){
			DKUtil::Execute(xcode + " -configuration Debug build");
		}
		if (same(type, "Release") || same(type, "ALL")){
			DKUtil::Execute(xcode + " -configuration Release build");
		}

        CopyAssets(app,os,type);
	}

	if(same(os,"IOS")){
		DKString xcode = GetGrid("XCODE_EXE");
		        
		// iPHONE
		DKFile::MakeDir(apppath+"/ios");
		DKFile::ChDir(apppath+"/ios");
		DKUtil::Execute(cmake+" -G \"Xcode\" -DIPHONE=ON "+apppath);
		//CreateAssetsHeader(app, os); //Recreate the assets.h file (LINUX,MAC)
		if (same(type, "Debug") || same(type, "ALL")){
			//DKUtil::Execute(xcode + " -target " + app + " -configuration Debug build -arch \"armv7 armv7s\"");
			DKUtil::Execute(xcode + " -target " + app + " -configuration Debug build");
		}
		if (same(type, "Release") || same(type, "ALL")){
			//DKUtil::Execute(xcode + " -target " + app + " -configuration Release build -arch \"armv7 armv7s\"");
			DKUtil::Execute(xcode + " -target " + app + " -configuration Release build");
		}

		CopyAssets(app,os,type);
	}

	if(same(os,"IOSSIMULATOR")){
		DKString xcode = GetGrid("XCODE_EXE");

		//// iPhoneSimulator
		DKFile::MakeDir(apppath+"/ios-simulator");
		DKFile::ChDir(apppath+"/ios-simulator");
		DKUtil::Execute(cmake+" -G \"Xcode\" -DIPHONESIMULATOR=ON -DCMAKE_TOOLCHAIN_FILE="+dkplugins+"/iOS.cmake -DIOS_PLATFORM=SIMULATOR "+apppath);
		//CreateAssetsHeader(app, os); //Recreate the assets.h file (LINUX,MAC)
		if (same(type, "Debug") || same(type, "ALL")){
			DKUtil::Execute(xcode + " -target " + app + " -configuration Debug build -arch i386 -sdk iphonesimulator6.1");
			//DKUtil::Execute(xcode + " -target " + app + " -configuration Debug build");
		}
		if (same(type, "Release") || same(type, "ALL")){
			DKUtil::Execute(xcode + " -target " + app + " -configuration Release build -arch i386 -sdk iphonesimulator6.1");
			//DKUtil::Execute(xcode + " -target " + app + " -configuration Release build");
		}

		CopyAssets(app,os,type);
	}

	if(same(os,"ANDROID")){
		DKString ndk = GetGrid("ANDROID_NDK_EXE");
		DKFile::MakeDir(apppath+"/android");

		//Run cmake to generate Android.mk files
		DKFile::ChDir(apppath+"/android");
		DKUtil::Execute(cmake+" -G \"MinGW Makefiles\" -DANDROID=ON "+apppath);
		
		/// Import any missing template files
		DKFile::Copy(dkplugins+"/DigitalKnob/DKApp/android", apppath + "/android", true, true);

		UpdateAndroidAppName(app);
		CopyAssets(app,os, type);
		
		if (same(type, "Debug") || same(type, "ALL")){
			DKFile::ChDir(apppath + "/android/Debug");
			DKUtil::Execute(ndk + " NDK_DEBUG=1 NDKLOG=1");
		}
		if (same(type, "Release") || same(type, "ALL")){
			DKFile::ChDir(apppath + "/android/Release");
			DKUtil::Execute(ndk + " NDK_DEBUG=0 NDKLOG=1");
		}
		DKLog("Import android folder into eclipse and run app from there.\n", DKINFO);
	}

	if(same(os,"LINUX")){
		DKLog("\n Marking .old files . . .\n", DKINFO);
		if (same(type, "Debug") || same(type, "ALL")){
			DKFile::Rename(apppath + "/linux/Debug/" + app + "", apppath + "/linux/Debug/" + app + ".old" + ".old", true);
		}
		if (same(type, "Release") || same(type, "ALL")){
			DKFile::Rename(apppath + "/linux/Release/" + app + "", apppath + "/linux/Release/" + app + ".old" + ".old", true);
		}

		DKFile::MakeDir(apppath+"/linux");
		DKFile::MakeDir(apppath+"/linux/Debug");
		DKFile::MakeDir(apppath+"/linux/Release");
		
		if (same(type, "Debug") || same(type, "ALL")){
			DKFile::ChDir(apppath + "/linux/Debug");
			DKUtil::Execute(cmake + " -G \"Eclipse CDT4 - Unix Makefiles\" -DLINUX=ON -DLINUX_DEBUG=ON " + apppath);
			//CreateAssetsHeader(app, os); //Recreate the assets.h file (LINUX,MAC)
			DKUtil::Execute("make");
		}

		if (same(type, "Release") || same(type, "ALL")){
			DKFile::ChDir(apppath + "/linux/Release");
			DKUtil::Execute(cmake + " -G \"Eclipse CDT4 - Unix Makefiles\" -DLINUX=ON " + apppath);
			//CreateAssetsHeader(app, os); //Recreate the assets.h file (LINUX,MAC)
			DKUtil::Execute("make");
		}

		CopyAssets(app,os, type);
	}

	DKLog("\n Done.\n",DKINFO);
	return true;
}


//////////////////////////////////////////////////////////////////////////////////////////
bool DKCreator::MakeLib(const DKString& libname, const DKString& os, const DKString& type)
{
	if(!OSCheck(os)){ return false; }

	DKLog("\nBuilding "+libname+" . . . . .\n", DKINFO);

	DKString dk = GetGrid("DKPATH");
	DKString cmake = GetGrid("CMAKE_EXE");
	DKString msys = GetGrid("MSYS_EXE");

	DKXml xml;
	xml.LoadDocument(DKApp::datapath+"DKCreator/"+libname);

	//// libpath
	DKString libpath;
	libpath = xml.GetNodeValue("/"+os+"/PATH");
	if(libpath.empty()){
		libpath = xml.GetNodeValue("/PATH");
	}
	if(libpath.empty()){
		DKLog("We can't seem to find a <PATH> tag or variable\n", DKINFO);
		return false;
	}

	PatchLibrary(libpath);	
	ReplaceVariables(os,libpath);

	//TODO: There may be better placement for creating directories during build
	/// Make and set path
	if(same(os,"WIN32")){
		DKFile::MakeDir(libpath+"/win32");
		DKFile::MakeDir(libpath+"/win32/Debug");
		DKFile::MakeDir(libpath+"/win32/Release");
		DKFile::ChDir(libpath+"/win32");
	}
	if(same(os,"WIN64")){
		DKFile::MakeDir(libpath+"/win64");
		DKFile::MakeDir(libpath+"/win64/Debug");
		DKFile::MakeDir(libpath+"/win64/Release");
		DKFile::ChDir(libpath+"/win64");
	}
	if(same(os,"MAC")){
		DKFile::MakeDir(libpath+"/mac");
		DKFile::MakeDir(libpath+"/mac/Debug");
		DKFile::MakeDir(libpath+"/mac/Release");
		DKFile::ChDir(libpath+"/mac");
	}
	if(same(os,"IOS")){
		DKFile::MakeDir(libpath+"/ios");
		DKFile::MakeDir(libpath+"/ios/Debug");
		DKFile::MakeDir(libpath+"/ios/Release");
		DKFile::ChDir(libpath+"/ios");
	}
	if(same(os,"IOSSIMULATOR")){
		DKFile::MakeDir(libpath+"/ios-simulator");
		DKFile::MakeDir(libpath+"/ios-simulator/Debug");
		DKFile::MakeDir(libpath+"/ios-simulator/Release");
		DKFile::ChDir(libpath+"/ios-simulator");
	}
	if(same(os,"ANDROID")){
		DKFile::MakeDir(libpath+"/android");
		DKFile::MakeDir(libpath+"/android/Debug");
		DKFile::MakeDir(libpath+"/android/Release");
		DKFile::ChDir(libpath+"/android");
	}
	if(same(os,"LINUX")){
		DKFile::MakeDir(libpath+"/linux");
		DKFile::MakeDir(libpath+"/linux/Debug");
		DKFile::MakeDir(libpath+"/linux/Release");
		DKFile::ChDir(libpath+"/linux");
	}

	RunScriptNode(DKApp::datapath+"DKCreator/"+libname, os, os);
	if(same(type,"Debug") || same(type,"ALL")){
		RunScriptNode(DKApp::datapath+"DKCreator/"+libname, os+"/DEBUG", os);
	}
	if(same(type,"Release") || same(type,"ALL")){
		RunScriptNode(DKApp::datapath+"DKCreator/"+libname, os+"/RELEASE", os);
	}
	return true;
}

////////////////////////////////////////////
bool DKCreator::BundleLibs(const DKString& os)
{
	/*
	if(same(os,"")){
		DKLog("Please Select an Operating System\n",DKERROR);
		return false;
	}
	DKLog("\nBundling Libraries together . . . . .\n");

	VerifyTool(os, "LINK.dktool");
	DKString dk = GetGrid("DKPATH");
	DKString dklibs = GetGrid("DKLIBS");
	DKString link = GetGrid("LINK_EXE");

	DKLog("LINK_EXE = "+link+"\n");
	DKStringArray libraries;

	///WIN32 Debug libs
	libraries.push_back(dklibs+"/zlib/win32/Debug/zlibstaticd.lib");
	libraries.push_back(dklibs+"/gif/win32/lib/.libs/libgif.lib");
	libraries.push_back(dklibs+"/freetype/win32/Debug/freetype.lib");
	libraries.push_back(dklibs+"/png/win32/Debug/libpng17_staticd.lib");
	libraries.push_back(dklibs+"/jpeg/win32/Debug/jpeg-static.lib");
	libraries.push_back(dklibs+"/tiff/win32/Debug/tiff-static.lib");
	libraries.push_back(dklibs+"/curl/win32/lib/Debug/libcurl.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/OpenThreadsd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgAnimationd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgDBd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgFXd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgGAd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgManipulatord.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgParticled.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPresentationd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgShadowd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgSimd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgTerraind.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgTextd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgUtild.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgViewerd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgVolumed.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgWidgetd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_3dcd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_3dsd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_acd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_bmpd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_bspd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_bvhd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_cfgd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_curld.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_ddsd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_deprecated_osganimationd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_deprecated_osgd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_deprecated_osgfxd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_deprecated_osgparticled.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_deprecated_osgshadowd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_deprecated_osgsimd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_deprecated_osgterraind.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_deprecated_osgtextd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_deprecated_osgviewerd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_deprecated_osgvolumed.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_deprecated_osgwidgetd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_dotd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_dwd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_dxfd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_freetyped.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_gifd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_glsld.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_gzd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_hdrd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_ived.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_jpegd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_ktxd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_logod.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_lwod.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_lwsd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_md2d.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_mdld.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_normalsd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_objd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_openflightd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_oscd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_osgad.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_osgd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_osgshadowd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_osgterraind.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_osgtgzd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_osgviewerd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_p3dd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_picd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_plyd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_pngd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_pnmd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_povd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_pvrd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_revisionsd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_rgbd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_rotd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_scaled.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_serializers_osganimationd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_serializers_osgd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_serializers_osgfxd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_serializers_osggad.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_serializers_osgmanipulatord.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_serializers_osgparticled.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_serializers_osgpresentationd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_serializers_osgshadowd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_serializers_osgsimd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_serializers_osgterraind.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_serializers_osgtextd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_serializers_osgviewerd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_serializers_osgvolumed.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_shpd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_stld.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_tgad.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_tgzd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_tiffd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_transd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_trkd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_txfd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_txpd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_vtfd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_xd.lib");
	libraries.push_back(dklibs+"/OpenSceneGraph/win32/lib/osgPlugins-3.3.0/osgdb_zipd.lib");
	libraries.push_back(dklibs+"/libRocket/win32/Debug/RocketControls_d.lib");
	libraries.push_back(dklibs+"/libRocket/win32/Debug/RocketCore_d.lib");
	libraries.push_back(dklibs+"/libRocket/win32/Debug/RocketDebugger_d.lib");
	libraries.push_back(dklibs+"/archive/win32/libarchive/Debug/archive_static.lib");
	libraries.push_back(dklibs+"/openal/win32/Debug/OpenAL32.lib");
	libraries.push_back(dklibs+"/rtmidi/win32/Debug/RtMidi.lib");
	libraries.push_back(dklibs+"/osgWorks/win32/lib/Debug/osgdb_osgobjectsd.lib");
	libraries.push_back(dklibs+"/osgWorks/win32/lib/Debug/osgdb_osgwToolsd.lib");
	libraries.push_back(dklibs+"/osgWorks/win32/lib/Debug/osgdb_skeletond.lib");
	libraries.push_back(dklibs+"/osgWorks/win32/lib/Debug/osgwControlsd.lib");
	libraries.push_back(dklibs+"/osgWorks/win32/lib/Debug/osgwMxd.lib");
	libraries.push_back(dklibs+"/osgWorks/win32/lib/Debug/osgwQueryd.lib");
	libraries.push_back(dklibs+"/osgWorks/win32/lib/Debug/osgwToolsd.lib");

	//build command string
	DKString command = link;
	command += " /OUT:";
	command += dklibs;
	command += "/DKLIBS_WIN32_D.lib";
	for(unsigned int i=0; i<libraries.size(); i++){
		command += " ";
		command += libraries[i];
	}

	//DKLog(command);
	DKUtil::System(command);

	return true;
	*/

	return false;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
bool DKCreator::RunScriptNode(const DKString& file, const DKString& nodename, const DKString& os)
{
	DKXml xml;
	xml.LoadDocument(file);

	//// use <PATH> to set the variables
	DKString path;
    path = xml.GetNodeValue("/"+os+"/PATH");
	if(path.empty()){
		path = xml.GetNodeValue("/PATH");
	}
	if(path.empty()){
		DKLog("We can't seem to find a <PATH> tag or variable\n", DKINFO);
		//return false;
	}
	else{
		ReplaceVariables(os,path);
	}
	
	DKStringArray nodes;
	DKString nodepath = "/"+os+"/"+nodename+"/*";
	nodes = xml.GetNodeNames(nodepath);
	if(nodes.empty()){
		nodepath = "/"+nodename+"/*";
		nodes = xml.GetNodeNames(nodepath);
	}
	if(nodes.empty()){
		DKLog("Cannot find <"+nodename+"> tag. \n", DKERROR);
		return false;
	}
	replace(nodepath,"/*","");

	///////////////////////////////////////////
	for(unsigned int i=0; i<nodes.size(); ++i){
		
		if(samei(nodes[i], "bash")){
			DKString node = xml.GetChildNodeValue(nodepath, i);
			ReplaceVariables(os, node);
			replace(node, ";", "\n");
			DKLog("Creating temporary bash script: C:/temp \n", DKINFO);
			DKFile::StringToFile(node, "C:/temp");
			DKUtil::Execute("C:/mingw/msys/bin/bash /c/temp");
			continue;
		}

		if(samei(nodes[i], "batch")){
			DKString node = xml.GetChildNodeValue(nodepath, i);
			ReplaceVariables(os,node);
			//replace(node, ";", "\n");
			DKLog("Creating temporary batch script: C:/temp.bat \n", DKINFO);
			DKFile::StringToFile(node, "C:/temp.bat");
			DKUtil::Execute("C:/temp.bat");
			continue;
		}

		if(samei(nodes[i],"clipboard")){
			DKString node = xml.GetChildNodeValue(nodepath, i);
			ReplaceVariables(os, node);
			DKUtil::SetClipboard(node);
			continue;
		}

		if(samei(nodes[i], "cmd")){
			DKString node = xml.GetChildNodeValue(nodepath, i);
			ReplaceVariables(os,node);
			DKUtil::Execute(node);
			continue;
		}

		if(samei(nodes[i], "cygwinbash")){
			DKString node = xml.GetChildNodeValue(nodepath, i);
			ReplaceVariables(os, node);
			replace(node, ";", "\n");
			DKLog("Creating temporary bash script: C:/temp \n", DKINFO);
			DKFile::StringToFile(node, "C:/temp");
			DKUtil::Execute("C:/digitalknob/DKPlugins/v8/third_party/cygwin/bin/bash C:/temp");
			continue;
		}

		if(samei(nodes[i],"copy")){
			DKString path = xml.GetChildAttribute(nodepath, i, "path");
			ReplaceVariables(os,path);

			DKString to = xml.GetChildAttribute(nodepath, i, "to");
			ReplaceVariables(os,to);

			if(!DKFile::Copy(path,to,true,false)){
				return false;
			}
			continue;
		}
		
		if(samei(nodes[i],"delete")){
			DKString path = xml.GetChildNodeValue(nodepath, i);
			ReplaceVariables(os,path);
			if(!DKFile::Delete(path)){
				return false; 
			}
			continue;
		}

		if(samei(nodes[i],"download")){
			DKString url = xml.GetChildAttribute(nodepath, i, "url");
			ReplaceVariables(os,url);

			DKString path = xml.GetChildAttribute(nodepath, i, "path");
			ReplaceVariables(os,path);

			if(!DKCurl::Download(url,path)){
				url = xml.GetChildAttribute(nodepath, i, "url2");
				ReplaceVariables(os,url);
				if(!DKCurl::Download(url,path)){
					DKString filename;
					DKFile::GetFileName(url,filename);
					DKLog("Unable to download "+filename+" \n", DKERROR);
					return false;
				}
			}
			continue;
		}

		if(samei(nodes[i],"execute")){
			DKString exec = xml.GetChildNodeValue(nodepath, i);
			ReplaceVariables(os,exec);
			DKUtil::Execute(exec);
			continue;
		}

		if(samei(nodes[i],"extract")){
			DKString filename = xml.GetChildAttribute(nodepath, i, "file");
			ReplaceVariables(os,filename);

			DKString path = xml.GetChildAttribute(nodepath, i, "path");
			ReplaceVariables(os,path);

			if(!DKArchive::Extract(filename,path)){
				return false;
			}
			continue;
		}

		if(samei(nodes[i],"message")){
			DKString msg = xml.GetChildNodeValue(nodepath, i);
			DKLog(msg+"\n", DKINFO);
			continue;
		}
		
		if(samei(nodes[i],"mkdir")){
			DKString path = xml.GetChildNodeValue(nodepath, i);
			ReplaceVariables(os,path);
			if(!DKFile::MakeDir(path)){
				return false; 
			}
			continue;
		}

		if(samei(nodes[i],"msg0")){
			DKString message = xml.GetChildNodeValue(nodepath, i);
			Trim(message);
			ReplaceVariables(os,message);
			DKLog("\n"+message+"\n", DKINFO);
			continue;
		}

		if(samei(nodes[i], "msys")){
			DKString node = xml.GetChildNodeValue(nodepath, i);
			ReplaceVariables(os, node);
			DKUtil::SetClipboard(node);
			DKLog("Please paste the command into the MSYS window\n", DKINFO);
			DKLog("(right-click the MINGW32:~ titlebar, edit, paste)\n", DKINFO);
			DKString msys = GetGrid("MSYS_EXE");
			DKUtil::Execute(msys);
			continue;
		}
#if defined(WIN32) && !defined(WIN64)
		if(samei(nodes[i], "refreshenvironment")){
			DKWindows::RefreshWindowsEnvironment();
			continue;
		}
#endif
		if(samei(nodes[i],"rename")){
			DKString path = xml.GetChildAttribute(nodepath, i, "path");
			ReplaceVariables(os,path);

			DKString output = xml.GetChildAttribute(nodepath, i, "output");
			ReplaceVariables(os,output);

			if(!DKFile::Rename(path,output,true)){
				return false;
			}
			continue;
		}

		if(samei(nodes[i], "setpath")){
			DKString path = xml.GetChildNodeValue(nodepath, i);
			ReplaceVariables(os,path);
			if(!DKFile::ChDir(path)){
				return false;
			}
			continue;
		}

		if(samei(nodes[i],"terminal")){
			DKString cmd = xml.GetChildNodeValue(nodepath, i);
			ReplaceVariables(os,cmd);

			//CMake fix for iOS / XCode
			if(has(cmd,"-DCMAKE_OSX_SYSROOT=\"iphoneos\"")){
				DKLog("Detected CMake iOS bug. applying fix.\n",DKWARN);
				DKString ioscmakefix = cmd;
				replace(ioscmakefix,"-DCMAKE_OSX_SYSROOT=\"iphoneos\"","");
				DKUtil::Execute(ioscmakefix);
			}

			DKUtil::Execute(cmd);
			continue;
		}

		if(samei(nodes[i],"waitforkey")){
			DKUtil::GetKey();
			continue;
		}

		// Some top level only nodes will be skipped
		if(same(nodes[i], "VERIFY")){ continue; }
		if(same(nodes[i], "INSTALL")){ continue; }
		if(same(nodes[i], "PATH")){ continue; }
		if(same(nodes[i], "DEBUG")){ continue; }
		if(same(nodes[i], "RELEASE")){ continue; }
		
		DKLog("Unknown Tag <"+nodes[i]+"> \n", DKERROR);
	}

	return true;
}
