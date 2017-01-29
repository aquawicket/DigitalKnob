//////////////////////////////
function DKMenuRightApp_Init()
{
	DKCreate("DKDev/DKMenuRightApp.html,DKMenuRight.html");
	DKAddEvent("SaveUserFile", "click", DKMenuRightApp_OnEvent);
	DKAddEvent("DKMenuRightApp.html", "Update", DKMenuRightApp_OnEvent);
	
	//DKMenuRightApp_Update();
}

/////////////////////////////
function DKMenuRightApp_End()
{
	DKRemoveEvent("SaveUserFile", "click", DKMenuRightApp_OnEvent);
	DKRemoveEvent("DKMenuRightApp.html", "Update", DKMenuRightApp_OnEvent);
	DKClose("DKMenuRightApp.html");
}

//////////////////////////////////////
function DKMenuRightApp_OnEvent(event)
{
	DKLog("DKMenuRightApp_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Id(event, "SaveUserFile")){
		DKMenuRightApp_SaveUserFile();
		return;
	}
	if(DK_Type(event, "Update")){
		DKMenuRightApp_Update();
		return;
	}
}

////////////////////////////////
function DKMenuRightApp_Update()
{
	//DKLog("DKMenuRightApp_Update() \n", DKDEBUG);
	var assets = DKAssets_LocalAssets();
	var userfile = DKFile_FileToString(assets+"User.js");
	DKWidget_SetValue("userfile", userfile);
}

//////////////////////////////////////
function DKMenuRightApp_SaveUserFile()
{
	//DKLog("DKMenuRightApp_SaveUserFile() \n");
	var assets = DKAssets_LocalAssets();
	var value = DKWidget_GetValue("userfile");
	DKFile_StringToFile(value, assets+"User.js");
}

