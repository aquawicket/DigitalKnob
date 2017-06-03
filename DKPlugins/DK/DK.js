//BROWSER

/*
var browser_js = document.createElement('script');
browser_js.setAttribute('type','text/javascript');
browser_js.setAttribute('src','DK/DKBrowser.js');
document.body.appendChild(browser_js);
*/

var LOG_DEBUG = false;
var LOG_INFO = true;
var LOG_WARNINGS = true;
var LOG_ERRORS = true;
var LOG_FILE = true;
var LOG_SHOW = ""; //comma seperated
var LOG_HIDE = ""; //comma seperated
var LOG_LINES = false;

// Dummy functions only implemented in c++
function DK_DoFrame(){ /*DKLog("DK_ClearEvents(): not available for "+DK_GetBrowser()+"\n", DKWARN);*/ }
function EventLoop(){ /*DKLog("DK_ClearEvents(): not available for "+DK_GetBrowser()+"\n", DKWARN);*/ }
EventLoop.run = function(){};

if(DK_GetBrowser() != "CEF"){
	function DK_ClearEvents(){DKLog("DK_ClearEvents(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
	function DKRocket_Reload(){DKLog("DKRocket_Reload(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
	function DK_CallFunc(var1, var2, var3){ DKLog("DK_CallFunc(): not available for "+DK_GetBrowser()+"\n", DKWARN); return ""; }
	function DK_Queue(var1, var2, var3){ DKLog("DK_Queue(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
	function DK_LeftClick(){DKLog("DK_LeftClick(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
	function DK_RightClick(){DKLog("DK_RightClick(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
	function DK_SetCursorPos(){ DKLog("DK_SetCursorPos(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
	function DKHook_GetWindows(){DKLog("DKHook_GetWindows(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
	function DK_Crash(){DKLog("DK_Crash(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
	function DK_LogGuiConsole(){DKLog("DK_LogGuiConsole(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
	function DK_GetScreenWidth(){DKLog("DK_GetScreenWidth(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
	function DK_GetScreenHeight(){DKLog("DK_GetScreenHeight(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
	function DK_System(){DKLog("DK_System(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
	function DK_PrintFunctions(){DKLog("DK_PrintFunctions(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
	function DK_GetPixelUnderMouse(){DKLog("DK_GetPixelUnderMouse(): not available for "+DK_GetBrowser()+"\n", DKWARN); return ""; }
}

var DKERROR = 1;     //Red
var DKWARN = 2;      //Yellow
var DKINFO = 3;      //White
var DKDEBUG = 4;     //Blue
var DKSHOW = 5;
var DKHIDE = 6;


///////////////////////////
function DKLog(string, lvl)
{
	if(!lvl){
		alert("DKLog("+string+") missing lvl");
	}
	
	//check for LOG_HIDE
	if(LOG_HIDE){
		var arry = LOG_HIDE.split(",");
		for(var i=0; i<arry.length; i++){
			if(arry[i] && string.includes(arry[i])){
				return;
			}
		}
	}
	
	if(window.console){
		var flag = false;
		if(LOG_SHOW){
			var arry = LOG_SHOW.split(",");
			for(var i=0; i<arry.length; i++){
				if(arry[i] && string.includes(arry[i])){
					flag = true;
					break;
				}
			}
		}
		if(flag == false){ 
			if(lvl == DKERROR && !LOG_ERRORS){ return; }
			if(lvl == DKWARN && !LOG_WARNINGS){ return; }
			if(lvl == DKINFO && !LOG_INFO){ return; }
			if(lvl == DKDEBUG && !LOG_DEBUG){ return; }
		}
		var color = "";
		if(lvl == DKERROR){ color = "color:red";}
		if(lvl == DKWARN){ color = "color:#B8860B"; }
		if(lvl == DKINFO){ color = "color:grey"; }
		if(lvl == DKDEBUG){ color = "color:blue"; }
		if(!color){ color = "color:grey"; }
		string = string.replace("\n","");
		
		function getFileLine(){
			var stack = Error().stack;
			if(!stack || !LOG_LINES){ return ""; }
			var lines = stack.split("\n");
			var n=0;
			while(lines[n].indexOf("DKLog") == -1){ n++; }
			var fileline = lines[n+1];
			var start = fileline.lastIndexOf("/");
			var end = fileline.lastIndexOf(":");
			fileline = fileline.substring(start+1, end+1);
			return fileline+"  ";
		};
		
		if(lvl == DKERROR){ alert("ERROR: "+string); /*throw string;*/ }
		if(DK_GetBrowser() == "CHROME" || DK_GetBrowser() == "CEF"){
			console.log("%c"+getFileLine()+string, color);
		}
		else{
			console.log(getFileLine()+string);
		}
	}
	//DKSendEvent("DKConsole.html", "DKNotify", string);
}
DKLog("*** DigitalKnob ***\n", DKINFO);
DKLog(DK_GetBrowser()+"\n", DKINFO);
DKLog(DK_GetJavascript()+"\n", DKINFO);



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
			//DKLog(events[i].name, DKDEBUG);
		}
		else{
			out += events[i] + " : ";
			//DKLog(events[i], DKDEBUG);
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
	
	os_value = os_value.replace("Intel", ""); //Mac
	os_value = os_value.replace(" x86_64", ""); //Linux
	
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
	//DKLog("GetType("+event+")\n", DKDEBUG);
	if(!event){ return false; }
	if(event.type){
		//DKLog("GetType("+event+") -> "+event.type+"\n", DKDEBUG);
		return event.type 
	}
	if(event[1]){
		//DKLog("GetType("+event+") -> "+event[1]+"\n", DKDEBUG);
		return event[1]; 
	}
	DKLog("DK_GetType("+event+"): could not get event type. \n", DKERROR);
	return false;
}

////////////////////////
function DK_GetId(event)
{
	//DKLog("GetId("+event+") \n", DKDEBUG);
	if(!event){ return false;}
	if(event.type && event.type == "contextmenu"){ //rightclick
		PreventDefault(event);
	}
	
	element = DKWidget_GetElement(event);
	if(element){
		//DKLog("GetId("+event+") -> "+element.id+"\n", DKDEBUG);
		if(element == window || element == document){ return "GLOBAL"; }
		return element.id; 
	}
	if(event[0]){ 
		//DKLog("GetId("+event+") -> "+event[0]+"\n", DKDEBUG);
		return event[0]; 
	}
	
	//DKLog("DK_GetId("+event+"): cannot match the id. \n", DKERROR);
	return;
}

///////////////////////////
function DK_GetValue(event)
{
	//TODO
	//DKLog("GetValue("+event+") \n", DKDEBUG);
	return DKWidget_GetValue(event);
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
	//DKLog("DK_Id("+event+", "+id+") \n", DKDEBUG);
	var element = DKWidget_GetElement(event);
	//DKLog("DK_Id(): element="+element.id+" \n", DKDEBUG);
	if((element == window || element == document) && id == "GLOBAL"){ return true; }
	if(element && element.id == id){ return true; }
	if(event[0] && event[0] == id){ return true; }
	return false;
}

/////////////////////////////
function DK_IdLike(event, id)
{ 
	//DKLog("DK_IdLike("+event+", "+id+") \n", DKDEBUG);
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

//////////////////////////////////
function DK_StopPropagation(event)
{
	//DKLog("StopPropagation("+event+") \n", DKDEBUG);
	if(event.stopPropagation) {
        event.stopPropagation();
    } else {
        event.cancelBubble = true;
    }
}

///////////////////////////////////////
function DKAddEvent(id, type, Function)
{
	//DKLog("DKAddEvent("+id+", "+type+", "+Function..name+") \n", DKDEBUG);
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
		//DKLog("addEvent("+id+","+type+","+Function.name+") \n", DKDEBUG);
		addEvent(element, type, Function);
	}
	
	//add event to array
	//DKLog("events.length="+events.length+"\n", DKDEBUG);
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
	
	//DKLog("DKRemoveEvent("+id+","+type+", Function) \n", DKDEBUG);
	for(var i=0; i<events.length; i++){
		if(events[i] == id){
			if(events[i+1] == type){
				if(events[i+2] == Function){
					events.splice(i, 3);
					if(element){
						removeEvent(element, type, Function);
						//DKLog("DKRemoveEvent("+id+","+type+", Function): Removed Element Event \n", DKDEBUG);
					}
					//DKLog("DKRemoveEvent("+id+","+type+", Function): Removed Event \n", DKDEBUG);
					i=0;
				}
			}
		}
	}

	//DKLog(events+"\n", DKDEBUG);
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
	DKLog("SendEvent("+id+","+type+","+message+") \n", DKDEBUG);
	//}
	
	for(var i=0; i<events.length; i++){
		//DKLog(events[i]+" \n", DKDEBUG);
		//if(events[i] == "GLOBAL"){ //global
			//DKLog(events[i+2]+"(["+id+", "+type+", "+message+"]) \n", DKDEBUG);
		//	events[i+2]([id, type, message]);
			//return;
		//}
		if(events[i] == id){
			if(events[i+1] == type){
				//DKLog(events[i+2]+"(["+id+", "+type+", "+message+"]) \n", DKDEBUG);
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

if(DK_GetBrowser() != "CEF"){
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

////////////////////////////
function DK_ClearSelection()
{
	//Clear text selection
	if(document.selection){
		document.selection.empty();
	}
	else if(window.getSelection){
		window.getSelection().removeAllRanges();
	}
}