var rgba = "0";
if(DK_GetBrowser() === "RML"){ rgba = "127"; }
else{ rgba = "0.5"; }

///////////////////////
function DKInput_init()
{
	dk.create("DKInputTest/DKInput.html", function(){
		window.addEventListener("keypress", DKInput_onevent);
		window.addEventListener("keydown", DKInput_onevent);
		window.addEventListener("keyup", DKInput_onevent);
		window.addEventListener("mousedown", DKInput_onevent);
		window.addEventListener("mouseup", DKInput_onevent);
		window.addEventListener("click", DKInput_onevent);
		window.addEventListener("dblclick", DKInput_onevent);
		window.addEventListener("mousemove", DKInput_onevent);
		window.addEventListener("mouseover", DKInput_onevent);
		window.addEventListener("mouseout", DKInput_onevent);
		window.addEventListener("wheel", DKInput_onevent);
		window.addEventListener("resize", DKInput_onevent);
		window.addEventListener("input", DKInput_onevent);
		window.addEventListener("change", DKInput_onevent);
		window.addEventListener("contextmenu", DKInput_onevent);
		window.addEventListener("scroll", DKInput_onevent);
		window.addEventListener("drag", DKInput_onevent);
		byId("Escape").addEventListener("mousedown", DKInput_onevent);
		byId("Escape").addEventListener("mouseup", DKInput_onevent);
	});
}

//////////////////////
function DKInput_end()()
{
	window.removeEventListener("keypress", DKInput_onevent);
	window.removeEventListener("keydown", DKInput_onevent);
	window.removeEventListener("keyup", DKInput_onevent);
	window.removeEventListener("mousedown", DKInput_onevent);
	window.removeEventListener("mouseup", DKInput_onevent);
	window.removeEventListener("click", DKInput_onevent);
	window.removeEventListener("dblclick", DKInput_onevent);
	window.removeEventListener("mousemove", DKInput_onevent);
	window.removeEventListener("mouseover", DKInput_onevent);
	window.removeEventListener("mouseout", DKInput_onevent);
	window.removeEventListener("wheel", DKInput_onevent);
	window.removeEventListener("resize", DKInput_onevent);
	window.removeEventListener("input", DKInput_onevent);
	window.removeEventListener("change", DKInput_onevent);
	window.removeEventListener("contextmenu", DKInput_onevent);
	window.removeEventListener("scroll", DKInput_onevent);
	window.removeEventListener("drag", DKInput_onevent);
	byId("Escape").removeEventListener("mousedown", DKInput_onevent);
	byId("Escape").removeEventListener("mouseup", DKInput_onevent);
	dk.close("DKInputTest/DKInput.html");
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
		//DKInput_ProcessKeyPress(event.code);
	}
	if(event.type === "keydown"){
		DKInput_ProcessKeyDown(event.code);
	}
	if(event.type === "keyup"){
		DKInput_ProcessKeyUp(event.code);
	}
	if(event.type === "mousedown"){
		DKInput_ProcessMouseDown(event.button);
		if(event.currentTarget !== window){
			DKInput_Highlight(event.currentTarget.id);
		}
	}
	if(event.type === "mouseup" || event.type === "click"){
		DKInput_ProcessMouseUp(event.button);
		if(event.currentTarget !== window){
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
	byId(button+"button").style.display = "block";
	byId(button+"button").style.visibility = "visible";
}

///////////////////////////////////////
function DKInput_ProcessMouseUp(button)
{
	byId(button+"button").style.display = "none";
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