/////////////////////
function DKOcr_Init()
{
	DKLog("DKOcr_Init()\n");
}

////////////////////
function DKOcr_End()
{
	DKLog("DKOcr_End()\n");
}

/////////////////////////////
function DKOcr_OnEvent(event)
{
	DKLog("DKOcr_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
}