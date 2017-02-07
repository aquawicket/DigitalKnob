DKLog("Opening TestRocket.js... \n", DKINFO);

//////////////////////////
function TestRocket_Init()
{
	DKLog("Running TestRocket_Init() \n", DKINFO);
	DKCreate("DKRocket");
	DKCreate("TestRocket.html");
	
	TestRocket_GetInfo();
}

/////////////////////////////
function TestJavascript_End()
{
	DKLog("Running TestRocket_End() \n", DKINFO);
	DKLog("closing TestRocket.js... \n", DKINFO);
	DKClose("Rocket");
	DKClose("TestRocket.html");
}

/////////////////////////////
function TestRocket_GetInfo()
{
	DKWidget_SetInnterHtml("Info", "Test");
}