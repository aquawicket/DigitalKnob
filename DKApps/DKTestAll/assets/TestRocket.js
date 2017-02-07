DKLog("Opening TestRocket.js... \n", DKINFO);
var info = "";

//////////////////////////
function TestRocket_Init()
{
	DKLog("Running TestRocket_Init() \n", DKINFO);
	DKCreate("DKRocket");
	DKCreate("TestRocket.html");
	
	TestRocket_GetDKInfo();
	TestRocket_GetWindowInfo();
	DKWidget_SetInnerHtml("Info", info);
}

/////////////////////////////
function TestJavascript_End()
{
	DKLog("Running TestRocket_End() \n", DKINFO);
	DKLog("closing TestRocket.js... \n", DKINFO);
	DKClose("Rocket");
	DKClose("TestRocket.html");
}

///////////////////////////////
function TestRocket_GetDKInfo()
{
	info += "Date: "+DK_GetDate();
	info += "<br/>";
	info += "Time: "+DK_GetTime();
	info += "<br/>";
	info += "OS: "+DK_GetOS();
	info += "<br/>";
	info += "Browser: "+DK_GetBrowser();
	info += "<br/>";
	info += "Framerate: "+DK_GetFramerate();
	info += "<br/>";
	info += "JS: "+DK_GetJavascript();
	info += "<br/>";
	info += "Local IP: "+DK_GetLocalIP();
	info += "<br/>";
	info += "Screen: "+DK_GetScreenWidth()+"x"+DK_GetScreenHeight();
	//info += "<br/>";
	//info += "Username: "+DK_GetUsername();
	info += "<br/>";
}

///////////////////////////////
function TestRocket_GetWindowInfo()
{
	info += "Window Position: "+DKWindow_GetX()+"x"+DKWindow_GetX();
	info += "<br/>";
	info += "Window Size: "+DKWindow_GetWidth()+"x"+DKWindow_GetHeight();
	info += "<br/>";
	info += "Pixel Ratio: "+DKWindow_GetPixelRatio();
	info += "<br/>";
	
}