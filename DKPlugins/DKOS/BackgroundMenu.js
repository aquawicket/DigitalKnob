//"use strict"; //FIXME: "use strict" breaks DUKTAPE

function BackgroundMenu(){}
dk.backgroundMenu = DKPlugin(BackgroundMenu)

BackgroundMenu.prototype.init = function BackgroundMenu_init(callback) {
    this.create()
	callback && callback(true);
}

BackgroundMenu.prototype.end = function BackgroundMenu_end() {
    dk.close("DKOS/BackgroundMenu.html");
}

BackgroundMenu.prototype.create = function BackgroundMenu_create(BackgroundMenu_create_callback) {
    const instance = new DKPlugin(BackgroundMenu)
    if (!instance)
        return error("instance invalid", BackgroundMenu_create_callback)
	dk.create("DKOS/BackgroundMenu.html", function dk_create_callback(html) {
        if(!html)
            return error("html invalid")
		var file = byId("Background").getAttribute("src");
		byId("BackgroundMenu_Image").setAttribute("src", file);
		instance.dkFrame = DKFrame.prototype.create(instance)
        instance.dkFrame.setTitle("Background Menu")
		
		BackgroundMenu_create_callback && BackgroundMenu_create_callback(instance)
		return instance;
	});
}
