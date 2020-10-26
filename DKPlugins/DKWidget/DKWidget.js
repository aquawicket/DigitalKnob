// *** EVENTS & VALUES *** //

////////////////////////////////////
function DKWidget_GetValue(variable)
{
	
	console.error("DKWidget_GetValue(): this function is deprecated and will be obsolete");
	
	//FIXME: limit what variable can be to phase this out
	if(typeof variable === "string"){ //id
		var ele = byId(variable);
		if(!ele){ console.log("DKWidget_GetValue("+variable+"): Cannot find element\n"); /*return false;*/ }
		if(ele){
			if(ele.type && ele.type === "checkbox"){
				console.debug("DKWidget_GetValue(): returning ele.checked\n");
				return ele.checked;
			}
			if(!ele.value){
				console.debug("DKWidget_GetValue(): returning ele.innerHTML\n");
				return ele.innerHTML;
			}
			console.debug("DKWidget_GetValue(): returning ele.value\n");
			return ele.value; 
		}
		
		console.error("DKWidget_GetValue("+variable+"): Could not get value\n");
		return false;
	}
	
	if(typeof variable === "object"){
		if(variable.nodeType === 1){
			if(variable.tagName === "INPUT"){
				console.debug("DKWidget_GetValue(): returning variable.value\n");
				return variable.value;
			}
			console.debug("DKWidget_GetValue(): returning variable.innerHTML\n");
			return variable.innerHTML;
		}
		if(variable.type){ //event
			var event = variable;
			if(variable.type === "mousedown"){
				console.debug("DKWidget_GetValue(): returning GetMouseButton(variable)\n");
				return GetMouseButton(variable);
			}
			if(variable.type === "mouseup"){
				console.debug("DKWidget_GetValue(): returning GetMouseButton(variable)\n");
				return GetMouseButton(variable);
			}
			if(variable.type === "click"){
				if(variable.target && variable.target.value){
					console.debug("DKWidget_GetValue(): returning variable.target.value\n");
					return variable.target.value;
				}
				console.debug("DKWidget_GetValue(): returning GetMouseButton(variable)\n");
				return GetMouseButton(variable);
			}
			if(variable.type === "dblclick"){
				console.debug("DKWidget_GetValue(): returning GetMouseButton(variable)\n");
				return GetMouseButton(variable);
			}
			if(variable.type === "contextmenu"){
				console.debug("DKWidget_GetValue(): returning GetMouseButton(variable)\n");
				return GetMouseButton(variable);
			}
			if(variable.type === "mousemove"){
				console.debug("DKWidget_GetValue(): returning event.clientX+","+event.clientY+","+event.screenX+","+event.screenY\n");
				return event.clientX+","+event.clientY+","+event.screenX+","+event.screenY;
			}
			if(variable.type === "mouseover"){
				if(!event.target){ return window.event.srcElement.id; }
				//if(!event.target){ return event.srcElement.id; }
				console.debug("DKWidget_GetValue(): returning event.target.id\n");
				return event.target.id;
			}
			if(variable.type === "mouseout"){
				if(!event.target){ return window.event.srcElement.id; }
				//if(!event.target){ return event.srcElement.id; }
				console.debug("DKWidget_GetValue(): returning event.target.id\n");
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
				console.debug("DKWidget_GetValue(): returning event.delta\n");
				return event.delta;
			}
			if(variable.type === "keypress"){
				console.debug("DKWidget_GetValue(): returning GetCharCode(variable)\n");
				return GetCharCode(variable);
			}
			if(variable.type === "keydown"){
				console.debug("DKWidget_GetValue(): returning GetKeyCode(variable)\n");
				return GetKeyCode(variable);
			}
			if(variable.type === "keyup"){
				console.debug("DKWidget_GetValue(): returning GetCharCode(variable)\n");
				return GetKeyCode(variable);
			}
			if(variable.type === "resize"){
				var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
				var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
				console.debug("DKWidget_GetValue(): returning width+","+height\n");
				return width+","+height;
			}
			var ele = DKWidget_GetElement(event);
			console.debug("DKWidget_GetValue(): returning ele.value\n");
			return ele.value;
		}
		else{ //element or other object
			if(variable.value){
				console.debug("DKWidget_GetValue(): returning variable.value\n");
				return variable.value;
			}
			console.debug("DKWidget_GetValue(): returning variable[2]\n");
			return variable[2];
		}
	}
	
	console.error("ERROR: DKWidget_GetValue(): unknown type\n");
	return false;
}












// *** DRAG & RESIZE *** //

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

//////////////////////////////////////////////
function DKWidget_AddDragHandle(element, drag)
{
	if(!DK_IE() && DK_GetBrowser() !== "RML"){
		element.style.setProperty("pointer-events","all");
	}
	element.onmousedown = function(event){ DragStart(event, drag); }
	element.addEventListener('touchstart', function(event){ DragStart(event, drag); }, false);
	return true;
}

//////////////////////////////////////////////////
function DKWidget_AddResizeHandle(element, resize)
{
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








// *** UNKNOWN *please test* *** //

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