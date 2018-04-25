var pos;
var animation;
///////////////////////
function Taskbar_Init()
{
	DKCreate("DKOS/Taskbar.html,DKOS/DKOS.html");
	DKCreate("DKOS/scale.js", function(){});
	DKCreate("DKOS/Clock.js", function(){});
	if(DK_GetBrowser() == "Rocket"){
		DKCreate("DKDebug/BugReport.js", function(){});
		DKWidget_AppendChild("DKOS/Taskbar.html","DKDebug/BugReport.html"); //reparent
	}
	DKAddEvent("start", "click", Taskbar_OnEvent);
	DKAddEvent("test_animate", "click", Taskbar_OnEvent);
}

//////////////////////
function Taskbar_End()
{
	DKRemoveEvents(Taskbar_OnEvent);
	DKClose("DKOS/Taskbar.html");
	DKClose("DKOS/scale.js");
	DKClose("DKOS/Clock.js");
	DKClose("DKDebug/BugReport.js");
}

///////////////////////////////
function Taskbar_OnEvent(event)
{
	DKLog("Taskbar_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event, "start")){
		DKCreate("DKOS/TaskbarMenu.js", function(){});
	}
	if(DK_Id(event, "test_animate")){
		//DKLog("Taskbar_OnEvent(): animate\n");
		pos = -45;
		animation = setInterval(Taskbar_Animate, 15);
		//EventLoop.run();
	}
}

//////////////////////////
function Taskbar_Animate()
{
	//DKLog("Taskbar_Animate(): frame()\n");
    if(pos == 0){
        clearInterval(animation);
    } 
	else{
        pos++; 
		DKWidget_SetProperty("DKOS/Taskbar.html","bottom",pos+"rem");
		DK_DoFrame();
    }
}