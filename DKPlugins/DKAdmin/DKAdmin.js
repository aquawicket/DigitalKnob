///////////////////////
function DKAdmin_Init()
{
	DK_Create("DKAdmin/DKAdmin.html");
	byId("AdminBadge").addEventListener("click", DKAdmin_OnEvent);
	
	//console.log("DK_GetBrowser() = "+DK_GetBrowser()+"\n");
	if(DK_GetBrowser() === "RML"){
		byId("AdminBadge").src = "DKAdmin/adminRed.png";
	}
	else{
		byId("AdminBadge")."src" = "DKAdmin/adminBlue.png");
		byId("DKAdmin/DKAdmin.html").style.left = "40rem";
	}
}

//////////////////////
function DKAdmin_End()
{
	byId("AdminBadge").removeEventListener("click", DKAdmin_OnEvent);
	DKClose("DKAdmin/DKAdmin.html");
}

///////////////////////////////
function DKAdmin_OnEvent(event)
{
	console.log("DKAdmin_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	
	if(event.currentTarget.id === "AdminBadge"){
		DK_Create("DKAdmin/DKAdminMenu.js", function(){});
	}
}