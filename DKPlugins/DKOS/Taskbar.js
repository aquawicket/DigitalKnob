var pos;
var animation;
///////////////////////
function Taskbar_Init()
{
	DK_Create("DKOS/Taskbar.html,DKOS/DKOS.html", function(){
	//DK_Create("DKOS/Taskbar.html", function(){
	DK_Create("DKOS/Clock.js", function(){
	DK_Create("DKOS/Scale.js", function(){
		if(DK_GetBrowser() === "RML"){
			DK_Create("DKDebug/BugReport.js", function(){});
				byId("DKOS/Taskbar.html").appendChild(byId("DKDebug/BugReport.html")); //reparent
		}
		byId("start").addEventListener("click", Taskbar_OnEvent);
		byId("test_animate").addEventListener("click", Taskbar_OnEvent);
	});
	});
	});
}

//////////////////////
function Taskbar_End()
{
	byId("start").removeEventListener("click", Taskbar_OnEvent);
	byId("test_animate").removeEventListener("click", Taskbar_OnEvent);
	DK_Close("DKOS/Taskbar.html");
	DK_Close("DKOS/Scale.js");
	DK_Close("DKOS/Clock.js");
	DK_Close("DKDebug/BugReport.js");
}

///////////////////////////////
function Taskbar_OnEvent(event)
{
	if(event.currentTarget.id === "start"){
		DK_Create("DKOS/TaskbarMenu.js", function(){});
	}
	if(event.currentTarget.id === "test_animate"){
		console.log("Taskbar_OnEvent(): animate");
		pos = -45;
		animation = setInterval(Taskbar_Animate, 15);
		//EventLoop.run();
	}
}

//////////////////////////
function Taskbar_Animate()
{
    if(pos === 0){
        clearInterval(animation);
    } 
	else{
        pos++; 
		byId("DKOS/Taskbar.html").style.bottom = pos+"rem";
		//DK_DoFrame();
    }
}