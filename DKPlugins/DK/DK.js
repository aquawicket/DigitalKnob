//BROWSER

// Dummy functions only implemented in c++
function DK_DoFrame(){ /*DKLog("DK_ClearEvents(): not available for javascript", DKERROR); return;*/ }
function EventLoop(){ /*DKLog("DK_ClearEvents(): not available for javascript", DKERROR); return;*/ }
EventLoop.run = function(){};

if(DK_GetBrowser() != "CEF"){
	function DK_ClearEvents(){DKLog("DK_ClearEvents(): not available for javascript", DKERROR); return; }
	function DKRocket_Reload(){DKLog("DKRocket_Reload(): not available for javascript", DKERROR); return; }
	function DK_CallFunc(var1, var2, var3){ DKLog("DK_CallFunc(): not available for javascript", DKERROR); return ""; }
	function DK_Queue(var1, var2, var3){ DKLog("DK_Queue(): not available for javascript", DKERROR); }
	function DK_LeftClick(){DKLog("DK_LeftClick(): not available for javascript", DKERROR); return; }
	function DK_RightClick(){DKLog("DK_RightClick(): not available for javascript", DKERROR); return; }
	function DK_SetCursorPos(){ DKLog("DK_SetCursorPos(): not available for javascript", DKERROR); return; }
	function DKHook_GetWindows(){DKLog("DKHook_GetWindows(): not available for javascript", DKERROR); return; }
	function DK_TestCrash(){DKLog("DK_TestCrash(): not available for javascript", DKERROR); return; }
	function DK_LogGuiConsole(){DKLog("DK_LogGuiConsole(): not available for javascript", DKERROR); return; }
	function DK_GetScreenWidth(){DKLog("DK_GetScreenWidth(): not available for javascript", DKERROR); return; }
	function DK_GetScreenHeight(){DKLog("DK_GetScreenHeight(): not available for javascript", DKERROR); return; }
	function DK_System(){DKLog("DK_System(): not available for javascript", DKERROR); return; }
	function DK_PrintFunctions(){DKLog("DK_PrintFunctions(): not available for javascript", DKERROR); return; }
}

var DKERROR = 0;     //Red
var DKWARN = 1;      //Yellow
var DKSUCCESS = 2;   //Green
var DKINFO = 3;      //White
var DKDEBUG = 4;     //Blue
var DKFILTER = 5;     //Yellow

/////////////////////
function DK_GetTime()
{
	var d = new Date();
	var hour = d.getHours();
	var minute = d.getMinutes();
	var time = hour;
	time += ":";
	time += minute;
	if(hour > 11){
		time += " PM";
	}
	else{
		time += " AM";
	}
	return time;
}

/////////////////////
function DK_GetDate()
{
	var d = new Date();
	var date = d.getMonth()+1;
	date += "/";
	date += d.getDate();
	date += "/";
	date += d.getFullYear();
	return date;
}

///////////////////////////
function DKLog(string, lvl)
{
	if(window.console){
		var color = "";
		if(lvl == DKERROR){ color = "color:red"; }
		if(lvl == DKWARN){ color = "color:#B8860B"; }
		if(lvl == DKSUCCESS){ color = "color:green"; }
		if(lvl == DKINFO){ color = "color:grey"; }
		if(lvl == DKDEBUG){ color = "color:blue"; }
		if(lvl == DKFILTER){ color = "color:#B8860B"; }
		//if(!color){ throw new Error("DKLog(): with no lvl."); }
		if(!color){ color = "color:grey"; }
		string = string.replace("\n","");
		if(DK_GetBrowser() == "CHROME" || DK_GetBrowser() == "CEF"){
			console.log("%c"+string, color);
		}
		else{
			console.log(string);
		}
	}
	//DKSendEvent("DKConsole.html", "DKNotify", string);
}
DKLog("*** DigitalKnob ***", DKSUCCESS);
DKLog(DK_GetBrowser()+"\n");
DKLog(DK_GetJavascript()+"\n");

////////////////////
function DK_Reload()
{
	window.location.href = href+"/index.html";
}

//////////////////////////
function DKAvailable(name)
{
	if(name == "DKWidget"){
		return true; 
	}
	if(name == "DKWidgetJS"){  //FIXME: is this needed?
		return true; 
	}
	return false;
}

////////////////////////
function DK_GetObjects()
{
	return filesloaded;
}

///////////////////////
function DK_GetEvents()
{
	var out = "";
	for(var i=0; i<events.length; i++){
		if(typeof events[i] == "function"){
			out += events[i].name + ",";
			//DKLog(events[i].name);
		}
		else{
			out += events[i] + " : ";
			//DKLog(events[i]);
		}
	}
	return out;
}

///////////////////
function DK_GetOS()
{
	var userAgent = navigator.userAgent || navigator.vendor || window.opera;

      // Windows Phone must come first because its UA also contains "Android"
    if (/windows phone/i.test(userAgent)) {
        return "Windows Phone";
    }

    if (/android/i.test(userAgent)) {
        return "Android";
    }

    // iOS detection from: http://stackoverflow.com/a/9039885/177710
    if (/iPad|iPhone|iPod/.test(userAgent) && !window.MSStream) {
        return "iOS";
    }

	var os_value = navigator.platform;
	
	if (navigator.userAgent.indexOf("WOW64") != -1 || navigator.userAgent.indexOf("Win64") != -1 ){
		os_value = os_value.replace("32", "64");
	}
	
	return os_value;
}

////////////////////////
function DK_GetBrowser()
{
    if((navigator.userAgent.indexOf("Opera") || navigator.userAgent.indexOf('OPR')) != -1 ){
        return "OPERA";
    }
    else if(navigator.userAgent.indexOf("Chrome") != -1 ){
		return "CHROME";
    }
	else if(navigator.userAgent.indexOf("Cef") != -1 ) {
        return "CEF";
    }
    else if(navigator.userAgent.indexOf("Safari") != -1){
        return "SAFARI";
    }
    else if(navigator.userAgent.indexOf("Firefox") != -1 ) {
        return "FIREFOX";
    }
    else if((navigator.userAgent.indexOf("MSIE") != -1 ) || (!!document.documentMode == true )){ //IF IE > 10
		return "IE";
    }
    else {
       return "UNKNOWN BROWSER";
    }
}

///////////////////////////
function DK_GetJavascript()
{
	var v8string = 'function%20javaEnabled%28%29%20%7B%20%5Bnative%20code%5D%20%7D';

	if('WebkitAppearance' in document.documentElement.style){  //If (probably) WebKit browser
		if (escape(navigator.javaEnabled.toString()) === v8string){
			return "V8";
		}
		else{
			return "JSC";
		}
	}
	else{
		return "UNKNOWN JAVASCRIPT ENGINE"
	}
}

//////////////////////////
function DK_GetUserAgent()
{
	return navigator.userAgent;
}

//////////////////////////
function DK_GetNavigator()
{
	var txt = "";
	txt += "Browser CodeName: " + navigator.appCodeName + "\n";
	txt += "Browser Name: " + navigator.appName + "\n";
	txt += "Browser Version: " + navigator.appVersion + "\n";
	txt += "Cookies Enabled: " + navigator.cookieEnabled + "\n";
	txt += "Browser Language: " + navigator.language + "\n";
	txt += "Browser Online: " + navigator.onLine + "\n";
	txt += "Platform: " + navigator.platform + "\n";
	txt += "User-agent header: " + navigator.userAgent + "\n";
	return txt;
}

////////////////
function DK_IE()
{
	var rv = 0; // Return value assumes failure.
	if (navigator.appName == 'Microsoft Internet Explorer')
	{
		var ua = navigator.userAgent;
		var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
		if (re.exec(ua) != null)
		rv = parseFloat( RegExp.$1 );
	}
	// Returns the version of Internet Explorer or a 0
	// (indicating the use of another browser).
	return rv;
}

//////////////////////////
function DK_GetType(event)
{
	//DKLog("GetType("+event+") \n", DKFILTER);
	if(!event){ return false; }
	if(event.type){
		//DKLog("GetType("+event+") -> "+event.type+"\n", DKFILTER);
		return event.type 
	}
	if(event[1]){
		//DKLog("GetType("+event+") -> "+event[1]+"\n", DKFILTER);
		return event[1]; 
	}
	DKLog("DK_GetType("+event+"): could not get event type. \n", DKERROR);
	return false;
}

////////////////////////
function DK_GetId(event)
{
	//DKLog("GetId("+event+") \n", DKFILTER);
	if(!event){ return false;}
	if(event.type && event.type == "contextmenu"){ //rightclick
		PreventDefault(event);
	}
	
	element = DKWidget_GetElement(event);
	if(element){
		//DKLog("GetId("+event+") -> "+element.id+"\n", DKFILTER);
		if(element == window || element == document){ return "GLOBAL"; }
		return element.id; 
	}
	if(event[0]){ 
		//DKLog("GetId("+event+") -> "+event[0]+"\n");
		return event[0]; 
	}
	
	//DKLog("DK_GetId("+event+"): cannot match the id. \n", DKERROR);
	return;
}

////////////////////////////////
function DK_Type(event, command)
{ 
	if(!event){ return false;}
	
	if(event.type && event.type == "contextmenu"){ //rightclick
		PreventDefault(event);
	}
	if(event.type && event.type == command){
		return true;
	}
	if(event.type && "window_"+event.type == command){ //window_resize
		return true;
	}
	if(event[1] && event[1] == command){ 
		return true;
	}
	//DKLog("DK_Type("+event+","+command+"): cannot match the type. \n", DKERROR);
	return false;
}

/////////////////////////
function DK_Id(event, id)
{ 
	//DKLog("DK_Id("+event+", "+id+") \n", DKFILTER);
	var element = DKWidget_GetElement(event);
	//DKLog("DK_Id(): element="+element.id+" \n", DKFILTER);
	if((element == window || element == document) && id == "GLOBAL"){ return true; }
	if(element && element.id == id){ return true; }
	if(event[0] && event[0] == id){ return true; }
	return false;
}

/////////////////////////////
function DK_IdLike(event, id)
{ 
	//DKLog("DK_IdLike("+event+", "+id+") \n", DKFILTER);
	if(!id){ return; }
	if(DK_GetType(event) == "keydown"){ return false; } //KeyboardEvent
	if(DK_GetType(event) == "keyup"){ return false; } //KeyboardEvent
	var element = DKWidget_GetElement(event);
	if(!element){ return; }
	if(!element.id){ return; }
	if(element.id.indexOf(id) != -1){ return true; }
	if(event[0] && event[0].indexOf(id) != -1){ return true; }
	return false;
}

////////////////////////////
function DK_Value(event, id)
{ 
	if(DKWidget_GetValue(event) == id){ return true; }
	return false;
}

///////////////////////////////////////
function DKAddEvent(id, type, Function)
{
	//DKLog("DKAddEvent("+id+", "+type+", "+Function..name+") \n", DKFILTER);
	if(!id){ return false; }
		
	var element;
	if(Function){
		if(typeof id == "object" && !id.type){
			element = id;
		}
		else{
			element = document.getElementById(id);
		}
	}
	else{
		element = top.document;
		Function = id;
	}
	
	if(id == "GLOBAL"){
		element = window;
	}
	
	if(element){
		//DKLog("addEvent("+id+","+type+","+Function.name+") \n", DKFILTER);
		//addEvent(element, type, function(event){ Function(event); StopPropagation(event); });
		addEvent(element, type, Function);
	}
	
	//add event to array
	//DKLog("events.length="+events.length+"\n");
	//events.push(id);
	//events.push(type);
	//events.push(Function);
	events[events.length] = id;
	events[events.length] = type;
	events[events.length] = Function;
	return true;
}

//////////////////////////////////////////
function DKRemoveEvent(id, type, Function)
{
	if(!id){ return false; }
		
	var element;
	if(Function){
		if(typeof id == "object" && !id.type){
			element = id;
		}
		else{
			element = document.getElementById(id);
		}
	}
	else{
		element = top.document;
		Function = id;
	}
	
	if(id == "GLOBAL"){
		element = window;
	}
	
	//DKLog("DKRemoveEvent("+id+","+type+", Function) \n");
	for(var i=0; i<events.length; i++){
		if(events[i] == id){
			if(events[i+1] == type){
				if(events[i+2] == Function){
					events.splice(i, 3);
					if(element){
						//removeEvent(element, type, function(event){ Function(event); });
						removeEvent(element, type, Function);
						//DKLog("DKRemoveEvent("+id+","+type+", Function): Removed Element Event \n");
					}
					//DKLog("DKRemoveEvent("+id+","+type+", Function): Removed Event \n");
					i=0;
				}
			}
		}
	}

	//DKLog(events+"\n");
}

/*
/////////////////////////////////
function DKRemoveEvents(Function)
{
	for(var i=0; i<events.length; i++){
		if(events[i+2] == Function){
			events.splice(i, 3);
		}
	}
}
*/

///////////////////////////////////////
function DKSendEvent(id, type, message)
{
	//if(id.indexOf("DKConsole.html") == -1){
	DKLog("SendEvent("+id+","+type+","+message+") \n", DKFILTER);
	//}
	
	for(var i=0; i<events.length; i++){
		//DKLog(events[i]+" \n", DKFILTER);
		//if(events[i] == "GLOBAL"){ //global
			//DKLog(events[i+2]+"(["+id+", "+type+", "+message+"]) \n", DKFILTER);
		//	events[i+2]([id, type, message]);
			//return;
		//}
		if(events[i] == id){
			if(events[i+1] == type){
				//DKLog(events[i+2]+"(["+id+", "+type+", "+message+"]) \n", DKFILTER);
				events[i+2]([id, type, message]);
			}
		}
	}
}

///////////////////////////
function GetCharCode(event) 
{
    var key = event.which || event.keyCode;
	return key;
}

//////////////////////////
function GetKeyCode(event) 
{
    var key = event.keyCode;
    return key;
}

//////////////////////////////
function GetMouseButton(event) 
{
    var button = event.which || event.button;
    return button;
}

////////////////////////////////
function DK_SetClipboard(string)
{
	//if(!document.queryCommandSupported('copy')){
	//	DKLog("Javascript (Copy) not supported. \n", DKERROR);
	//	return false;
	//}
	
	window.prompt("Copy to clipboard: Ctrl+C, Enter", string);
	return true;
}

/////////////////////////////
function DK_FileToString(url)
{
	return ajaxGetUrl(url);
}

/////////////////////////////
function DK_GetMouseWindowX()
{
	return mouseX;
}

/////////////////////////////
function DK_GetMouseWindowY()
{
	return mouseY;
}

////////////////////////////////
function DK_Sleep(milliseconds){
  var start = new Date().getTime();
  for (var i = 0; i < 1e7; i++) {
    if ((new Date().getTime() - start) > milliseconds){
      break;
    }
  }
}