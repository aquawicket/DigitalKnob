////////////////////////
function Template_Init()
{
	DKLog("Template_Init()\n", DKINFO);
	DKCreate("Template.html", function(){});
}

///////////////////////
function Template_End()
{
	DKLog("Template_End()\n", DKINFO);
}

////////////////////////////////
function Template_OnEvent(event)
{
	DKLog("Tempalte_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKINFO);
}