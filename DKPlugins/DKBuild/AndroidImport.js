var WORKSPACE = "C:/AndroidStudio";
var ANDROIDSTUDIO = "C:/Program Files/Android/Android Studio/bin/studio64.exe"
TYPE = DKWidget_GetValue("BuildType");

/////////////////////////////
function AndroidImport_Init()
{
	DKCreate("DKHandles");
	ANDROIDSTUDIO = DKFile_GetShortName(ANDROIDSTUDIO);
	DKLog("ANDROIDSTUDIO="+ANDROIDSTUDIO+"\n");
}

///////////////////////////////
function AndroidImport_Import()
{
	//DKLog("AndroidImport_Import()\n");
	if(!APP){ 
		DKLog("Please select an app.\n");
		return; 
	}
	
	var appdir = "";	
	var contents = DKFile_DirectoryContents(DKPATH);
	var files = contents.split(",");
	/*
	for(var i=0; i<files.length; i++){ 
		if(DKFile_Exists(DKPATH+"/"+files[i]+"/DKApps/"+APP)){
			appdir = files[i]+"/DKApps";
		}
	}
	*/
	if(DKFile_Exists(DKPATH+"/DKApps/"+APP)){
		appdir = DKPATH+"/DKApps/"+APP;
	}
		
	if(!appdir){
		DKLog("AndroidImport_Import(): cannot locate appdir.\n");
		
		return;
	}
	
	DKFile_MkDir(WORKSPACE);
	DKFile_Delete(WORKSPACE+"/"+APP+"_"+TYPE);
	DKFile_MkDir(WORKSPACE+"/"+APP+"_"+TYPE);
	DK_Run(ANDROIDSTUDIO);
	
	if(!DKHandles_WaitForWindow("Welcome to Android Studio", 30)){ return ; }  //Check for 30 seconds
	DKLog("Window is ready.\n");
	var assets = DKAssets_LocalAssets();
	if(!DK_WaitForImage(assets+"DKBuild/import.bmp", 30)){ return ; } //Check for 30 seconds
	if(!DK_ClickImage(assets+"DKBuild/import.bmp")){ return; }

	if(!DKHandles_WaitForWindow("Select Eclipse or Gradle Project to Import", 30)){ return ; } //Check for 30 seconds
	DKLog("Window is ready.\n");
	
	//Multipe user folders
	/*
	var contents = DKFile_DirectoryContents(DKPATH);
	var files = contents.split(",");
	for(var i=0; i<files.length; i++){ //DKLog("files["+i+"] = "+files[i]+"\n");
		DKFile_ChDir(DKPATH);
		if(DKFile_IsDirectory(files[i])){ continue; }
		var url = DKFile_GetSetting(files[i], "[MYGIT]");
		if(url){ //DKLog("url = "+url+"\n");
			var folder = files[i].replace(".txt",""); //DKLog("folder = "+folder+"\n");
			if(DKFile_Exists(DKPATH+"/"+folder+"/DKApps/"+APP+"/DKCMake.txt")){
				appdir = folder+"/DKApps";
			}
		}
	}
	*/
	
	//Get app path
	if(TYPE == "Debug"){
		path =  appdir+"/android32/Debug";
	}
	else{
		path =  appdir+"/android32/Release";
	}
	
	
	DKLog(path+"\n");
	DK_SetClipboard(path);
	DK_Sleep(2000);
	DK_PressKey(17); //press ctrl
	DK_StrokeKey(86) //stroke v
	DK_ReleaseKey(17); //release ctrl
	DK_Sleep(2000);
	DK_StrokeKey(13) //stroke enter
	
	if(!DKHandles_WaitForWindow("Import Project from ADT (Eclipse Android)", 30)){ return; } //Check for 30 seconds
	DKLog("Window is ready.\n");
	path = WORKSPACE+"/"+APP+"_"+TYPE;
	DK_SetClipboard(path);
	DK_PressKey(17); //press ctrl
	DK_StrokeKey(86) //stroke v
	DK_ReleaseKey(17); //release ctrl
	DK_Sleep(2000);
	DK_StrokeKey(13) //stroke enter
	DK_Sleep(3000);
	DK_StrokeKey(13) //stroke enter
	
	if(!DK_WaitForImage(assets+"DKBuild/enableNdk.bmp", 500)){ return; } //Check for 500 seconds
	if(!DK_ClickImage(assets+"DKBuild/enableNdk.bmp")){ return ; }
	
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
		DKFile_Copy(appdir+"/android32/Debug/libs/armeabi-v7a", WORKSPACE+"/"+APP+"_"+TYPE+"/app/src/main/jniLibs/armeabi-v7a", true);
	}
	else{
		DKFile_Copy(appdir+"/android32/Release/libs/armeabi-v7a", WORKSPACE+"/"+APP+"_"+TYPE+"/app/src/main/jniLibs/armeabi-v7a", true);
	}
	
	DKLog("Import finished\n");
	
	DKCreate("DKAudio");
	if(DKValid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}
