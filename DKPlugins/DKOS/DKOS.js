////////////////////
function DKOS_init()()() {
	//console.debug("DKOS_init()()()");
	dk.create("DKOS/DKOS.html", function(){
		document.documentElement.style.backgroundColor = "black";
		document.body.style.margin = "0px";
		document.body.style.overflow = "hidden";
		var OS = DK_GetOS();
		if(OS !== "iOS" && OS !== "Android"){
			/*
			var screenwidth = screen.width;
			var screenheight = screen.height;
			var newwidth = parseInt(screenwidth)-100;
			var newheight = parseInt(screenheight)-150;
			//DKWindow_SetWidth(newwidth);
			//DKWindow_SetHeight(newheight);
			*/
		}

		//dk.create("DKGui/DKFrame.js", function(){
		//dk.create("DKGui/DKMenu.js", function(){
		dk.create("DKOS/Desktop.js", function(){
		dk.create("DKOS/Taskbar.js", function(){
			if(OS === "iOS" || OS === "Android"){
				//DK_SetScale(2);   FIXME
			}
		});
		});
		//});
		//});
	});
}