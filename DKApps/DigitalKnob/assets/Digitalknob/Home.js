////////////////////
function Home_Init()
{
	DKCreate("Digitalknob/Home.html,Digitalknob_content");
}

///////////////////
function Home_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", Home_OnEvent);
	DKClose("Digitalknob/Home.html");
}

////////////////////////////
function Home_OnEvent(event)
{
	
}