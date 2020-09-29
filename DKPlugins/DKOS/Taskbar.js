var pos;
var animation;
///////////////////////
function Taskbar_Init()
{
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
	//DKRemoveEvents(Taskbar_OnEvent);
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
    if(pos == 0){
        clearInterval(animation);
    } 
	else{
        pos++; 
		byId("DKOS/Taskbar.html").style.bottom = pos+"rem";
		//DK_DoFrame();
    }
}