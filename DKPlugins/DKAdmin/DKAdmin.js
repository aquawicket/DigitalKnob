///////////////////////
function DKAdmin_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKAdmin/DKAdmin.html");
	DKAddEvent("AdminBadge", "click", DKAdmin_OnEvent);
	
	//DKINFO("DK_GetBrowser() = "+DK_GetBrowser()+"\n");
	if(DK_GetBrowser() == "RML"){
		DKWidget_SetAttribute("AdminBadge", "src", "DKAdmin/adminRed.png");
	}
	else{
		DKWidget_SetAttribute("AdminBadge", "src", "DKAdmin/adminBlue.png");
		document.getElementById("DKAdmin/DKAdmin.html").style.left = "40rem";
	}
}

//////////////////////
function DKAdmin_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKAdmin_OnEvent);
	DKClose("DKAdmin/DKAdmin.html");
}

///////////////////////////////
function DKAdmin_OnEvent(event)
{
	DKDEBUGFUNC(event
	DKINFO("DKAdmin_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	
	if(event.currentTarget.id == "AdminBadge"){
		DKCreate("DKAdmin/DKAdminMenu.js", function(){});
	}
}



