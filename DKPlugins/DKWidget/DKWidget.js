//BROWSER

function DKWidget_GetFocusElement(){ DKLog("DKWidget_GetFocusElement(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
function DKWidget_ValidateColor(color){ DKLog("DKWidget_ValidateColor(): not available for "+DK_GetBrowser()+"\n", DKWARN); return color; }


/////////////////////////////////
function DKCreate(data, callback)
{
	//DKLog("DKCreate("+data+")\n");
	
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
		//DKLog("DKCreate("+data+"): requesting c++ plugin\n");
		if(DK_GetBrowser() == "CEF"){
			DKCreate_CPP(data);
		}
	}
	
	if(arry[0] == "DKJavascript"){
		LoadJs(arry[1], function(rval){
			if(callback){ 
				callback(rval); 
			}
			else{
				DKLog("DKCreate("+data+"): does not have a callback \n", DKERROR);
			}
		});
	}
	if(arry[0] == "DKWidget"){
		DKWidget_NewWidget(arry[1], arry[2]);
		//Mobile device minimum font-size fix
		//if(arry[1]){ 
		//	var filename = arry[1].replace(/^.*[\\\/]/, '');
		//	AdjustRems(filename);
		//}
		if(callback){
			callback();
		}
		else{
			//DKLog("DKCreate("+data+"): does not have a callback \n");
			//alert("DKCreate("+data+"): does not have a callback \n");
		}
	}
	if(arry[0] == "DKCss"){
		LoadCss(arry[1]);
		if(callback){
			callback();
		}
		else{
			//DKLog("DKCreate("+data+"): does not have a callback \n");
			//alert("DKCreate("+data+"): does not have a callback \n");
		}
	}

	return;
}

/*
//Mobile device minimum font-size fix
///////////////////////
function AdjustRems(id)
{
	//DKLog("AdjustRems("+id+")");
	var nodelist = document.getElementById(id).getElementsByTagName('*'); //NOTE: nodelist is read-only
	var elements = Array.prototype.slice.call(nodelist); //put nodelist into a writable array
	elements.unshift(document.getElementById(id)); //add the root element to the beginning of the array
	for(var i=0; i<elements.length; i++){
		//DKLog("\n");
		//DKLog(elements[i].id);
		for(var s=0; s<elements[i].style.length; s++){
			var style_name = elements[i].style[s];
			var style_value = elements[i].style[elements[i].style[s]];
			//DKLog(style_name+" : "+style_value);
			
			if(style_value.indexOf("rem") > -1){
				elements[i].style[elements[i].style[s]] = (parseFloat(style_value) / 10)+"rem";  //NOTE: 10 = scale factor
				//DKLog(style_name+" changed to:"+(parseFloat(style_value) / 10)+"rem");
			}
        }
	}	
}
*/

//////////////////////
function DKClose(data)
{
	//DKLog("DKClose("+data+")");
	
	if(!data){
		DKLog("DKClose("+data+"): data empty \n", DKERROR);
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
		DKLog("DKClose("+data+"): file invalid \n", DKERROR);
		return false; 
	}
	
	if(arry[0] == "DKJavascript"){
		var name = file.replace(".js", "");
		name += "_End";
		var func = window[name]; //End
		if(typeof func == 'function'){ 
			func(); // Call the jsclass_End() function
		}
		else{
			DKLog(name+" is not callable \n", DKWARN);
		}
		var script = document.getElementById(arry[1]);
		if(!script){
			//DKLog("DKClose("+data+"): "+arry[1]+" does not exist \n", DKWARN);
			return false;
		}
		script.parentNode.removeChild(script);
		//DKLog("Closed "+arry[1]+"\n");
	}
	if(arry[0] == "DKWidget"){
		var element = document.getElementById(arry[1]);
		if(!element){ 
			//DKLog("DKClose("+data+"): "+file+" does not exist \n", DKWARN);
			return false; 
		}
		element.parentNode.removeChild(element);
		//DKLog("Closed "+arry[1]+"\n");
	}
	if(arry[0] == "DKCss"){
		var css = document.getElementById(arry[1]);
		if(!css){ 
			//DKLog("DKClose("+data+"): "+arry[1]+" does not exist \n", DKERROR);
			return false; 
		}
		css.parentNode.removeChild(css);
		//DKLog("Closed "+arry[1]+"\n");
	}
	
	return true;
}

////////////////////////////////////////
function DKWidget_NewWidget(url, parent)
{
	//DKLog("DKWidget_NewWidget("+url+","+parent+")\n");
		
	var filename = url.replace(/^.*[\\\/]/, '');
	if(parent){
		//if(parent.indexOf(".html") == -1){ parent+=".html"; }
		var element = document.getElementById(parent);
		if(!element){ DKLog("DKWidget(): could not get parent ("+parent+") \n", DKERROR); return false; }
		LoadHtml(url, element);
		DKWidget_AttachDrags(filename); //Attach Drags
	}
	else{
		LoadHtml(url);
		DKWidget_AttachDrags(filename); //Attach Drags
	}
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
	//DKLog("GetAvailableId("+id+")-> "+out+"\n");
}

/////////////////////////////
function DKWidget_GetFile(id)
{
	return id;
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
		
		if(x.getAttribute("drag") != null){ 	//Drag events
			var mov_tar = x.getAttribute("drag");	
			x.onmousedown = function(event){DragStart(event, mov_tar);}
		}
		if(x.getAttribute("resize") != null){ 	//Resize events
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
	element.onmousedown = function(event){ DragStart(event, drag);}
	return true;
}

/////////////////////////////////////////////
function DKWidget_AddResizeHandle(id, resize)
{
	var element = document.getElementById(id);
	if(!DK_IE()){
		element.style.setProperty("pointer-events","all");
	}
	element.onmousedown = function(event){ ResizeStart(event, resize); }
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
	
	//var nodes = document.getElementById(id).getElementsByTagName('*'); //all children recursively
	var nodes = document.getElementById(id).childNodes;
	for(var i=0; i<nodes.length; i++){
		if(nodes[i].id){
			string += nodes[i].id;
			string += ",";
		}
	}
	//DKLog("GetElements("+id+"): -> "+string+" \n");
	return string;
}

////////////////////////////////////
function DKWidget_GetValue(variable)
{
	//DKLog("DKWidget_GetValue("+variable+") \n");
	if(!variable){ DKLog("variable empty \n"); return; }

	if(typeof variable === "string"){ //id
		//DKLog("GetValue("+variable+") -> typeof variable === string\n");
		var ele = document.getElementById(variable);
		if(!ele){ DKLog("DKWidget_GetValue("+variable+"): Cannot find element. \n"); /*return false;*/ }
		if(ele){
			if(ele.type && ele.type === "checkbox"){
				return ele.checked;
			}
			if(!ele.value){
				//DKLog("DKWidget_GetValue("+variable+"): Could not get value. \n", DKERROR);
				return false;
			}
			//DKLog("DKWidget_GetValue("+variable+") -> "+ele.value+"\n");
			return ele.value; 
		}
		
		DKLog("DKWidget_GetValue("+variable+"): Could not get value. \n", DKERROR);
		return false;
	}
	
	if(typeof variable === "object"){
		//DKLog("DKWidget_GetValue("+variable+") -> typeof variable === object\n");
		//DKLog("DKWidget_GetValue("+variable+") -> variable.nodeType == "+variable.nodeType+"\n");
		//DKLog("DKWidget_GetValue("+variable+") -> variable.tagName == "+variable.tagName+"\n");
		//DKLog("DKWidget_GetValue("+variable+") -> variable.type == "+variable.type+"\n");
		if(variable.nodeType == 1){
			//DKLog("variable.tagName: "+variable.tagName+"\n");
			if(variable.tagName == "INPUT"){
				//DKLog("DKWidget_GetValue("+variable+") -> "+variable.value+"\n");
				return variable.value;
			}
			return DKWidget_GetInnerHtml(variable);
		}
		if(variable.type){ //event
			//DKLog("GetValue("+variable+") -> variable.type == true\n");
			//DKLog("GetValue("+variable+") -> "+variable.type+"\n");
			if(variable.type == "mousedown"){
				return GetMouseButton(variable);
			}
			if(variable.type == "mouseup"){
				return GetMouseButton(variable);
			}
			if(variable.type == "click"){
				if(variable.target && variable.target.value){
					return variable.target.value;
				}
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
			//DKLog("DKWidget_GetValue("+variable+") -> "+ele.value+"\n");
			return ele.value;
		}
		else{ //element or other object
			if(variable.value){
				//DKLog("DKWidget_GetValue("+variable+") -> "+variable.value+"\n");
				return variable.value;
			}
			//DKLog("DKWidget_GetValue("+variable+") -> "+variable[2]+"\n");
			return variable[2];
		}
	}
	
	DKLog("ERROR: DKWidget_GetValue(): unknown type", DKERROR);
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
	if(!variable){
		DKLog("DKWidget_GetAttribute(): veriable empty\n", DKWARN);
		return "";
	}
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
	if(!variable){ DKLog("DKWidget_SetAttribute(): variable not set \n", DKERROR); return false; }
	if(!value){ DKLog("DKWidget_SetAttribute(): value not set \n", DKWARN); return false; }
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
	//DKLog("DKWidget_GetProperty("+variable+","+parameter+") \n");
	if(!variable){ return ""; }
	if(!parameter){ return ""; }
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
		//if(!element.hasOwnProperty(parameter)){
			//DKLog("DKWidget_GetProperty(): parameter is null \n", DKWARN);
			//return false; 
		//}
		return element.style[parameter];
	}
	DKLog("ERROR: GetProperty(): unknown type", DKERROR);
	return false;
}

/////////////////////////////////////////////////////////
function DKWidget_SetProperty(variable, parameter, value)
{
	//DKLog("DKWidget_SetProperty("+variable+", "+parameter+", "+value+")\n");
	
	if(!variable){ //FIXME: who called you?
		DKLog("DKWidget_SetProperty("+variable+", "+parameter+", "+value+"): variable not set \n", DKERROR);
		return false; 
	}
	if(!parameter){
		DKLog("DKWidget_SetProperty("+variable+", "+parameter+", "+value+"): parameter not set \n", DKERROR);
		return false; 
	}
	if(!value){
		DKLog("DKWidget_SetProperty("+variable+", "+parameter+", "+value+"): value not set \n", DKWARN);
		return false; 
	} 
	
	if(parameter == "background-color"){ parameter = "backgroundColor"; } //IE 8- fix
	//DKLog("DK_IE() = "+DK_IE()+"\n");
	if(DK_IE() && DK_IE() < 9){
		value = value.replace("rem", "px"); //IE 8- fix
	}

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

		element.style[parameter] = value; //FIXME: how to deal with failure here? (IE8)
		return true;
	}
	DKLog("ERROR: SetProperty(): unknown type", DKERROR);
	return false;
}

////////////////////////////////////////////
function DKWidget_HasProperty(id, parameter)
{
	if(document.getElementById(id).style[parameter]){
		return true;
	}
	return false;
}

///////////////////////////////////////////////
function DKWidget_RemoveProperty(id, parameter)
{
	//DKLog("DKWidget_RemoveProperty("+id+","+parameter+") \n");
	var element = document.getElementById(id);
	if(!element){ 
		DKLog("DKWidget_RemoveProperty(): element invalid. \n");
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
		if(element.type && element.type === "checkbox"){
			element.checked = value;
			return true;
		}
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
	if(!id){ DKLog("DKWidget_GetInnerHtmlString(): empty id\n", DKWARN); return "";}
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

///////////////////////////////////////
function DKWidget_IsChildOf(id, parent)
{
	//DKLog("DKWidget_IsChildOf("+id+", "+parent+") \n");
	if(!id){return false;}
	if(!parent){return false;}
	var ele = document.getElementById(id);
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
	//DKLog("DKWidget_CreateElement("+parent+", "+tag+", "+id+") \n");
	
	id = DKWidget_GetAvailableId(id);
	
	var par = document.getElementById(parent);
	if(!par){ DKLog("CreateElement(): parent invalid ("+parent+") \n", DKERROR); return false;}
	var ele = document.createElement(tag);
	if(!ele){ DKLog("CreateElement(): ele invalid ("+tag+") \n", DKERROR); return false;}
	ele.id = id;
	
	//DKLog("DKWidget_CreateElement(): par = "+par+"\n");
	//DKLog("DKWidget_CreateElement(): ele = "+ele+"\n");
	par.appendChild(ele); //This is not working on IE
	
	//DKLog("DKWidget_CreateElement(parent, tag, id): return = "+id+"\n");
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
	//DKLog("DKWidget_PrependChild("+parent+","+element+")\n");
	
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
	if(!document.getElementById(id)){ return ""; }
	return document.getElementById(id).parentNode.id;
}

///////////////////////////////////
function DKWidget_GetFirstChild(id)
{
	var fc = document.getElementById(id).firstChild;
	if(fc){
		//DKLog("GetFirstChild("+id+"): -> "+fc.id+"\n");
		return fc.id;
	}
	return false;
}

/////////////////////////////////////
function DKWidget_GetMouseWindowX(id)
{
	return mouseX;
}

/////////////////////////////////////
function DKWidget_GetMouseWindowY(id)
{
	return mouseY;
}

//////////////////////////////////////
function DKWidget_GetMouseElementX(id)
{
	//DKLog("DKWidget_GetMouseElementX("+id+")\n");
	if(!id){ id = "body"; }
	/*
	var ele = document.getElementById(id);
	var left = ele.offsetLeft;
	while((ele=ele.offsetParent) != null){ 
		left += ele.offsetLeft; 
	}
	*/
	//DKLog("DKWidget_GetMouseElementX("+element+"): left = "+left+"\n");
	return mouseX - DKWidget_GetOffsetLeft(id);//parseInt(left);
}

///////////////////////////////////////////
function DKWidget_GetMouseElementY(id)
{
	//DKLog("DKWidget_GetMouseElementY("+id+")\n");
	if(!id){ id = "body"; }
	/*
	var ele = document.getElementById(element);
	var top = ele.offsetTop;
	while((ele=ele.offsetParent) != null){ 
		top += ele.offsetTop; 
	}
	*/
	//DKLog("DKWidget_GetMouseElementX("+element+"): top = "+top+"\n");
	return mouseY - DKWidget_GetOffsetTop(id);//parseInt(top);
}

//////////////////////////////////////
function DKWidget_GetClientWidth(id)
{
	return document.getElementById(id).clientWidth;
		
}

///////////////////////////////////////
function DKWidget_GetClientHeight(id)
{
	return document.getElementById(id).clientHeight;
}

//////////////////////////////////
function DKWidget_GetOffsetTop(id)
{
	var ele = document.getElementById(id);
	var top = ele.offsetTop;
	while((ele=ele.offsetParent) != null){ 
		top += ele.offsetTop; 
	}
	//DKLog("DKWidget_GetOffsetTop("+id+") = "+top+"\n");
	return parseInt(top);
}

//////////////////////////////////
function DKWidget_GetOffsetLeft(id)
{
	var ele = document.getElementById(id);
	var left = ele.offsetLeft;
	while((ele=ele.offsetParent) != null){ 
		left += ele.offsetLeft; 
	}
	return parseInt(left);
}

////////////////////////////////////
function DKWidget_GetOffsetRight(id)
{
	var ele = document.getElementById(id);
	var right = ele.offsetRight;
	while((ele=ele.offsetParent) != null){ 
		right += ele.offsetRight; 
	}
	//DKLog("DKWidget_GetOffsetTop("+id+") = "+top+"\n");
	return parseInt(right);
}

/////////////////////////////////////
function DKWidget_GetOffsetBottom(id)
{
	var ele = document.getElementById(id);
	var bottom = ele.offsetRight;
	while((ele=ele.offsetParent) != null){ 
		bottom += ele.offsetBottom; 
	}
	//DKLog("DKWidget_GetOffsetTop("+id+") = "+top+"\n");
	return parseInt(bottom);
}

////////////////////////////////////
function DKWidget_GetOffsetWidth(id)
{
	return document.getElementById(id).offsetWidth;
}

/////////////////////////////////////
function DKWidget_GetOffsetHeight(id)
{
	return document.getElementById(id).offsetHeight;
}

////////////////////////////////////
function DKWidget_GetComputedTop(id)
{
	return window.getComputedStyle(document.getElementById(id)).top;
}

///////////////////////////////////
function DKWidget_ElementExists(id)
{
	if(document.getElementById(id)){
		return true;
	}
	return false;
}

///////////////////////////////////
function DKWidget_RemoveElement(id)
{
	//DKLog("RemoveElement("+id+")\n");
	var ele = document.getElementById(id);
	if(!ele){
		DKLog("RemoveElement("+id+"): element does not exist\n");
		return false;
	}
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
	if(!element){ return false; }
	if(element.style.display == "none"){ return false; }
	if(element.style.visibility != "visible"){ return false; }
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

///////////////////////////////////////
function DKWidget_OpenLink(url, target)
{
	//DKLog("DKWidget_OpenLink("+url+","+target+")\n");
	//window.location = url;
	window.open(url, target);
}

///////////////////////////////////
function DKWidget_SetFile(id, file)
{ 
	DKLog("DKWidget_SetFile(): not available for "+DK_GetBrowser()+"\n", DKWARN); 
	return;
	
	//TODO
	if(!id){ DKLog("DKWidget_SetFile(): id empty", DKWARN); return; }
	while(id.indexOf(".html") == -1 && id.indexOf("body") == -1){
		id = DKWidget_GetParent(id);
	}
	
	/*  C++
	std::vector<DKWidget*> instances;
	DKWidget::GetInstances(instances);
	for(unsigned int i=0; i<instances.size(); ++i){
		if(same(instances[i]->root->GetId().CString(), id)){
			instances[i]->data[1] = file;
		}
	}
	*/
}