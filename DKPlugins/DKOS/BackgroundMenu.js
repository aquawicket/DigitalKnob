//"use strict";

function BackgroundMenu(){}
dk.backgroundMenu = DKPlugin(BackgroundMenu)

BackgroundMenu.prototype.init = function BackgroundMenu_init() {
    dk.create("DKOS/BackgroundMenu.html");
    var file = byId("Background").getAttribute("src");
    byId("BackgroundMenu_Image").setAttribute("src", file);
}

BackgroundMenu.prototype.end = function BackgroundMenu_end() {
    dk.close("DKOS/BackgroundMenu.html");
}
