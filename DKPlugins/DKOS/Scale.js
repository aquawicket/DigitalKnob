/////////////////////
function Scale_init()
{
	dk.create("DKOS/Scale.html,DKOS/Taskbar.html", function(){
	    byId("scale_minus").addEventListener("mousedown", Scale_onevent);
	    byId("scale_plus").addEventListener("mousedown", Scale_onevent);
	});
}

////////////////////
function Scale_end()()
{
	byId("scale_minus").removeEventListener("mousedown", Scale_onevent);
	byId("scale_plus").removeEventListener("mousedown", Scale_onevent);
	dk.close("Scale.html");
}

/////////////////////////////
function Scale_OnEvent(event)
{
	if(event.currentTarget.id === "scale_minus"){
		Scale_minus();
	}
	if(event.currentTarget.id === "scale_plus"){
		Scale_plus();
	}
}

//////////////////////
function Scale_minus()
{
	var scale = window.getComputedStyle(document.documentElement).fontSize;
	scale = parseFloat(scale.replace("px",""));
	scale = scale - 0.1;
	if(scale < 1.0){ scale = 1.0; }
	document.documentElement.style.fontSize = scale+"px";
}

/////////////////////
function Scale_plus()
{
	var scale = window.getComputedStyle(document.documentElement).fontSize;
	scale = parseFloat(scale.replace("px",""));
	scale = scale + .1;
	if(scale > 100.0){ scale = 100.0; }
	document.documentElement.style.fontSize = scale+"px";
}