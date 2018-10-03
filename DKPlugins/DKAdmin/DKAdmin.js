///////////////////////
function DKAdmin_Init()
{
	//DKLog("DKAdmin_Init()\n");
	
	DKCreate("DKAdmin/DKAdmin.html");
	DKAddEvent("AdminBadge", "click", DKAdmin_OnEvent);
}

//////////////////////
function DKAdmin_End()
{
	//DKLog("DKAdmin_End()\n");
	
	DKRemoveEvents(DKAdmin_OnEvent);
	DKClose("DKAdmin/DKAdmin.html");
}

///////////////////////////////
function DKAdmin_OnEvent(event)
{
	DKLog("DKAdmin_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event, "AdminBadge")){
		DKCreate("DKAdmin/DKAdminMenu.js", function(){});
	}
}



