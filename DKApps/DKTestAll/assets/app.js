CPP_DK_Create("DKTray");
CPP_DK_Create("DKWindow");
CPP_DK_Create("DKRml");
CPP_DK_Create("DKSDLText");
//CPP_DK_Create("DKSDLCef");

location.href = CPP_DKAssets_LocalAssets()+"index.html";
//location.href = CPP_DKAssets_LocalAssets()+"DKWebTest/index.html";


/*
//// Create Cef window ////
var USE_CEF = 1;
CPP_DK_Create("DKCef,Cef,0,0,800,600,"+url);
CPP_DKCef_NewBrowser("Cef",5,5,screen.width/2-10,screen.height-45,url);
//CPP_DKCef_ShowDevTools(0);
*/


window.addEventListener("keydown", function mykeydown(event){
	console.log(" ");
	console.log("event.type: "+event.type)
	console.log("event.altKey: "+event.altKey)
	console.log("event.char: "+event.char)     //OBSOLETE
	console.log("event.charCode: "+event.charCode)
	console.log("event.code: "+event.code)
	console.log("event.ctrlKey: "+event.ctrlKey)
	console.log("event.isComposition: "+event.isComposision)
	console.log("event.key: "+event.key)
	console.log("event.keyCode: "+event.keyCode)
	console.log("event.keyIdentifier: "+event.keyIdentifier)
	console.log("event.locale: "+event.locale)
	console.log("event.location: "+event.location)
	console.log("event.metaKey: "+event.metaKey)
	console.log("event.repeat: "+event.repeat)
	console.log("event.shiftKey: "+event.shiftKey)
	console.log("event.which: "+event.which)
	console.log(" ");
})
