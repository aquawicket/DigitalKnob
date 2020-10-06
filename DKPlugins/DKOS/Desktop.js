///////////////////////
function Desktop_Init()
{
	//DKCreate("DKOS/Desktop.html,DKOS/DKOS.html");
	DKCreate("DKOS/Desktop.html");
	byId("Background").addEventListener("contextmenu", Desktop_OnEvent);
}

//////////////////////
function Desktop_End()
{
	byId("Background").removeEventListener("contextmenu", Desktop_OnEvent);
	DKClose("DKOS/Desktop.html");
}

///////////////////////////////
function Desktop_OnEvent(event)
{
	//console.log("Desktop_OnEvent("+event+")");
	if(event.currentTarget.id === "Background" && event.type === "contextmenu"){
		event.preventDefault();
		DKCreate("DKOS/DesktopMenu.js", function(){
			DKMenu_ValidatePosition("DKOS/DesktopMenu.html");
		});
	}
}