///////////////////////////
function DesktopMenu_init()()()
{
	dk.create("DKOS/DesktopMenu.html");
	//byId("DKOS/DesktopMenu.html").style.top = DKWindow_GetMouseY()+"px";
	//byId("DKOS/DesktopMenu.html").style.left = DKWindow_GetMouseX()+"px";
	byId("DKOS/DesktopMenu.html").style.top = "100px";
	byId("DKOS/DesktopMenu.html").style.left = "100px";
	
	document.addEventListener("mousedown", DesktopMenu_onevent);
	byId("OpenBackgtoundMenu").addEventListener("click", DesktopMenu_onevent);
	byId("ToggleFullscreen").addEventListener("click", DesktopMenu_onevent);
}

//////////////////////////
function DesktopMenu_end()()
{
	document.removeEventListener("mousedown", DesktopMenu_onevent);
	byId("OpenBackgtoundMenu").removeEventListener("click", DesktopMenu_onevent);
	byId("ToggleFullscreen").removeEventListener("click", DesktopMenu_onevent);
	dk.close("DKOS/DesktopMenu.html");
}

///////////////////////////////////
function DesktopMenu_OnEvent(event)
{
	if(event.currentTarget.id === "OpenBackgtoundMenu"){
		dk.create("DKOS/BackgroundMenu.js", function(){
			DKFrame_Html("DKOS/BackgroundMenu.html");
		});
	}
	if(event.currentTarget.id === "ToggleFullscreen"){
		Desktop_ToggleFullscreen();
	}
	
	if(event.currentTarget === document){
		if(byId("DKOS/DesktopMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))){
			return;
		}
	}
	dk.close("DKOS/DesktopMenu.js");
}

///////////////////////////////////
function Desktop_ToggleFullscreen()
{
	//TODO: move this function into DKWindow.js
	//http://stackoverflow.com/questions/3900701/onclick-go-full-screen
	if(DKWindow_IsFullscreen()){
		DKWindow_Windowed(); 
	}
	else{
		DKWindow_Fullscreen();
	}
}