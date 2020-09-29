/////////////////////////////
function DKWebviewTest_Init()
{
	DKCreate("DKWebview/DKWebviewTest.html");
	window.addEventListener("mousedown", DKWebviewTest_OnEvent);
	window.addEventListener("keydown", DKWebviewTest_OnEvent);
	byId("DKWebviewTest.html").addEventListener("mousedown", DKWebviewTest_OnEvent);
}

////////////////////////////
function DKWebviewTest_End()
{
	window.addEventListener("mousedown", DKWebviewTest_OnEvent);
	window.addEventListener("keydown", DKWebviewTest_OnEvent);
	byId("DKWebviewTest.html").addEventListener("mousedown", DKWebviewTest_OnEvent);
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