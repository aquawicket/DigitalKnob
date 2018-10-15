var pos;
var animation;
///////////////////////
function Taskbar_Init()
{
	DKLog("Taskbar_Init()\n", DKDEBUG);
	//DKCreate("DKGui/Taskbar.html,DKGui/DKOS.html");
	DKCreate("DKGui/Taskbar.html", function(){});
	DKCreate("DKGui/scale.js", function(){});
	DKCreate("DKGui/Clock.js", function(){});
	if(DK_GetBrowser() == "Rocket"){
		DKCreate("DKDebug/BugReport.js", function(){});
			DKWidget_AppendChild("DKGui/Taskbar.html","DKDebug/BugReport.html"); //reparent
			
		
	}
	DKAddEvent("start", "click", Taskbar_OnEvent);
	DKAddEvent("test_animate", "click", Taskbar_OnEvent);
}

//////////////////////
function Taskbar_End()
{
	DKLog("Taskbar_End()\n", DKDEBUG);
	DKRemoveEvents(Taskbar_OnEvent);
	DKClose("DKGui/Taskbar.html");
	DKClose("DKGui/scale.js");
	DKClose("DKGui/Clock.js");
	DKClose("DKDebug/BugReport.js");
}

///////////////////////////////
function Taskbar_OnEvent(event)
{
	DKLog("Taskbar_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	if(DK_Id(event, "start")){
		DKCreate("DKGui/TaskbarMenu.js", function(){});
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
	DKLog("Taskbar_Animate()\n", DKDEBUG);
    if(pos == 0){
        clearInterval(animation);
    } 
	else{
        pos++; 
		DKWidget_SetProperty("DKGui/Taskbar.html","bottom",pos+"rem");
		DK_DoFrame();
    }
}