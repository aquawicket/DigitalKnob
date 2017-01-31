DKLog("Opening TestJavascript.js... \n", DKINFO);

//////////////////////////////
function TestJavascript_Init()
{
	DKLog("Running TestJavascript_Init() \n", DKINFO);
	var a = 123;
	var b = 456;
	var c = a + b;
	DKLog(a+" + "+b+" = "+c+" \n", DKINFO);
}

/////////////////////////////
function TestJavascript_End()
{
	DKLog("Running TestJavascript_End() \n", DKINFO);
	DKLog("closing TestJavascript.js... \n", DKINFO);
}