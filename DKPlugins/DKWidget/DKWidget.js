/////////////////////////////////
function DKWidget_AttachDrags(id)
{
	var parent = byId(id);
	if(!parent){ return false; }
	var elements = parent.getElementsByTagName('*');
	for (var i=0; i<elements.length; i++) {	
		var x = elements[i];
		
		if(!DK_IE() && DK_GetBrowser() !== "RML"){
			x.style.setProperty("pointer-events","all");
		}
		
		if(x.getAttribute("drag") !== null){ 	//Drag events
			var mov_tar = x.getAttribute("drag");	
			x.onmousedown = function(event){DragStart(event, mov_tar);}
		}
		if(x.getAttribute("resize") !== null){ 	//Resize events
			var res_tar = x.getAttribute("resize");	
			x.onmousedown = function(event){ResizeStart(event, res_tar);}
		}
	}
}

/////////////////////////////////////////
function DKWidget_AddDragHandle(id, drag)
{
	var element = byId(id);
	if(!DK_IE() && DK_GetBrowser() !== "RML"){
		element.style.setProperty("pointer-events","all");
	}
	element.onmousedown = function(event){ DragStart(event, drag); }
	element.addEventListener('touchstart', function(event){ DragStart(event, drag); }, false);
	return true;
}

/////////////////////////////////////////////
function DKWidget_AddResizeHandle(id, resize)
{
	var element = byId(id);
	if(!DK_IE() && DK_GetBrowser() !== "RML"){
		element.style.setProperty("pointer-events","all");
	}
	element.onmousedown = function(event){ ResizeStart(event, resize); }
	element.addEventListener('touchstart', function(event){ ResizeStart(event, resize); }, false);
	return true;
}

//////////////////////////////////////
function DKWidget_RemoveDragHandle(id)
{
	if(!id){ return; }
	var element = byId(id);
	if(!DK_IE()){
		//element.style.setProperty("pointer-events","none");
	}
	element.onmousedown = 0;
	//element.removeEventListener('touchstart', function(event){ DragStart(event, drag);});
}

////////////////////////////////////
function DKWidget_GetValue(variable)
{
	if(!variable){ console.log("variable empty\n"); return; }

	if(typeof variable === "string"){ //id
		//console.log("GetValue("+variable+") -> typeof variable === string\n");
		var ele = byId(variable);
		if(!ele){ console.log("DKWidget_GetValue("+variable+"): Cannot find element\n"); /*return false;*/ }
		if(ele){
			if(ele.type && ele.type === "checkbox"){
				return ele.checked;
			}
			if(!ele.value){
				//console.log("DKWidget_GetValue("+variable+"): Could not get ele.value\n");
				return ele.innerHTML;
			}
			//console.log("DKWidget_GetValue("+variable+") -> "+ele.value+"\n");
			return ele.value; 
		}
		
		console.error("DKWidget_GetValue("+variable+"): Could not get value\n");
		return false;
	}
	
	if(typeof variable === "object"){
		//console.log("DKWidget_GetValue("+variable+") -> typeof variable === object\n");
		//console.log("DKWidget_GetValue("+variable+") -> variable.nodeType === "+variable.nodeType+"\n");
		//console.log("DKWidget_GetValue("+variable+") -> variable.tagName === "+variable.tagName+"\n");
		//console.log("DKWidget_GetValue("+variable+") -> variable.type === "+variable.type+"\n");
		if(variable.nodeType === 1){
			//console.log("variable.tagName: "+variable.tagName+"\n");
			if(variable.tagName === "INPUT"){
				//console.log("DKWidget_GetValue("+variable+") -> "+variable.value+"\n");
				return variable.value;
			}
			return variable.innerHTML;
		}
		if(variable.type){ //event
			var event = variable;
			//console.log("GetValue("+variable+") -> variable.type === true\n");
			//console.log("GetValue("+variable+") -> "+variable.type+"\n");
			if(variable.type === "mousedown"){
				return GetMouseButton(variable);
			}
			if(variable.type === "mouseup"){
				return GetMouseButton(variable);
			}
			if(variable.type === "click"){
				if(variable.target && variable.target.value){
					return variable.target.value;
				}
				return GetMouseButton(variable);
			}
			if(variable.type === "dblclick"){
				return GetMouseButton(variable);
			}
			if(variable.type === "contextmenu"){
				return GetMouseButton(variable);
			}
			if(variable.type === "mousemove"){
				return event.clientX+","+event.clientY+","+event.screenX+","+event.screenY;
			}
			if(variable.type === "mouseover"){
				if(!event.target){ return window.event.srcElement.id; }
				//if(!event.target){ return event.srcElement.id; }
				return event.target.id;
			}
			if(variable.type === "mouseout"){
				if(!event.target){ return window.event.srcElement.id; }
				//if(!event.target){ return event.srcElement.id; }
				return event.target.id;
			}
			if(variable.type === "wheel"){
				var o = variable//.originalEvent,
				d = o.detail, w = o.wheelDelta,
				n = 225, n1 = n-1;

				// Normalize delta
				d = d ? w && (f = w/d) ? d/f : -d/1.35 : w/120;
				// Quadratic scale if |d| > 1
				d = d < 1 ? d < -1 ? (-Math.pow(d, 2) - n1) / n : d : (Math.pow(d, 2) + n1) / n;
				// Delta *should* not be greater than 2...
				event.delta = Math.min(Math.max(d / 2, -1), 1) * 2;
				return event.delta;
			}
			if(variable.type === "keypress"){
				return GetCharCode(variable);
			}
			if(variable.type === "keydown"){
				return GetKeyCode(variable);
			}
			if(variable.type === "keyup"){
				return GetKeyCode(variable);
			}
			if(variable.type === "resize"){
				var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
				var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
				return width+","+height;
			}
			var ele = DKWidget_GetElement(event);
			//console.log("DKWidget_GetValue("+variable+") -> "+ele.value+"\n");
			return ele.value;
		}
		else{ //element or other object
			if(variable.value){
				//console.log("DKWidget_GetValue("+variable+") -> "+variable.value+"\n");
				return variable.value;
			}
			//console.log("DKWidget_GetValue("+variable+") -> "+variable[2]+"\n");
			return variable[2];
		}
	}
	
	console.error("ERROR: DKWidget_GetValue(): unknown type\n");
	return false;
}

///////////////////////////////////////////////
function DKWidget_RemoveProperty(id, parameter)
{
	var element = byId(id);
	if(!element){ 
		console.error("DKWidget_RemoveProperty(): element invalid\n");
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
	//if(!value){ value = ""; } //FIXME - sould be if(value === emptystring) so 0's can pass through
	if(typeof variable === "object"){
		if(variable.tagName === "INPUT"){
			variable.value = value;
			return true;
		}
		byId(variable).innerHTML = value;
		return true;
	}
	if(typeof variable === "string"){
		var element = byId(variable);
		if(!element){ console.error("SetValue("+variable+"): Cannot find element\n"); return false; }
		if(element.type && element.type === "checkbox"){
			element.checked = value;
			return true;
		}
		if(element.tagName === "INPUT"){
			element.value = value;
			return true;
		}
		byId(variable).innerHTML = value;
		return true;
	}
	console.error("ERROR: SetValue(): unknown type\n");
	return false;
}

////////////////////////////////////////
function DKWidget_GetInnerHtmlString(id)
{
	if(!id){ console.warn("DKWidget_GetInnerHtmlString(): empty id\n"); return "";}
	var element = byId(id);
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
	var element = byId(id);
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
	if(typeof variable === "object"){
		return variable.outerHTML;
	}
	if(typeof variable === "string"){
		var element = byId(variable);
		return element.outerHTML;
	}
	console.error("ERROR: GetInnerHtml(): unknown type\n");
	return false;
}

////////////////////////////////////////////////
function DKWidget_CreateElement(parent, tag, id)
{
	if(!(parent instanceof HTMLElement)){
		console.error("CreateElement("+parent+"): parent is not an HTMLElement");
		return;
	}
	
	id = DK_GetAvailableId(id);
		
	var ele = document.createElement(tag);
	if(!ele){ console.error("DKWidget_CreateElement(): ele invalid ("+tag+")\n"); return false;}
	ele.id = id;
	//ele.setAttribute("id", id);
	
	parent.appendChild(ele); //This is not working on IE
	
	return id;
}

//////////////////////////////////////////////////////
function DKWidget_CreateElementBefore(parent, tag, id)
{
	id = DK_GetAvailableId(id);
	var par = byId(parent);
	var ele = document.createElement(tag);
	ele.id = id;
	
	var node = par.parentNode;
	if(!node){
		console.error("InsertBefore(): could not get parent of "+parent+"\n");
		return false;
	}
	
	node.insertBefore(ele, par);
	return id;
}

///////////////////////////////////////////////
function DKWidget_PrependChild(parent, element)
{
	var par;
	if(typeof parent === "string"){
		par = byId(parent);
	}
	else{
		par = parent;
	}
	var ele;
	if(typeof element === "string"){
		ele = byId(element);
	}
	else{
		ele = element;
	}
	
	if(!par){
		console.error("PrependChild("+parent+", "+element+"): par invalid\n");
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
	if(typeof parent === "string"){
		par = byId(parent);
	}
	else{
		par = parent;
	}
	var ele;
	if(typeof element === "string"){
		ele = byId(element);
	}
	else{
		ele = element;
	}
	var node = par.parentNode;
	if(!node){
		console.error("InsertBefore(): could not get parent of "+parent+"\n");
		return false;
	}
	
	node.insertBefore(ele, par);
}

//////////////////////////////////////
function DKWidget_GetMouseElementX(id)
{
	if(!id){ id = "body"; }
	/*
	var ele = byId(id);
	var left = ele.offsetLeft;
	while((ele=ele.offsetParent) !== null){ 
		left += ele.offsetLeft; 
	}
	*/
	//console.log("DKWidget_GetMouseElementX("+element+"): left = "+left+"\n");
	return mouseX - DKWidget_GetOffsetLeft(id);//parseInt(left);
}

///////////////////////////////////////////
function DKWidget_GetMouseElementY(id)
{
	if(!id){ id = "body"; }
	/*
	var ele = byId(element);
	var top = ele.offsetTop;
	while((ele=ele.offsetParent) !== null){ 
		top += ele.offsetTop; 
	}
	*/
	//console.log("DKWidget_GetMouseElementX("+element+"): top = "+top+"\n");
	return mouseY - DKWidget_GetOffsetTop(id);//parseInt(top);
}

///////////////////////////////////
function DKWidget_RemoveElement(id)
{
	var ele = byId(id);
	if(!ele){
		console.warn("RemoveElement("+id+"): element does not exist\n");
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
	var element = byId(id);
	if(!element){ return false; }
	return element.outerHTML;
}

/////////////////////////////////////////////
function DKWidget_RemoveAttribute(id, attrib)
{
	var element = byId(id);
	if(!element){ return false; }
	element.removeAttribute(attrib);
}

///////////////////////////////////
function DKWidget_GetHoverElement()
{ 
	if(!document.elementFromPoint(window.mouseX, window.mouseY)){ 
		console.log("DKWidget_GetHoverElement(): document.elementFromPoint("+window.mouseX+","+window.mouseY+") invalid");
		return false;
	}
	return document.elementFromPoint(window.mouseX, window.mouseY);
}

///////////////////////////////////////
function DKWidget_OpenLink(url, target)
{
	//window.location = url;
	window.open(url, target);
}

///////////////////////////////////
function DKWidget_SetFile(id, file)
{ 
	console.warn("DKWidget_SetFile(): not available for "+DK_GetBrowser()+"\n"); 
	return;
	
	//TODO
	if(!id){ console.warn("DKWidget_SetFile(): id empty\n"); return; }
	while(id.indexOf(".html") === -1 && id.indexOf("body") === -1){
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

//////////////////////////////
function DKWidget_SetFocus(id)
{
	//console.log("DKWidget_SetFocus("+id+")");
	var element = byId(id);
	//console.log("DKWidget_SetFocus("+id+"): element = "+element);
	element.focus();
}


/////////////////////////
function DKWidget_Cut(id)
{
	var text = "";
    if(window.getSelection){
        text = window.getSelection().toString();
    } 
	else if(document.selection && document.selection.type !== "Control"){
        text = document.selection.createRange().text;
    }
	//console.log("DKWidget_Cut("+id+"): text = "+text+"\n");
	copyToClipboard(text);
	removeSelection(id);
}

//////////////////////////
function DKWidget_Copy(id)
{
	var text = "";
    if(window.getSelection){
        text = window.getSelection().toString();
    } 
	else if(document.selection && document.selection.type !== "Control"){
        text = document.selection.createRange().text;
    }
	
	//console.log("DKWidget_Cut("+id+"): text = "+text+"\n");
	copyToClipboard(text);
}

///////////////////////////
function DKWidget_Paste(id)
{
	//TODO
	removeSelection(id);
	var ele = byId(id);
	ele.focus();
	ele.select();
	document.execCommand('Paste');
}

//////////////////////////////
function copyToClipboard(text) 
{
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
	var ele = byId(id);
    var text = ele.value;
    text = text.slice(0, ele.selectionStart) + text.slice(ele.selectionEnd);
    ele.value = text;
}