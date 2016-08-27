////////////////////
function Home_Init()
{
	DKCreate("Digitalknob/Home.html,Digitalknob_content");
	//DKAddEvent("GLOBAL", "mousedown", Home_OnEvent);
}

///////////////////
function Home_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", Home_OnEvent);
	DKClose("Digitalknob/DKHome.html");
}

////////////////////////////
function Home_OnEvent(event)
{
	
}