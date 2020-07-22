///////////////////////////
function DesktopMenu_Init()
{
	DKDEBUGFUNC();
	//DKWidget_SetProperty("DKOS/DesktopMenu.html","top",DKWindow_GetMouseY()+"px");
	//DKWidget_SetProperty("DKOS/DesktopMenu.html","left",DKWindow_GetMouseX()+"px");
	DKCreate("DKOS/DesktopMenu.html");
	DKWidget_SetProperty("DKOS/DesktopMenu.html","top","100px");
	DKWidget_SetProperty("DKOS/DesktopMenu.html","left","100px");
	
	DKAddEvent("document", "mousedown", DesktopMenu_OnEvent);
	DKAddEvent("OpenBackgtoundMenu", "click", DesktopMenu_OnEvent);
	DKAddEvent("ToggleFullscreen", "click", DesktopMenu_OnEvent);
}

//////////////////////////
function DesktopMenu_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DesktopMenu_OnEvent);
	DKClose("DKOS/DesktopMenu.html");
}

///////////////////////////////////
function DesktopMenu_OnEvent(event)
{
	DKDEBUGFUNC(event);	
	if(DK_Id(event, "OpenBackgtoundMenu")){
		DKCreate("DKOS/BackgroundMenu.js", function(){
			DKFrame_Widget("DKOS/BackgroundMenu.html");
		});
	}
	if(DK_Id(event, "ToggleFullscreen")){
		Desktop_ToggleFullscreen();
	}
	
	if(DK_Id(event, "document")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKOS/DesktopMenu.html")){
			return;
		}
	}
	DKClose("DKOS/DesktopMenu.js");
	DKClose("DKOS/DesktopMenu.html");
}

///////////////////////////////////
function Desktop_ToggleFullscreen()
{
	DKDEBUGFUNC();
	//TODO: move this function into DKWindow.js
	//http://stackoverflow.com/questions/3900701/onclick-go-full-screen
	if(DKWindow_IsFullscreen()){
		DKWindow_Windowed(); 
	}
	else{
		DKWindow_Fullscreen();
	}
}