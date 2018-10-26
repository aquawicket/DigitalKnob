var pos;
var animation;
///////////////////////
function Taskbar_Init()
{
	DKDEBUGFUNC();
	//DKCreate("DKGui/Taskbar.html,DKGui/DKOS.html");
	DKCreate("DKGui/DKTaskbar/Taskbar.html");
	DKCreate("DKGui/scale.js", function(){});
	DKCreate("DKGui/Clock.js", function(){});
	if(DK_GetBrowser() == "Rocket"){
		DKCreate("DKDebug/BugReport.js", function(){});
		DKWidget_AppendChild("DKGui/DKTaskbar/Taskbar.html","DKDebug/BugReport.html"); //reparent
	}
	DKAddEvent("start", "click", Taskbar_OnEvent);
	DKAddEvent("test_animate", "click", Taskbar_OnEvent);
}

//////////////////////
function Taskbar_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(Taskbar_OnEvent);
	DKClose("DKGui/DKTaskbar/Taskbar.html");
	DKClose("DKGui/scale.js");
	DKClose("DKGui/Clock.js");
	DKClose("DKDebug/BugReport.js");
}

///////////////////////////////
function Taskbar_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(DK_Id(event, "start")){
		DKCreate("DKGui/TaskbarMenu.js", function(){});
	}
	if(DK_Id(event, "test_animate")){
		//DKINFO("Taskbar_OnEvent(): animate\n");
		pos = -45;
		animation = setInterval(Taskbar_Animate, 15);
		//EventLoop.run();
	}
}

//////////////////////////
function Taskbar_Animate()
{
	DKDEBUGFUNC();
	//DKINFO("Taskbar_Animate(): frame()\n");
    if(pos == 0){
        clearInterval(animation);
    } 
	else{
        pos++; 
		DKWidget_SetProperty("DKGui/DKTaskbar/Taskbar.html","bottom",pos+"rem");
		DK_DoFrame();
    }
}