var pos;
var animation;
///////////////////////
function Taskbar_Init()
{
	DKDEBUGFUNC();
	//DKCreate("DKOS/Taskbar.html,DKOS/DKOS.html");
	DKCreate("DKOS/Taskbar.html", function(){});
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
	DKDEBUGFUNC();
	DKRemoveEvents(Taskbar_OnEvent);
	DKClose("DKOS/Taskbar.html");
	DKClose("DKOS/scale.js");
	DKClose("DKOS/Clock.js");
	DKClose("DKDebug/BugReport.js");
}

///////////////////////////////
function Taskbar_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(DK_Id(event, "start")){
		DKCreate("DKOS/TaskbarMenu.js", function(){});
	}
	if(DK_Id(event, "test_animate")){
		DKINFO("Taskbar_OnEvent(): animate\n");
		pos = -45;
		animation = setInterval(Taskbar_Animate, 15);
		//EventLoop.run();
	}
}

//////////////////////////
function Taskbar_Animate()
{
	DKDEBUGFUNC();
    if(pos == 0){
        clearInterval(animation);
    } 
	else{
        pos++; 
		DKWidget_SetProperty("DKOS/Taskbar.html","bottom",pos+"rem");
		DK_DoFrame();
    }
}