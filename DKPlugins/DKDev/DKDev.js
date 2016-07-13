var key_history = [];
//var osg_fps = 0;

/////////////////////
function DKDev_Init()
{
	DKCreate("DKDev/DKDev.html");
	DKCreate("DKDev/DKEditor.js");

	//var os = DK_GetOS();
	//var browser = DK_GetBrowser();
	//DKLog("OS: "+os+"\n", DKDEBUG);
	//if(os != "ANDROID" && browser != "IE"){
		//DKWidget_Hide("DKDev.html");
	//}
	//else{
		//DKDev_DevModeOn();
	//}
	
	//DKLog("os = "+os+"\n");
	//DKLog("browser = "+browser+"\n");
	
	//DKWidget_Hide("fps_box");
	//DKAddEvent("GLOBAL", "keydown", DKDev_OnEvent);
	//DKAddEvent("DevModeButton", "click", DKDev_OnEvent);
	//DKAddEvent("DevCloseButton", "click", DKDev_OnEvent);
}

////////////////////
function DKDev_End()
{
	DKClose("DKDev.html");
}

/////////////////////////////
function DKDev_OnEvent(event)
{
	//DKLog("DKDev_OnEvent("+event+") \n", DKDEBUG);
	DKWidget_Hide("DKDevMenu");
	
	if(DK_Type(event, "keydown")){
		DKDev_ProcessKey(DKWidget_GetValue(event));
	}
	
	if(DK_Id(event, "DevModeButton")){
		DKDev_ToggleEditMode();
	}
	
	if(DK_Id(event, "DevCloseButton")){
		DKDev_DevModeOff();
	}
}

//////////////////////////////
function DKDev_ProcessKey(key)
{
	//DKLog("DKDev_ProcessKey("+key+")\n", DKDEBUG);
	
	if(key == "189"){ DK_SetFramerate(DK_GetFramerate()-1);}
	if(key == "187"){ DK_SetFramerate(DK_GetFramerate()+1);}
	
	if(key == "113" && DKWidget_Visible("DKDev.html")){
		DKLog("*** Rocket Debugger *** \n", DKINFO);
		DKRocket_ToggleRocketDebugger();
	}
	
	key_history.push(key);
	if(key_history.length > 7){
		key_history.shift();
	}
	
	if(key_history[0] == "68" &&  // d
		key_history[1] == "75" && // k
		key_history[2] == "65" && // a
		key_history[3] == "68" && // d
		key_history[4] == "77" && // m
		key_history[5] == "73" && // i
		key_history[6] == "78")   // n
	{  
		DKLog("*** DEVELOPER MODE *** \n", DKINFO);
		DKDev_DevModeOn();
	}
	
	if(key == "112" && DKWidget_Visible("DKDev.html")){
		if(osg_fps < 4){
			DKWidget_Show("fps_box");
			osg_fps++;
		}
		else{
			DKWidget_Hide("fps_box");
			osg_fps = 0;
		}
	}
}

///////////////////////////////
function DKDev_ToggleEditMode()
{
	DKLog("DKDev_ToggleEditMode() \n", DKDEBUG);
	var img = DKWidget_GetAttribute("DevModeButton", "src");
	if(img.indexOf("greenbutton.png") != -1){
		DKDev_EditModeOn();
		return;
	}
	if(img.indexOf("redbutton.png") != -1){
		DKDev_EditModeOff();
	}
}

//////////////////////////
function DKDev_DevModeOn()
{
	DKLog("DKDev_DevModeOn() \n", DKDEBUG);
	DKWidget_Show("DKDev.html");
	//DKCreate("DKTriggers/DKTriggers.js");
	DKCreate("DKDev/DKMenuRight.js");
	DKWidget_Show("DKMenuRight.html");
	//DKCreate("DKTriggers/DKAutomate.js");
	DKCreate("DKOSGStats");
}

///////////////////////////
function DKDev_DevModeOff()
{
	DKLog("DKDev_DevModeOff() \n", DKDEBUG);
	DKDev_EditModeOff();
	DKWidget_Hide("DKMenuRight.html");
	DKWidget_Hide("DKAutomate.html");
	DKWidget_Hide("DKHook.html");
	DKWidget_Hide("fps_box");
	DKClose("DKOSGStats");
	DKWidget_Hide("DKDev.html");
}

///////////////////////////
function DKDev_EditModeOn()
{
	DKLog("DKDev_EditModeOn() \n", DKDEBUG);
	DKWidget_SetAttribute("DevModeButton", "src", "DKDev/redbutton.png");
	DKCreate("DKDev/DKEditor.js");
	DKEditor_On();
	DKSendEvent("GLOBAL", "ToggleTriggers", "OFF");
}

////////////////////////////
function DKDev_EditModeOff()
{
	DKLog("DKDev_EditModeOff() \n", DKDEBUG);
	DKWidget_SetAttribute("DevModeButton", "src", "DKDev/greenbutton.png");
	DKCreate("DKDev/DKEditor.js");
	DKEditor_Off();
	DKSendEvent("GLOBAL", "ToggleTriggers", "ON");
}
