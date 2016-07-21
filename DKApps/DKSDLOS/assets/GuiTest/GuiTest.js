
///////////////////////
function GuiTest_Init()
{
	DKCreate("GuiTest/GuiTest.html");
	DKCreate("GuiTest/scrolltest1.html,GuiTest.html");
	DKCreate("GuiTest/scrolltest2.html,GuiTest.html");
	DKAddEvent("bottomdiv", "mousedown", GuiTest_OnEvent);
}

//////////////////////
function GuiTest_End()
{
	DKClose("GuiTest/GuiTest.html");
	DKClose("GuiTest/scrolltest1.html");
	DKClose("GuiTest/scrolltest2.html");
}

///////////////////////////////
function GuiTest_OnEvent(event)
{
	//DKLog("scrolltest_OnEvent\n");
	DKCreate("DKMessage/DKMessage.js");
	DKMessageBox(0, "ShowMessage", "bottomdiv clicked");
}