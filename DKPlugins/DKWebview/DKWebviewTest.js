/////////////////////////////
function DKWebviewTest_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKWebview/DKWebviewTest.html");
	DKAddEvent("window", "mousedown", DKWebviewTest_OnEvent);
	DKAddEvent("window", "keydown", DKWebviewTest_OnEvent);
	DKAddEvent("DKWebviewTest.html", "mousedown", DKWebviewTest_OnEvent);
}

////////////////////////////
function DKWebviewTest_End()
{
	DKDEBUGFUNC();
	DKClose("DKWebviewTest.html");
}

/////////////////////////////////////
function DKWebviewTest_OnEvent(event)
{
	DKDEBUGFUNC(event);
	//FIXME: these are not available, DKWebView::OnCreate has not been called yet. 
	DKINFO("DKWebview_SendValue() = "+DKWebview_SendValue()+"\n");
	DKWebview_ReceiveValue("DKWebview_ReceiveValue sent");
	DKWebview_PrintFunctions();
}