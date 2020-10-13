//////////////////////////
function scrolltest_Init()
{
	DK_Create("DKGui/scrolltest.html", function(){
	DK_Create("DKGui/scrolltest1.html", function(){
	DK_Create("DKGui/scrolltest2.html", function(){
		byId("DKGui/scrolltest.html").appendChild(byId("DKGui/scrolltest1.html"));
		byId("DKGui/scrolltest.html").appendChild(byId("DKGui/scrolltest2.html"));
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
		DKFrame_Html("DKGui/DKMessageBox.html");
		DKMessageBox_Message("bottomdiv clicked");
	});
}