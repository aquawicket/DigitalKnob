//"use strict"; //FIXME: "use strict" breaks DUKTAPE

function DesktopMenu(){}
//dk.os.desktop.menu = DKPlugin(DesktopMenu, "singleton") //FIXME: "singleton" breaks DUKTAPE
dk.os.desktop.menu = DKPlugin(DesktopMenu)

DesktopMenu.prototype.init = function DesktopMenu_init(callback) {
	this.create()
	callback && callback(true);
}

DesktopMenu.prototype.end = function DesktopMenu_end() {
    document.removeEventListener("mousedown", dk.os.desktop.menu.onevent);
    byId("OpenBackgoundMenu").removeEventListener("click", dk.os.desktop.menu.onevent);
    byId("ToggleFullscreen").removeEventListener("click", dk.os.desktop.menu.onevent);
    dk.close("DKOS/DesktopMenu.html");
}

DesktopMenu.prototype.create = function DesktopMenu_create(DesktopMenu_create_callback) {
    const instance = new DKPlugin(DesktopMenu)
    if (!instance)
        return error("instance invalid", DesktopMenu_create_callback)
    dk.create("DKOS/DesktopMenu.html", function dk_create_callback(html) {
        if(!html)
            return error("html invalid")
		if(!instance)
			return error("instance invalid")
        instance.html = html;
		instance.backgroundMenu = byId("OpenBackgoundMenu");
		if(!instance.backgroundMenu)
			return error("instance.backgroundMenu invalid")
		instance.toggleFullscreen = byId("ToggleFullscreen")
		if(!instance.toggleFullscreen)
			return error("instance.toggleFullscreen invalid")
		
		instance.html.style.top = window.mouseY + "rem"
		instance.html.style.left = window.mouseX + "rem"
		document.addEventListener("mousedown", dk.os.desktop.menu.onevent);
		
		instance.backgroundMenu.onclick = function(event) {
            instance.onBackgroundMenu(instance, event)
        }
		
		instance.toggleFullscreen.onclick = function(event) {
            instance.onToggleFullscreen(event)
        }
	});
		
	DesktopMenu_create_callback && DesktopMenu_create_callback(instance)
    return instance;
}
		
		
		
		
DesktopMenu.prototype.onevent = function DesktopMenu_onevent(event) {
	/*
    if (event.currentTarget.id === "OpenBackgtoundMenu") {
        DKPlugin("DKOS/BackgroundMenu.js", function() {
            DKFrame_Html("DKOS/BackgroundMenu.html");
        });
    }
    if (event.currentTarget.id === "ToggleFullscreen")
        Desktop_ToggleFullscreen();
   
    if (event.currentTarget === document) {
        //if (byId("DKOS/DesktopMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY)))
		if (instance.html.contains(document.elementFromPoint(window.mouseX, window.mouseY)))
            return;
    }
	*/
    //dk.close("DKOS/DesktopMenu.js");
	DesktopMenu.prototype.end()
}

DesktopMenu.prototype.onBackgroundMenu = function(instance) {
    DKPlugin("DKOS/BackgroundMenu.js", function() {
        DKFrame_Html("DKOS/BackgroundMenu.html");
    });
}

Desktop.prototype.onToggleFullscreen = function() {
    //TODO: move this function into DKWindow.js
    //http://stackoverflow.com/questions/3900701/onclick-go-full-screen
    if (CPP_DKWindow_IsFullscreen())
        CPP_DKWindow_Windowed();
    else
        CPP_DKWindow_Fullscreen();
}
