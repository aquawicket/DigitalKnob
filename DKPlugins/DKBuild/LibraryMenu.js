///////////////////////////
function LibraryMenu_Init()
{
	DK_Create("DKBuild/LibraryMenu.html");
	document.addEventListener("mousedown", LibraryMenu_OnEvent);
	byId("Build Libraries").addEventListener("click", LibraryMenu_OnEvent);
}

//////////////////////////
function LibraryMenu_End()
{
	document.removeEventListener("mousedown", LibraryMenu_OnEvent);
	byId("Build Libraries").removeEventListener("click", LibraryMenu_OnEvent);
	DK_Close("DKBuild/LibraryMenu.html");
}

///////////////////////////////////
function LibraryMenu_OnEvent(event)
{
	console.debug("LibraryMenu_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	
	if(event.currentTarget.id === "Build Libraries"){
		console.log("Clicked Build Librariesn");
	}
	
	if(event.currentTarget === document){
		if(byId("DKBuild/LibraryMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))){
			return;
		}
	}
	DK_Close("DKBuild/LibraryMenu.js");
}