////////////////////////
function DKEditor_Init()
{
	DKCreate("DKEditor/DKEditor.html");
}

////////////////////
function DKDev_End()
{
	DKClose("DKEditor/DKEditor.html");
}

/////////////////////////////
function DKDev_OnEvent(event)
{
	//DKLog("DKEditor_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKINFO);
}