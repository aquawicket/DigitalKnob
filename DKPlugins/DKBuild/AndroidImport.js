var WORKSPACE = "C:/AndroidStudio";
var ANDROIDSTUDIO = "C:/Program Files/Android/Android Studio/bin/studio64.exe"
TYPE = DKWidget_GetValue("BuildType");

/////////////////////////////
function AndroidImport_Init()
{
	DKCreate("DKHook");
	ANDROIDSTUDIO = DKFile_GetShortName(ANDROIDSTUDIO);
	DKLog("ANDROIDSTUDIO="+ANDROIDSTUDIO+"\n", DKINFO);
}

///////////////////////////////
function AndroidImport_Import()
{
	//DKLog("AndroidImport_Import()\n", DKDEBUG);
	if(!APP){ 
		DKLog("Please select an app.\n", DKINFO);
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
		DKLog("AndroidImport_Import(): cannot locate appdir.\n", DKINFO);
	}
	
	DKFile_Delete(WORKSPACE+"/"+APP+"_"+TYPE);
	DKFile_MkDir(WORKSPACE+"/"+APP+"_"+TYPE);
	DK_Run(ANDROIDSTUDIO);
	
	DKHook_WaitForWindow("Welcome to Android Studio", 30); //Check for 30 seconds
	DKLog("Window is ready.\n", DKDEBUG);
	var assets = DKAssets_LocalAssets();
	DK_ClickImage(assets+"DKBuild/import.bmp");

	DKHook_WaitForWindow("Select Eclipse or Gradle Project to Import", 30); //Check for 30 seconds
	DKLog("Window is ready.\n", DKDEBUG);
	
	//Multipe user folders
	var contents = DKFile_DirectoryContents(DKPATH);
	var files = contents.split(",");
	for(var i=0; i<files.length; i++){ //DKLog("files["+i+"] = "+files[i]+"\n", DKINFO);
		DKFile_ChDir(DKPATH);
		if(DKFile_IsDirectory(files[i])){ continue; }
		var url = DKFile_GetSetting(files[i], "[MYGIT]");
		if(url){ //DKLog("url = "+url+"\n", DKINFO);
			var folder = files[i].replace(".txt",""); //DKLog("folder = "+folder+"\n", DKINFO);
			if(DKFile_Exists(DKPATH+"/"+folder+"/DKApps/"+APP+"/DKCMake.txt";)){
				appdir = folder+"/DKApps";
			}
		}
	}
	//Get app path
	if(TYPE == "Debug"){
		path =  DKPATH+"/"+appdir+"/"+APP+"/android32/Debug";
	}
	else{
		path =  DKPATH+"/"+appdir+"/"+APP+"/android32/Release";
	}
	
	
	
	//DKLog(path+"\n", DKDEBUG);
	DK_SetClipboard(path);	
	DK_PressKey(17); //press ctrl
	DK_StrokeKey(86) //stroke v
	DK_ReleaseKey(17); //release ctrl	
	DK_Sleep(2000);
	DK_StrokeKey(13) //stroke enter
	
	DKHook_WaitForWindow("Import Project from ADT (Eclipse Android)", 30); //Check for 30 seconds
	DKLog("Window is ready.\n", DKDEBUG);
	path = WORKSPACE+"/"+APP+"_"+TYPE;
	DK_SetClipboard(path);
	DK_PressKey(17); //press ctrl
	DK_StrokeKey(86) //stroke v
	DK_ReleaseKey(17); //release ctrl
	DK_Sleep(2000);
	DK_StrokeKey(13) //stroke enter
	DK_Sleep(3000);
	DK_StrokeKey(13) //stroke enter
	
	DK_WaitForImage(assets+"DKBuild/enableNdk.bmp", 30); //Check for 30 seconds
	DK_ClickImage(assets+"DKBuild/enableNdk.bmp");
	
	/*
	DK_WaitForImage(assets+"DKBuild/selectNdk.bmp", 30); //Check for 30 seconds
	DK_ClickImage(assets+"DKBuild/selectNdk.bmp");
	
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
	*/
	
	//update C:/AndroidStudio/"APP"/app/build.gradle
	var gradle = DKFile_FileToString(WORKSPACE+"/"+APP+"_"+TYPE+"/app/build.gradle");

	//replace buildTypes with 
	gradle = gradle.replace("compileSdkVersion 23", "compileSdkVersion 19");
	gradle = gradle.replace("buildTypes", "sourceSets { main { jni.srcDirs = [] } } \n buildTypes");
	
	//write file
	DKFile_StringToFile(gradle, WORKSPACE+"/"+APP+"_"+TYPE+"/app/build.gradle");
	
	//copy shared libs
	DKFile_MkDir(WORKSPACE+"/"+APP+"_"+TYPE+"/app/src/main/jniLibs");
	DKFile_MkDir(WORKSPACE+"/"+APP+"_"+TYPE+"/app/src/main/jniLibs/armeabi-v7a");
	if(TYPE == "Debug"){
		DKFile_Copy(DKPATH+"/"+appdir+"/"+APP+"/android32/Debug/libs/armeabi-v7a", WORKSPACE+"/"+APP+"_"+TYPE+"/app/src/main/jniLibs/armeabi-v7a", true);
	}
	else{
		DKFile_Copy(DKPATH+"/"+appdir+"/"+APP+"/android32/Release/libs/armeabi-v7a", WORKSPACE+"/"+APP+"_"+TYPE+"/app/src/main/jniLibs/armeabi-v7a", true);
	}
	
	DKLog("Import finished\n", DKINFO);
	
	DKCreate("DKAudio");
	if(DKValid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}
