var WORKSPACE = "C:/AndroidStudio";
var ANDROIDSTUDIO = "C:/Program Files/Android/Android Studio/bin/studio64.exe"

/////////////////////////////
function AndroidImport_Init()
{
	DKCreate("DKHookJS");
	ANDROIDSTUDIO = DKFile_GetShortName(ANDROIDSTUDIO);
	DKLog("ANDROIDSTUDIO="+ANDROIDSTUDIO+"\n");
}

///////////////////////////////
function AndroidImport_Import()
{
	//DKLog("AndroidImport_Import() \n", DKDEBUG);
	if(!APP){ 
		DKLog("Please select an app. \n", DKINFO);
		return; 
	}
	var appdir;
	if(DKFile_Exists(DKPATH+"/DKApps/"+APP)){
		appdir = "DKApps";
	}
	if(DKFile_Exists(DKPATH+"/USER/DKApps/"+APP)){
		appdir = "USER/DKApps";
	}
	if(!appdir){
		DKLog("AndroidImport_Import(): cannot locate appdir. \n", DKINFO);
	}
	
	DKFile_Delete(WORKSPACE);
	DKFile_MkDir(WORKSPACE);
	DK_Run(ANDROIDSTUDIO);
	
	DKHook_WaitForWindow("Welcome to Android Studio", 30); //Check for 30 seconds
	DKLog("Window is ready. \n", DKDEBUG);
	var datapath = DKAssets_GetDataPath();
	DK_ClickImage(datapath+"DKBuild/import.bmp");

	DKHook_WaitForWindow("Select Eclipse or Gradle Project to Import", 30); //Check for 30 seconds
	DKLog("Window is ready. \n", DKDEBUG);
	
	//Get app path
	path =  DKPATH+"/"+appdir+"/"+APP+"/android32/Release";
	DKLog(path+"\n");
	DK_SetClipboard(path);	
	DK_PressKey(17); //press ctrl
	DK_StrokeKey(86) //stroke v
	DK_ReleaseKey(17); //release ctrl
	DK_StrokeKey(13) //stroke enter
	
	DKHook_WaitForWindow("Import Project from ADT (Eclipse Android)", 30); //Check for 30 seconds
	DKLog("Window is ready. \n", DKDEBUG);
	DK_StrokeKey(13) //stroke enter
	DK_Sleep(3000);
	DK_StrokeKey(13) //stroke enter
	
	DK_WaitForImage(datapath+"DKBuild/enableNdk.bmp", 30); //Check for 30 seconds
	DK_ClickImage(datapath+"DKBuild/enableNdk.bmp");
	
	DK_WaitForImage(datapath+"DKBuild/selectNdk.bmp", 30); //Check for 30 seconds
	DK_ClickImage(datapath+"DKBuild/selectNdk.bmp");
	
	//tab tab tab, space, tab, paste
	DK_StrokeKey(9) //stroke tab
	DK_Sleep(500);
	DK_StrokeKey(9) //stroke tab
	DK_Sleep(500);
	DK_StrokeKey(9) //stroke tab
	DK_Sleep(500);
	DK_StrokeKey(32) //stroke space
	DK_Sleep(500);
	DK_StrokeKey(9) //stroke tab
	DK_SetClipboard(NDK);
	DK_Sleep(500);
	DK_PressKey(17); //press ctrl
	DK_StrokeKey(86) //stroke v
	DK_ReleaseKey(17); //release ctrl
	DK_Sleep(500);
	DK_StrokeKey(13) //stroke enter
	
	//update C:/AndroidStudio/Release/app/build.gradle
	var gradle = DKFile_FileToString(WORKSPACE+"/Release/app/build.gradle");

	//replace buildTypes with 
	gradle = gradle.replace("buildTypes", "sourceSets { main { jni.srcDirs = [] } } \n buildTypes");
	
	//write file
	DKFile_StringToFile(gradle, WORKSPACE+"/Release/app/build.gradle");
	
	//copy shared libs
	DKFile_MkDir(WORKSPACE+"/Release/app/src/main/jniLibs");
	DKFile_MkDir(WORKSPACE+"/Release/app/src/main/jniLibs/armeabi-v7a");
	DKFile_Copy(DKPATH+"/"+appdir+"/"+APP+"/android32/Release/libs/armeabi-v7a", WORKSPACE+"/Release/app/src/main/jniLibs/armeabi-v7a", true);
	
	DKLog("Import finished\n", DKINFO);
}
