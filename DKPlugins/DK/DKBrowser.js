//BROWSER

//***** DigitalKnob *****
top.document.body.style.backgroundColor = "rgb(200,200,200)";
document.onselectstart = function() { return false; }; //prevent screen highlighting while dragging

document.body.id = "body";
document.body.style.fontSize = "13em";
document.documentElement.id = "html";
document.documentElement.style.fontSize = "1.0px";


var mouseX;
var mouseY;
var events = [];
var filesloaded="";

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
function LoadCSS(url)
{
	//DKLog("LoadCSS("+url+") \n", DKDEBUG);
	var link = document.createElement('link');
	link.setAttribute('rel', 'stylesheet');
	link.setAttribute('type', 'text/css');
	link.setAttribute('href', url);
	document.getElementsByTagName('head')[0].appendChild(link);
}

////////////////////
function LoadJS(url)
{
	//DKLog("LoadJS("+url+") \n", DKDEBUG);
	if(!url){ 
		DKLog("LoadJS("+url+"): url invalid\n", DKERROR);
		return; 
	}
	
	//loading = true;
	//if(filesloaded.indexOf(url) != -1){
	//	DKLog(url+" already loaded \n", DKWARN);
	//	return;
	//}
	// Call the js init function
	var file = url.substring(url.lastIndexOf("/") + 1);
	if(!file){ 
		DKLog("LoadJS("+url+"): file invalid\n", DKERROR);
		return; 
	}
	if(document.getElementById(url) || document.getElementById(file)){
		return; //already loaded
	}
	
	// Adding the script tag to the head as suggested before
	var head = document.getElementsByTagName('head')[0];
	var script = document.createElement('script');
	script.type = 'text/javascript';
	script.id = file;
	script.src = url;
	script.async = true; // optionally
	
	if(typeof script == "undefined"){ 
		DKLog("Cannot load "+url+" \n", DKERROR);
		return; 
	}
	
	var name = file.replace(".js", "");
	name += "_Init";

	head.appendChild(script);
	
	var done = false;
	script.onload = script.onreadystatechange = function(){
		if(!done && (!this.readyState || this.readyState == "loaded" || this.readyState == "complete")){
			
			DKLog("Loaded: "+url, DKSUCCESS);
			var func = window[name]; //Init    
			if(typeof func == 'function'){ 
				DKLog("Calling: "+name+" \n", DKINFO);
				func(); //Init
			}
			else{
				DKLog(name+" is not callable \n", DKERROR);
			}
			
			//filesloaded += url+","; //add file to loaded list
			done = true;
		}
	};
}

//////////////////////////////////
function CreateWidget(url, parent)
{
	var string = DK_FileToString(url);
	if(!string){ 
		//DKLog("file not found \n", DKERROR); 
		var file = DKFile_GetFilename(url);
		string  = "<div id=\""+file+"\" style=\"position:absolute;top:200rem;left:200rem;width:200rem;height:200rem;background-color:rgb(230,230,230);\"></div>";
	}

	var temp = document.createElement("temp");
	temp.innerHTML = string;
	var nodes = temp.childNodes;
	if(!nodes){
		DKLog("Could not get nodes from file "+url, DKERROR);
	}
	for(var i=0; i<nodes.length; i++){
		//if(i == 0){ nodes[i].setAttribute("id",url); } //The first node is our widget
		if(parent){
			parent.appendChild(nodes[i]);
		}
		else{
			//DKLog("set parent to body", DKINFO);
			top.document.body.appendChild(nodes[i]);
		}
				
		//redraw the element (bug fix)
		//top.document.body.style.display='none';
		//top.document.body.offsetHeight; // no need to store this anywhere, the reference is enough
		//top.document.body.style.display='block';
	}
	//DKLog("Created Widget:("+url+","+parent+")", DKDEBUG);
}

///////////////////////////
function CheckFileSupport()
{
	if(window.File && window.FileReader && window.FileList && window.Blob){
		DKLog("File support OK.", DKSUCCESS);
	}
	else {
		DKLog("The File APIs are not fully supported in this browser.", DKERROR);
	}
}

///////////////////////////
function GetLeftPx(element)
{
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
	
	objectX = GetLeftPx(element);
	objectY = GetTopPx(element);

	ceiling = document.createElement( 'div' );
	ceiling.setAttribute('id', 'ceiling');
	ceiling.style.position = 'absolute';
    ceiling.style.top = '0px';
	ceiling.style.left = '0px';
	ceiling.style.bottom = '0px';
	ceiling.style.right = '0px';
	ceiling.style.overflow = 'hidden';  //FIXME   do we need this
	ceiling.style.zIndex = '100000';
	ceiling.onmousemove = function(event){DragMove(event, mouseStartX, mouseStartY, objectX, objectY, id);}
	ceiling.onmouseup = function(event){DragStop(id);}
	document.body.appendChild(ceiling);
}

////////////////////////////////////////////////////////////////////////
function DragMove(event, mouseStartX, mouseStartY, objectX, objectY, id)
{
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
	ceiling = document.getElementById('ceiling');
}

//////////////////////
function DragStop(id){
	ceiling = document.getElementById('ceiling');
	if(ceiling){document.body.removeChild(ceiling);} 
}

////////////////////////////////
function ResizeStart(event, id){
	//DebugStr('ResizeStart('+id+')');
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
	
	ceiling2 = document.createElement( 'div' );
	ceiling2.setAttribute('id', 'ceiling2');
	ceiling2.style.position = 'absolute';
    ceiling2.style.top = '0px';
	ceiling2.style.left = '0px';
	ceiling2.style.bottom = '0px';
	ceiling2.style.right = '0px';
	ceiling2.style.overflow = 'hidden'; //FIXME  do we need this
	ceiling2.style.zIndex = '100000';
	ceiling2.onmousemove = function(event){ResizeMove(event, mouseStartX, mouseStartY, objectX, objectY, id);}
	ceiling2.onmouseup = function(event){ResizeStop(id);}
	document.body.appendChild(ceiling2);
}

///////////////////////////////////////////////////////////////////////////
function ResizeMove(event, mouseStartX, mouseStartY, objectX, objectY, id){	
	//DebugStr('ResizeMove()');
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
    //SetEditResize(id);
	ceiling2 = document.getElementById('ceiling2');
	/*
	if(browserName == 'Internet Explorer'){
		ceiling2.style.width = document.body.clientWidth + document.documentElement.scrollLeft + document.body.scrollLeft + 'px';
		ceiling2.style.height = document.body.clientHeight + document.documentElement.scrollTop + document.body.scrollTop + 'px';
	}
	else{
		ceiling2.style.width = document.body.clientWidth  + window.scrollX + 'px';
		ceiling2.style.height = document.body.clientHeight + window.scrollY + 'px';
	}
	*/
}

////////////////////////
function ResizeStop(id){
	//DebugStr('ResizeStop('+id+')');
	ceiling2 = document.getElementById('ceiling2');
	if(ceiling2){document.body.removeChild(ceiling2);} 
	
	/*
	element = document.getElementById(id);
  	var width = parseInt(element.style.width);
  	var height = (parseInt(element.style.height) - 30);
	var zindex = parseInt(element.style.zIndex);
	*/
		
	//ajaxGet('UpdateWindow='+id+'&width='+width+'&height='+height+'&zindex='+zindex, true);
}

///////////////////////
function Pos(position){
	if(position == ''){
		return position;	
	}
	if(typeof position == 'string'){
		if(position.search('px') != -1){
			return position;
		}
		if(position.search('%') != -1){
			return position;
		}
		if(position.search('auto') != -1){
			return position;
		}
		return position+'px'; 
	}
	if(typeof position == 'number'){
		return position+'px';	
	}
	DKLog("Pos() ERROR", DKERROR);
}

/////////////////////////
function GetKeyNum(event)
{
	return (event.charCode) ? event.charCode : event.keyCode; //IE or other
}

//////////////////////////////
function PreventDefault(event)
{
	if(event.stopPropagation) {
        event.preventDefault();
    } else {
        event.cancelBubble = true;
    }
}

///////////////////////////////
function StopPropagation(event)
{
	//DKLog("StopPropagation("+event+") \n", DKDEBUG);
	if(event.stopPropagation) {
        event.stopPropagation();
    } else {
        event.cancelBubble = true;
    }
}

///////////////////////////////////
function addEvent(elem, evnt, func)
{
	//DKLog("addEvent("+evnt+", "+elem.id+", "+func+") \n", DKDEBUG);
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
	//DKLog("removeEvent("+elem.id+", "+evnt+", "+func+") \n", DKDEBUG);
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
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires;
}

/////////////////////////
function getCookie(cname) 
{
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
	return document.documentElement.clientWidth;
}

///////////////////////
function WindowHeight()
{
	return document.documentElement.clientHeight;
}

////////////////////
function GetMouseX()
{
	return mouseX;
}

////////////////////
function GetMouseY()
{
	return mouseY;
}

//////////////////////////
function makeStruct(names)
{
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
	DKLog("AJAX SEND: "+url);
	
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
				//DKDebug("AJAX RETURN: "+output.value);
				return true;
			}
			else{
				DKLog("AJAX ERROR: "+request.statusText, DKERROR); //report error
				DKLog("status: "+request.status, DKERROR);
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
	var response = new Object();
	AjaxGet(url, response);
	
	//php has a DKLog() function that injects return messages with {"strings"}
	//The response may contain {"log data"}, let's extract and print it.
	//Also remove them and pass the remaining data on
	var place = 0;
	var n = response.value.indexOf("{", place);
	while(n != -1){
		place = response.value.indexOf("}");
		var res = response.value.substring(n+1, place);
		response.value = response.value.replace("{"+res+"}", "");
		//DKLog("PHPLog: "+res+"\n", DKINFO);
		n = response.value.indexOf("{");
	}

	return response.value;
}