/////////////////////////
function DKLoading_Init()
{
	DKCreate("DKLoading/DKLoading.html");
}

////////////////////////
function DKLoading_End()
{
	DKClose("DKLoading.html");
}

/////////////////////////////////
function DKLoading_OnEvent(event)
{
	DKLog("DKLoading_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
}
