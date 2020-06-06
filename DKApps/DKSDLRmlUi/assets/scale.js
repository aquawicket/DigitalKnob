/////////////////////
function scale_Init()
{
	DKCreate("scale.html");
	DKAddEvent("scale_minus", "mousedown", scale_OnEvent);
	DKAddEvent("scale_plus", "mousedown", scale_OnEvent);
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
	//DKLog("scale_minus() \n");
	var scale = DKWidget_GetScale();
	scale = scale - 0.1;
	DKWidget_SetScale(scale);
}

/////////////////////
function scale_plus()
{
	//DKLog("scale_plus() \n");
	var scale = DKWidget_GetScale();
	scale = scale + 0.1;
	DKWidget_SetScale(scale);
}
