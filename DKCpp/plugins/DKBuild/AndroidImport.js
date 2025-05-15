var WORKSPACE = "C:/AndroidStudio";
var ANDROIDSTUDIO = "C:/Program Files/Android/Android Studio/bin/studio64.exe";
TYPE = byId("BuildType").innerHTML;

function AndroidImport_init(){
    dk.create("DKHandles");
    ANDROIDSTUDIO = DKFile_GetShortName(ANDROIDSTUDIO);
    console.log("ANDROIDSTUDIO=" + ANDROIDSTUDIO + "\n");
}

function AndroidImport_Import(){
    if (!APP){
        console.log("Please select an app\n");
        return;
    }

    var appdir = "";
    var contents = DKFile_DirectoryContents(DIGITALKNOB_DIR);
    var files = contents.split(",");

    for (var i = 0; i < files.length; i++){
        if (dk.file.extist(DIGITALKNOB_DIR + "/" + files[i] + "/DKCpp/apps/" + APP)){
            appdir = DIGITALKNOB_DIR + "/" + files[i] + "/DKCpp/apps/" + APP;
        }
    }

    /*
	if(dk.file.extist(DIGITALKNOB_DIR+"/DKCpp/apps/"+APP)){
		appdir = DIGITALKNOB_DIR+"/DKCpp/apps/"+APP;
	}
	*/

    if (!appdir){
        console.log("AndroidImport_Import(): cannot locate appdir\n");
        return;
    }

    dk.file.makeDir(WORKSPACE);
    DKFile_Delete(WORKSPACE + "/" + APP + "_" + TYPE);
    dk.file.makeDir(WORKSPACE + "/" + APP + "_" + TYPE);
    DK_Run(ANDROIDSTUDIO, "");

    if (!DKHandles_WaitForWindow("Welcome to Android Studio", 60)){
        //Check for 60 seconds
        console.warn("DKHandles_WaitForWindow(Welcome to Android Studio): failed\n");
        return;
    }
    console.log("Window is ready.\n");
    var assets = DKAssets_LocalAssets();
    if (!DK_WaitForImage(assets + "DKBuild/import.bmp", 30)){
        //Check for 30 seconds
        console.warn("DK_WaitForImage(" + assets + "DKBuild/import.bmp): failed\n");
        return;
    }
    if (!DK_ClickImage(assets + "DKBuild/import.bmp")){
        console.warn("DK_ClickImage(" + assets + "DKBuild/import.bmp): failed\n");
        return;
    }

    if (!DKHandles_WaitForWindow("Select Eclipse or Gradle Project to Import", 30)){
        //Check for 30 seconds
        console.warn("DKHandles_WaitForWindow(Select Eclipse or Gradle Project to Import): failed\n");
        return;
    }
    console.log("Window is ready.\n");

    //Multipe user folders
    /*
	var contents = DKFile_DirectoryContents(DIGITALKNOB_DIR);
	var files = contents.split(",");
	for(var i=0; i<files.length; i++){ //console.log("files["+i+"] = "+files[i]+"\n");
		DKFile_ChDir(DIGITALKNOB_DIR);
		if(DKFile_IsDirectory(files[i])){ continue; }
		var url = DKFile_GetSetting(files[i], "[MYGIT]");
		if(url){ //console.log("url = "+url+"\n");
			var folder = files[i].replace(".txt",""); //console.log("folder = "+folder+"\n");
			if(dk.file.extist(DIGITALKNOB_DIR+"/"+folder+"/DKCpp/apps/"+APP+"/DKINSTALL.cmake")){
				appdir = folder+"/DKCpp/apps";
			}
		}
	}
	*/

    //Get app path
    if (TYPE === "Debug"){
        path = appdir + "/Android_Arm32/Debug";
    } else {
        path = appdir + "/Android_Arm32/Release";
    }

    console.log(path + "\n");
    DK_SetClipboard(path);
    DK_Sleep(3000);
    DK_PressKey(17);
    //press ctrl
    DK_StrokeKey(86)
    //stroke v
    DK_ReleaseKey(17);
    //release ctrl
    DK_Sleep(5000);
    DK_StrokeKey(13)
    //stroke enter

    if (!DKHandles_WaitForWindow("Import Project from ADT (Eclipse Android)", 30)){
        //Check for 30 seconds
        console.warn("DKHandles_WaitForWindow(Import Project from ADT (Eclipse Android)): failed\n");
        return;
    }
    console.log("Window is ready.\n");
    path = WORKSPACE + "/" + APP + "_" + TYPE;
    DK_SetClipboard(path);
    DK_PressKey(17);
    //press ctrl
    DK_StrokeKey(86)
    //stroke v
    DK_ReleaseKey(17);
    //release ctrl
    DK_Sleep(5000);
    DK_StrokeKey(13)
    //stroke enter
    DK_Sleep(5000);
    console.log("Pressing enter\n");
    DK_StrokeKey(13)
    //stroke enter

    /*
	if(!DK_WaitForImage(assets+"DKBuild/enableNdk.bmp", 500)){ //Check for 500 seconds
		console.warn("DK_WaitForImage("+assets+"DKBuild/enableNdk.bmp): failed\n");
		return; 
	}
	if(!DK_ClickImage(assets+"DKBuild/enableNdk.bmp")){
		console.warn("DK_ClickImage("+assets+"DKBuild/enableNdk.bmp): failed\n");
		return ; 
	}
	*/

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
    DK_Sleep(5000);
    var gradle = DKFile_FileToString(WORKSPACE + "/" + APP + "_" + TYPE + "/app/build.gradle");

    //replace buildTypes with 
    gradle = gradle.replace("compileSdkVersion 23", "compileSdkVersion 19");
    gradle = gradle.replace("buildTypes", "sourceSets { main { jni.srcDirs = [] } } \n buildTypes");

    //write file
    DKFile_StringToFile(gradle, WORKSPACE + "/" + APP + "_" + TYPE + "/app/build.gradle");

    //copy shared libs
    dk.file.makeDir(WORKSPACE + "/" + APP + "_" + TYPE + "/app/src/main/jniLibs");
    dk.file.makeDir(WORKSPACE + "/" + APP + "_" + TYPE + "/app/src/main/jniLibs/armeabi-v7a");
    if (TYPE === "Debug"){
        DKFile_Copy(appdir + "/Android_Arm32/Debug/libs/armeabi-v7a", WORKSPACE + "/" + APP + "_" + TYPE + "/app/src/main/jniLibs/armeabi-v7a", true);
    } else {
        DKFile_Copy(appdir + "/Android_Arm32/Release/libs/armeabi-v7a", WORKSPACE + "/" + APP + "_" + TYPE + "/app/src/main/jniLibs/armeabi-v7a", true);
    }

    console.log("Import finished\n");

    dk.create("DKAudio");
    if (CPP_DK_Valid("DKAudioJS,DKAudioJS0")){
        DKAudio_PlaySound("DKBuild/ding.wav");
    }
}
