//"use strict";

dk.os = DKPlugin(DKOS, "singleton")
function DKOS() {}

DKOS.prototype.init = function DKOS_init() {
    console.log("DKOS.prototype.init()")
	DKPlugin("DKFile/DKFile.js")
	DKPlugin("DKGui/DKGui.js")
	DKPlugin("DKGui/DKFrame.js")
	DKPlugin("DKGui/DKMenu.js")
	this.create()
}

DKOS.prototype.end = function DKOS_end() {
	console.log("DKOS.prototype.end()")
}

DKOS.prototype.create = function DKOS_create(parent, top, bottom, left, right, width, height) {
	console.log("DKCodeRunner.prototype.create()")
	
	 dk.create("DKOS/DKOS.html", function() {
        document.documentElement.style.backgroundColor = "black";
        document.body.style.margin = "0px";
        document.body.style.overflow = "hidden";
        
		/*
		var OS = DK_GetOS();
        if (OS !== "iOS" && OS !== "Android") {/*
			var screenwidth = screen.width;
			var screenheight = screen.height;
			var newwidth = parseInt(screenwidth)-100;
			var newheight = parseInt(screenheight)-150;
			//CPP_DKWindow_SetWidth(newwidth);
			//CPP_DKWindow_SetHeight(newheight);
        }
		*/

        DKPlugin("DKOS/Desktop.js")//, function() {
            DKPlugin("DKOS/Taskbar.js")//, function() {
                //if (OS === "iOS" || OS === "Android") {//DK_SetScale(2);   FIXME
                //}
            //});
        //});
        //});
        //});
    });
}
