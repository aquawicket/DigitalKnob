var rgba = "0";
if(DK_GetBrowser() == "RML"){ rgba = "127"; }
else{ rgba = "0.5"; }

///////////////////////
function DKInput_Init()
{
	DKDEBUGFUNC();
	window.id = "window";
	DKCreate("DKInputTest/DKInput.html");
	DKAddEvent("window", "keypress", DKInput_OnEvent);
	DKAddEvent("window", "keydown", DKInput_OnEvent);
	DKAddEvent("window", "keyup", DKInput_OnEvent);
	DKAddEvent("window", "mousedown", DKInput_OnEvent);
	DKAddEvent("window", "mouseup", DKInput_OnEvent);
	DKAddEvent("window", "click", DKInput_OnEvent);
	DKAddEvent("window", "dblclick", DKInput_OnEvent);
	DKAddEvent("window", "mousemove", DKInput_OnEvent);
	DKAddEvent("window", "mouseover", DKInput_OnEvent);
	DKAddEvent("window", "mouseout", DKInput_OnEvent);
	DKAddEvent("window", "wheel", DKInput_OnEvent);
	DKAddEvent("window", "resize", DKInput_OnEvent);
	DKAddEvent("window", "input", DKInput_OnEvent);
	DKAddEvent("window", "change", DKInput_OnEvent);
	DKAddEvent("window", "contextmenu", DKInput_OnEvent);
	DKAddEvent("window", "scroll", DKInput_OnEvent);
	DKAddEvent("window", "drag", DKInput_OnEvent);
	DKAddEvent("esc", "mousedown", DKInput_OnEvent);
	DKAddEvent("esc", "mouseup", DKInput_OnEvent); 
}

//////////////////////
function DKInput_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKInput_OnEvent);
	DKClose("DKInputTest/DKInput.html");
}

///////////////////////////////
function DKInput_OnEvent(event)
{
	//DKDomEvent_getParameters(event.pointer);
	DKDEBUGFUNC(event);
	document.getElementById("lastevent").innerHTML = "Last Event: "+event.currentTarget.id+","+event.type;
	document.getElementById("event.char").innerHTML = "event.char: "+event.char;
	document.getElementById("event.charCode").innerHTML = "event.charCode: "+event.charCode;
	document.getElementById("event.code").innerHTML = "event.code: "+event.code;
	document.getElementById("event.key").innerHTML = "event.key: "+event.key;
	document.getElementById("event.keyCode").innerHTML = "event.keyCode: "+event.keyCode;
	document.getElementById("event.which").innerHTML = "event.which: "+event.which;

	if(event.type == "keypress"){	
		//DKInput_ProcessKeyPress(DK_GetValue(event));
	}
	if(event.type == "keydown"){
		DKInput_ProcessKeyDown(event.code);
	}
	if(event.type == "keyup"){
		DKInput_ProcessKeyUp(event.code);
	}
	if(event.type == "mousedown"){
		DKInput_ProcessMouseDown(event.button);
		if(event.currentTarget != window){
			DKInput_Highlight(event.currentTarget.id);
		}
	}
	if(event.type == "mouseup" || event.type == "click"){
		DKInput_ProcessMouseUp(event.button);
		if(event.currentTarget != window){
			DKInput_UnHighlight(event.currentTarget.id);
		}
	}
	//if(event.type == "mousemove"){
		document.getElementById("event.clientX").innerHTML = "event.clientX: "+event.clientX;
		document.getElementById("event.clientY").innerHTML = "event.clientY: "+event.clientY;
		document.getElementById("event.screenX").innerHTML = "event.screenX: "+event.screenX;
		document.getElementById("event.screenY").innerHTML = "event.screenY: "+event.screenY;
		document.getElementById("event.button").innerHTML = "event.button: "+event.button;
	//}
	if(event.type == "wheel"){
		DKWidget_SetInnerHtml("wheeldelta", "Wheel Delta: "+DK_GetValue(event));
	}
	
	//element events
	if(event.currentTarget.id == "esc"){
		console.log("event.currentTarget.id == 'esc'");
	}
}

/////////////////////////////////////////
function DKInput_ProcessMouseDown(button)
{
	DKDEBUGFUNC(button);
	DKWidget_Show(button+"button");	
}

///////////////////////////////////////
function DKInput_ProcessMouseUp(button)
{
	DKDEBUGFUNC(button);
	DKWidget_Hide(button+"button");	
}
		
////////////////////////////////////
function DKInput_ProcessKeyDown(key)
{
	DKDEBUGFUNC(key);
	DKInput_Highlight(key);
}

//////////////////////////////////
function DKInput_ProcessKeyUp(key)
{
	DKDEBUGFUNC(key);
	DKInput_UnHighlight(key);
}

///////////////////////////////
function DKInput_Highlight(div)
{
	DKDEBUGFUNC(div);
	if(!div){ return; }
	if(!document.getElementById(div)){ return; }
	document.getElementById(div).style.backgroundColor = "rgba(0,255,0,"+rgba+")";
	if(div == "Shift"){ document.getElementById("Shift2").style.backgroundColor = "rgba(0,255,0,0.5)"; }
	if(div == "Meta"){ document.getElementById("Meta2").style.backgroundColor = "rgba(0,255,0,0.5)"; }
	if(div == "Control"){ document.getElementById("Control2").style.backgroundColor = "rgba(0,255,0,0.5)"; }
	if(div == "Alt"){ document.getElementById("Alt2").style.backgroundColor = "rgba(0,255,0,0.5)"; }
	if(div == "Enter"){ document.getElementById("Enter2").style.backgroundColor = "rgba(0,255,0,0.5)"; }
}

/////////////////////////////////
function DKInput_UnHighlight(div)
{
	DKDEBUGFUNC(div);
	if(!div){ return; }
	if(!document.getElementById(div)){ return; }
	document.getElementById(div).style.backgroundColor = "rgba(0,255,0,0)";
	if(div == "Shift"){ document.getElementById("Shift2").style.backgroundColor = "rgba(0,255,0,0)"; }
	if(div == "Meta"){ document.getElementById("Meta2").style.backgroundColor = "rgba(0,255,0,0)"; }
	if(div == "Control"){ document.getElementById("Control2").style.backgroundColor = "rgba(0,255,0,0)"; }
	if(div == "Alt"){ document.getElementById("Alt2").style.backgroundColor = "rgba(0,255,0,0)"; }
	if(div == "Enter"){ document.getElementById("Enter2").style.backgroundColor = "rgba(0,255,0,0)"; }
}