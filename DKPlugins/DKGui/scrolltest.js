//////////////////////////
function scrolltest_Init()
{
	DK_Create("DKGui/scrolltest.html", function(){
	DK_Create("DKGui/scrolltest1.html", function(){
	DK_Create("DKGui/scrolltest2.html", function(){
		DKWidget_AppendChild("DKGui/scrolltest.html", "DKGui/scrolltest1.html");
		DKWidget_AppendChild("DKGui/scrolltest.html", "DKGui/scrolltest2.html");
		byId("bottomdiv").addEventListener("mousedown", scrolltest_OnEvent);
	});		
	});
	});
}

/////////////////////////
function scrolltest_End()
{
	byId("bottomdiv").removeEventListener("mousedown", scrolltest_OnEvent);
}

//////////////////////////////////
function scrolltest_OnEvent(event)
{	
	DK_Create("DKGui/DKMessageBox.js", function(){
		DKFrame_Widget("DKGui/DKMessageBox.html");
		DKMessageBox_Message("bottomdiv clicked");
	});
}