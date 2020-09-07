var browser = DK_GetBrowser();

/////////////////////////
function DKInput_Init()
{
	DKDEBUGFUNC();
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
	DKDEBUGFUNC(event);
	console.log("DKInput_OnEvent(event)");
	if(event.type){ //Browser
		document.getElementById("lastevent").innerHTML = "Last Event: "+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event);
		//DKWidget_SetInnerHtml("lastevent", "Last Event: "+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event));
		if(DK_GetType(event) != "mousemove"){
			//DKINFO("Last Event: "+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+"\n");
		}
	}
	else{ //App
		DKWidget_SetInnerHtml("lastevent", "Last Event: "+event);
		if(DK_GetType(event) != "mousemove"){
			//DKINFO("Last Event: "+event+"\n");
		}
	}
	
	if(DK_Type(event, "keypress")){
		document.getElementById("charcode").innerHTML = "Unicode CHARACTER code: "+DK_GetValue(event);
		//DKInput_ProcessKeyPress(DK_GetValue(event));
	}
	if(DK_Type(event, "keydown")){
		document.getElementById("keycode").innerHTML = "Unicode KEY code: "+event.key;
		DKInput_ProcessKeyDown(event.key);
	}
	if(DK_Type(event, "keyup")){
		DKInput_ProcessKeyUp(event.key);
	}
	if(DK_Type(event, "mousedown")){
		DKInput_ProcessMouseDown(DK_GetValue(event));
		if(DK_GetId(event) != "window"){
			DKInput_Highlight(DK_GetId(event));
		}
	}
	if(DK_Type(event, "mouseup") || DK_Type(event, "click")){
		DKInput_ProcessMouseUp(DK_GetValue(event));
		if(DK_GetId(event) != "window"){
			DKInput_UnHighlight(DK_GetId(event));
		}
	}
	if(DK_Type(event, "mousemove")){
		//DKINFO(DK_GetValue(event)+"\n");
		var xy = DK_GetValue(event);
		var arry = xy.split(",");
		document.getElementById("mousex").innerHTML = "Mouse X: "+arry[0];
		document.getElementById("mousey").innerHTML = "Mouse Y: "+arry[1];
		document.getElementById("screenx").innerHTML = "Screen X: "+arry[2];
		document.getElementById("screeny").innerHTML = "Screen Y: "+arry[3];
	}
	if(DK_Type(event, "wheel")){
		DKWidget_SetInnerHtml("wheeldelta", "Wheel Delta: "+DK_GetValue(event));
	}
	
	//element events
	if(DK_Id(event, "esc")){
		//DKINFO("esc\n")
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
	DKInput_Highlight(DKInput_KeyToDiv(key));
}

//////////////////////////////////
function DKInput_ProcessKeyUp(key)
{
	DKDEBUGFUNC(key);
	DKInput_UnHighlight(DKInput_KeyToDiv(key));
}

//////////////////////////////
function DKInput_KeyToDiv(key)
{
	DKDEBUGFUNC(key);
	if(key == 27){ return "esc"; }
	if(key == 112){ return "f1"; }
	if(key == 113){ return "f2"; }
	if(key == 114){ return "f3"; }
	if(key == 115){ return "f4"; }
	if(key == 116){ return "f5"; }
	if(key == 117){ return "f6"; }
	if(key == 118){ return "f7"; }
	if(key == 119){ return "f8"; }
	if(key == 120){ return "f9"; }
	if(key == 121){ return "f10"; }
	if(key == 122){ return "f11"; }
	if(key == 123){ return "f12"; }
	if(key == 44){ return "printscreen"; }
	if(key == 145){ return "scrolllock"; }
	if(key == 19){ return "pause"; }
	if(key == 192){ return "tilde"; }
	if(key == 48){ return "0"; }
	if(key == 49){ return "1"; }
	if(key == 50){ return "2"; }
	if(key == 51){ return "3"; }
	if(key == 52){ return "4"; }
	if(key == 53){ return "5"; }
	if(key == 54){ return "6"; }
	if(key == 55){ return "7"; }
	if(key == 56){ return "8"; }
	if(key == 57){ return "9"; }
	if(key == 189){ return "minus"; }
	if(key == 187){ return "equal"; }
	if(key == 220){ return "backslash"; }
	if(key == 8){ return "backspace"; }
	if(key == 35){ return "end"; }
	if(key == 36){ return "home"; }
	if(key == 144){ return "numlock"; }
	if(key == 111){ return "kp_slash"; }
	if(key == 106){ return "kp_multiply"; }
	if(key == 109){ return "kp_minus"; }
	if(key == 9){ return "tab"; }
	if(key == 81){ return "q"; }
	if(key == 87){ return "w"; }
	if(key == 69){ return "e"; }
	if(key == 82){ return "r"; }
	if(key == 84){ return "t"; }
	if(key == 89){ return "y"; }
	if(key == 85){ return "u"; }
	if(key == 73){ return "i"; }
	if(key == 79){ return "o"; }
	if(key == 80){ return "p"; }
	if(key == 219){ return "leftbracket"; }
	if(key == 221){ return "rightbracket"; }
	if(key == 13){ return "enter"; }
	if(key == 46){ return "delete"; }
	if(key == 45){ return "insert"; }
	if(key == 33){ return "pageup"; }
	if(key == 34){ return "pagedown"; }
	if(key == 96){ return "kp_0"; }
	if(key == 97){ return "kp_1"; }
	if(key == 98){ return "kp_2"; }
	if(key == 99){ return "kp_3"; }
	if(key == 100){ return "kp_4"; }
	if(key == 101){ return "kp_5"; }
	if(key == 102){ return "kp_6"; }
	if(key == 103){ return "kp_7"; }
	if(key == 104){ return "kp_8"; }
	if(key == 105){ return "kp_9"; }
	if(key == 110){ return "kp_period"; }
	if(key == 107){ return "kp_plus"; }
	if(key == 20){ return "capslock"; }
	if(key == 65){ return "a"; }
	if(key == 83){ return "s"; }
	if(key == 68){ return "d"; }
	if(key == 70){ return "f"; }
	if(key == 71){ return "g"; }
	if(key == 72){ return "h"; }
	if(key == 74){ return "j"; }
	if(key == 75){ return "k"; }
	if(key == 76){ return "l"; }
	if(key == 186){ return "semicolon"; }
	if(key == 222){ return "quote"; }
	if(key == 16){ return "leftshift"; }
	if(key == 90){ return "z"; }
	if(key == 88){ return "x"; }
	if(key == 67){ return "c"; }
	if(key == 86){ return "v"; }
	if(key == 66){ return "b"; }
	if(key == 78){ return "n"; }
	if(key == 77){ return "m"; }
	if(key == 188){ return "comma"; }
	if(key == 190){ return "period"; }
	if(key == 191){ return "slash"; }
	if(key == 16){ return "rightshift"; }
	if(key == 17){ return "leftctrl"; }
	if(key == 91){ return "leftwinkey"; }
	if(key == 18){ return "leftalt"; }
	if(key == 32){ return "space"; }
	if(key == 18){ return "rightalt"; }
	if(key == 91){ return "rightwinkey"; }
	if(key == 93){ return "menu"; }
	if(key == 17){ return "rightctrl"; }
	if(key == 38){ return "up"; }
	if(key == 40){ return "down"; }
	if(key == 37){ return "left"; }
	if(key == 39){ return "right"; }
	if(key == 12){ return "kp_5"; }
}

///////////////////////////////
function DKInput_Highlight(div)
{
	DKDEBUGFUNC(div);
	console.log("DKInput_Highlight("+div+")");
	document.getElementById(div).style.backgroundColor = "rgba(0,255,0,0.5)";
	if(div == "leftshift"){ DKWidget_SetProperty("rightshift", "background-color", "rgba(0,255,0,0.5)"); }
	if(div == "rightshift"){ DKWidget_SetProperty("leftshift", "background-color", "rgba(0,255,0,0.5)"); }
	if(div == "leftctrl"){ DKWidget_SetProperty("rightctrl", "background-color", "rgba(0,255,0,0.5)"); }
	if(div == "rightctrl"){ DKWidget_SetProperty("leftctrl", "background-color", "rgba(0,255,0,0.5)"); }
	if(div == "leftalt"){ DKWidget_SetProperty("rightalt", "background-color", "rgba(0,255,0,0.5)"); }
	if(div == "rightalt"){ DKWidget_SetProperty("leftalt", "background-color", "rgba(0,255,0,0.5)"); }
	if(div == "enter"){ DKWidget_SetProperty("kp_enter", "background-color", "rgba(0,255,0,0.5)"); }
	if(div == "kp_enter"){ DKWidget_SetProperty("enter", "background-color", "rgba(0,255,0,0.5)"); }
}

/////////////////////////////////
function DKInput_UnHighlight(div)
{
	DKDEBUGFUNC(div);
	document.getElementById(div).style.backgroundColor = "rgba(0,255,0,0)";
	if(div == "leftshift"){ DKWidget_SetProperty("rightshift", "background-color", "rgba(0,255,0,0)"); }
	if(div == "rightshift"){ DKWidget_SetProperty("leftshift", "background-color", "rgba(0,255,0,0)"); }
	if(div == "leftctrl"){ DKWidget_SetProperty("rightctrl", "background-color", "rgba(0,255,0,0)"); }
	if(div == "rightctrl"){ DKWidget_SetProperty("leftctrl", "background-color", "rgba(0,255,0,0)"); }
	if(div == "leftalt"){ DKWidget_SetProperty("rightalt", "background-color", "rgba(0,255,0,0)"); }
	if(div == "rightalt"){ DKWidget_SetProperty("leftalt", "background-color", "rgba(0,255,0,0)"); }
	if(div == "enter"){ DKWidget_SetProperty("kp_enter", "background-color", "rgba(0,255,0,0)"); }
	if(div == "kp_enter"){ DKWidget_SetProperty("enter", "background-color", "rgba(0,255,0,0)"); }
}