//BROWSER

//***** DigitalKnob *****
top.document.body.style.backgroundColor = "rgb(200,200,200)";
document.onselectstart = function() { return false; }; //prevent screen highlighting while dragging


document.getElementsByTagName('head')[0].id = "head";
document.body.id = "body";
document.body.style.fontSize = "13em";
document.documentElement.id = "html";
document.documentElement.style.fontSize = "1px";
document.body.style.cursor = "default";


var mouseX;
var mouseY;
var mouseStartX;
var mouseStartY;
var events = [];

///////////////////////////////////
document.onmousemove = function(e){
  if(DK_IE()){ // grab the x-y pos.s if browser is IE
    mouseX = event.clientX + document.body.scrollLeft
    mouseY = event.clientY + document.body.scrollTop
  } else {  // grab the x-y pos.s if browser is NS
    mouseX = e.pageX
    mouseY = e.pageY
  }  
  // catch possible negative values in NS4
  if (mouseX < 0){mouseX = 0}
  if (mouseY < 0){mouseY = 0}  

  return true
}

/////////////////////
function LoadCss(url)
{
	//DKLog("LoadCss("+url+")\n");
	
	if(!url){ 
		DKLog("LoadCss("+url+"): url invalid\n", DKERROR);
		return false; 
	}
	
	if(DK_GetObjects().indexOf(url) != -1){
		DKLog("LoadCss("+url+"): url already loaded \n", DKWARN);
		return false;
	}
	
	var link = document.createElement('link');
	link.setAttribute('rel', 'stylesheet');
	link.setAttribute('type', 'text/css');
	link.setAttribute('id', url);
	link.setAttribute('href', url);
	document.getElementsByTagName('head')[0].appendChild(link);
	
	return true;
}

//////////////////////////////
function LoadJs(url, callback)
{
	//DKLog("LoadJs("+url+", callback)\n");
	
	if(!url){ 
		DKLog("LoadJs("+url+"): url invalid\n", DKERROR);
		return false; 
	}
	
	if(DK_GetObjects().indexOf(url) != -1){
		DKLog("LoadJs("+url+", callback): url already loaded \n", DKWARN);
		callback && callback(false);
		return false;
	}
	
	var file = url.substring(url.lastIndexOf("/") + 1);
	
	// Call the js init function
	if(!file){ 
		DKLog("LoadJs("+url+"): file invalid\n", DKERROR);
		return false; 
	}
	
	//already loaded, remove it first
	if(document.getElementById(url)){
		document.getElementById(url).parentNode.removeChild(document.getElementById(url));
	}
	
	// Adding the script tag to the head as suggested before
	var head = document.getElementsByTagName('head')[0];
	var script = document.createElement('script');
	script.type = 'text/javascript';
	script.id = url;
	script.src = url;
	script.async = true; // optionally
	
	if(typeof script == "undefined"){ 
		DKLog("Cannot load "+url+" \n", DKERROR);
		return false; 
	}
	
	var name = file.replace(".js", "");
	name += "_Init";

	head.appendChild(script);
	
	var done = false;
	script.onload = script.onreadystatechange = function(){
		if(!done && (!this.readyState || this.readyState == "loaded" || this.readyState == "complete")){
			
			//DKLog("Loaded: "+url);
			var func = window[name]; //Init    
			if(typeof func == 'function'){ 
				//DKLog("Calling: "+name+" \n");
				func(); //Init
			}
			else{
				DKLog(name+" is not callable \n", DKWARN);
			}
			
			done = true;
			callback && callback(true);
		}
	};
	
	return true;
}

//////////////////////////////
function LoadHtml(url, parent)
{
	//DKLog("LoadHtml("+url+","+parent+")\n");
	
	//TODO: the id of the root element in the html file should be the file path..   I.E. MyPlugin/MyPlugin.html
	if(!url){ 
		DKLog("LoadJs("+url+"): url invalid\n", DKERROR);
		return false; 
	}
	
	if(url.indexOf(".html") == -1){ 
		DKLog("LoadHtml("+url+", parent): url is not a valid .html file \n", DKERROR);
		return false;
	}
	
	if(url == ".html"){ url = "New.html"; }
	
	if(DK_GetObjects().indexOf(url) != -1){
		DKLog("LoadHtml("+url+", parent): url already loaded \n", DKWARN);
		return false;
	}
	
	var string = DK_FileToString(url);
	//Create an empty widget
	if(!string || string == "ERROR"){ 
		string  = "<div id=\""+url+"\" style=\"position:absolute;top:200rem;left:200rem;width:200rem;height:200rem;background-color:rgb(230,230,230);\"></div>";
	}

	var temp = document.createElement("temp");
	temp.innerHTML = string;
	var nodes = temp.childNodes;
	if(!nodes){
		DKLog("LoadHtml("+url+", "+parent+"): Could not get nodes from file url \n", DKERROR);
		return false;
	}
	if(nodes.length > 1){
		//DKLog("LoadHtml("+url+", "+parent+"): too many nodes in file \n", DKERROR);
		//return false;
	}

	if(nodes[0].id != url){
		nodes[0].id = url;
		DKLog("LoadHtml("+url+",parent): please fix the id", DKWARN);
	}
	if(parent){
		parent.appendChild(nodes[0]);
	}
	else{
		top.document.body.appendChild(nodes[0]);
	}
	
	return true;
}

///////////////////////////
function CheckFileSupport()
{
	//DKLog("CheckFileSupport()\n");
	
	if(window.File && window.FileReader && window.FileList && window.Blob){
		DKLog("File support OK.");
	}
	else {
		DKLog("The File APIs are not fully supported in this browser.", DKERROR);
	}
}

///////////////////////////
function GetLeftPx(element)
{
	//DKLog("GetLeftPx("+element+")\n");
	
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
	//DKLog("GetTopPx("+element+")\n");
	
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
	//DKLog("GetWidthPx("+element+")\n");
	
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
	//DKLog("GetHeightPx("+element+")\n");
	
	if(!element){ return 0; }
	if(!element.style.height){ return 0; }
	if(element.style.height.indexOf("%") > -1){
		return parseInt(element.style.height) * WindowHeight() / 100;
	}
	return parseInt(element.style.height);
}

/////////////////////////////
function DragStart(event, id)
{
	DKLog("DragStart("+event+","+id+")\n");
	
	if(!event){event = window.event;}
	if(DK_IE()){
		mouseStartX = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        mouseStartY = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
	}
	else{
		//DKLog("DragStart("+event+","+id+"): event.clientX="+event.clientX+", window.scrollX="+window.scrollX+"\n");
		mouseStartX = event.clientX + window.scrollX;
		mouseStartY = event.clientY + window.scrollY;
		//mouseStartX = parseInt(event.changedTouches[0].clientX);
		//mouseStartY = parseInt(event.changedTouches[0].clientY);
	}
	element = document.getElementById(id);
	
	objectX = GetLeftPx(element);
	objectY = GetTopPx(element);

	document.body.onmousemove = function(event){ DragMove(event, mouseStartX, mouseStartY, objectX, objectY, id); }
	document.body.onmouseup = function(event){ DragStop(id); }
	
	//DKLog("DragStart("+event+","+id+"): event="+event+", mouseStartX="+mouseStartX+", mouseStartY="+mouseStartY+", objectX="+objectX+", objectY="+objectY+", id="+id+"\n");
	//document.body.addEventListener('touchmove', function(event){ DragMove(event, mouseStartX, mouseStartY, objectX, objectY, id); }, false);
	//document.body.addEventListener('touchend', function(event){ DragStop(id); }, false);
}

////////////////////////////////////////////////////////////////////////
function DragMove(event, mouseStartX, mouseStartY, objectX, objectY, id)
{
	//DKLog("DragMove("+event+","+mouseStartX+","+mouseStartY+","+objectX+","+objectY+","+id+")\n");
	
	if(!event){event = window.event;}
	if(DK_IE()){
		x = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        y = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
	}
	else{
		x = event.clientX + window.scrollX;
		y = event.clientY + window.scrollY;	
	}

	element = document.getElementById(id);

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

/////////////////////
function DragStop(id)
{
	//DKLog("DragStop(id)\n");
	
	document.body.onmousemove = function(){};
}

///////////////////////////////
function ResizeStart(event, id)
{
	//DKLog("ResizeStart("+event+","+id+")\n");
	
	if(!event){event = window.event;}
	if(DK_IE()){
		mouseStartX = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        mouseStartY = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
	}
	else{
		mouseStartX = event.clientX + window.scrollX;
		mouseStartY = event.clientY + window.scrollY;
	}
	element = document.getElementById(id);
	
	objectX = GetWidthPx(element);
	objectY = GetHeightPx(element);
	
	document.body.onmousemove = function(event){ ResizeMove(event, mouseStartX, mouseStartY, objectX, objectY, id); }
	document.body.onmouseup = function(event){ ResizeStop(id); }
}

//////////////////////////////////////////////////////////////////////////
function ResizeMove(event, mouseStartX, mouseStartY, objectX, objectY, id)
{	
	//DKLog("ResizeMove()\n");
	
	if(!event){event = window.event;}
	if(DK_IE()){
		x = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        y = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
	}
	else{
		x = event.clientX + window.scrollX;
		y = event.clientY + window.scrollY;
	}
	element = document.getElementById(id);
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
	//DKLog("ResizeStop("+id+")\n");
	
	document.body.onmousemove = function(){};
}

//////////////////////
function Pos(position)
{
	//DKLog("Pos("+position+")\n");
	
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
	
	DKLog("Pos() ERROR", DKERROR);
}

/////////////////////////
function GetKeyNum(event)
{
	//DKLog("GetKeyNum("+event+")\n");
	
	return (event.charCode) ? event.charCode : event.keyCode; //IE or other
}

//////////////////////////////
function PreventDefault(event)
{
	//DKLog("PreventDefault("+event+")\n");
	
	if(event.stopPropagation) {
        event.preventDefault();
    } else {
        event.cancelBubble = true;
    }
}

/*
///////////////////////////////
function StopPropagation(event)
{
	//DKLog("StopPropagation("+event+")\n");
	
	if(event.stopPropagation) {
        event.stopPropagation();
    } else {
        event.cancelBubble = true;
    }
}
*/

///////////////////////////////////
function addEvent(elem, evnt, func)
{
	//DKLog("addEvent("+elem+","+evnt+","+func+")\n");
	
	if (elem.addEventListener){  // W3C DOM
		elem.addEventListener(evnt,func,false);
	}
	else if (elem.attachEvent){ // IE 8> DOM
		if(elem == window && evnt != "resize"){
			elem = document;
		}
		elem.attachEvent("on"+evnt,
                     function(a){
                         a.currentTarget = elem;
                         func(a);
                     });
	}
	else{
		elem[evnt] = func;
	}
}

//////////////////////////////////////
function removeEvent(elem, evnt, func)
{
	//DKLog("removeEvent("+elem+","+evnt+","+func.name+")\n");
	
	if (elem.removeEventListener){  // W3C DOM
		elem.removeEventListener(evnt,func);
	}
	else if (elem.detachEvent){ // IE 8> DOM
		if(elem == window && evnt != "resize"){
			elem = document;
		}
		elem.detachEvent("on"+evnt,
                     function(a){
                         a.currentTarget = elem;
                         func(a);
                     });
	}
	else{
		elem[evnt] = null;
	}
}

/////////////////////////////////////////
function setCookie(cname, cvalue, exdays)
{
	//DKLog("setCookie("+cname+","+cvalue+","+exdays+")\n");
	
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires;
}

/////////////////////////
function getCookie(cname) 
{
	//DKLog("getCookie("+cname+")\n");
	
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
	//DKLog("WindowWidth()\n");
	
	return document.documentElement.clientWidth;
}

///////////////////////
function WindowHeight()
{
	//DKLog("WindowHeight()\n");
	
	return document.documentElement.clientHeight;
}

////////////////////
function GetMouseX()
{
	//DKLog("GetMouseX()\n");
	
	return mouseX;
}

////////////////////
function GetMouseY()
{
	//DKLog("GetMouseY()\n");
	
	return mouseY;
}

//////////////////////////
function makeStruct(names)
{
	//DKLog("makeStruct("+names+")\n");
	
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
	//DKLog("replace("+str+","+old+","+newstr+")\n");
	
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
	//DKLog("IsLocal()\n");
	
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
	//DKLog("AjaxGet("+url+","+output+")\n");
	
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
		DKLog("AJAX ERROR: Error creating request object", DKERROR);
		return false;
	}

	request.onreadystatechange=function(){
		if(request.readyState==4){
			if(request.status==200 || request.status==0){
				output.value = request.responseText;
				//DKLog("AJAX RETURN: "+output.value);
				return true;
			}
			else{
				DKLog("AJAX ERROR: "+request.statusText, DKWARN); //report error
				DKLog("status: "+request.status, DKWARN);
				return false;
			}
		}
	}
	
	try{ 
		request.open("GET",url,false); 
		request.send(); 
	}
	catch(err){
		output.value = "";
		return false;
	}
	return true;
}

////////////////////////
function ajaxGetUrl(url)
{
	//DKLog("ajaxGetUrl("+url+")\n");
	
	var response = new Object();
	AjaxGet(url, response);
	
	if(!response.value){ return "ERROR"; }
	//php has a DKLog() function that injects return messages with {"strings"}
	//The response may contain {"log data"}, let's extract and print it.
	//Also remove them and pass the remaining data on
	var place = 0;
	var n = response.value.indexOf("{", place);
	while(n != -1){
		place = response.value.indexOf("}");
		var res = response.value.substring(n+1, place);
		response.value = response.value.replace("{"+res+"}", "");
		//DKLog("PHPLog: "+res+"\n");
		n = response.value.indexOf("{");
	}

	return response.value;
}