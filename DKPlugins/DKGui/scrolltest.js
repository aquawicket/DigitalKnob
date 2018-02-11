//////////////////////////
function scrolltest_Init()
{
	DKCreate("DKGui/scrolltest.html");
	//DKCreate("DKGui/scrolltest1.html", "DKGui/scrolltest.html");
	//DKCreate("DKGui/scrolltest2.html", "DKGui/scrolltest.html");
	//DKCreate("DKMessage/DKMessage.js", function(){});
	DKAddEvent("bottomdiv", "mousedown", scrolltest_OnEvent);
}

//////////////////////////////////
function scrolltest_OnEvent(event)
{
	DKLog("scrolltest_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	DKMessageBox(0, "ShowMessage", "bottomdiv clicked");
}