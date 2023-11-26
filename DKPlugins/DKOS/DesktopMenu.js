//"use strict";

function DesktopMenu(){}
dk.os.desktop.menu = DKPlugin(DesktopMenu, "singleton")

DesktopMenu.prototype.init = function DesktopMenu_init() {
    dk.create("DKOS/DesktopMenu.html", function(){
    //byId("DKOS/DesktopMenu.html").style.top = CPP_DKWindow_GetMouseY()+"px";
    //byId("DKOS/DesktopMenu.html").style.left = CPP_DKWindow_GetMouseX()+"px";
    byId("DKOS/DesktopMenu.html").style.top = "100px";
    byId("DKOS/DesktopMenu.html").style.left = "100px";

    document.addEventListener("mousedown", dk.os.desktop.menu.onevent);
    byId("OpenBackgtoundMenu").addEventListener("click", dk.os.desktop.menu.onevent);
    byId("ToggleFullscreen").addEventListener("click", dk.os.desktop.menu.onevent);
	});
}

DesktopMenu.prototype.end = function DesktopMenu_end() {
    document.removeEventListener("mousedown", dk.os.desktop.menu.onevent);
    byId("OpenBackgtoundMenu").removeEventListener("click", dk.os.desktop.menu.onevent);
    byId("ToggleFullscreen").removeEventListener("click", dk.os.desktop.menu.onevent);
    dk.close("DKOS/DesktopMenu.html");
}

DesktopMenu.prototype.onevent = function DesktopMenu_onevent(event) {
    if (event.currentTarget.id === "OpenBackgtoundMenu") {
        DKPlugin("DKOS/BackgroundMenu.js", function() {
            DKFrame_Html("DKOS/BackgroundMenu.html");
        });
    }
    if (event.currentTarget.id === "ToggleFullscreen")
        Desktop_ToggleFullscreen();
   
    if (event.currentTarget === document) {
        if (byId("DKOS/DesktopMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY)))
            return;
    }
    dk.close("DKOS/DesktopMenu.js");
}

Desktop.prototype.toggleFullscreen = function Desktop_toggleFullscreen() {
    //TODO: move this function into DKWindow.js
    //http://stackoverflow.com/questions/3900701/onclick-go-full-screen
    if (CPP_DKWindow_IsFullscreen())
        CPP_DKWindow_Windowed();
    else
        CPP_DKWindow_Fullscreen();
}
