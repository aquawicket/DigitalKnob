/////////////////////
function scale_Init()
{
	DKLog("scale_Init()\n", DKDEBUG);
	DKCreate("DKGui/scale.html,DKGui/Taskbar.html");
	DKAddEvent("scale_minus", "mousedown", scale_OnEvent);
	DKAddEvent("scale_plus", "mousedown", scale_OnEvent);
}

////////////////////
function scale_End()
{
	DKLog("scale_End()\n", DKDEBUG);
	DKClose("scale.html");
}

/////////////////////////////
function scale_OnEvent(event)
{
	DKLog("scale_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	if(DK_Id(event,"scale_minus")){
		scale_minus();
	}
	if(DK_Id(event,"scale_plus")){
		scale_plus();
	}
}

//////////////////////
function scale_minus()
{
	DKLog("scale_minus()\n", DKDEBUG);
	var scale = DKWidget_GetScale();
	scale = scale - 0.1;
	if(scale < 1.0){ scale = 1.0; }
	//DKLog("DKWidget_SetScale("+scale+")\n");
	DKWidget_SetScale(scale);
}

/////////////////////
function scale_plus()
{
	DKLog("scale_plus()\n", DKDEBUG);
	var scale = DKWidget_GetScale();
	scale = scale + 0.1;
	if(scale > 100.0){ scale = 100.0; }
	//DKLog("DKWidget_SetScale("+scale+")\n");
	DKWidget_SetScale(scale);
}