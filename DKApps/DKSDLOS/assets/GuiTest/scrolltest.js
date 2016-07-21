
//////////////////////////
function scrolltest_Init()
{
	DKCreate("GuiTest/scrolltest.html");
	DKCreate("GuiTest/scrolltest1.html");
	DKCreate("GuiTest/scrolltest2.html");
	DKCreate("DKMessage/DKMessage.js");
	DKAddEvent("bottomdiv", "mousedown", scrolltest_OnEvent);
}

/////////////////////////
function scrolltest_End()
{
	DKClose("GuiTest/scrolltest.html");
	DKClose("GuiTest/scrolltest1.html");
	DKClose("GuiTest/scrolltest2.html");
}

//////////////////////////////////
function scrolltest_OnEvent(event)
{
	//DKLog("scrolltest_OnEvent\n");
	DKMessageBox(0, "ShowMessage", "bottomdiv clicked");
}