/////////////////////////////
function DKWebviewTest_init()()
{
	dk.create("DKWebview/DKWebviewTest.html");
	window.addEventListener("mousedown", DKWebviewTest_onevent);
	window.addEventListener("keydown", DKWebviewTest_onevent);
	byId("DKWebviewTest.html").addEventListener("mousedown", DKWebviewTest_onevent);
}

////////////////////////////
function DKWebviewTest_end()()
{
	window.addEventListener("mousedown", DKWebviewTest_onevent);
	window.addEventListener("keydown", DKWebviewTest_onevent);
	byId("DKWebviewTest.html").addEventListener("mousedown", DKWebviewTest_onevent);
	dk.close("DKWebviewTest.html");
}

/////////////////////////////////////
function DKWebviewTest_OnEvent(event)
{
	//FIXME: these are not available, DKWebView::OnCreate has not been called yet. 
	console.log("DKWebview_SendValue() = "+DKWebview_SendValue()+"\n");
	DKWebview_ReceiveValue("DKWebview_ReceiveValue sent");
	DKWebview_PrintFunctions();
}