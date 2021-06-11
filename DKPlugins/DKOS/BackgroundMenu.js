BackgroundMenu.init = function BackgroundMenu_init() {
    dk.create("DKOS/BackgroundMenu.html");
    var file = byId("Background").getAttribute("src");
    byId("BackgroundMenu_Image").setAttribute("src", file);
}

BackgroundMenu.end = function BackgroundMenu_end() {
    dk.close("DKOS/BackgroundMenu.html");
}
