DKOS.init = function DKOS_init() {
    //console.debug("DKOS_init()");
    dk.create("DKOS/DKOS.html", function() {
        document.documentElement.style.backgroundColor = "black";
        document.body.style.margin = "0px";
        document.body.style.overflow = "hidden";
        var OS = DK_GetOS();
        if (OS !== "iOS" && OS !== "Android") {/*
			var screenwidth = screen.width;
			var screenheight = screen.height;
			var newwidth = parseInt(screenwidth)-100;
			var newheight = parseInt(screenheight)-150;
			//CPP_DKWindow_SetWidth(newwidth);
			//CPP_DKWindow_SetHeight(newheight);
			*/
        }

        //DKPlugin("DKGui/DKFrame.js", function(){
        //DKPlugin("DKGui/DKMenu.js", function(){
        DKPlugin("DKOS/Desktop.js", function() {
            DKPlugin("DKOS/Taskbar.js", function() {
                if (OS === "iOS" || OS === "Android") {//DK_SetScale(2);   FIXME
                }
            });
        });
        //});
        //});
    });
}
