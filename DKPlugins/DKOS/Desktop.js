//"use strict";

function Desktop(){}
dk.desktop = DKPlugin(Desktop)

Desktop.prototype.init = function Desktop_init() {
	console.log("Desktop.prototype.init()")
    dk.create("DKOS/Desktop.html,DKOS/DKOS.html", function() {
        byId("Background").addEventListener("contextmenu", Desktop.onevent);
    });
}

Desktop.prototype.end = function Desktop_end() {
	console.log("Desktop.prototype.end()")
    byId("Background").removeEventListener("contextmenu", Desktop.onevent);
    dk.close("DKOS/Desktop.html");
}

Desktop.onevent = function Desktop_onevent(event) {
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
