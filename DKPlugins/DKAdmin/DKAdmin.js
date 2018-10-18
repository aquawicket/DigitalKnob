///////////////////////
function DKAdmin_Init()
{
	DKLog("DKAdmin_Init()\n", DKDEBUG);
	
	DKCreate("DKAdmin/DKAdmin.html");
	DKAddEvent("AdminBadge", "click", DKAdmin_OnEvent);
	
	//DKLog("DK_GetBrowser() = "+DK_GetBrowser()+"\n");
	if(DK_GetBrowser() == "Rocket"){
		DKWidget_SetAttribute("AdminBadge", "src", "DKAdmin/adminRed.png");
	}
	else{
		DKWidget_SetAttribute("AdminBadge", "src", "DKAdmin/adminBlue.png");
		DKWidget_SetProperty("DKAdmin/DKAdmin.html", "left", "40rem");
	}
}

//////////////////////
function DKAdmin_End()
{
	DKLog("DKAdmin_End()\n", DKDEBUG);
	
	DKRemoveEvents(DKAdmin_OnEvent);
	DKClose("DKAdmin/DKAdmin.html");
}

///////////////////////////////
function DKAdmin_OnEvent(event)
{
	DKLog("DKAdmin_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Id(event, "AdminBadge")){
		DKCreate("DKAdmin/DKAdminMenu.js", function(){});
	}
}



