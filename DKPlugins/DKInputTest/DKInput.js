var rgba = "0";
if(DK_GetBrowser() === "RML"){ rgba = "127"; }
else{ rgba = "0.5"; }

///////////////////////
function DKInput_Init()
{
	DKCreate("DKInputTest/DKInput.html", function(){
	window.addEventListener("keypress", DKInput_OnEvent);
	window.addEventListener("keydown", DKInput_OnEvent);
	window.addEventListener("keyup", DKInput_OnEvent);
	window.addEventListener("mousedown", DKInput_OnEvent);
	window.addEventListener("mouseup", DKInput_OnEvent);
	window.addEventListener("click", DKInput_OnEvent);
	window.addEventListener("dblclick", DKInput_OnEvent);
	window.addEventListener("mousemove", DKInput_OnEvent);
	window.addEventListener("mouseover", DKInput_OnEvent);
	window.addEventListener("mouseout", DKInput_OnEvent);
	window.addEventListener("wheel", DKInput_OnEvent);
	window.addEventListener("resize", DKInput_OnEvent);
	window.addEventListener("input", DKInput_OnEvent);
	window.addEventListener("change", DKInput_OnEvent);
	window.addEventListener("contextmenu", DKInput_OnEvent);
	window.addEventListener("scroll", DKInput_OnEvent);
	window.addEventListener("drag", DKInput_OnEvent);
	byId("Escape").addEventListener("mousedown", DKInput_OnEvent);
	byId("Escape").addEventListener("mouseup", DKInput_OnEvent);
	});
}

//////////////////////
function DKInput_End()
{
	window.removeEventListener("keypress", DKInput_OnEvent);
	window.removeEventListener("keydown", DKInput_OnEvent);
	window.removeEventListener("keyup", DKInput_OnEvent);
	window.removeEventListener("mousedown", DKInput_OnEvent);
	window.removeEventListener("mouseup", DKInput_OnEvent);
	window.removeEventListener("click", DKInput_OnEvent);
	window.removeEventListener("dblclick", DKInput_OnEvent);
	window.removeEventListener("mousemove", DKInput_OnEvent);
	window.removeEventListener("mouseover", DKInput_OnEvent);
	window.removeEventListener("mouseout", DKInput_OnEvent);
	window.removeEventListener("wheel", DKInput_OnEvent);
	window.removeEventListener("resize", DKInput_OnEvent);
	window.removeEventListener("input", DKInput_OnEvent);
	window.removeEventListener("change", DKInput_OnEvent);
	window.removeEventListener("contextmenu", DKInput_OnEvent);
	window.removeEventListener("scroll", DKInput_OnEvent);
	window.removeEventListener("drag", DKInput_OnEvent);
	byId("Escape").removeEventListener("mousedown", DKInput_OnEvent);
	byId("Escape").removeEventListener("mouseup", DKInput_OnEvent);
	DKClose("DKInputTest/DKInput.html");
}

///////////////////////////////
function DKInput_OnEvent(event)
{
	byId("lastevent").innerHTML = "Last Event: "+event.currentTarget.id+","+event.type;
	byId("event.char").innerHTML = "event.char: "+event.char;
	byId("event.charCode").innerHTML = "event.charCode: "+event.charCode;
	byId("event.code").innerHTML = "event.code: "+event.code;
	byId("event.key").innerHTML = "event.key: "+event.key;
	byId("event.keyCode").innerHTML = "event.keyCode: "+event.keyCode;
	byId("event.which").innerHTML = "event.which: "+event.which;

	if(event.type === "keypress"){	
		//DKInput_ProcessKeyPress(DK_GetValue(event));
	}
	if(event.type === "keydown"){
		console.log("keydown");
		DKInput_ProcessKeyDown(event.code);
	}
	if(event.type === "keyup"){
		DKInput_ProcessKeyUp(event.code);
	}
	if(event.type === "mousedown"){
		DKInput_ProcessMouseDown(event.button);
		if(event.currentTarget != window){
			DKInput_Highlight(event.currentTarget.id);
		}
	}
	if(event.type === "mouseup" || event.type === "click"){
		DKInput_ProcessMouseUp(event.button);
		if(event.currentTarget != window){
			DKInput_UnHighlight(event.currentTarget.id);
		}
	}
	//if(event.type === "mousemove"){
		byId("event.clientX").innerHTML = "event.clientX: "+event.clientX;
		byId("event.clientY").innerHTML = "event.clientY: "+event.clientY;
		byId("event.screenX").innerHTML = "event.screenX: "+event.screenX;
		byId("event.screenY").innerHTML = "event.screenY: "+event.screenY;
		byId("event.button").innerHTML = "event.button: "+event.button;
	//}
	if(event.type === "wheel"){
		byId("wheeldelta").innerHTML = "Wheel Delta: "+DK_GetValue(event);
	}
	
	//element events
	if(event.currentTarget.id === "esc"){
		console.log("event.currentTarget.id === 'esc'");
	}
}

/////////////////////////////////////////
function DKInput_ProcessMouseDown(button)
{
	DKWidget_Show(button+"button");	
}

///////////////////////////////////////
function DKInput_ProcessMouseUp(button)
{
	DKWidget_Hide(button+"button");	
}
		
////////////////////////////////////
function DKInput_ProcessKeyDown(key)
{
	DKInput_Highlight(key);
}

//////////////////////////////////
function DKInput_ProcessKeyUp(key)
{
	DKInput_UnHighlight(key);
}

///////////////////////////////
function DKInput_Highlight(div)
{
	if(!div){ return; }
	if(!byId(div)){ return; }
	byId(div).style.backgroundColor = "rgba(0,255,0,"+rgba+")";
	if(div === "Shift"){ byId("Shift2").style.backgroundColor = "rgba(0,255,0,0.5)"; }
	if(div === "Meta"){ byId("Meta2").style.backgroundColor = "rgba(0,255,0,0.5)"; }
	if(div === "Control"){ byId("Control2").style.backgroundColor = "rgba(0,255,0,0.5)"; }
	if(div === "Alt"){ byId("Alt2").style.backgroundColor = "rgba(0,255,0,0.5)"; }
	if(div === "Enter"){ byId("Enter2").style.backgroundColor = "rgba(0,255,0,0.5)"; }
}

/////////////////////////////////
function DKInput_UnHighlight(div)
{
	if(!div){ return; }
	if(!byId(div)){ return; }
	byId(div).style.backgroundColor = "rgba(0,255,0,0)";
	if(div === "Shift"){ byId("Shift2").style.backgroundColor = "rgba(0,255,0,0)"; }
	if(div === "Meta"){ byId("Meta2").style.backgroundColor = "rgba(0,255,0,0)"; }
	if(div === "Control"){ byId("Control2").style.backgroundColor = "rgba(0,255,0,0)"; }
	if(div === "Alt"){ byId("Alt2").style.backgroundColor = "rgba(0,255,0,0)"; }
	if(div === "Enter"){ byId("Enter2").style.backgroundColor = "rgba(0,255,0,0)"; }
}