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
function DK_DoFrame(){ /*DKWARN("DK_ClearEvents(): not available for "+DK_GetBrowser()+"\n");*/ }
function EventLoop(){ /*DKWARN("DK_ClearEvents(): not available for "+DK_GetBrowser()+"\n");*/ }
EventLoop.run = function(){};

var myVar = setInterval(myTimer, 1000);
function myTimer() {
    DKSendEvent("GLOBAL", "second", "");
}

if(DK_GetBrowser() != "CEF"){
	function DK_ClearEvents(){ DKWARN("DK_ClearEvents(): not available for "+DK_GetBrowser()+"\n"); }
	function DKRocket_Reload(){ DKWARN("DKRocket_Reload(): not available for "+DK_GetBrowser()+"\n"); }
	function DK_CallFunc(var1, var2, var3){ DKWARN("DK_CallFunc(): not available for "+DK_GetBrowser()+"\n"); return ""; }
	function DK_Queue(var1, var2, var3){ DKWARN("DK_Queue(): not available for "+DK_GetBrowser()+"\n"); }
	function DK_LeftClick(){ DKWARN("DK_LeftClick(): not available for "+DK_GetBrowser()+"\n"); }
	function DK_RightClick(){ DKWARN("DK_RightClick(): not available for "+DK_GetBrowser()+"\n"); }
	function DK_SetCursorPos(){ DKWARN("DK_SetCursorPos(): not available for "+DK_GetBrowser()+"\n"); }
	function DKHook_GetWindows(){ DKWARN("DKHook_GetWindows(): not available for "+DK_GetBrowser()+"\n"); }
	function DK_Crash(){ DKWARN("DK_Crash(): not available for "+DK_GetBrowser()+"\n"); }
	function DK_LogGuiConsole(){ DKWARN("DK_LogGuiConsole(): not available for "+DK_GetBrowser()+"\n"); }
	function DK_GetScreenWidth(){ DKWARN("DK_GetScreenWidth(): not available for "+DK_GetBrowser()+"\n"); }
	function DK_GetScreenHeight(){ DKWARN("DK_GetScreenHeight(): not available for "+DK_GetBrowser()+"\n"); }
	function DK_System(){ DKWARN("DK_System(): not available for "+DK_GetBrowser()+"\n"); }
	function DK_PrintFunctions(){ DKWARN("DK_PrintFunctions(): not available for "+DK_GetBrowser()+"\n"); }
	function DK_GetPixelUnderMouse(){ DKWARN("DK_GetPixelUnderMouse(): not available for "+DK_GetBrowser()+"\n"); return ""; }
	function DK_ShowConsole(){ DKWARN("DK_ShowConsole(): not available for "+DK_GetBrowser()+"\n"); return ""; }
	function DK_HideConsole(){ DKWARN("DK_HideConsole(): not available for "+DK_GetBrowser()+"\n"); return ""; }
	function DK_CpuUsed(){DKWARN("DK_CpuUsed(): not available for "+DK_GetBrowser()+"\n"); return ""; }
	function DK_CpuUsedByApp(){ DKWARN("DK_CpuUsedByApp(): not available for "+DK_GetBrowser()+"\n"); return ""; }
	function DK_PhysicalMemory(){ DKWARN("DK_PhysicalMemory(): not available for "+DK_GetBrowser()+"\n"); return ""; }
	function DK_PhysicalMemoryUsedByApp(){ DKWARN("DK_PhysicalMemoryUsedByApp(): not available for "+DK_GetBrowser()+"\n"); return ""; }
}

var DK_ERROR = 1;     //Red
var DK_WARN = 2;      //Yellow
var DK_INFO = 3;      //White
var DK_DEBUG = 4;     //Blue
var DK_SHOW = 5;
var DK_HIDE = 6;


function DKERROR(string){ Log(string, DK_ERROR); }
function DKWARN(string){ Log(string, DK_WARN); }
function DKINFO(string){ Log(string, DK_INFO); }
function DKDEBUG(string){ Log(string, DK_DEBUG); }

/////////////////////////
function Log(string, lvl)
{
	if(!lvl){
		lvl = DK_INFO;
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
		if(!flag){ 
			if(lvl == DK_ERROR && !LOG_ERRORS){ return; }
			if(lvl == DK_WARN && !LOG_WARNINGS){ return; }
			if(lvl == DK_INFO && !LOG_INFO){ return; }
			if(lvl == DK_DEBUG && !LOG_DEBUG){ return; }
		}
		var color = "";
		if(lvl == DK_ERROR){ color = "color:red";}
		if(lvl == DK_WARN){ color = "color:#B8860B"; }
		if(lvl == DK_INFO){ color = "color:grey"; }
		if(lvl == DK_DEBUG){ color = "color:blue"; }
		if(!color){ color = "color:grey"; }
		string = string.replace("\n","");
		
		function getFileLine(){
			var stack = Error().stack;
			if(!stack || !LOG_LINES){ return ""; }
			var lines = stack.split("\n");
			var n=0;
			while(lines[n].indexOf("Log") == -1){ n++; }
			var fileline = lines[n+1];
			var start = fileline.lastIndexOf("/");
			var end = fileline.lastIndexOf(":");
			fileline = fileline.substring(start+1, end+1);
			return fileline+"  ";
		};
		
		if(DK_GetBrowser() == "CHROME" || DK_GetBrowser() == "CEF"){
			if(lvl == DK_ERROR){
				//alert("ERROR: "+string);
				//throw "ERROR: "+string;
				console.error(getFileLine()+string);
			}
			else if(lvl == DK_WARN){
				console.warn(getFileLine()+string);
			}
			else if(lvl == DK_INFO){
				console.log(getFileLine()+string);
			}
			else if(lvl == DK_DEBUG){
				//console.info("%c"+getFileLine()+string, color);
				console.debug("%c"+getFileLine()+string, color);
			}
			else{
				console.log("%c"+getFileLine()+string, color);
			}
		}
		else{
			if(lvl == DK_ERROR){
				//alert("ERROR: "+string);
				//throw "ERROR: "+string;
				console.error(getFileLine()+string);
			}
			else if(lvl == DK_WARN){
				console.warn(getFileLine()+string);
			}
			else if(lvl == DK_INFO){
				console.log(getFileLine()+string);
			}
			else if(lvl == DK_DEBUG){
				console.debug(getFileLine()+string);
			}
			else{
				console.log(getFileLine()+string);
			}
		}
	}
	//DKSendEvent("DKConsole.html", "DKNotify", string);
}
DKINFO("*** DigitalKnob ***\n");
DKINFO(DK_GetBrowser()+"\n");
DKINFO(DK_GetJavascript()+"\n");

//////////////////////////
function DKDEBUGFUNC(vars)
{
	var string = DKDEBUGFUNC.caller.name+"(";
	if(vars){
		for(var i=0; i<arguments.length; i++){
			string += arguments[i];
			if(i < arguments.length-1){
				string += ",";
			}
		}
	}
	string += ")";
	DKDEBUG(string+"\n");
}

//////////////////////////
function DKDEBUGVARS(vars)
{
	function getFileLine(){
		var stack = Error().stack;
		if(!stack || !LOG_LINES){ return ""; }
		var lines = stack.split("\n");
		var n=0;
		while(lines[n].indexOf("Log") == -1){ n++; }
		var fileline = lines[n+1];
		var start = fileline.lastIndexOf("/");
		var end = fileline.lastIndexOf(":");
		fileline = fileline.substring(start+1, end+1);
		return fileline;
	};
		
	var info = getFileLine()+" "+DKDEBUGVARS.caller.name+"()   ";
	if(vars){
		for(var i=0; i<arguments.length; i++){
			var variable = "unknown_name: ";
			variable += arguments[i];
			DKDEBUG(info+variable+"\n");
		}
	}
}

/////////////////////
function DK_GetTime()
{
	DKDEBUGFUNC();
	var d = new Date();
	var hour = d.getHours();
	var minute = d.getMinutes();
	minute = minute > 9 ? minute : '0' + minute; //pad 0
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
	DKDEBUGFUNC();
	var d = new Date();
	var date = d.getMonth()+1;
	date += "/";
	date += d.getDate();
	date += "/";
	date += d.getFullYear();
	return date;
}


/////////////////////
function DK_Refresh()
{	
	DKDEBUGFUNC();
	//window.location.href = href+"index.html";
	window.location.hash = "";
	window.location.reload(true);
}


//////////////////////////
function DKAvailable(name)
{
	DKDEBUGFUNC(name);
	if(name == "DKWidget"){
		return true; 
	}
	if(name == "DKWidgetJS"){  //FIXME: is this needed?
		DKINFO("DKAvailable("+name+"): name == DKWidgetJS!  check DK.js line 235\n");
		return true; 
	}
	return false;
}

////////////////////////
function DK_GetObjects()
{
	DKDEBUGFUNC();
	// Search the Dom for all scripts (.js files)
	var jsfiles = "";
	var elements = document.getElementsByTagName("script");
	for(var i=0; i<elements.length; i++){
		if(!elements[i].id){
			DKWARN(elements[i].src+": js object has no id\n");
			continue; 
		}
		jsfiles += elements[i].id+",";
	}
	
	// Search the Dom for all css (.css files)
	var cssfiles = "";
	var elements = document.getElementsByTagName("link");
	for(var i=0; i<elements.length; i++){
		if(!elements[i].id){
			DKWARN(elements[i].href+": css object has no id\n");
			continue; 
		}
		cssfiles += elements[i].id+",";
	}
	
	// Search the Dom for all widgets (.html id's)
	var htmlfiles = "";
	var divs = document.getElementsByTagName("div");
	for(var i = divs.length; i;){
		var div = divs[--i];
		if(!div.id){
			DKWARN(div+": html object has no id\n");
			continue; 
		}
		if(div.id.indexOf(".html") > -1){
			htmlfiles += div.id+",";
		}
	}
	
	return jsfiles+cssfiles+htmlfiles;
}

///////////////////////
function DK_GetEvents()
{
	DKDEBUGFUNC();
	var out = "";
	for(var i=0; i<events.length; i++){
		if(typeof events[i] == "function"){
			out += events[i].name + ",";
			//DKINFO(events[i].name);
		}
		else{
			out += events[i] + " : ";
			//DKINFO(events[i]);
		}
	}
	return out;
}

///////////////////
function DK_GetOS()
{
	DKDEBUGFUNC();
	var userAgent = navigator.userAgent || navigator.vendor || window.opera;
     // Windows Phone must come first because its UA also contains "Android"
    if (/windows phone/i.test(userAgent)){
        return "Windows Phone";
    }
    if (/android/i.test(userAgent)){
        return "Android";
    }
    // iOS detection from: http://stackoverflow.com/a/9039885/177710
    if (/iPad|iPhone|iPod/.test(userAgent) && !window.MSStream){
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
	//DKDEBUGFUNC();
    if((navigator.userAgent.indexOf("Opera") || navigator.userAgent.indexOf('OPR')) != -1 ){
        return "OPERA";
    }
    else if(navigator.userAgent.indexOf("Chrome") != -1 && navigator.userAgent.indexOf("Cef") == -1){
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
	DKDEBUGFUNC();
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
	DKDEBUGFUNC();
	return navigator.userAgent;
}

//////////////////////////
function DK_GetNavigator()
{
	DKDEBUGFUNC();
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
	DKDEBUGFUNC();
	var rv = 0;
	if(navigator.appName == 'Microsoft Internet Explorer'){
		var ua = navigator.userAgent;
		var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
		if(re.exec(ua) != null)
		rv = parseFloat( RegExp.$1 );
	}
	else if (navigator.appName == 'Netscape'){
		var ua = navigator.userAgent;
		var re  = new RegExp("Trident/.*rv:([0-9]{1,}[\.0-9]{0,})");
		if(re.exec(ua) != null)
      rv = parseFloat( RegExp.$1 );
	}
	
	// Returns the version of Internet Explorer or a 0
	// (indicating the use of another browser).
	return rv;
}

//////////////////////////
function DK_GetType(event)
{
	DKDEBUGFUNC(event);
	if(!event){ return false; }
	if(event.type){
		//DKINFO("GetType("+event+") -> "+event.type+"\n");
		return event.type 
	}
	if(event[1]){
		//DKINFO("GetType("+event+") -> "+event[1]+"\n");
		return event[1]; 
	}
	DKERROR("DK_GetType("+event+"): could not get event type\n");
	return false;
}

////////////////////////
function DK_GetId(event)
{
	DKDEBUGFUNC(event);
	if(!event){ return false;}
	if(event.type && event.type == "contextmenu"){ //rightclick
		PreventDefault(event);
	}
	
	element = DKWidget_GetElement(event);
	if(element){
		//DKINFO("GetId("+event+") -> "+element.id+"\n");
		if(element == window || element == document){ return "GLOBAL"; }
		return element.id; 
	}
	if(event[0]){ 
		//DKINFO("GetId("+event+") -> "+event[0]+"\n");
		return event[0]; 
	}
	
	//DKERROR("DK_GetId("+event+"): cannot match the id\n");
	return;
}

///////////////////////////
function DK_GetValue(event)
{
	DKDEBUGFUNC(event);
	return DKWidget_GetValue(event);
}

////////////////////////////////
function DK_Type(event, command)
{
	DKDEBUGFUNC(event, command);
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
	//DKERROR("DK_Type("+event+","+command+"): cannot match the type\n");
	return false;
}

/////////////////////////
function DK_Id(event, id)
{ 
	DKDEBUGFUNC(event, id);
	var element = DKWidget_GetElement(event);
	//DKINFO("DK_Id(): element="+element.id+"\n");
	if((element == window || element == document) && id == "GLOBAL"){ return true; }
	if(element && element.id == id){ return true; }
	if(event[0] && event[0] == id){ return true; }
	return false;
}

/////////////////////////////
function DK_IdLike(event, id)
{
	DKDEBUGFUNC(event, id);
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
	DKDEBUGFUNC(event, id);
	if(DKWidget_GetValue(event) == id){ return true; }
	return false;
}

//////////////////////////////////
function DK_StopPropagation(event)
{
	DKDEBUGFUNC(event);
	if(event.stopPropagation) {
        event.stopPropagation();
    } else {
        event.cancelBubble = true;
    }
}

///////////////////////////////////////
function DKAddEvent(id, type, Function)
{
	DKDEBUGFUNC(id, type, Function.name);
	if(typeof id != "string"){
		DKWARN("DKAddEvent(id, type, Function): id invalid\n");
		return;
	}
	if(typeof type != "string"){
		DKWARN("DKAddEvent(id, type, Function): type invalid\n");
		return;
	}
	if(typeof Function != "function"){
		DKWARN("DKAddEvent(id, type, Function): Function invalid\n");
		return;
	}
	if(id == "GLOBAL"){
		element = window;
	}
	else{
		element = document.getElementById(id);
	}
	if(!element){
		DKWARN("DKAddEvent("+id+","+type+","+Function.name+"): element invalid\n");
		return;
	}
	
	//DKINFO("addEvent("+id+","+type+","+Function.name+")\n");
	addEvent(element, type, Function);
	
	//add event to array
	//DKINFO("events.length="+events.length+"\n");
	events[events.length] = id;
	events[events.length] = type;
	events[events.length] = Function;
	return true;
}

//////////////////////////////////////////
function DKRemoveEvent(id, type, Function)
{
	DKDEBUGFUNC(id, type, Function.name);
	if(typeof id != "string"){
		DKERROR("DKRemoveEvent(id, type, Function): id invalid\n");
		return false;
	}
	if(typeof type != "string"){
		DKERROR("DKRemoveEvent(id, type, Function): type invalid\n");
		return false;
	}
	if(typeof Function != "function"){
		DKERROR("DKRemoveEvent(id, type, Function): Function invalid\n");
		return false;
	}
		
	if(id == "GLOBAL"){
		element = window;
	}
	else{
		element = document.getElementById(id);
	}
	if(!element){
		DKWARN("DKRemoveEvent("+id+","+type+","+Function.name+"): element invalid\n");
		return false;
	}
	
	for(var i=0; i<events.length; i++){
		if(events[i] == id){
			if(events[i+1] == type){
				if(typeof events[i+2] == "function" && events[i+2].name == Function.name){
					//DKINFO("DKRemoveEvent("+id+","+type+","+Function.name+"): Removing event\n");
					removeEvent(element, type, Function);
					events.splice(i, 3);
					i--;
				}
			}
		}
	}
	
	return true;
}

/////////////////////////////////
function DKRemoveEvents(Function)
{
	DKDEBUGFUNC(Function.name);
	if(typeof Function != "function"){
		DKERROR("DKRemoveEvents(Function): Function invalid\n");
		return false;
	}

	for(var i=0; i<events.length; i++){
		if(typeof events[i+2] == "function" && events[i+2].name == Function.name){
			//DKINFO("DKRemoveEvent("+events[i]+","+events[i+1]+", Function): events[i+2] == Function\n");
			//var element;
			if(events[i] == "GLOBAL"){
				element = window;
			}
			else{
				element = document.getElementById(events[i]);
			}
			
			if(element){
				//DKINFO("DKRemoveEvent("+events[i]+","+events[i+1]+","+events[i+2].name+"): Removing Event\n");
				removeEvent(element, events[i+1], Function);
				events.splice(i, 3);
				i--;
			}
			else{
				//DKWARN("DKRemoveEvents("+Function.name+"): element "+events[i]+" is invalid\n");
				events.splice(i, 3);
				i--;
			}
		}
	}
}

///////////////////////////////////////
function DKSendEvent(id, type, message)
{
	DKDEBUGFUNC(id, type, message);
	if(typeof id != "string"){
		DKERROR("DKRemoveEvent(id, type, message): id invalid\n");
		return false;
	}
	if(typeof type != "string"){
		DKERROR("DKRemoveEvent(id, type, message): type invalid\n");
		return false;
	}
	//if(typeof message != "string"){
	//	DKERROR("DKRemoveEvents(id, type, message): message invalid\n");
	//	return;
	//}
	
	for(var i=0; i<events.length; i++){
		if(events[i] == id){
			if(events[i+1] == type){
				//DKINFO(events[i+2]+"(["+id+", "+type+", "+message+"])\n");
				events[i+2]([id, type, message]);
				//return true;
			}
		}
	}
	return true;
}

///////////////////////////
function GetCharCode(event) 
{
	DKDEBUGFUNC(event);
    var key = event.which || event.keyCode;
	return key;
}

//////////////////////////
function GetKeyCode(event) 
{
	DKDEBUGFUNC(event);
    var key = event.keyCode;
    return key;
}

//////////////////////////////
function GetMouseButton(event) 
{
	DKDEBUGFUNC(event);
    var button = event.which || event.button;
    return button;
}

if(DK_GetBrowser() != "CEF"){
	////////////////////////////////
	function DK_SetClipboard(string)
	{
		DKDEBUGFUNC(string);
		//if(!document.queryCommandSupported('copy')){
		//	DKERROR("Javascript (Copy) not supported\n");
		//	return false;
		//}
		
		window.prompt("Copy to clipboard: Ctrl+C, Enter", string);
		return true;
	}
}

/////////////////////////////
function DK_FileToString(url)
{
	DKDEBUGFUNC(url);
	return ajaxGetUrl(url);
}

/*
/////////////////////////////
function DK_GetMouseWindowX()
{
	DKDEBUGFUNC();
	return mouseX;
}

/////////////////////////////
function DK_GetMouseWindowY()
{
	DKDEBUGFUNC();
	return mouseY;
}
*/

///////////////////////////////
function DK_Sleep(milliseconds)
{
	DKDEBUGFUNC(milliseconds);
	var start = new Date().getTime();
	for (var i = 0; i < 1e7; i++) {
		if((new Date().getTime() - start) > milliseconds){
		break;
    }
	}
}

////////////////////////////
function DK_ClearSelection()
{
	DKDEBUGFUNC();
	//Clear text selection
	if(document.selection){
		document.selection.empty();
	}
	else if(window.getSelection){
		window.getSelection().removeAllRanges();
	}
}