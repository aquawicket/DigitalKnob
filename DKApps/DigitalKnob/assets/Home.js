////////////////////
function Home_Init()
{
	DKCreate("Home.html,Panel0_content");
	//DKAddEvent("GLOBAL", "mousedown", Home_OnEvent);
}

///////////////////
function Home_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", Home_OnEvent);
	DKClose("DKHome.html");
}

////////////////////////////
function Home_OnEvent(event)
{
	
}