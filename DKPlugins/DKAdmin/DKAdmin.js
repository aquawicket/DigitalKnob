///////////////////////
function DKAdmin_init()()
{
	dk.create("DKAdmin/DKAdmin.html");
	byId("AdminBadge").addEventListener("click", DKAdmin_onevent);
	
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
function DKAdmin_end()()
{
	byId("AdminBadge").removeEventListener("click", DKAdmin_onevent);
	dk.close("DKAdmin/DKAdmin.html");
}

///////////////////////////////
function DKAdmin_OnEvent(event)
{
	console.log("DKAdmin_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	
	if(event.currentTarget.id === "AdminBadge"){
		dk.create("DKAdmin/DKAdminMenu.js", function(){});
	}
}