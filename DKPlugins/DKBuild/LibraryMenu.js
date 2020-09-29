///////////////////////////
function LibraryMenu_Init()
{
	DKCreate("DKBuild/LibraryMenu.html");
	window.addEventListener("mousedown", LibraryMenu_OnEvent);
	byId("Build Libraries").addEventListener("click", LibraryMenu_OnEvent);
}

//////////////////////////
function LibraryMenu_End()
{
	window.removeEventListener("mousedown", LibraryMenu_OnEvent);
	byId("Build Libraries").removeEventListener("click", LibraryMenu_OnEvent);
	DKClose("DKBuild/LibraryMenu.html");
}

///////////////////////////////////
function LibraryMenu_OnEvent(event)
{
	DKDEBUG("LibraryMenu_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	
	if(event.currentTarget.id == "Build Libraries"){
		console.log("Clicked Build Librariesn");
	}
	
	if(eventCurrentTarget == window)){
		if(byId("DKBuild/LibraryMenu.html").contains(DKWidget_GetHoverElement())){
			return;
		}
	}
	DKClose("DKBuild/LibraryMenu.js");
}