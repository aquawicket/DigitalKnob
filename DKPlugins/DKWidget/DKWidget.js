//BROWSER

function DKWidget_ValidateColor(color){ DKLog("DKWidget_ValidateColor(): not available for javascript", DKERROR); return color; }
function DKWidget_GetFocusElement(){ DKLog("DKWidget_GetFocusElement(): not available for javascript", DKERROR); }

/////////////////////////////////
function DKCreate(data, callback)
{
	DKLog("DKCreate("+data+")", DKDEBUG);
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
	
	
	if(arry[0] == "DKJavascript"){
		LoadJS(arry[1], function(){
			//setTimeout(function(){
			if(callback){
				//DKLog("DKCreate("+data+"): has callback \n");
				callback();
			}
			else{
				DKLog("DKCreate("+data+"): does not have a callback \n", DKERROR);
			}
			//}, 500);
		});
		return true;
	}
	if(arry[0] == "DKWidget"){
		DKWidget_NewWidget(arry[1], arry[2]);
		setTimeout(function(){
			if(callback){
				//DKLog("DKCreate("+data+"): has callback \n");
				callback();
			}
			else{
				//DKLog("DKCreate("+data+"): does not have a callback \n");
			}
		}, 500);
		return true;
	}
	if(arry[0] == "DKCss"){
		LoadCSS(arry[1]);
		setTimeout(function(){
			if(callback){
				//DKLog("DKCreate("+data+"): has callback \n");
				callback();
			}
			else{
				//DKLog("DKCreate("+data+"): does not have a callback \n");
			}
		}, 500);
		return true;
	}

	return false;
}

//////////////////////
function DKClose(data)
{
	DKLog("DKClose("+data+")", DKDEBUG);
	
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
		DKLog("DKClose("+data+"): file invalid \n", DKERROR);
		return; 
	}
	
	if(arry[0] == "DKJavascript"){
		// Call the js end function
		var name = file.replace(".js", "");
		name += "_End";
		var func = window[name]; //End
		if(typeof func == 'function'){ 
			DKLog("Calling: "+name+" \n", DKINFO);
			func(); //End
		}
		else{
			DKLog(name+" is not callable \n", DKERROR);
		}
		var script = document.getElementById(arry[1]);
		if(!script){
			DKLog("DKClose("+data+"): "+arry[1]+" does not exist \n", DKERROR);
			return;
		}
		script.parentNode.removeChild(script);
	}
	if(arry[0] == "DKWidget"){
		var file = DKFile_GetFilename(arry[1]);
		var element = document.getElementById(file);
		if(!element){ 
			DKLog("DKClose("+data+"): "+file+" does not exist \n", DKERROR);
			return; 
		}
		element.parentNode.removeChild(element);
	}
	if(arry[0] == "DKCss"){
		var css = document.getElementById(arry[1]);
		if(!css){ 
			DKLog("DKClose("+data+"): "+arry[1]+" does not exist \n", DKERROR);
			return; 
		}
		css.parentNode.removeChild(css);
	}
}

////////////////////////////////////////
function DKWidget_NewWidget(url, parent)
{
	DKLog("DKWidget("+url+", "+parent+") \n", DKDEBUG);
	
	//if(filesloaded.indexOf(url) != -1){
		//DKLog(url+" already loaded \n", DKWARN);
		//return;
	//}
	
	if(url.indexOf(".html") == -1){ 
		DKLog(url+" is not a valid .html file \n", DKERROR);
		return;
	}
	
	var filename = url.replace(/^.*[\\\/]/, '');
	if(parent){
		//if(parent.indexOf(".html") == -1){ parent+=".html"; }
		var element = document.getElementById(parent);
		if(!element){ DKLog("DKWidget(): could not get parent ("+parent+") \n", DKERROR); return false; }
		CreateWidget(url, element);
		DKWidget_AttachDrags(filename); //Attach Drags
	}
	else{
		CreateWidget(url);
		DKWidget_AttachDrags(filename); //Attach Drags
	}
	
	//filesloaded += url+","; //add file to loaded list
}

////////////////////////////////////
function DKWidget_GetAvailableId(id)
{
	out = id;
	var i = 0;
	
	while(DKWidget_ElementExists(out)){
		//if there is a .  the number must come before
		var n = id.lastIndexOf(".");
		if(n > 0){
			out = id.substring(0, n)+String(i)+id.substring(n);
		}
		else{
			out = id+toString(i);
			out = id+String(i);
		}
		i++;
	}
	return out;
	//DKLog("GetAvailableId("+id+")-> "+out+"\n", DKDEBUG);
}

/////////////////////////////
function DKWidget_GetFile(id)
{
	return "";
}

//////////////////////////
function DKWidget_Hide(id)
{
	var element = document.getElementById(id);
	if(!element){ return false; }
	element.style.display = "none";
}

//////////////////////////
function DKWidget_Show(id)
{
	var element = document.getElementById(id);
	if(!element){ return false; }
	element.style.display = "block";
	element.style.visibility = "visible";
}

////////////////////////////
function DKWidget_Toggle(id)
{
	var element = document.getElementById(id);
	if(!element){ return false; }
	if(element.style.display == "none" || element.style.visibility == "hidden"){
		DKWidget_Show(id);
	}
	else{
		DKWidget_Hide(id);
	}
}

/////////////////////////////////
function DKWidget_AttachDrags(id)
{
	var parent = document.getElementById(id);
	if(!parent){ return false; }
	var elements = parent.getElementsByTagName('*');
	for (var i=0; i<elements.length; i++) {	
		var x = elements[i];
		
		if(!DK_IE()){
			x.style.setProperty("pointer-events","all");
		}
		
		if(x.hasAttribute("drag")){ 	//Drag events
			var mov_tar = x.getAttribute("drag");	
			x.onmousedown = function(event){DragStart(event, mov_tar);}
		}
		if(x.hasAttribute("resize")){ 	//Resize events
			var res_tar = x.getAttribute("resize");	
			x.onmousedown = function(event){ResizeStart(event, res_tar);}
		}
	}
}

/////////////////////////////////////////
function DKWidget_AddDragHandle(id, drag)
{
	var element = document.getElementById(id);
	if(!DK_IE()){
		element.style.setProperty("pointer-events","all");
	}
	element.onmousedown = function(event){DragStart(event, drag);}
	return true;
}

/////////////////////////////////////////////
function DKWidget_AddResizeHandle(id, resize)
{
	var element = document.getElementById(id);
	if(!DK_IE()){
		element.style.setProperty("pointer-events","all");
	}
	element.onmousedown = function(event){ResizeStart(event, resize);}
	return true;
}

//////////////////////////////////////
function DKWidget_RemoveDragHandle(id)
{
	if(!id){ return; }
	var element = document.getElementById(id);
	if(!DK_IE()){
		//element.style.setProperty("pointer-events","none");
	}
	element.onmousedown = 0;
}

///////////////////////////////////
function DKWidget_GetElement(event)
{
	if(!event){event = window.event;}
	return (event.currentTarget) ? event.currentTarget : event.srcElement; //IE or other
}

/////////////////////////////////
function DKWidget_GetElements(id)
{
	var string = "";
	
	var nodes = document.getElementById(id).getElementsByTagName('*');
	//var nodes = document.getElementById(id).childNodes;
	for(var i=0; i<nodes.length; i++){
		if(nodes[i].id){
			string += nodes[i].id;
			string += ",";
		}
	}
	DKLog("GetElements("+id+"): -> "+string+" \n", DKDEBUG);
	return string;
}

////////////////////////////////////
function DKWidget_GetValue(variable)
{
	//DKLog("GetValue("+variable+") \n", DKDEBUG);
	if(!variable){ DKLog("variable empty \n"); return; }

	if(typeof variable === "string"){ //id
		//DKLog("GetValue("+variable+") -> typeof variable === string\n", DKDEBUG);
		var ele = document.getElementById(variable);
		if(!ele){ DKLog("GetValue("+variable+"): Cannot find element. \n"); /*return false;*/ }
		if(ele){ 
			//DKLog("GetValue("+variable+") -> "+ele.value+"\n", DKDEBUG);
			return ele.value; 
		}
		
		DKLog("GetValue("+variable+"): Could not get value. \n", DKERROR);
		return false;
	}
	
	if(typeof variable === "object"){
		DKLog("GetValue("+variable+") -> typeof variable === object\n", DKDEBUG);
		DKLog("GetValue("+variable+") -> variable.nodeType == "+variable.nodeType+"\n", DKDEBUG);
		DKLog("GetValue("+variable+") -> variable.tagName == "+variable.tagName+"\n", DKDEBUG);
		DKLog("GetValue("+variable+") -> variable.type == "+variable.type+"\n", DKDEBUG);
		if(variable.nodeType == 1){
			DKLog("variable.tagName: "+variable.tagName+"\n");
			if(variable.tagName == "INPUT"){
				DKLog("GetValue("+variable+") -> "+variable.value+"\n", DKDEBUG);
				return variable.value;
			}
			return DKWidget_GetInnerHtml(variable);
		}
		if(variable.type){ //event
			//DKLog("GetValue("+variable+") -> variable.type == true\n", DKDEBUG);
			//DKLog("GetValue("+variable+") -> "+variable.type+"\n", DKDEBUG);
			if(variable.type == "mousedown"){
				return GetMouseButton(variable);
			}
			if(variable.type == "mouseup"){
				return GetMouseButton(variable);
			}
			if(variable.type == "click"){
				return GetMouseButton(variable);
			}
			if(variable.type == "dblclick"){
				return GetMouseButton(variable);
			}
			if(variable.type == "contextmenu"){
				return GetMouseButton(variable);
			}
			if(variable.type == "mousemove"){
				return event.clientX+","+event.clientY+","+event.screenX+","+event.screenY;
			}
			if(variable.type == "mouseover"){
				if(!event.target){ return window.event.srcElement.id; }
				return event.target.id;
			}
			if(variable.type == "mouseout"){
				if(!event.target){ return window.event.srcElement.id; }
				return event.target.id;
			}
			if(variable.type == "wheel"){
				var o = variable//.originalEvent,
				d = o.detail, w = o.wheelDelta,
				n = 225, n1 = n-1;

				// Normalize delta
				d = d ? w && (f = w/d) ? d/f : -d/1.35 : w/120;
				// Quadratic scale if |d| > 1
				d = d < 1 ? d < -1 ? (-Math.pow(d, 2) - n1) / n : d : (Math.pow(d, 2) + n1) / n;
				// Delta *should* not be greater than 2...
				e.delta = Math.min(Math.max(d / 2, -1), 1) * 2;
				return e.delta;
			}
			if(variable.type == "keypress"){
				return GetCharCode(variable);
			}
			if(variable.type == "keydown"){
				return GetKeyCode(variable);
			}
			if(variable.type == "keyup"){
				return GetKeyCode(variable);
			}
			if(variable.type == "resize"){
				var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
				var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
				return width+","+height;
			}
			var ele = DKWidget_GetElement(event);
			DKLog("GetValue("+variable+") -> "+ele.value+"\n", DKDEBUG);
			return ele.value;
		}
		else{ //element or other object
			if(variable.value){
				DKLog("GetValue("+variable+") -> "+variable.value+"\n", DKDEBUG);
				return variable.value;
			}
			//DKLog("GetValue("+variable+") -> "+variable[2]+"\n", DKDEBUG);
			return variable[2];
		}
	}
	
	DKLog("ERROR: GetValue(): unknown type", DKERROR);
	return false;
}

////////////////////////////////
function DKWidget_GetTagName(id)
{
	var element = document.getElementById(id);
	if(!element){ return false; }
	return element.tag;
}

///////////////////////////////////////////////////
function DKWidget_GetAttribute(variable, parameter)
{
	if(typeof variable == "object"){
		return variable[parameter];
	}
	if(typeof variable == "string"){
		var element = document.getElementById(variable);
		return element[parameter];
	}
	DKLog("ERROR: GetAttribute(): unknown type", DKERROR);
	return false;
}

//////////////////////////////////////////////////////////
function DKWidget_SetAttribute(variable, parameter, value)
{
	if(!variable){ DKLog("variable not set \n", DKERROR); return false; }
	if(typeof variable == "object"){
		//variable.setAttribute(parameter, value);
		if(parameter == "class"){
			variable.className = value;
		}
		else{
			variable[parameter] = value;
		}
		return true;
	}
	if(typeof variable == "string"){
		var element = document.getElementById(variable);
		if(!element){
			DKLog("DKWidget_SetAttribute(): element invalid", DKERROR);
			return false;
		}
		//element.setAttribute(parameter, value);
		if(parameter == "class"){
			element.className = value;
		}
		else{
			element[parameter] = value;
		}
		return true;
	}
	DKLog("DKWidget_SetAttribute(): unknown type", DKERROR);
	return false;
}

//////////////////////////////////////////////////
function DKWidget_GetProperty(variable, parameter)
{
	//DKLog("DKWidget_GetProperty("+variable+","+parameter+") \n", DKDEBUG);
	if(parameter == "background-color"){ parameter = "backgroundColor"; }

	if(typeof variable == "object"){
		return variable.style[parameter];
	}
	if(typeof variable == "string"){
		var element = document.getElementById(variable);
		if(!element){
			DKLog("DKWidget_GetProperty(): element is null \n", DKERROR);
			return;
		}
		//if(!element.hasOwnProperty(parameter)){ return; }
		return element.style[parameter];
	}
	DKLog("ERROR: GetProperty(): unknown type", DKERROR);
	return false;
}

/////////////////////////////////////////////////////////
function DKWidget_SetProperty(variable, parameter, value)
{
	if(!variable){ DKLog("variable not set \n", DKERROR); return false; }
	if(parameter == "background-color"){ parameter = "backgroundColor"; } //IE 8- fix

	if(typeof variable == "object"){
		variable.style[parameter] = value;
		return true;
	}
	if(typeof variable == "string"){
		var element = document.getElementById(variable);
		if(!element){ 
			DKLog("ERROR: SetProperty(): element("+variable+") invalid", DKERROR);
			return false;
		}
		element.style[parameter] = value;
		return true;
	}
	DKLog("ERROR: SetProperty(): unknown type", DKERROR);
	return false;
}

///////////////////////////////////////////////
function DKWidget_RemoveProperty(id, parameter)
{
	//DKLog("DKWidget_RemoveProperty("+id+","+parameter+") \n", DKDEBUG);
	var element = document.getElementById(id);
	if(!element){ 
		DKLog("DKWidget_RemoveProperty(): element invalid. \n", DKDEBUG);
		return; 
	}
	if(element.style[parameter]){
		element.style[parameter] = null;
	}
}

///////////////////////////////////////////
function DKWidget_SetValue(variable, value)
{
	if(!variable){ return false; }
	if(!value){ value = ""; }
	if(typeof variable == "object"){
		if(variable.tagName == "INPUT"){
			variable.value = value;
			return true;
		}
		DKWidget_SetInnerHtml(variable, value);
		return true;
	}
	if(typeof variable == "string"){
		var element = document.getElementById(variable);
		if(!element){ DKLog("SetValue("+variable+"): Cannot find element. \n", DKERROR); return false; }
		if(element.tagName == "INPUT"){
			element.value = value;
			return true;
		}
		DKWidget_SetInnerHtml(variable, value);
		return true;
	}
	DKLog("ERROR: SetValue(): unknown type", DKERROR);
	return false;
}

////////////////////////////////////////
function DKWidget_GetInnerHtml(variable)
{
	if(typeof variable == "object"){
		return variable.innerHTML;
	}
	if(typeof variable == "string"){
		var element = document.getElementById(variable);
		return element.innerHTML;
	}
	DKLog("ERROR: GetInnerHtml(): unknown type", DKERROR);
	return false;
}

///////////////////////////////////////////////
function DKWidget_SetInnerHtml(variable, value)
{
	if(typeof variable == "object"){
		variable.innerHTML = value;
		return true;
	}
	if(typeof variable == "string"){
		var element = document.getElementById(variable);
		if(!element){ 
			DKLog("ERROR: SetInnerHtml(): element invalid", DKERROR);
			return false; 
		}
		element.innerHTML = value;
		return true;
	}
	DKLog("ERROR: SetInnerHtml(): unknown type", DKERROR);
	return false;
}

////////////////////////////////////////
function DKWidget_GetInnerHtmlString(id)
{
	var element = document.getElementById(id);
	for(var i = 0; i < element.childNodes.length; i++){
		var curNode = element.childNodes[i];
		if(curNode.nodeName === "#text"){
			return curNode.nodeValue;
		}
	}
}

////////////////////////////////////////////////
function DKWidget_SetInnerHtmlString(id, string)
{
	var element = document.getElementById(id);
	for(var i = 0; i < element.childNodes.length; i++){
		var curNode = element.childNodes[i];
		if(curNode.nodeName === "#text"){
			curNode.nodeValue = string;
			return;
		}
	}
}

////////////////////////////////////////
function DKWidget_GetOuterHtml(variable)
{
	if(typeof variable == "object"){
		return variable.outerHTML;
	}
	if(typeof variable == "string"){
		var element = document.getElementById(variable);
		return element.outerHTML;
	}
	DKLog("ERROR: GetInnerHtml(): unknown type", DKERROR);
	return false;
}

////////////////////////////////////////////
function DKWidget_IsChildOf(element, parent)
{
	//DKLog("DKWidget_IsChildOf("+element+", "+parent+") \n", DKDEBUG);
	if(!element){return false;}
	if(!parent){return false;}
	var ele = document.getElementById(element);
	var par = document.getElementById(parent);
	if(!ele){return false;}
	if(!par){return false;}
	
	while(ele && (ele != par)){
		if(ele == top.document.body){ return false; }
		ele = ele.parentNode;
	}
	
	if(ele == par){
		return true;
	}
	
	return false;
}

////////////////////////////////////////////////
function DKWidget_CreateElement(parent, tag, id)
{
	if(tag == "handle"){ return ""; } //we don't make handles for browsers
	//DKLog("DKWidget_CreateElement("+parent+", "+tag+", "+id+") \n", DKDEBUG);
	
	id = DKWidget_GetAvailableId(id);
	
	var par = document.getElementById(parent);
	if(!par){ DKLog("CreateElement(): parent invalid ("+parent+") \n", DKERROR); return false;}
	var ele = document.createElement(tag);
	if(!ele){ DKLog("CreateElement(): ele invalid ("+tag+") \n", DKERROR); return false;}
	ele.id = id;
	
	par.appendChild(ele); //This is not working on IE
	return id;
}

//////////////////////////////////////////////////////
function DKWidget_CreateElementBefore(parent, tag, id)
{
	id = DKWidget_GetAvailableId(id);
	
	var par = document.getElementById(parent);
	var ele = document.createElement(tag);
	ele.id = id;
	
	var node = par.parentNode;
	if(!node){
		DKLog("InsertBefore(): could not get parent of "+parent+"\n", DKERROR);
		return false;
	}
	
	node.insertBefore(ele, par);
	return id;
}

//////////////////////////////////////////////
function DKWidget_AppendChild(parent, element)
{
	var par;
	if(typeof parent == "string"){
		par = document.getElementById(parent);
	}
	else{
		par = parent;
	}
	var ele;
	if(typeof element == "string"){
		ele = document.getElementById(element);
	}
	else{
		ele = element;
	}
	par.appendChild(ele);
}

///////////////////////////////////////////////
function DKWidget_PrependChild(parent, element)
{
	var par;
	if(typeof parent == "string"){
		par = document.getElementById(parent);
	}
	else{
		par = parent;
	}
	var ele;
	if(typeof element == "string"){
		ele = document.getElementById(element);
	}
	else{
		ele = element;
	}
	
	if(!par){
		DKLog("PrependChild("+parent+", "+element+"): par invalid. \n", DKERROR);
		return false;
	}
	var first_child = par.firstChild;
	if(first_child){
		par.insertBefore(ele, first_child);
	}
	else{
		par.appendChild(ele);
	}
}

///////////////////////////////////////////////
function DKWidget_InsertBefore(parent, element)
{
	var par;
	if(typeof parent == "string"){
		par = document.getElementById(parent);
	}
	else{
		par = parent;
	}
	var ele;
	if(typeof element == "string"){
		ele = document.getElementById(element);
	}
	else{
		ele = element;
	}
	var node = par.parentNode;
	if(!node){
		DKLog("InsertBefore(): could not get parent of "+parent+"\n", DKERROR);
		return false;
	}
	
	node.insertBefore(ele, par);
}

///////////////////////////////
function DKWidget_GetParent(id)
{
	return document.getElementById(id).parentNode.id;
}

///////////////////////////////////
function DKWidget_GetFirstChild(id)
{
	var fc = document.getElementById(id).firstChild;
	if(fc){
		DKLog("GetFirstChild("+id+"): -> "+fc.id+"\n", DKDEBUG);
		return fc.id;
	}
	return false;
}

///////////////////////////////////////////
function DKWidget_GetMouseWindowX(element)
{
	return mouseX;
}

///////////////////////////////////////////
function DKWidget_GetMouseWindowY(element)
{
	return mouseY;
}

///////////////////////////////////////////
function DKWidget_GetMouseElementX(element)
{
	//TODO: calcualte mouse postition over element
	var left = DKWidget_GetProperty(element, "left");
	left = left.replace("px", "");
	return mouseX - Number(left);
}

///////////////////////////////////////////
function DKWidget_GetMouseElementY(element)
{
	//TODO: calcualte mouse postition over element
	var top = DKWidget_GetProperty(element, "top");
	top = top.replace("px", "");
	return mouseY - Number(top);
}

////////////////////////////////////////
function DKWidget_ElementExists(element)
{
	if(document.getElementById(element)){
		return true;
	}
	return false;
}

////////////////////////////////////////
function DKWidget_RemoveElement(element)
{
	//DKLog("RemoveElement("+element+") \n", DKDEBUG);
	var ele = document.getElementById(element);
	var par = ele.parentNode;
	if(ele && par){
		par.removeChild(ele);
		return true;
	}
	return false;
}

/////////////////////////////////////
function DKWidget_ElementToString(id)
{
	var element = document.getElementById(id);
	if(!element){ return false; }
	return element.outerHTML;
}

/////////////////////////////
function DKWidget_Visible(id)
{
	var element = document.getElementById(id);
	if(!element){ DKLog("Visible("+id+"): element invalid. \n", DKERROR); return false;}
	if(document.getElementById(id).style.display == "none"){ return false; }
	if(document.getElementById(id).style.visibility != "visible"){ return false; }
	return true;
}

/////////////////////////////////////////////
function DKWidget_RemoveAttribute(id, attrib)
{
	var element = document.getElementById(id);
	if(!element){ return false; }
	element.removeAttribute(attrib);
}

///////////////////////////////////
function DKWidget_GetHoverElement()
{ 
	//DKLog("DKWidget_GetHoverElement() = "+document.elementFromPoint(mouseX, mouseY).id+"\n");
	return document.elementFromPoint(mouseX, mouseY).id;
}

////////////////////////////
function DKWidget_GetScale()
{
	var scale = getComputedStyle(document.documentElement).fontSize;
	scale = scale.replace("px","");
	//DKLog("DKWidget_GetScale() = "+scale+"\n");
	return parseFloat(scale);
}

/////////////////////////////////
function DKWidget_SetScale(scale)
{
	//DKLog("DKWidget_SetScale("+scale+")\n");
	DKWidget_SetProperty("html", "font-size", scale+"px");
}

///////////////////////////////
function DKWidget_OpenLink(url)
{
	window.location = url;
}