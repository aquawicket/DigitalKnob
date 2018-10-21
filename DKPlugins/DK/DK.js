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

var myVar = setInterval(myTimer, 1000);
function myTimer() {
    DKSendEvent("GLOBAL", "second", "");
}

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
	function DK_ShowConsole(){DKLog("DK_ShowConsole(): not available for "+DK_GetBrowser()+"\n", DKWARN); return ""; }
	function DK_HideConsole(){DKLog("DK_HideConsole(): not available for "+DK_GetBrowser()+"\n", DKWARN); return ""; }
	function DK_CpuUsed(){DKLog("DK_CpuUsed(): not available for "+DK_GetBrowser()+"\n", DKWARN); return ""; }
	function DK_CpuUsedByApp(){DKLog("DK_CpuUsedByApp(): not available for "+DK_GetBrowser()+"\n", DKWARN); return ""; }
	function DK_PhysicalMemory(){DKLog("DK_PhysicalMemory(): not available for "+DK_GetBrowser()+"\n", DKWARN); return ""; }
	function DK_PhysicalMemoryUsedByApp(){DKLog("DK_PhysicalMemoryUsedByApp(): not available for "+DK_GetBrowser()+"\n", DKWARN); return ""; }
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
		//alert("DKLog("+string+") missing lvl");
		lvl = DKINFO;
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
		
		if(DK_GetBrowser() == "CHROME" || DK_GetBrowser() == "CEF"){
			if(lvl == DKERROR){
				//alert("ERROR: "+string);
				//throw "ERROR: "+string;
				console.error(getFileLine()+string);
			}
			else if(lvl == DKWARN){
				console.warn(getFileLine()+string);
			}
			else if(lvl == DKINFO){
				console.info(getFileLine()+string);
			}
			else if(lvl == DKDEBUG){
				console.log("%c"+getFileLine()+string, color);
			}
			else{
				console.log("%c"+getFileLine()+string, color);
			}
		}
		else{
			if(lvl == DKERROR){
				//alert("ERROR: "+string);
				//throw "ERROR: "+string;
				console.error(getFileLine()+string);
			}
			else if(lvl == DKWARN){
				console.warn(getFileLine()+string);
			}
			else if(lvl == DKINFO){
				console.info(getFileLine()+string);
			}
			else if(lvl == DKDEBUG){
				console.log(getFileLine()+string);
			}
			else{
				console.log(getFileLine()+string);
			}
		}
	}
	//DKSendEvent("DKConsole.html", "DKNotify", string);
}
DKLog("*** DigitalKnob ***\n");
DKLog(DK_GetBrowser()+"\n");
DKLog(DK_GetJavascript()+"\n");



/////////////////////
function DK_GetTime()
{
	DKLog("DK_GetTime()\n", DKDEBUG);
	
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
	DKLog("DK_GetDate()\n", DKDEBUG);
	
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
	DKLog("DK_Refresh()\n", DKDEBUG);
	
	//window.location.href = href+"index.html";
	window.location.hash = "";
	window.location.reload(true);
}


//////////////////////////
function DKAvailable(name)
{
	DKLog("DKAvailable("+name+")\n", DKDEBUG);
	
	if(name == "DKWidget"){
		return true; 
	}
	if(name == "DKWidgetJS"){  //FIXME: is this needed?
		DKLog("DKAvailable("+name+"): name == DKWidgetJS!  check DK.js line 191\n");
		return true; 
	}
	return false;
}

////////////////////////
function DK_GetObjects()
{
	DKLog("DK_GetObjects()\n", DKDEBUG);
	
	// Search the Dom for all scripts (.js files)
	var jsfiles = "";
	var elements = document.getElementsByTagName("script");
	for(var i=0; i<elements.length; i++){
		if(!elements[i].id){
			DKLog(elements[i].src+": js object has no id\n", DKWARN);
			continue; 
		}
		jsfiles += elements[i].id+",";
	}
	
	// Search the Dom for all css (.css files)
	var cssfiles = "";
	var elements = document.getElementsByTagName("link");
	for(var i=0; i<elements.length; i++){
		if(!elements[i].id){
			DKLog(elements[i].href+": css object has no id\n", DKWARN);
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
			DKLog(div+": html object has no id\n", DKWARN);
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
	DKLog("DK_GetEvents()\n", DKDEBUG);
	
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
	DKLog("DK_GetOS()\n", DKDEBUG);
	
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
	//DKLog("DK_GetBrowser()\n", DKDEBUG);
	
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
	DKLog("DK_GetJavascript()\n", DKDEBUG);
	
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
	DKLog("DK_GetUserAgent()\n", DKDEBUG);
	
	return navigator.userAgent;
}

//////////////////////////
function DK_GetNavigator()
{
	DKLog("DK_GetNavigator()\n", DKDEBUG);
	
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
	//DKLog("DK_IE() \n", DKDEBUG);
	
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
	DKLog("GetType("+event+")\n", DKDEBUG);
	
	if(!event){ return false; }
	if(event.type){
		//DKLog("GetType("+event+") -> "+event.type+"\n");
		return event.type 
	}
	if(event[1]){
		//DKLog("GetType("+event+") -> "+event[1]+"\n");
		return event[1]; 
	}
	DKLog("DK_GetType("+event+"): could not get event type. \n", DKERROR);
	return false;
}

////////////////////////
function DK_GetId(event)
{
	DKLog("GetId("+event+")\n", DKDEBUG);
	
	if(!event){ return false;}
	if(event.type && event.type == "contextmenu"){ //rightclick
		PreventDefault(event);
	}
	
	element = DKWidget_GetElement(event);
	if(element){
		//DKLog("GetId("+event+") -> "+element.id+"\n");
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

///////////////////////////
function DK_GetValue(event)
{
	DKLog("DK_GetValue("+event+")\n", DKDEBUG);
	
	return DKWidget_GetValue(event);
}

////////////////////////////////
function DK_Type(event, command)
{ 
	DKLog("DK_Type("+event+","+command+")\n", DKDEBUG);
	
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
	DKLog("DK_Id("+event+","+id+")\n", DKDEBUG);
	
	var element = DKWidget_GetElement(event);
	//DKLog("DK_Id(): element="+element.id+" \n");
	if((element == window || element == document) && id == "GLOBAL"){ return true; }
	if(element && element.id == id){ return true; }
	if(event[0] && event[0] == id){ return true; }
	return false;
}

/////////////////////////////
function DK_IdLike(event, id)
{ 
	DKLog("DK_IdLike("+event+","+id+")\n", DKDEBUG);
	
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
	DKLog("DK_Value("+event+","+id+")\n", DKDEBUG);
	
	if(DKWidget_GetValue(event) == id){ return true; }
	return false;
}

//////////////////////////////////
function DK_StopPropagation(event)
{
	DKLog("StopPropagation("+event+")\n", DKDEBUG);
	
	if(event.stopPropagation) {
        event.stopPropagation();
    } else {
        event.cancelBubble = true;
    }
}

///////////////////////////////////////
function DKAddEvent(id, type, Function)
{
	DKLog("DKAddEvent("+id+","+type+","+Function.name+")\n", DKDEBUG);
	
	if(typeof id != "string"){
		DKLog("DKAddEvent(id, type, Function): id invalid\n", DKWARN);
		return;
	}
	if(typeof type != "string"){
		DKLog("DKAddEvent(id, type, Function): type invalid\n", DKWARN);
		return;
	}
	if(typeof Function != "function"){
		DKLog("DKAddEvent(id, type, Function): Function invalid\n", DKWARN);
		return;
	}
	if(id == "GLOBAL"){
		element = window;
	}
	else{
		element = document.getElementById(id);
	}
	if(!element){
		DKLog("DKAddEvent("+id+","+type+","+Function.name+"): element invalid\n", DKWARN);
		return;
	}
	
	//DKLog("addEvent("+id+","+type+","+Function.name+") \n");
	addEvent(element, type, Function);
	
	//add event to array
	//DKLog("events.length="+events.length+"\n");
	events[events.length] = id;
	events[events.length] = type;
	events[events.length] = Function;
	return true;
}

//////////////////////////////////////////
function DKRemoveEvent(id, type, Function)
{
	DKLog("DKRemoveEvent("+Function.name+")\n", DKDEBUG);
	
	if(typeof id != "string"){
		DKLog("DKRemoveEvent(id, type, Function): id invalid\n", DKERROR);
		return false;
	}
	if(typeof type != "string"){
		DKLog("DKRemoveEvent(id, type, Function): type invalid\n", DKERROR);
		return false;
	}
	if(typeof Function != "function"){
		DKLog("DKRemoveEvent(id, type, Function): Function invalid\n", DKERROR);
		return false;
	}
		
	if(id == "GLOBAL"){
		element = window;
	}
	else{
		element = document.getElementById(id);
	}
	if(!element){
		DKLog("DKRemoveEvent("+id+","+type+","+Function.name+"): element invalid\n", DKWARN);
		return false;
	}
	
	for(var i=0; i<events.length; i++){
		if(events[i] == id){
			if(events[i+1] == type){
				if(typeof events[i+2] == "function" && events[i+2].name == Function.name){
					//DKLog("DKRemoveEvent("+id+","+type+","+Function.name+"): Removing event \n");
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
	DKLog("DKRemoveEvents("+Function.name+")\n", DKDEBUG);
	
	if(typeof Function != "function"){
		DKLog("DKRemoveEvents(Function): Function invalid\n", DKERROR);
		return false;
	}

	for(var i=0; i<events.length; i++){
		if(typeof events[i+2] == "function" && events[i+2].name == Function.name){
			//DKLog("DKRemoveEvent("+events[i]+","+events[i+1]+", Function): events[i+2] == Function\n");
			//var element;
			if(events[i] == "GLOBAL"){
				element = window;
			}
			else{
				element = document.getElementById(events[i]);
			}
			
			if(element){
				//DKLog("DKRemoveEvent("+events[i]+","+events[i+1]+","+events[i+2].name+"): Removing Event \n");
				removeEvent(element, events[i+1], Function);
				events.splice(i, 3);
				i--;
			}
			else{
				//DKLog("DKRemoveEvents("+Function.name+"): element "+events[i]+" is invalid\n", DKWARN);
				events.splice(i, 3);
				i--;
			}
		}
	}
}

///////////////////////////////////////
function DKSendEvent(id, type, message)
{
	DKLog("SendEvent("+id+","+type+","+message+")\n", DKDEBUG);
	
	if(typeof id != "string"){
		DKLog("DKRemoveEvent(id, type, message): id invalid\n", DKERROR);
		return false;
	}
	if(typeof type != "string"){
		DKLog("DKRemoveEvent(id, type, message): type invalid\n", DKERROR);
		return false;
	}
	//if(typeof message != "string"){
	//	DKLog("DKRemoveEvents(id, type, message): message invalid\n", DKERROR);
	//	return;
	//}
	
	for(var i=0; i<events.length; i++){
		if(events[i] == id){
			if(events[i+1] == type){
				//DKLog(events[i+2]+"(["+id+", "+type+", "+message+"]) \n");
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
	DKLog("GetCharCode("+event+")\n", DKDEBUG);
	
    var key = event.which || event.keyCode;
	return key;
}

//////////////////////////
function GetKeyCode(event) 
{
	DKLog("GetKeyCode("+event+")\n", DKDEBUG);
	
    var key = event.keyCode;
    return key;
}

//////////////////////////////
function GetMouseButton(event) 
{
	DKLog("GetMouseButton("+event+")\n", DKDEBUG);
	
    var button = event.which || event.button;
    return button;
}

if(DK_GetBrowser() != "CEF"){
	////////////////////////////////
	function DK_SetClipboard(string)
	{
		DKLog("DK_SetClipboard("+string+")\n", DKDEBUG);
		
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
	DKLog("DK_FileToString("+url+")\n", DKDEBUG);
	
	return ajaxGetUrl(url);
}

/*
/////////////////////////////
function DK_GetMouseWindowX()
{
	DKLog("DK_GetMouseWindowX()\n", DKDEBUG);
	return mouseX;
}

/////////////////////////////
function DK_GetMouseWindowY()
{
	DKLog("DK_GetMouseWindowY()\n", DKDEBUG);
	return mouseY;
}
*/

///////////////////////////////
function DK_Sleep(milliseconds)
{
	DKLog("DK_Sleep("+milliseconds+")\n", DKDEBUG);
	
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
	DKLog("DK_ClearSelection()\n", DKDEBUG);
	
	//Clear text selection
	if(document.selection){
		document.selection.empty();
	}
	else if(window.getSelection){
		window.getSelection().removeAllRanges();
	}
}