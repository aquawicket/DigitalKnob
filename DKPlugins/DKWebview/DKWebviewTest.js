/////////////////////////////
function DKWebviewTest_Init()
{
	DKCreate("DKWebview/DKWebviewTest.html");
	DKAddEvent("window", "mousedown", DKWebviewTest_OnEvent);
	DKAddEvent("window", "keydown", DKWebviewTest_OnEvent);
	DKAddEvent("DKWebviewTest.html", "mousedown", DKWebviewTest_OnEvent);
}

////////////////////////////
function DKWebviewTest_End()
{
	DKClose("DKWebviewTest.html");
}

/////////////////////////////////////
function DKWebviewTest_OnEvent(event)
{
	//FIXME: these are not available, DKWebView::OnCreate has not been called yet. 
	console.log("DKWebview_SendValue() = "+DKWebview_SendValue()+"\n");
	DKWebview_ReceiveValue("DKWebview_ReceiveValue sent");
	DKWebview_PrintFunctions();
}