DKLog("Opening TestWindow.js... \n", DKINFO);

//////////////////////////
function TestWindow_Init()
{
	DKLog("Running TestWindow_Init() \n", DKINFO);
	DKCreate("DKWindow"); //create an sdl window
	DKWindow_MessageBox("Test Message Box");
}

/////////////////////////////
function TestJavascript_End()
{
	DKLog("Running TestWindow_End() \n", DKINFO);
	DKLog("closing TestWindow.js... \n", DKINFO);
}