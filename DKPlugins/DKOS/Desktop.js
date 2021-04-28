///////////////////////
function Desktop_init()
{
	dk.create("DKOS/Desktop.html,DKOS/DKOS.html", function(){
		byId("Background").addEventListener("contextmenu", Desktop_onevent);
	});
}

//////////////////////
function Desktop_end()
{
	byId("Background").removeEventListener("contextmenu", Desktop_onevent);
	dk.close("DKOS/Desktop.html");
}

///////////////////////////////
function Desktop_OnEvent(event)
{
	//console.log("Desktop_OnEvent("+event+")");
	if(event.currentTarget.id === "Background" && event.type === "contextmenu"){
		event.preventDefault();
		dk.create("DKOS/DesktopMenu.js", function(){
			dk.create("DKGui/DKMenu.js", function(){
			    DKMenu_ValidatePosition("DKOS/DesktopMenu.html");
			});
		});
	}
}