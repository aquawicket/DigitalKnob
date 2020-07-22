/////////////////////
function scale_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKOS/scale.html,DKOS/Taskbar.html");
	DKAddEvent("scale_minus", "mousedown", scale_OnEvent);
	DKAddEvent("scale_plus", "mousedown", scale_OnEvent);
}

////////////////////
function scale_End()
{
	DKDEBUGFUNC();
	DKClose("scale.html");
}

/////////////////////////////
function scale_OnEvent(event)
{
	DKDEBUGFUNC(event);
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
	DKDEBUGFUNC();
	var scale = DKWidget_GetScale();
	scale = scale - 0.1;
	if(scale < 1.0){ scale = 1.0; }
	//DKINFO("DKWidget_SetScale("+scale+")\n");
	DKWidget_SetScale(scale);
}

/////////////////////
function scale_plus()
{
	DKDEBUGFUNC();
	var scale = DKWidget_GetScale();
	scale = scale + 0.1;
	if(scale > 100.0){ scale = 100.0; }
	//DKINFO("DKWidget_SetScale("+scale+")\n");
	DKWidget_SetScale(scale);
}