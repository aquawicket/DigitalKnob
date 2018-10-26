//////////////////////////
function scrolltest_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKGui/scrolltest.html", function(){
	DKCreate("DKGui/scrolltest1.html", function(){
	DKCreate("DKGui/scrolltest2.html", function(){
		DKWidget_AppendChild("DKGui/scrolltest.html", "DKGui/scrolltest1.html");
		DKWidget_AppendChild("DKGui/scrolltest.html", "DKGui/scrolltest2.html");
	});		
	});
	});

	//DKCreate("DKMessage/DKMessage.js", function(){});
	DKAddEvent("bottomdiv", "mousedown", scrolltest_OnEvent);
}

//////////////////////////////////
function scrolltest_OnEvent(event)
{
	DKDEBUGFUNC(event);
	DKMessageBox(0, "ShowMessage", "bottomdiv clicked");
}