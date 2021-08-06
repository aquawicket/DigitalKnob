Desktop.init = function Desktop_init() {
    dk.create("DKOS/Desktop.html,DKOS/DKOS.html", function() {
        byId("Background").addEventListener("contextmenu", Desktop.onevent);
    });
}

Desktop.end = function Desktop_end() {
    byId("Background").removeEventListener("contextmenu", Desktop.onevent);
    dk.close("DKOS/Desktop.html");
}

Desktop.onevent = function Desktop_onevent(event) {
    //console.log("Desktop_onevent("+event+")");
    if (event.currentTarget.id === "Background" && event.type === "contextmenu") {
        event.preventDefault();
        DKPlugin("DKOS/DesktopMenu.js", function() {
            DKPlugin("DKGui/DKMenu.js", function() {
                DKMenu_ValidatePosition("DKOS/DesktopMenu.html");
            });
        });
    }
}
