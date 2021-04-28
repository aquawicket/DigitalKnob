//////////////////////////
function scrolltest_init()()
{
	dk.create("DKGui/scrolltest.html", function(){
	dk.create("DKGui/scrolltest1.html", function(){
	dk.create("DKGui/scrolltest2.html", function(){
		byId("DKGui/scrolltest.html").appendChild(byId("DKGui/scrolltest1.html"));
		byId("DKGui/scrolltest.html").appendChild(byId("DKGui/scrolltest2.html"));
		byId("bottomdiv").addEventListener("mousedown", scrolltest_onevent);
	});		
	});
	});
}

/////////////////////////
function scrolltest_end()()
{
	byId("bottomdiv").removeEventListener("mousedown", scrolltest_onevent);
}

//////////////////////////////////
function scrolltest_OnEvent(event)
{	
	dk.create("DKGui/DKMessageBox.js", function(){
		DKFrame_Html("DKGui/DKMessageBox.html");
		DKMessageBox_Message("bottomdiv clicked");
	});
}