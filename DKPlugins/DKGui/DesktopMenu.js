///////////////////////////
function DesktopMenu_Init()
{
	DKCreate("DKGui/DesktopMenu.html");
	DKWidget_SetProperty("DKGui/DesktopMenu.html","top",DKWindow_GetMouseY()+"px");
	DKWidget_SetProperty("DKGui/DesktopMenu.html","left",DKWindow_GetMouseX()+"px");
	
	DKAddEvent("GLOBAL", "mousedown", DesktopMenu_OnEvent);
	DKAddEvent("OpenBackgtoundMenu", "click", DesktopMenu_OnEvent);
	DKAddEvent("ToggleFullscreen", "click", DesktopMenu_OnEvent);
}

//////////////////////////
function DesktopMenu_End()
{
	DKRemoveEvents(DesktopMenu_OnEvent);
	DKClose("DKGui/DesktopMenu.html");
}

///////////////////////////////////
function DesktopMenu_OnEvent(event)
{
	DKLog("DesktopMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	
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
	//TODO: move this function into DKWindow.js
	//http://stackoverflow.com/questions/3900701/onclick-go-full-screen
	if(DK_GetBrowser() != "Rocket"){
		if((document.fullScreenElement && document.fullScreenElement !== null) || (!document.mozFullScreen && !document.webkitIsFullScreen)){
			if(document.documentElement.requestFullScreen){  
				document.documentElement.requestFullScreen();  
			} 
			else if(document.documentElement.mozRequestFullScreen){  
				document.documentElement.mozRequestFullScreen();  
			} 
			else if(document.documentElement.webkitRequestFullScreen){  
				document.documentElement.webkitRequestFullScreen(Element.ALLOW_KEYBOARD_INPUT);  
			}  
		}
		else{  
			if(document.cancelFullScreen){  
				document.cancelFullScreen();  
			} 
			else if(document.mozCancelFullScreen){  
				document.mozCancelFullScreen();  
			} 
			else if(document.webkitCancelFullScreen){  
				document.webkitCancelFullScreen();  
			}  
		} 
	}
	else{
		if(DKWindow_IsFullscreen()){
			DKLog("EXIT Fullscreen \n");
			DKWindow_Windowed();
		}
		else{
			DKLog("ENTER Fullscreen \n");
			DKWindow_Fullscreen();
		}
	}
}