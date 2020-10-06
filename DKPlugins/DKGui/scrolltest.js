//////////////////////////
function scrolltest_Init()
{
	DK_Create("DKGui/scrolltest.html", function(){
	DK_Create("DKGui/scrolltest1.html", function(){
	DK_Create("DKGui/scrolltest2.html", function(){
		DKWidget_AppendChild("DKGui/scrolltest.html", "DKGui/scrolltest1.html");
		DKWidget_AppendChild("DKGui/scrolltest.html", "DKGui/scrolltest2.html");
	});		
	});
	});

	//DK_Create("DKMessage/DKMessage.js", function(){});
	byId("bottomdiv").addEventListener("mousedown", scrolltest_OnEvent);
}

/////////////////////////
function scrolltest_End()
{
	byId("bottomdiv").removeEventListener("mousedown", scrolltest_OnEvent);
}

//////////////////////////////////
function scrolltest_OnEvent(event)
{
	DKMessageBox(0, "ShowMessage", "bottomdiv clicked");
}