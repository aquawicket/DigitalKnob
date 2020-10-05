/////////////////////
function scale_Init()
{
	DKCreate("DKOS/scale.html,DKOS/Taskbar.html");
	byId("scale_minus").addEventListener("mousedown", scale_OnEvent);
	byId("scale_plus").addEventListener("mousedown", scale_OnEvent);
}

////////////////////
function scale_End()
{
	byId("scale_minus").removeEventListener("mousedown", scale_OnEvent);
	byId("scale_plus").removeEventListener("mousedown", scale_OnEvent);
	DKClose("scale.html");
}

/////////////////////////////
function scale_OnEvent(event)
{
	if(event.currentTarget.id === "scale_minus"){
		scale_minus();
	}
	if(event.currentTarget.id === "scale_plus"){
		scale_plus();
	}
}

//////////////////////
function scale_minus()
{
	var scale = window.getComputedStyle(document.documentElement).fontSize;
	scale = parseFloat(scale.replace("px",""));
	scale = scale - 0.1;
	if(scale < 1.0){ scale = 1.0; }
	document.documentElement.style.fontSize = scale+"px";
}

/////////////////////
function scale_plus()
{
	var scale = window.getComputedStyle(document.documentElement).fontSize;
	scale = parseFloat(scale.replace("px",""));
	scale = scale + .1;
	if(scale > 100.0){ scale = 100.0; }
	document.documentElement.style.fontSize = scale+"px";
}