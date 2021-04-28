//////////////////////////////
function BackgroundMenu_Init()
{
	dk.create("DKOS/BackgroundMenu.html");
	var file = byId("Background").getAttribute("src");
	//console.log("file="+file+"\n");
	byId("BackgroundMenu_Image").setAttribute("src", file);
}

/////////////////////////////
function BackgroundMenu_End()
{
	dk.close("DKOS/BackgroundMenu.html");
}

//////////////////////////////////////
function BackgroundMenu_OnEvent(event)
{
	
}
