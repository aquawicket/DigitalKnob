console.log("Loading DKWidget.js");

function DKWidget_GetFocusElement(){ DKWARN("DKWidget_GetFocusElement(): not available for "+DK_GetBrowser()+"\n"); }
function DKWidget_ValidateColor(color){ DKWARN("DKWidget_ValidateColor(): not available for "+DK_GetBrowser()+"\n"); return color; }


/*
//Mobile device minimum font-size fix
///////////////////////
function AdjustRems(id)
{
	DKDEBUGFUNC();
	var nodelist = document.getElementById(id).getElementsByTagName('*'); //NOTE: nodelist is read-only
	var elements = Array.prototype.slice.call(nodelist); //put nodelist into a writable array
	elements.unshift(document.getElementById(id)); //add the root element to the beginning of the array
	for(var i=0; i<elements.length; i++){
		//DKINFO("\n");
		//DKINFO(elements[i].id+"\n");
		for(var s=0; s<elements[i].style.length; s++){
			var style_name = elements[i].style[s];
			var style_value = elements[i].style[elements[i].style[s]];
			//DKINFO(style_name+" : "+style_value+"\n");
			
			if(style_value.indexOf("rem") > -1){
				elements[i].style[elements[i].style[s]] = (parseFloat(style_value) / 10)+"rem";  //NOTE: 10 = scale factor
				//DKINFO(style_name+" changed to:"+(parseFloat(style_value) / 10)+"rem"+"\n");
			}
        }
	}	
}
*/


////////////////////////////////////////
function DKWidget_NewWidget(url, parent)
{
	DKDEBUGFUNC(url, parent);
	console.log("DKWidget_NewWidget("+url+","+parent+")");
	var filename = url.replace(/^.*[\\\/]/, '');
	if(parent){
		//if(parent.indexOf(".html") == -1){ parent+=".html"; }
		var element = document.getElementById(parent);
		if(!element){ DKERROR("DKWidget(): could not get parent ("+parent+")\n"); return false; }
		if(!LoadHtml(url, element)){ 
			return false;
		}
		//DKWidget_AttachDrags(filename); //Attach Drags
	}
	else{
		if(!LoadHtml(url)){
			return false;
		}
		//DKWidget_AttachDrags(filename); //Attach Drags
	}
	
	return true;
}

////////////////////////////////////
function DKWidget_GetAvailableId(id)
{
	DKDEBUGFUNC(id);
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
	//DKINFO("GetAvailableId("+id+")-> "+out+"\n");
}

/////////////////////////////
function DKWidget_GetFile(id)
{
	DKDEBUGFUNC(id);
	return id;
}

//////////////////////////
function DKWidget_Hide(id)
{
	DKDEBUGFUNC(id);
	var element = document.getElementById(id);
	if(!element){ return false; }
	element.style.display = "none";
}

//////////////////////////
function DKWidget_Show(id)
{
	DKDEBUGFUNC(id);
	var element = document.getElementById(id);
	if(!element){ return false; }
	element.style.display = "block";
	element.style.visibility = "visible";
}

////////////////////////////
function DKWidget_Toggle(id)
{
	DKDEBUGFUNC(id);
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
	DKDEBUGFUNC(id);
	var parent = document.getElementById(id);
	if(!parent){ return false; }
	var elements = parent.getElementsByTagName('*');
	for (var i=0; i<elements.length; i++) {	
		var x = elements[i];
		
		if(!DK_IE() && DK_GetBrowser() != "RML"){
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
	DKDEBUGFUNC(id, drag);
	var element = document.getElementById(id);
	if(!DK_IE() && DK_GetBrowser() != "RML"){
		element.style.setProperty("pointer-events","all");
	}
	element.onmousedown = function(event){ DragStart(event, drag);}
	element.addEventListener('touchstart', function(event){ DragStart(event, drag);}, false);
	return true;
}

/////////////////////////////////////////////
function DKWidget_AddResizeHandle(id, resize)
{
	DKDEBUGFUNC(id, resize);
	var element = document.getElementById(id);
	if(!DK_IE() && DK_GetBrowser() != "RML"){
		element.style.setProperty("pointer-events","all");
	}
	element.onmousedown = function(event){ ResizeStart(event, resize); }
	element.addEventListener('touchstart', function(event){ ResizeStart(event, resize); }, false);
	return true;
}

//////////////////////////////////////
function DKWidget_RemoveDragHandle(id)
{
	DKDEBUGFUNC(id);
	if(!id){ return; }
	var element = document.getElementById(id);
	if(!DK_IE()){
		//element.style.setProperty("pointer-events","none");
	}
	element.onmousedown = 0;
	//element.removeEventListener('touchstart', function(event){ DragStart(event, drag);});
}

///////////////////////////////////
function DKWidget_GetElement(event)
{
	DKDEBUGFUNC(event);
	if(!event){event = window.event;}
	return (event.currentTarget) ? event.currentTarget : event.srcElement; //IE or other
}

/////////////////////////////////
function DKWidget_GetElements(id)
{
	DKDEBUGFUNC(id);
	var string = "";
	//var nodes = document.getElementById(id).getElementsByTagName('*'); //all children recursively
	var nodes = document.getElementById(id).childNodes;
	for(var i=0; i<nodes.length; i++){
		if(nodes[i].id){
			string += nodes[i].id;
			string += ",";
		}
	}
	//DKINFO("GetElements("+id+"): -> "+string+"\n");
	return string;
}

////////////////////////////////////
function DKWidget_GetValue(variable)
{
	DKDEBUGFUNC(variable);
	if(!variable){ DKINFO("variable empty\n"); return; }

	if(typeof variable === "string"){ //id
		//DKINFO("GetValue("+variable+") -> typeof variable === string\n");
		var ele = document.getElementById(variable);
		if(!ele){ DKINFO("DKWidget_GetValue("+variable+"): Cannot find element\n"); /*return false;*/ }
		if(ele){
			if(ele.type && ele.type === "checkbox"){
				return ele.checked;
			}
			if(!ele.value){
				//DKERROR("DKWidget_GetValue("+variable+"): Could not get value\n");
				return false;
			}
			//DKINFO("DKWidget_GetValue("+variable+") -> "+ele.value+"\n");
			return ele.value; 
		}
		
		DKERROR("DKWidget_GetValue("+variable+"): Could not get value\n");
		return false;
	}
	
	if(typeof variable === "object"){
		//DKINFO("DKWidget_GetValue("+variable+") -> typeof variable === object\n");
		//DKINFO("DKWidget_GetValue("+variable+") -> variable.nodeType == "+variable.nodeType+"\n");
		//DKINFO("DKWidget_GetValue("+variable+") -> variable.tagName == "+variable.tagName+"\n");
		//DKINFO("DKWidget_GetValue("+variable+") -> variable.type == "+variable.type+"\n");
		if(variable.nodeType == 1){
			//DKINFO("variable.tagName: "+variable.tagName+"\n");
			if(variable.tagName == "INPUT"){
				//DKINFO("DKWidget_GetValue("+variable+") -> "+variable.value+"\n");
				return variable.value;
			}
			return DKWidget_GetInnerHtml(variable);
		}
		if(variable.type){ //event
			//DKINFO("GetValue("+variable+") -> variable.type == true\n");
			//DKINFO("GetValue("+variable+") -> "+variable.type+"\n");
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
			//DKINFO("DKWidget_GetValue("+variable+") -> "+ele.value+"\n");
			return ele.value;
		}
		else{ //element or other object
			if(variable.value){
				//DKINFO("DKWidget_GetValue("+variable+") -> "+variable.value+"\n");
				return variable.value;
			}
			//DKINFO("DKWidget_GetValue("+variable+") -> "+variable[2]+"\n");
			return variable[2];
		}
	}
	
	DKERROR("ERROR: DKWidget_GetValue(): unknown type\n");
	return false;
}

////////////////////////////////
function DKWidget_GetTagName(id)
{
	DKDEBUGFUNC(id);
	var element = document.getElementById(id);
	if(!element){ return false; }
	return element.tag;
}

///////////////////////////////////////////////////
function DKWidget_GetAttribute(variable, parameter)
{
	DKDEBUGFUNC(variable, parameter);
	if(!variable){
		DKWARN("DKWidget_GetAttribute(): veriable empty\n");
		return "";
	}
	if(typeof variable == "object"){
		return variable[parameter];
	}
	if(typeof variable == "string"){
		var element = document.getElementById(variable);
		return element[parameter];
	}
	DKERROR("ERROR: GetAttribute(): unknown type\n");
	return false;
}

//////////////////////////////////////////////////////////
function DKWidget_SetAttribute(variable, parameter, value)
{
	DKDEBUGFUNC(variable, parameter, value);
	if(!variable){ DKERROR("DKWidget_SetAttribute(): variable not set\n"); return false; }
	//if(!value){ DKWARN("DKWidget_SetAttribute(): value not set\n"); return false; }
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
			DKERROR("DKWidget_SetAttribute(): element invalid\n");
			return false;
		}
		if(parameter == "class"){
			element.className = value;
		}
		else{
			//element[parameter] = value;
			element.setAttribute(parameter, value);
		}
		return true;
	}
	DKERROR("DKWidget_SetAttribute(): unknown type\n");
	return false;
}

//////////////////////////////////////////////////
function DKWidget_GetProperty(variable, parameter)
{
	DKDEBUGFUNC(variable, parameter);
	//DKWARN("DKWidget_GetProperty("+variable+","+parameter+")");
	if(!variable){ return ""; }
	if(!parameter){ return ""; }
	if(parameter == "background-color"){ parameter = "backgroundColor"; }

	if(typeof variable == "object"){
		return variable.style[parameter];
	}
	if(typeof variable == "string"){
		var element = document.getElementById(variable);
		if(!element){
			DKERROR("DKWidget_GetProperty(): element is null\n");
			return;
		}
		//if(!element.hasOwnProperty(parameter)){
			//DKWARN("DKWidget_GetProperty(): parameter is null\n");
			//return false; 
		//}
		return element.style[parameter];
	}
	DKERROR("ERROR: GetProperty(): unknown type\n");
	return false;
}

/////////////////////////////////////////////////////////
function DKWidget_SetProperty(variable, parameter, value)
{
	DKDEBUGFUNC(variable, parameter, value);
	//console.log("DKWidget_SetProperty("+variable+", "+parameter+", "+value+")");
	if(!variable){ //FIXME: who called you?
		DKERROR("DKWidget_SetProperty("+variable+", "+parameter+", "+value+"): variable not set\n");
		return false; 
	}
	if(!parameter){
		DKERROR("DKWidget_SetProperty("+variable+", "+parameter+", "+value+"): parameter not set\n");
		return false; 
	}
	if(!value){
		DKERROR("DKWidget_SetProperty("+variable+", "+parameter+", "+value+"): value not set\n");
		return false; 
	} 
	
	if(parameter == "background-color"){ parameter = "backgroundColor"; } //IE 8- fix
	//DKINFO("DK_IE() = "+DK_IE()+"\n");
	if(DK_IE() && DK_IE() < 9){
		value = value.replace("rem", "px"); //IE 8- fix
	}

	if(typeof variable == "object"){
		variable.style[parameter] = value;
		return true;
	}
	if(typeof variable == "string"){
		var element = document.getElementById(variable);
		if(variable == "body"){ element = document.body; }
		if(!element){ 
			DKERROR("ERROR: SetProperty(): element("+variable+") invalid\n");
			return false;
		}

		element.style[parameter] = value; //FIXME: how to deal with failure here? (IE8)
		return true;
	}
	DKERROR("ERROR: SetProperty(): unknown type\n");
	return false;
}

////////////////////////////////////////////
function DKWidget_HasProperty(id, parameter)
{
	DKDEBUGFUNC(id, parameter);
	if(document.getElementById(id).style[parameter]){
		return true;
	}
	return false;
}

///////////////////////////////////////////////
function DKWidget_RemoveProperty(id, parameter)
{
	DKDEBUGFUNC(id, parameter);
	var element = document.getElementById(id);
	if(!element){ 
		DKERROR("DKWidget_RemoveProperty(): element invalid\n");
		return; 
	}
	if(element.style[parameter]){
		element.style[parameter] = null;
	}
}

///////////////////////////////////////////
function DKWidget_SetValue(variable, value)
{
	DKDEBUGFUNC(variable, value);
	if(!variable){ return false; }
	//if(!value){ value = ""; } //FIXME - sould be if(value == emptystring) so 0's can pass through
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
		if(!element){ DKERROR("SetValue("+variable+"): Cannot find element\n"); return false; }
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
	DKERROR("ERROR: SetValue(): unknown type\n");
	return false;
}

////////////////////////////////////////
function DKWidget_GetInnerHtml(variable)
{
	DKDEBUGFUNC(variable);
	if(typeof variable == "object"){
		return variable.innerHTML;
	}
	if(typeof variable == "string"){
		var element = document.getElementById(variable);
		return element.innerHTML;
	}
	DKERROR("ERROR: GetInnerHtml(): unknown type\n");
	return false;
}

///////////////////////////////////////////////
function DKWidget_SetInnerHtml(variable, value)
{
	DKDEBUGFUNC(variable, value);
	if(typeof variable == "object"){
		variable.innerHTML = value;
		return true;
	}
	if(typeof variable == "string"){
		var element = document.getElementById(variable);
		if(!element){ 
			DKERROR("ERROR: SetInnerHtml(): element invalid\n");
			return false; 
		}
		element.innerHTML = value;
		return true;
	}
	DKERROR("ERROR: SetInnerHtml(): unknown type\n");
	return false;
}

////////////////////////////////////////
function DKWidget_GetInnerHtmlString(id)
{
	DKDEBUGFUNC(id);
	if(!id){ DKWARN("DKWidget_GetInnerHtmlString(): empty id\n"); return "";}
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
	DKDEBUGFUNC(id, string);
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
	DKDEBUGFUNC(variable);
	if(typeof variable == "object"){
		return variable.outerHTML;
	}
	if(typeof variable == "string"){
		var element = document.getElementById(variable);
		return element.outerHTML;
	}
	DKERROR("ERROR: GetInnerHtml(): unknown type\n");
	return false;
}

///////////////////////////////////////
function DKWidget_IsChildOf(id, parent)
{
	DKDEBUGFUNC(id, parent);
	if(!id){return false;}
	if(!parent){return false;}
	var ele = document.getElementById(id);
	var par = document.getElementById(parent);
	if(!ele){return false;}
	if(!par){return false;}
	
	while(ele && (ele.id != par.id)){
		//console.log("ele.id: "+ele.id+" par.id:"+par.id);
		if(ele.id == "body"){ return false; }
		ele = ele.parentNode;
	}
	
	if(ele.id == par.id){
		//console.log("ele: " +ele);
		//console.log("par: " +par);
		//console.log("DKWidget_IsChildOf(): returned true");
		return true;
	}
	
	return false;
}

////////////////////////////////////////////////
function DKWidget_CreateElement(parent, tag, id)
{
	DKDEBUGFUNC(parent, tag, id);
	if(tag == "handle"){ return ""; } //we don't make handles for browsers
	console.log("DKWidget_CreateElement("+parent+", "+tag+", "+id+")");
	
	id = DKWidget_GetAvailableId(id);
	
	var par = document.getElementById(parent);
	if(!par){ DKERROR("DKWidget_CreateElement(): parent invalid ("+parent+")\n"); return false;}
	var ele = document.createElement(tag);
	if(!ele){ DKERROR("DKWidget_CreateElement(): ele invalid ("+tag+")\n"); return false;}
	//ele.id = id;
	ele.setAttribute("id", id);
	
	//DKINFO("DKWidget_CreateElement(): par = "+par+"\n");
	//DKINFO("DKWidget_CreateElement(): ele = "+ele+"\n");
	par.appendChild(ele); //This is not working on IE
	
	//DKINFO("DKWidget_CreateElement(parent, tag, id): return = "+id+"\n");
	return id;
}

//////////////////////////////////////////////////////
function DKWidget_CreateElementBefore(parent, tag, id)
{
	DKDEBUGFUNC(parent, tag, id);
	id = DKWidget_GetAvailableId(id);
	var par = document.getElementById(parent);
	var ele = document.createElement(tag);
	ele.id = id;
	
	var node = par.parentNode;
	if(!node){
		DKERROR("InsertBefore(): could not get parent of "+parent+"\n");
		return false;
	}
	
	node.insertBefore(ele, par);
	return id;
}

//////////////////////////////////////////////
function DKWidget_AppendChild(parent, element)
{
	DKDEBUGFUNC(parent, element);
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
	DKDEBUGFUNC(parent, element);
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
		DKERROR("PrependChild("+parent+", "+element+"): par invalid\n");
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
	DKDEBUGFUNC(parent, element);
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
		DKERROR("InsertBefore(): could not get parent of "+parent+"\n");
		return false;
	}
	
	node.insertBefore(ele, par);
}

///////////////////////////////
function DKWidget_GetParent(id)
{
	DKDEBUGFUNC(id);
	if(!document.getElementById(id)){ return ""; }
	return document.getElementById(id).parentNode.id;
}

///////////////////////////////////
function DKWidget_GetFirstChild(id)
{
	DKDEBUGFUNC(id);
	var fc = document.getElementById(id).firstChild;
	if(fc){
		//DKINFO("GetFirstChild("+id+"): -> "+fc.id+"\n");
		return fc.id;
	}
	return false;
}

/////////////////////////////////////
function DKWidget_GetMouseWindowX(id)
{
	DKDEBUGFUNC(id);
	return mouseX;
}

/////////////////////////////////////
function DKWidget_GetMouseWindowY(id)
{
	DKDEBUGFUNC(id);
	return mouseY;
}

//////////////////////////////////////
function DKWidget_GetMouseElementX(id)
{
	DKDEBUGFUNC(id);
	if(!id){ id = "body"; }
	/*
	var ele = document.getElementById(id);
	var left = ele.offsetLeft;
	while((ele=ele.offsetParent) != null){ 
		left += ele.offsetLeft; 
	}
	*/
	//DKINFO("DKWidget_GetMouseElementX("+element+"): left = "+left+"\n");
	return mouseX - DKWidget_GetOffsetLeft(id);//parseInt(left);
}

///////////////////////////////////////////
function DKWidget_GetMouseElementY(id)
{
	DKDEBUGFUNC(id);
	if(!id){ id = "body"; }
	/*
	var ele = document.getElementById(element);
	var top = ele.offsetTop;
	while((ele=ele.offsetParent) != null){ 
		top += ele.offsetTop; 
	}
	*/
	//DKINFO("DKWidget_GetMouseElementX("+element+"): top = "+top+"\n");
	return mouseY - DKWidget_GetOffsetTop(id);//parseInt(top);
}

//////////////////////////////////////
function DKWidget_GetClientWidth(id)
{
	DKDEBUGFUNC(id);
	return document.getElementById(id).clientWidth;
}

///////////////////////////////////////
function DKWidget_GetClientHeight(id)
{
	DKDEBUGFUNC(id);
	return document.getElementById(id).clientHeight;
}

//////////////////////////////////
function DKWidget_GetOffsetTop(id)
{
	DKDEBUGFUNC(id);
	var ele = document.getElementById(id);
	var top = ele.offsetTop;
	while((ele=ele.offsetParent) != null){ 
		top += ele.offsetTop; 
	}
	//DKINFO("DKWidget_GetOffsetTop("+id+") = "+top+"\n");
	return parseInt(top);
}

//////////////////////////////////
function DKWidget_GetOffsetLeft(id)
{
	DKDEBUGFUNC(id);
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
	DKDEBUGFUNC(id);
	var ele = document.getElementById(id);
	var right = ele.offsetRight;
	while((ele=ele.offsetParent) != null){ 
		right += ele.offsetRight; 
	}
	//DKINFO("DKWidget_GetOffsetRight("+id+") = "+top+"\n");
	return parseInt(right);
}

/////////////////////////////////////
function DKWidget_GetOffsetBottom(id)
{
	DKDEBUGFUNC(id);
	var ele = document.getElementById(id);
	var bottom = ele.offsetRight;
	while((ele=ele.offsetParent) != null){ 
		bottom += ele.offsetBottom; 
	}
	//DKINFO("DKWidget_GetOffsetBottom("+id+") = "+top+"\n");
	return parseInt(bottom);
}

////////////////////////////////////
function DKWidget_GetOffsetWidth(id)
{
	DKDEBUGFUNC(id);
	return document.getElementById(id).offsetWidth;
}

/////////////////////////////////////
function DKWidget_GetOffsetHeight(id)
{
	DKDEBUGFUNC(id);
	return document.getElementById(id).offsetHeight;
}

////////////////////////////////////
function DKWidget_GetComputedTop(id)
{
	DKDEBUGFUNC(id);
	return window.getComputedStyle(document.getElementById(id)).top;
}

///////////////////////////////////
function DKWidget_ElementExists(id)
{
	DKDEBUGFUNC(id);
	if(document.getElementById(id)){
		return true;
	}
	return false;
}

///////////////////////////////////
function DKWidget_RemoveElement(id)
{
	DKDEBUGFUNC(id);
	var ele = document.getElementById(id);
	if(!ele){
		DKWARN("RemoveElement("+id+"): element does not exist\n");
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
	DKDEBUGFUNC(id);
	var element = document.getElementById(id);
	if(!element){ return false; }
	return element.outerHTML;
}

/////////////////////////////
function DKWidget_Visible(id)
{
	DKDEBUGFUNC(id);
	var element = document.getElementById(id);
	if(!element){ return false; }
	if(element.style.display == "none"){ return false; }
	if(element.style.visibility != "visible"){ return false; }
	return true;
}

/////////////////////////////////////////////
function DKWidget_RemoveAttribute(id, attrib)
{
	DKDEBUGFUNC(id, attrib);
	var element = document.getElementById(id);
	if(!element){ return false; }
	element.removeAttribute(attrib);
}

///////////////////////////////////
function DKWidget_GetHoverElement()
{ 
	DKDEBUGFUNC();
	//DKINFO("DKWidget_GetHoverElement() = "+document.elementFromPoint(mouseX, mouseY).id+"\n");
	return document.elementFromPoint(mouseX, mouseY).id;
}

////////////////////////////
function DKWidget_GetScale()
{
	DKDEBUGFUNC();
	//var scale = getComputedStyle(document.documentElement).fontSize;
	var scale = document.documentElement.style.fontSize;
	console.log(scale);
	scale = scale.replace("px","");
	//DKINFO("DKWidget_GetScale() = "+scale+"\n");
	return parseFloat(scale);
}

/////////////////////////////////
function DKWidget_SetScale(scale)
{
	DKDEBUGFUNC(scale);
	document.documentElement.style.fontSize = scale+"px";
}

///////////////////////////////////////
function DKWidget_OpenLink(url, target)
{
	DKDEBUGFUNC(url, target);
	//window.location = url;
	window.open(url, target);
}

///////////////////////////////////
function DKWidget_SetFile(id, file)
{ 
	DKDEBUGFUNC(id, file);
	DKWARN("DKWidget_SetFile(): not available for "+DK_GetBrowser()+"\n"); 
	return;
	
	//TODO
	if(!id){ DKWARN("DKWidget_SetFile(): id empty\n"); return; }
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

//////////////////////////////////
function DKWidget_GetLastChild(id)
{
	DKDEBUGFUNC(id);
	return document.getElementById("body").lastChild.id;
}

//////////////////////////////
function DKWidget_SetFocus(id)
{
	DKDEBUGFUNC(id);
	console.log("DKWidget_SetFocus("+id+")");
	var element = document.getElementById(id);
	console.log("DKWidget_SetFocus("+id+"): element = "+element);
	element.focus();
}


/////////////////////////
function DKWidget_Cut(id)
{
	DKDEBUGFUNC(id);
	var text = "";
    if(window.getSelection){
        text = window.getSelection().toString();
    } 
	else if(document.selection && document.selection.type != "Control"){
        text = document.selection.createRange().text;
    }
	//DKINFO("DKWidget_Cut("+id+"): text = "+text+"\n");
	copyToClipboard(text);
	removeSelection(id);
}

//////////////////////////
function DKWidget_Copy(id)
{
	DKDEBUGFUNC(id);
	var text = "";
    if(window.getSelection){
        text = window.getSelection().toString();
    } 
	else if(document.selection && document.selection.type != "Control"){
        text = document.selection.createRange().text;
    }
	
	//DKINFO("DKWidget_Cut("+id+"): text = "+text+"\n");
	copyToClipboard(text);
}

///////////////////////////
function DKWidget_Paste(id)
{
	DKDEBUGFUNC(id);
	//TODO
	removeSelection(id);
	var ele = document.getElementById(id);
	ele.focus();
	ele.select();
	document.execCommand('Paste');
}

//////////////////////////////
function copyToClipboard(text) 
{
	DKDEBUGFUNC(text);
    if(window.clipboardData && window.clipboardData.setData){
        // IE specific code path to prevent textarea being shown while dialog is visible.
        return clipboardData.setData("Text", text); 

    } 
	else if (document.queryCommandSupported && document.queryCommandSupported("copy")){
        var textarea = document.createElement("textarea");
        textarea.textContent = text;
        textarea.style.position = "fixed";  // Prevent scrolling to bottom of page in MS Edge.
        document.body.appendChild(textarea);
        textarea.select();
        try {
            return document.execCommand("copy");  // Security exception may be thrown by some browsers.
        } catch (ex) {
            console.warn("Copy to clipboard failed.", ex);
            return false;
        } finally {
            document.body.removeChild(textarea);
        }
    }
}

////////////////////////////
function removeSelection(id)
{
	DKDEBUGFUNC(id);
	var ele = document.getElementById(id);
    var text = ele.value;
    text = text.slice(0, ele.selectionStart) + text.slice(ele.selectionEnd);
    ele.value = text;
}