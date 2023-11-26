//"use strict";

dk.os.desktop = DKPlugin(Desktop, "singleton")
function Desktop(){}

Desktop.prototype.init = function Desktop_init() {
	console.log("Desktop.prototype.init()")
    dk.create("DKOS/Desktop.html,DKOS/DKOS.html", function() {
        byId("Background").addEventListener("contextmenu", dk.os.desktop.onevent);
    });
}

Desktop.prototype.end = function Desktop_end() {
	console.log("Desktop.prototype.end()")
    byId("Background").removeEventListener("contextmenu", dk.os.desktop.onevent);
    dk.close("DKOS/Desktop.html");
}

Desktop.prototype.onevent = function Desktop_onevent(event) {
    console.log("Desktop.onevent()")
    if (event.currentTarget.id === "Background" && event.type === "contextmenu") {
        event.preventDefault();
        DKPlugin("DKOS/DesktopMenu.js", function() {
            DKPlugin("DKGui/DKMenu.js", function() {
                //DKMenu_ValidatePosition("DKOS/DesktopMenu.html");
            });
        });
    }
}
