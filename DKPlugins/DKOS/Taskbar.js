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
	if(DK_GetBrowser() == "RML"){
		DKCreate("DKDebug/BugReport.js", function(){});
			//DKWidget_AppendChild("DKOS/Taskbar.html","DKDebug/BugReport.html"); //reparent
			byId("DKOS/Taskbar.html").appendChild(byId("DKDebug/BugReport.html")); //reparent
	}
	//DKAddEvent("start", "click", Taskbar_OnEvent);
	byId("start").addEventListener("click", Taskbar_OnEvent);
	//DKAddEvent("test_animate", "click", Taskbar_OnEvent);
	byId("test_animate").addEventListener("click", Taskbar_OnEvent);
}

//////////////////////
function Taskbar_End()
{
	DKDEBUGFUNC();
	//DKRemoveEvents(Taskbar_OnEvent);
	if(!byId("DKOS/Taskbar.html")){
		console.error("Taskbar_End(): DKOS/Taskbar.html invalid");
		return;
	}
	byId("start").removeEventListener("click", Taskbar_OnEvent);
	byId("test_animate").removeEventListener("click", Taskbar_OnEvent);
	DKClose("DKOS/Taskbar.html");
	DKClose("DKOS/scale.js");
	DKClose("DKOS/Clock.js");
	DKClose("DKDebug/BugReport.js");
}

///////////////////////////////
function Taskbar_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(event.currentTarget.id == "start"){
		DKCreate("DKOS/TaskbarMenu.js", function(){});
	}
	if(event.currentTarget.id == "test_animate"){
		console.log("Taskbar_OnEvent(): animate");
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