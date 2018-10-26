///////////////////////////
function DesktopMenu_Init()
{
	DKDEBUGFUNC();
	DKWidget_SetProperty("DKGui/DesktopMenu.html","top",DKWindow_GetMouseY()+"px");
	DKWidget_SetProperty("DKGui/DesktopMenu.html","left",DKWindow_GetMouseX()+"px");
	
	DKAddEvent("GLOBAL", "mousedown", DesktopMenu_OnEvent);
	DKAddEvent("OpenBackgtoundMenu", "click", DesktopMenu_OnEvent);
	DKAddEvent("ToggleFullscreen", "click", DesktopMenu_OnEvent);
}

//////////////////////////
function DesktopMenu_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DesktopMenu_OnEvent);
	DKClose("DKGui/DesktopMenu.html");
}

///////////////////////////////////
function DesktopMenu_OnEvent(event)
{
	DKDEBUGFUNC(event);	
	if(DK_Id(event, "OpenBackgtoundMenu")){
		DKCreate("DKGui/BackgroundMenu.js", function(){
			DKFrame_Widget("DKGui/BackgroundMenu.html");
		});
	}
	if(DK_Id(event, "ToggleFullscreen")){
		Desktop_ToggleFullscreen();
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKGui/DesktopMenu.html")){
			return;
		}
	}
	DKClose("DKGui/DesktopMenu.js");
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