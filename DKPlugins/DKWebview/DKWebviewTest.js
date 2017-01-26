
/////////////////////////////
function DKWebviewTest_Init()
{
	DKCreate("DKWebview/DKWebviewTest.html");
	DKAddEvent("GLOBAL", "mousedown", DKWebviewTest_OnEvent);
	DKAddEvent("GLOBAL", "keydown", DKWebviewTest_OnEvent);
	DKAddEvent("DKWebviewTest.html", "mousedown", DKWebviewTest_OnEvent);
}

////////////////////////////
function DKWebviewTest_End()
{
	
}

/////////////////////////////////////
function DKWebviewTest_OnEvent(event)
{
	DKLog("DKWebviewTest_OnEvent("+event+") \n",DKINFO);
	
	//FIXME: these are not available, DKWebView::OnCreate has not been called yet. 
	DKLog("DKWebview_SendValue() = "+DKWebview_SendValue()+"\n", DKINFO);
	DKWebview_ReceiveValue("DKWebview_ReceiveValue sent");
	DKWebview_PrintFunctions();
}