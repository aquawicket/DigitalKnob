//////////////////////////////
function BackgroundMenu_Init()
{
	DKCreate("DKOS/BackgroundMenu.html");
	var file = document.getElementById("Background").getAttribute("src");
	//console.log("file="+file+"\n");
	document.getElementById("BackgroundMenu_Image").setAttribute("src", file);
}

/////////////////////////////
function BackgroundMenu_End()
{
	DKClose("DKOS/BackgroundMenu.html");
}

//////////////////////////////////////
function BackgroundMenu_OnEvent(event)
{
	
}
