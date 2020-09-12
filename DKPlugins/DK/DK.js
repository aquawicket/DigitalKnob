var LOG_DEBUG = false;
var LOG_INFO = true;
var LOG_WARNINGS = true;
var LOG_ERRORS = true;
var LOG_FILE = true;
var LOG_SHOW = ""; //comma seperated
var LOG_HIDE = ""; //comma seperated
var LOG_LINES = false;

var DK_ERROR = 1;     //Red
var DK_WARN = 2;      //Yellow
var DK_INFO = 3;      //White
var DK_DEBUG = 4;     //Blue
var DK_SHOW = 5;
var DK_HIDE = 6;

var mouseStartX;
var mouseStartY;
var objectX;
var objectY;
var drag_id;
var events = [];

var byId = function(id){ return document.getElementById(id); } //shortcut alias
 
//document.getElementsByTagName("html")[0].style.fontSize = "1.0px";
//document.body.style.fontSize = "13em";
//document.body.style.fontSize = "1.0px";

//document.onselectstart = function() { return false; }; //prevent screen highlighting while dragging
//document.documentElement.id = "html";
//document.getElementsByTagName('head')[0].id = "head";
//document.body.id = "body";
//document.body.style.cursor = "default";

// Dummy functions only implemented in c++
//function DK_DoFrame(){ /*DKWARN("DK_ClearEvents(): not available for "+DK_GetBrowser()+"\n");*/ }
//function EventLoop(){ /*DKWARN("DK_ClearEvents(): not available for "+DK_GetBrowser()+"\n");*/ }
//EventLoop.run = function(){};

//https://stackoverflow.com/a/11035042/688352
if(DK_GetBrowser() != "CEF" && DK_GetBrowser() != "RML"){
	var DK_ClearEvents = function(){ DKWARN("DK_ClearEvents(): not available for "+DK_GetBrowser()+"\n"); }
	var DKRocket_Reload = function(){ DKWARN("DKRocket_Reload(): not available for "+DK_GetBrowser()+"\n"); }
	var DK_CallFunc = function(var1, var2, var3){ DKWARN("DK_CallFunc(): not available for "+DK_GetBrowser()+"\n"); return ""; }
	var DK_Queue = function(var1, var2, var3){ DKWARN("DK_Queue(): not available for "+DK_GetBrowser()+"\n"); }
	var DK_LeftClick = function(){ DKWARN("DK_LeftClick(): not available for "+DK_GetBrowser()+"\n"); }
	var DK_RightClick = function(){ DKWARN("DK_RightClick(): not available for "+DK_GetBrowser()+"\n"); }
	var DK_SetCursorPos = function(){ DKWARN("DK_SetCursorPos(): not available for "+DK_GetBrowser()+"\n"); }
	var DKHook_GetWindows = function(){ DKWARN("DKHook_GetWindows(): not available for "+DK_GetBrowser()+"\n"); }
	var DK_Crash = function(){ DKWARN("DK_Crash(): not available for "+DK_GetBrowser()+"\n"); }
	var DK_LogGuiConsole = function(){ DKWARN("DK_LogGuiConsole(): not available for "+DK_GetBrowser()+"\n"); }
	var DK_GetScreenWidth = function(){ DKWARN("DK_GetScreenWidth(): not available for "+DK_GetBrowser()+"\n"); }
	var DK_GetScreenHeight = function(){ DKWARN("DK_GetScreenHeight(): not available for "+DK_GetBrowser()+"\n"); }
	var DK_PrintFunctions = function(){ DKWARN("DK_PrintFunctions(): not available for "+DK_GetBrowser()+"\n"); }
	var DK_GetPixelUnderMouse = function(){ DKWARN("DK_GetPixelUnderMouse(): not available for "+DK_GetBrowser()+"\n"); return ""; }
	var DK_ShowConsole = function(){ DKWARN("DK_ShowConsole(): not available for "+DK_GetBrowser()+"\n"); return ""; }
	var DK_HideConsole = function(){ DKWARN("DK_HideConsole(): not available for "+DK_GetBrowser()+"\n"); return ""; }
	var DK_CpuUsed = function(){DKWARN("DK_CpuUsed(): not available for "+DK_GetBrowser()+"\n"); return ""; }
	var DK_CpuUsedByApp = function(){ DKWARN("DK_CpuUsedByApp(): not available for "+DK_GetBrowser()+"\n"); return ""; }
	var DK_PhysicalMemory = function(){ DKWARN("DK_PhysicalMemory(): not available for "+DK_GetBrowser()+"\n"); return ""; }
	var DK_PhysicalMemoryUsedByApp = function(){ DKWARN("DK_PhysicalMemoryUsedByApp(): not available for "+DK_GetBrowser()+"\n"); return ""; }
}

/*
var myVar = setInterval(myTimer, 1000);
function myTimer() {
    DKSendEvent("window", "second", "");
}
*/

//This function is used to debug googlebot crawling
/////////////////////////////////////////////
window.addEventListener('error', function(e){
    var errorText = [
        e.message + '\n',
        'URL: ' + e.filename,
        'Line: ' + e.lineno + ', Column: ' + e.colno,
        'Stack: ' + (e.error && e.error.stack || '(no stack trace)')
    ].join('\n');
	DKERROR(errorText);
	
	/*
    // Example: log errors as visual output into the host page.
    // Note: you probably don’t want to show such errors to users, or
    //       have the errors get indexed by Googlebot; however, it may
    //       be a useful feature while actively debugging the page.
    var DOM_ID = 'rendering-debug-pre';
    if(!byId(DOM_ID)){
        var log = document.createElement('pre');
        log.id = DOM_ID;
        log.style.whiteSpace = 'pre-wrap';
        log.textContent = errorText;
        if (!document.body) document.body = document.createElement('body');
        document.body.insertBefore(log, document.body.firstChild);
    } else {
        byId(DOM_ID).textContent += '\n\n' + errorText;
    }
	(/

	/*
    // Example: log the error to remote service.
    // Note: you can log errors to a remote service, to understand
    //       and monitor the types of errors encountered by regular users,
    //       Googlebot, and other crawlers.
    var client = new XMLHttpRequest();
    client.open('POST', 'https://example.com/logError');
    client.setRequestHeader('Content-Type', 'text/plain;charset=UTF-8');
    client.send(errorText);
	*/
});

/*
/////////////////////////////////
window.onmousemove = function(e){
	if(DK_IE()){ // grab the x-y pos.s if browser is IE
		window.mouseX = e.clientX + document.body.scrollLeft
		window.mouseY = e.clientY + document.body.scrollTop
	} 
	else{  // grab the x-y pos.s if browser is NS
		window.mouseX = e.pageX
		window.mouseY = e.pageY
	}  
	// catch possible negative values in NS4
	if (window.mouseX < 0){window.mouseX = 0}
	if (window.mouseY < 0){window.mouseY = 0}  
	return true;
}
*/


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
DKINFO("Browser = "+DK_GetBrowser()+"\n");
DKINFO("JSEngine = "+DK_GetJSEngine()+"\n\n");


/////////////////////////////////
function DKCreate(data, callback)
{
	DKDEBUGFUNC(data, callback);
	//console.log("DK.js:DKCreate("+data+")\n");	
	var arry = data.split(",");
	if(arry[0].indexOf(".html") > -1){
		arry.splice(0, 0, "DKWidget");
	}
	else if(arry[0].indexOf(".js") > -1){
		arry.splice(0, 0, "DKJavascript");
	}
	else if(arry[0].indexOf(".css") > -1){
		arry.splice(0, 0, "DKCss");
	}
	else{
		//DKINFO("DKCreate("+data+"): requesting c++ plugin\n");
		if(DK_GetBrowser() == "CEF" || DK_GetBrowser() == "RML"){
			DKCreate_CPP(data);
		}
	}	
	if(arry[0] == "DKJavascript"){
		if(!LoadJs(arry[1], function(rval){
			if(callback){ 
				callback(rval); 
			}
			else{
				DKERROR("DKCreate("+data+"): does not have a callback\n");
			}
		})
		){
			return false;
		}
	}
	if(arry[0] == "DKWidget"){
		//DKINFO("DKCreate(data, callback)\n");
			if(!DKWidget_NewWidget(arry[1], arry[2])){
				return false;
			}
			if(callback){ 
				callback(); 
			}
			else{
			//DKERROR("DKCreate("+data+"): does not have a callback\n");
			}
	}
	if(arry[0] == "DKCss"){
		if(!LoadCss(arry[1])){
			return false;
		}
		if(callback){ 
			callback(); 
		}
		else{
			//DKERROR("DKCreate("+data+"): does not have a callback\n");
		}
	}
	return true;
}

//////////////////////
function DKClose(data)
{
	DKDEBUGFUNC(data);
	DKINFO("DKClose("+data+")\n");
	if(!data){
		DKERROR("DKClose("+data+"): data empty\n");
		return false;
	}
	
	var arry = data.split(",");
	if(arry[0].indexOf(".html") > -1){
		arry.splice(0, 0, "DKWidget");
	}
	else if(arry[0].indexOf(".js") > -1){
		arry.splice(0, 0, "DKJavascript");
	}
	else if(arry[0].indexOf(".css") > -1){
		arry.splice(0, 0, "DKCss");
	}
	
	var file = DKFile_GetFilename(arry[1]);
	if(!file){ 
		DKERROR("DKClose("+data+"): file invalid\n");
		return false; 
	}
	
	if(arry[0] == "DKJavascript"){
		var end = file.replace(".js", "");
		end += "_End";
		eval(end+"()");
		
		//FIXME
		/*
		console.log(end);
		var func = window[end]; //Plugin_End() //FIXME
		if(typeof func === 'function'){
			
			func(); // Call the jsclass_End() function
		}
		else{
			DKWARN("DKClose(data): "+func+" is not a function\n");
		}
		*/
		
		var script = byId(arry[1]);
		if(!script){
			//DKWARN("DKClose("+data+"): "+arry[1]+" does not exist\n");
			return false;
		}
		script.parentNode.removeChild(script);
		//DKINFO("Closed "+arry[1]+"\n");
	}
	if(arry[0] == "DKWidget"){
		var element = byId(arry[1]);
		if(!element){ 
			//DKWARN("DKClose("+data+"): "+file+" does not exist\n");
			return false; 
		}
		element.parentNode.removeChild(element);
		//DKINFO("Closed "+arry[1]+"\n");
	}
	if(arry[0] == "DKCss"){
		var css = byId(arry[1]);
		if(!css){ 
			//DKERROR("DKClose("+data+"): "+arry[1]+" does not exist\n");
			return false; 
		}
		css.parentNode.removeChild(css);
		//DKINFO("Closed "+arry[1]+"\n");
	}
	
	return true;
}

/////////////////////
function LoadCss(url)
{
	DKDEBUGFUNC(url);
	//console.log("DK.js:LoadCss("+url+")");
	if(!url){ 
		DKERROR("LoadCss("+url+"): url invalid\n");
		return false; 
	}
	
	if(DK_GetObjects().indexOf(url) != -1){
		DKWARN("LoadCss("+url+"): url already loaded\n");
		return false;
	}
	
	var link = document.createElement('link');
	//console.log("link = "+link.POINTER);
	link.setAttribute('href', url);
	link.id = url;
	link.setAttribute('rel', 'stylesheet');
	link.setAttribute('type', 'text/css');
	var elements = document.getElementsByTagName('head');
	
	//console.log("LoadCss("+url+"): link = "+link.POINTER);
	//console.log("LoadCss("+url+"): link = "+link);
	//console.log("LoadCss("+url+"): elements[0] = "+elements[0]);
	//console.log("DK.js:LoadCss("+url+") appending link");
	elements[0].appendChild(link);
	
	return true;
}

//////////////////////////////
function LoadJs(url, callback)
{
	DKDEBUGFUNC(url, callback);
	if(!url){ 
		DKERROR("LoadJs("+url+"): url invalid\n");
		return false; 
	}
	
	if(DK_GetObjects().indexOf(url) != -1){
		DKWARN("LoadJs("+url+", callback): url already loaded\n");
		callback && callback(false);
		return false;
	}
	
	//TEST: already loaded, remove it first
	if(byId(url)){
		byId(url).parentNode.removeChild(byId(url));
	}
	
	var file = url.substring(url.lastIndexOf("/") + 1);
	
	// Call the js init function
	if(!file){ 
		DKERROR("LoadJs("+url+"): file invalid\n");
		return false; 
	}
	
	// Adding the script tag to the head as suggested before
	var head = document.getElementsByTagName('head')[0];
	var script = document.createElement('script');
	//script.type = 'text/javascript';
	script.setAttribute('type', 'text/javascript');
	script.id = url;
	//script.async = true; // optionally
	script.setAttribute('async', true);
	script.setAttribute('src', url);
	
	//console.log("script.type = "+script.type);
	
	//if(typeof script == "undefined"){ 
	//	DKERROR("Cannot load "+url+"\n");
	//	return false; 
	//}
	
	var init = file.replace(".js", "");
	init += "_Init";
	
	head.appendChild(script);
	
	////////// CALLBACKS
	var done = false;
	script.onload = script.onreadystatechange = function(){ //FIXME - DigitalKnob can't trigger onload yet.
		if(!done && (!this.readyState || this.readyState == "loaded" || this.readyState == "complete")){
			//DKINFO("Loaded: "+url+"\n");
			var func = window[init]; //Plugin_Init()    
			if(typeof func == 'function'){ 
				//DKINFO("Calling: "+init+"\n");
				func(); //Init
			}
			else{
				DKWARN(init+" is not defined\n");
			}
			
			done = true;
			callback && callback(true);
		}
	};
	script.onerror = function(){
		DKERROR("LoadJs("+url+"): Could not load file\n");
	}
	////////////////////////
	
	//FIXME - DigitalKnob can't trigger onload yet, so we do this
	if(DK_GetJSEngine() == "Duktape"){
		DKINFO("Loaded: "+url+"\n");
		var func = init; //Plugin_Init() 
		if(eval("typeof "+func) === "function"){
			//DKINFO("Calling: "+init+"\n");
			eval(func)(); //Init
		}
		else{
			DKWARN(init+" is not defined\n");
		}
		callback && callback(true);
	}
	
	return true;
}

//////////////////////////////
function LoadHtml(url, parent)
{
	DKDEBUGFUNC(url, parent);
	//DKWARN("DK.js:LoadHtml("+url+","+parent+")");
	//TODO: the id of the root element in the html file should be the file path..   I.E. MyPlugin/MyPlugin.html
	if(!url){ 
		DKERROR("DK.js:LoadJs("+url+"): url invalid\n");
		return false; 
	}
	
	if(url.indexOf(".html") == -1){ 
		DKERROR("DK.js:LoadHtml("+url+", parent): url is not a valid .html file\n");
		return false;
	}
	
	if(url == ".html"){ url = "New.html"; }
	
	if(DK_GetObjects().indexOf(url) != -1){
		DKWARN("DK.js:LoadHtml("+url+", parent): url already loaded\n");
		return false;
	}
	
	var string = DK_FileToString(url);
	//DKWARN("url = "+url+"\n");
	//DKWARN("string = "+string+"\n");
	//Create an empty widget
	if(!string || string == "ERROR"){ 
		string  = "<div id=\""+url+"\" style=\"position:absolute;top:200rem;left:200rem;width:200rem;height:200rem;background-color:rgb(230,230,230);\"></div>";
	}

	var temp = document.createElement("temp");
	//console.log("temp.id = "+temp.id);
	temp.innerHTML = string;
	//console.log("temp.innerHTML = "+temp.innerHTML);
	//console.log("temp.id = "+temp.id);
	var nodes = temp.childNodes;
	if(!nodes){
		DKERROR("DK.js:LoadHtml("+url+", "+parent+"): Could not get nodes from file url\n");
		return false;
	}
	if(nodes.length > 1){
		for(var i=0; i < nodes.length; i++){
			DKWARN("node["+i+"]: "+nodes[i]+"\n");
		}
		
		DKWARN("###############################################\n");
		DKWARN("DK.js:LoadHtml("+url+", "+parent+"): Too many nodes in file\n");
		//DKINFO(temp.innerHTML+"\n");
		DKWARN("You either have too many root nodes in your html file or, you have extra whitespace at the begining or the end of the file\n");
		DKWARN("###############################################\n");
		//return false;
	}

	if(nodes[0].id != url){
		DKWARN("DK.js:LoadHtml("+url+",parent): did not match the node id ("+nodes[0].id+")\n");
		nodes[0].id = url;
		DKWARN("DK.js:LoadHtml("+url+",parent): please fix the id\n");
	}
	if(parent){
		//console.log("DK.js:LoadHtml(): appending to parent");
		parent.appendChild(nodes[0]);
	}
	else{
		//console.log("DK.js:LoadHtml(): appending to body");
		document.body.appendChild(nodes[0]);
	}
	
	//FIXME - CEF seems to do this automatically. DKRml need to act the same.
	//var elements = document.getElementsByTagName("temp");
	//if(elements){ console.log("getElementsByTagName(temp).length: "+elements.length); }
	//if(elements[0]){ console.log("elements[0].innerHTML: "+elements[0].innerHTML); }
	//if(elements[0]){ document.removeChild(elements[0]); }
	
	return true;
}

///////////////////////////
function CheckFileSupport()
{
	DKDEBUGFUNC();
	if(window.File && window.FileReader && window.FileList && window.Blob){
		DKINFO("File support OK\n");
	}
	else {
		DKERROR("The File APIs are not fully supported in this browser\n");
	}
}

///////////////////////////
function GetLeftPx(element)
{
	DKDEBUGFUNC(element);
	if(!element){ return 0; }
	if(!element.style.left){ return 0; }
	if(element.style.left.indexOf("%") > -1){
		return parseInt(element.style.left) * WindowWidth() / 100;
	}
	return parseInt(element.style.left);
}

//////////////////////////
function GetTopPx(element)
{
	DKDEBUGFUNC(element);
	if(!element){ return 0; }
	if(!element.style.top){ return 0; }
	if(element.style.top.indexOf("%") > -1){
		return parseInt(element.style.top) * WindowHeight() / 100;
	}
	return parseInt(element.style.top);
}

////////////////////////////
function GetWidthPx(element)
{
	DKDEBUGFUNC(element);
	if(!element){ return 0; }
	if(!element.style.width){ return 0; }
	if(element.style.width.indexOf("%") > -1){
		return parseInt(element.style.width) * WindowWidth() / 100;
	}
	return parseInt(element.style.width);
}

/////////////////////////////
function GetHeightPx(element)
{
	DKDEBUGFUNC(element);
	if(!element){ return 0; }
	if(!element.style.height){ return 0; }
	if(element.style.height.indexOf("%") > -1){
		return parseInt(element.style.height) * WindowHeight() / 100;
	}
	return parseInt(element.style.height);
}

/*
/////////////////////////////
function DragStart(event, id)
{
	DKDEBUGFUNC(event, id);
	if(!event){event = window.event;}
	if(DK_IE()){
		mouseStartX = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        mouseStartY = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
	}
	else{
		mouseStartX = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
		mouseStartY = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
	}
	drag_id = id;
	element = byId(drag_id);
	
	objectX = GetLeftPx(element);
	objectY = GetTopPx(element);

	document.body.onmousemove = function(event){ DragMove(event); }
	document.body.onmouseup = function(event){ DragStop(event); }
	document.body.addEventListener('touchmove', DragMove, false);
	document.body.addEventListener('touchend', DragStop, false);
}

////////////////////////
function DragMove(event)
{
	DKDEBUGFUNC(event);
	if(!event){event = window.event;}
	if(DK_IE()){
		x = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        y = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
	}
	else{
		x = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
		y = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
	}

	element = byId(drag_id);

	if(element.style.left){
		element.style.left = Pos(objectX + x - mouseStartX);
	}
	else{
		element.style.right = Pos(objectX + mouseStartX - x);
	}
	if(element.style.top){
		element.style.top =  Pos(objectY + y - mouseStartY);
	}
	else{
		element.style.bottom =  Pos(objectY + mouseStartY - y);
	}
	
	//WindowRestrictions(id);
	
	//Create a custom move event
	///////////////////////////////////////////////////
	var moveevent;
	if(document.createEvent){
		moveevent = document.createEvent("HTMLEvents");
		moveevent.initEvent("move", true, true);
	}
	else{
		moveevent = document.createEventObject();
		moveevent.eventType = "move";
	}

	moveevent.eventName = "move";

	if(document.createEvent){
		element.dispatchEvent(moveevent);
	}
	else{
		element.fireEvent("on" + moveevent.eventType, moveevent);
	}
	////////////////////////////////////////////////////////////
}

////////////////////////
function DragStop(event)
{
	DKDEBUGFUNC(event);
	document.body.onmousemove = function(){};
	document.body.onmouseup = function(){};
	document.body.removeEventListener('touchmove', DragMove, false);
	document.body.removeEventListener('touchend', DragStop, false);
}
*/

/*
///////////////////////////////
function ResizeStart(event, id)
{
	DKDEBUGFUNC(event, id);
	if(!event){event = window.event;}
	if(DK_IE()){
		mouseStartX = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        mouseStartY = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
	}
	else{
		mouseStartX = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
		mouseStartY = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
	}
	
	drag_id = id;
	element = byId(id);
	
	objectX = GetWidthPx(element);
	objectY = GetHeightPx(element);
	
	document.body.onmousemove = function(event){ ResizeMove(event); }
	document.body.onmouseup = function(event){ ResizeStop(event); }
	document.body.addEventListener('touchmove', ResizeMove, false);
	document.body.addEventListener('touchend', ResizeStop, false);
}

//////////////////////////
function ResizeMove(event)
{	
	DKDEBUGFUNC(event);
	if(!event){event = window.event;}
	if(DK_IE()){
		x = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        y = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
	}
	else{
		x = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
		y = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
	}
	
	element = byId(drag_id);
	if((objectX + x - mouseStartX) > 1){
  		element.style.width = Pos(objectX + x - mouseStartX);
		
  	}
  	if((objectY + y - mouseStartY) > 1){
	  	element.style.height = Pos(objectY + y - mouseStartY);
  	}
	
	//WindowRestrictions(id);
	//DKSendEvent(id, "resize");
}

///////////////////////
function ResizeStop(id)
{
	DKDEBUGFUNC(id);
	document.body.onmousemove = function(){};
	document.body.onmouseup = function(){};
	document.body.removeEventListener('touchmove', ResizeMove, false);
	document.body.removeEventListener('touchend', ResizeStop, false);
}
*/

/*
//////////////////////
function Pos(position)
{
	DKDEBUGFUNC(position);
	if(position == ''){
		return position;	
	}
	if(typeof position == 'string'){
		if(position.search('rem') != -1){
			if(DK_IE() && DK_IE() < 9){
				position = position.replace("rem", "px");
			}
			return position;
		}
		if(position.search('px') != -1){
			return position;
		}
		if(position.search('%') != -1){
			return position;
		}
		if(position.search('auto') != -1){
			return position;
		}
		
		if(DK_IE() && DK_IE() < 9){
			return position+'px';
		}
		else{
			return position+'rem';
		}
	}
	if(typeof position == 'number'){
		if(DK_IE() && DK_IE() < 9){
			return position+'px';
		}
		else{
			return position+'rem';
		}	
	}
	
	DKERROR("Pos() ERROR\n");
}
*/

/////////////////////////
function GetKeyNum(event)
{
	DKDEBUGFUNC(event);
	return (event.charCode) ? event.charCode : event.keyCode; //IE or other
}

//////////////////////////////
function PreventDefault(event)
{
	DKDEBUGFUNC(event);
	if(event.stopPropagation) {
        event.preventDefault();
    } else {
        event.cancelBubble = true;
    }
}

///////////////////////////////
function StopPropagation(event)
{
	DKDEBUGFUNC(event);
	if(event.stopPropagation) {
        event.stopPropagation();
    } else {
        event.cancelBubble = true;
    }
}

/////////////////////////////////////////
function setCookie(cname, cvalue, exdays)
{
	DKDEBUGFUNC(cname, cvalue, exdays);
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires;
}

/////////////////////////
function getCookie(cname) 
{
	DKDEBUGFUNC(cname);
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
    }
    return "";
}

//////////////////////
function WindowWidth()
{
	DKDEBUGFUNC();
	return document.documentElement.clientWidth;
}

///////////////////////
function WindowHeight()
{
	DKDEBUGFUNC();
	return document.documentElement.clientHeight;
}

////////////////////
function GetMouseX()
{
	DKDEBUGFUNC();
	return mouseX;
}

////////////////////
function GetMouseY()
{
	DKDEBUGFUNC();
	return mouseY;
}

//////////////////////////
function makeStruct(names)
{
	DKDEBUGFUNC(names);
	var names = names.split(' ');
	var count = names.length;
	function constructor(){
		for (var i = 0; i < count; i++) {
			this[names[i]] = arguments[i];
		}
	}
	return constructor;
	
	//Usage:
	//var Item = makeStruct("id speaker country");
	//var row = new Item(1, 'john', 'au');
	//alert(row.speaker); // displays: john
}


//////////////////////////////////
function replace(str, old, newstr)
{
	DKDEBUGFUNC(str, old, newstr);
	var re = new RegExp(old, 'g');
	return str.replace(re, newstr);
}

// trim for IE8
if(typeof String.prototype.trim !== 'function') {
  String.prototype.trim = function() {
    return this.replace(/^\s+|\s+$/g, ''); 
  }
}

//////////////////
function IsLocal()
{
	DKDEBUGFUNC();
	switch(window.location.protocol){
		case 'http:':
		case 'https:':
			//remote file over http or https
			return false;
			break;
		case 'file:':
			//local file
			return true;
			break;
		default: 
			//some other protocol
	}
}

//////////////////////////
function DKDEBUGFUNC(vars)
{
	/*
	var string = DKDEBUGFUNC.caller.name+"(";  //func.caller.name not available in Duktape
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
	*/
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
			if(!LOG_DEBUG){
				LOG_DEBUG = true;
				DKDEBUG(info+variable+"\n");
				LOG_DEBUG = false
			}
			else{
				DKDEBUG(info+variable+"\n");
			}
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
	for(var i=0; elements && i<elements.length; i++){
		if(!elements[i].id){
			//DKWARN(elements[i].src+": script object has no id\n");
			continue; 
		}
		jsfiles += elements[i].id+",";
	}
	
	// Search the Dom for all css (.css files)
	var cssfiles = "";
	var elements = document.getElementsByTagName("link");
	if(elements){
		for(var i=0; i<elements.length; i++){
			if(!elements[i].id){
				//DKWARN(elements[i].href+": css object has no id\n");
				continue; 
			}
			cssfiles += elements[i].id+",";
		}
	}
	
	// Search the Dom for all widgets (.html id's)
	var htmlfiles = "";
	var divs = document.getElementsByTagName("div");
	if(divs){
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
	if(navigator.userAgent.indexOf("Rml") != -1){
        return "RML";
    }
    else if((navigator.userAgent.indexOf("Opera") || navigator.userAgent.indexOf('OPR')) != -1 ){
        return "OPERA";
    }
    else if(navigator.userAgent.indexOf("Chrome") != -1 && navigator.userAgent.indexOf("Cef") == -1){
		return "CHROME";
    }
	else if(navigator.userAgent.indexOf("Cef") != -1){
        return "CEF";
    }
    else if(navigator.userAgent.indexOf("Safari") != -1){
        return "SAFARI";
    }
    else if(navigator.userAgent.indexOf("Firefox") != -1){
        return "FIREFOX";
    }
    else if((navigator.userAgent.indexOf("MSIE") != -1) || (!!document.documentMode == true )){ //IF IE > 10
		return "IE";
    }
    else {
       return "UNKNOWN BROWSER";
    }
}

/////////////////////////
function DK_GetJSEngine()
{
	DKDEBUGFUNC();
	if(navigator.product == "Duktape"){
		return "Duktape"
	}
	var v8string = 'function%20javaEnabled%28%29%20%7B%20%5Bnative%20code%5D%20%7D';
	if('WebkitAppearance' in document.documentElement.style){  //If (probably) WebKit browser
		if (escape(navigator.javaEnabled.toString()) === v8string){
			return "V8";
		}
		else{
			return "JSC";
		}
	}
	return "UNKNOWN JAVASCRIPT ENGINE"
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
		if(element == window){ return "window"; }
		if(element == document){ return "document"; }
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
	//DKWARN("DK_Type("+event+","+command+"): type does not match\n");
	return false;
}

/////////////////////////
function DK_Id(event, id)
{ 
	DKDEBUGFUNC(event, id);
	var element = DKWidget_GetElement(event);
	//DKWARN("DK_Id(): element="+element.id+"\n");
	if(element == window && id == "window"){ return true; }
	//if(element == document) && id == "document"){ return true; }
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
	/////////////////////////////////////////////////
	if(id == "window"){
		element = window;
	}
	else{
		element = byId(id);
	}
	if(!element){
		DKWARN("DKAddEvent("+id+","+type+","+Function.name+"): element invalid\n");
		return;
	}
	
	if(element.addEventListener){  // W3C DOM
		element.addEventListener(type, Function, false);
	}
	else if (element.attachEvent){ // IE 8> DOM
		if(element == window && type != "resize"){
			element = document;
		}
		element.attachEvent("on"+type, function(a){
			a.currentTarget = element;
			Function(a);
        });
	}
	else{
		element[type] = Function;
	}
	
	//add event to array for reference
	events[events.length] = id;
	events[events.length] = type;
	events[events.length] = Function;
	return true;
}

/////////////////////////////////////////////
function removeEvent(element, type, Function)
{
	DKDEBUGFUNC(element, type, Function.name);
	if (element.removeEventListener){  // W3C DOM
		element.removeEventListener(type, Function);
	}
	else if (element.detachEvent){ // IE 8> DOM
		if(element == window && type != "resize"){
			element = document;
		}
		element.detachEvent("on"+type, function(a){
            a.currentTarget = element;
            Function(a);
		});
	}
	else{
		element[type] = null;
	}
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
		
	if(id == "window"){
		element = window;
	}
	else{
		element = byId(id);
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
			if(events[i] == "window"){
				element = window;
			}
			else{
				element = byId(events[i]);
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

if(DK_GetBrowser() != "CEF" && DK_GetBrowser() != "RML"){
	//////////////////////////////////////
	var DK_SetClipboard = function(string)
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


//////////////////////////////////////////////////////////////////
//  We can take a ajaxGetUrl(url) call and give back php stuff
//
//  Single return value 
//	ajaxGetUrl("http://DigitalKnob.com/assets/DKText.php?text=hello world");      
//	returns "hello world"
//
//	Multiple return values are comma separated.
//	ajaxGetUrl("http://digitalknob.com/assets/DKMySql.php?Query=SHOW TABLES");     
//	returns "1,User"
//  
//	Multidimensional return values are also comma separated with the first value specifying the number of fields in each row.
//  ajaxGetUrl("http://digitalknob.com/assets/DKMySql.php?Query=SELECT * FROM User");
//  returns "3,1,aquawicket@hotmail.com,peanut123,2,aquawicket@gmail.com,peanut456"
//	the first value of "3" specifies that the array should be broken into rows of 3
//
/////////////////////////////////////////////////////////////////

/////////////////////////////
function AjaxGet(url, output)
{
	DKDEBUGFUNC(url, output);
	var request = "";
	try {
        request = new XMLHttpRequest();
    }catch(e){}
    try {
        request = new ActiveXObject("Msxml3.XMLHTTP");
    }catch(e){}
    try {
        request = new ActiveXObject("Msxml2.XMLHTTP.6.0");
    }catch(e){}
    try {
        request = new ActiveXObject("Msxml2.XMLHTTP.3.0");
    }catch(e){}
    try {
        request = new ActiveXObject("Msxml2.XMLHTTP");
    }catch(e){}
    try {
        request = new ActiveXObject("Microsoft.XMLHTTP");
    }catch(e){}

	if(!request){
		DKERROR("AJAX ERROR: Error creating request object\n");
		return false;
	}

	request.onreadystatechange=function(){
		if(request.readyState==4){
			if(request.status==200 || request.status==0){
				output.value = request.responseText;
				//DKINFO("AJAX RETURN: "+output.value+"\n");
				return true;
			}
			else{
				DKERROR("AJAX ERROR: "+url+" "+request.statusText+"\n"); //report error
				DKWARN("status: "+request.status+"\n");
				return false;
			}
		}
	}
	
	//try{ 
		request.open("GET", url, false); 
		request.send(); 
	//}
	//catch(err){
	//	output.value = "";
	//	return false;
	//}
	return true;
}

////////////////////////
function ajaxGetUrl(url)
{
	DKDEBUGFUNC(url);
	var response = new Object();
	AjaxGet(url, response);
	
	if(!response.value){ return "ERROR"; }
	//php has a DKINFO() function that injects return messages with {"strings"}
	//The response may contain {"log data"}, let's extract and print it.
	//Also remove them and pass the remaining data on
	//TODO - upgrade this to JSON date transfers
	var place = 0;
	var n = response.value.indexOf("{", place);
	while(n != -1){
		place = response.value.indexOf("}");
		var res = response.value.substring(n+1, place);
		response.value = response.value.replace("{"+res+"}", "");
		//DKINFO("PHPLog: "+res+"\n");
		n = response.value.indexOf("{");
	}

	return response.value;
}