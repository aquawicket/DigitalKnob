var sizes = [];

DKAddEvent("GLOBAL", "mousedown", DKFrame_OnEvent);

///////////////////////
function DKFrame_Init()
{

}

///////////////////////////////
function DKFrame_OnEvent(event)
{
	DKLog("DKFrame_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);

	if(DK_Type(event, "mousedown")){
		DKFrame_BringToFront();
	}
	if(DK_Type(event, "dblclick")){
		var id = DK_GetId(event);
		var titlebar = DKWidget_GetParent(id);
		DKFrame_MaximizeButton(titlebar);
	}
	if(DK_IdLike(event, "minimize")){
		DKFrame_MinimizeButton(DK_GetId(event));
	}
	if(DK_IdLike(event, "maximize")){
		DKFrame_MaximizeButton(DK_GetId(event));
	}
	if(DK_IdLike(event, "close")){
		DKFrame_CloseButton(DK_GetId(event));
	}
}

///////////////////////////
function DKFrame_Widget(id)
{
	DKLog("DKFrame_Widget("+id+")\n", DKDEBUG);
	if(!DKWidget_ElementExists(id)){
		DKLog("DKFrame_Widget(): element does not exist\n", DKERROR);
		return false;
	}
	
	var top = DKWidget_GetProperty(id, "top");
	var bottom = DKWidget_GetProperty(id, "bottom");
	var left = DKWidget_GetProperty(id, "left");
	var right = DKWidget_GetProperty(id, "right");
	var width = DKWidget_GetProperty(id, "width");
	var height = DKWidget_GetProperty(id, "height");
	top = top.replace("px", "");
	bottom = bottom.replace("px", "");
	left = left.replace("px", "");
	right = right.replace("px", "");
	width = width.replace("px", "");
	height = height.replace("px", "");
	top = top.replace("rem", "");
	bottom = bottom.replace("rem", "");
	left = left.replace("rem", "");
	right = right.replace("rem", "");
	width = width.replace("rem", "");
	height = height.replace("rem", "");
	
	var title = id.replace(".html", "");
	var frame = DKFrame_CreateFrame(title, width, height);
	
	DKWidget_SetProperty(id, "position", "absolute");
	DKWidget_SetProperty(id, "top", "21rem");
	DKWidget_SetProperty(id, "left", "0rem");
	DKWidget_SetProperty(id, "width", "100%");
	DKWidget_SetProperty(id, "bottom", "-1rem");
	DKWidget_RemoveProperty(id, "height");
	DKWidget_RemoveProperty(id, "right");
	DKWidget_AppendChild(frame, id);
	
	DKFrame_CreateResize(frame);

	return frame;
}

//////////////////////////////////////////////////
function DKFrame_Iframe(title, url, width, height)
{
	DKLog("DKFrame_Iframe("+title+","+url+","+width+","+height+") \n", DKDEBUG);
	
	var frame = DKFrame_CreateFrame(title, width, height);

	var iframe = DKWidget_CreateElement(frame, "iframe", title);
	DKWidget_SetAttribute(iframe, "src", url);
	
	DKWidget_SetAttribute(iframe, "width", "100%");
	DKWidget_SetAttribute(iframe, "height", "100%");
	DKWidget_SetProperty(iframe, "position", "absolute");
	DKWidget_SetProperty(iframe, "top", "21rem");
	DKWidget_SetProperty(iframe, "left", "0rem");
	DKWidget_SetProperty(iframe, "width", "100%");
	DKWidget_SetProperty(iframe, "bottom", "0rem");
	DKWidget_RemoveProperty(iframe, "height");
	DKWidget_RemoveProperty(iframe, "right");
	
	var currentBrowser = DKCef_GetCurrentBrowser(iframe);
	DKCef_SetUrl(iframe, url, currentBrowser);
	DKFrame_CreateResize(frame);
	DKCef_SetFocus(iframe);
	return iframe;
}

/////////////////////////////////////////////////
function DKFrame_CreateFrame(title, width, height)
{
	DKLog("DKFrame_CreateFrame("+title+","+width+","+height+") \n", DKDEBUG);
	var window_width = parseInt(DKWindow_GetWidth());
	var window_height = parseInt(DKWindow_GetHeight());
	if(width == "100%"){ width = window_width-100; }
	if(height == "100%"){ height = window_height-100; }
	if(!width){ width = "300"; }
	if(!height){ height = "300"; }
	var newheight = parseFloat(height)+2.1;
	var newtop = parseFloat((window_height / 2) - (newheight / 2) - 2.1);
	var newleft = parseFloat((window_width / 2) - (width / 2));
	
	var frame = DKWidget_CreateElement("body", "div", "frame");
	DKWidget_SetProperty(frame, "position", "absolute");
	DKWidget_SetProperty(frame, "overflow", "hidden");
	DKWidget_SetProperty(frame, "top", newtop.toString()+"px");
	DKWidget_SetProperty(frame, "left", newleft.toString()+"px");
	DKWidget_SetProperty(frame, "width", width+"rem");
	DKWidget_SetProperty(frame, "height", newheight.toString()+"rem");
	DKWidget_SetProperty(frame, "background-color", "rgb(150,150,150)");
	DKWidget_SetProperty(frame, "border-color", "rgb(0,0,0)");
	DKWidget_SetProperty(frame, "border-style", "solid");
	DKWidget_SetProperty(frame, "border-width", "1rem");
	DKWidget_SetProperty(frame, "min-width", "62px");
	DKWidget_SetProperty(frame, "min-height", "30px");
	
	//DKLog("DKFrame_Widget("+id+"): frame top="+newtop.toString()+"\n", DKDEBUG);
	//DKLog("DKFrame_Widget("+id+"): frame left="+newleft.toString()+"\n", DKDEBUG);
	//DKLog("DKFrame_Widget("+id+"): frame width="+width+"\n", DKDEBUG);
	//DKLog("DKFrame_Widget("+id+"): frame height="+newheight.toString()+"\n", DKDEBUG);
	
	var titlebar = DKWidget_CreateElement(frame, "div", "titlebar");
	DKWidget_SetProperty(titlebar, "position", "absolute");
	DKWidget_SetProperty(titlebar, "width", "100%");
	DKWidget_SetProperty(titlebar, "height", "21rem");
	DKWidget_SetProperty(titlebar, "background-color", "rgb(200,200,200)");
	
	var titlebartext = DKWidget_CreateElement(titlebar, "div", "titlebartext");
	DKWidget_SetProperty(titlebartext, "position", "absolute");
	DKWidget_SetProperty(titlebartext, "width", "100%");
	DKWidget_SetProperty(titlebartext, "height", "100%");
	DKWidget_SetProperty(titlebartext, "color", "rgb(25,25,25)");
	DKWidget_SetInnerHtml(titlebartext, title);	
	DKWidget_AddDragHandle(titlebartext, frame);
	DKAddEvent(titlebartext, "dblclick", DKFrame_OnEvent);
	
	var minimize = DKWidget_CreateElement(frame, "img", "minimize");
	DKWidget_SetAttribute(minimize, "src", "DKFrame/minimize.png");
	DKWidget_SetProperty(minimize, "position", "absolute");
	DKWidget_SetProperty(minimize, "top", "0rem");
	DKWidget_SetProperty(minimize, "right", "42rem");
	DKWidget_SetProperty(minimize, "height", "20rem");
	DKAddEvent(minimize, "click", DKFrame_OnEvent);
	
	var maximize = DKWidget_CreateElement(frame, "img", "maximize");
	DKWidget_SetAttribute(maximize, "src", "DKFrame/maximize.png");
	DKWidget_SetProperty(maximize, "position", "absolute");
	DKWidget_SetProperty(maximize, "top", "0rem");
	DKWidget_SetProperty(maximize, "right", "21rem");
	DKWidget_SetProperty(maximize, "height", "20rem");
	DKAddEvent(maximize, "click", DKFrame_OnEvent);
	
	var close = DKWidget_CreateElement(frame, "img", "close");
	DKWidget_SetAttribute(close, "src", "DKFrame/close.png");
	DKWidget_SetProperty(close, "position", "absolute");
	DKWidget_SetProperty(close, "top", "0rem");
	DKWidget_SetProperty(close, "right", "0rem");
	DKWidget_SetProperty(close, "height", "20rem");
	DKAddEvent(close, "click", DKFrame_OnEvent);
	
	return frame;
}

////////////////////////////////////
function DKFrame_CreateResize(frame)
{
	DKLog("DKFrame_CreateResize("+frame+") \n", DKDEBUG);
	
	var resize = DKWidget_CreateElement(frame, "img", "resize");
	DKWidget_SetAttribute(resize, "src", "DKFrame/resize.png");
	DKWidget_RemoveProperty(resize, "top");
	DKWidget_SetProperty(resize, "position", "absolute");
	DKWidget_SetProperty(resize, "right", "0rem");
	DKWidget_SetProperty(resize, "bottom", "0rem");
	DKWidget_SetProperty(resize, "width", "16rem");
	DKWidget_AddResizeHandle(resize, frame);
	
	return resize;
}

///////////////////////////////
function DKFrame_BringToFront()
{
	//return;
	
	//DKLog("DKFrame_BringToFront()\n", DKDEBUG);
	var id = DKWidget_GetHoverElement();
	if(!id){ return; }
	//DKLog("DKWidget_GetFocusElement() = "+id+"\n", DKDEBUG);
	if(DKWidget_IsChildOf(id, "frame")){
		//DKLog("DKWidget_AppendChild(body, frame)\n", DKDEBUG);
		DKWidget_AppendChild("body", "frame");
		return;
	}
	for(var i=0; i<100; i++){
		var frame = "frame"+i.toString();
		//DKLog("DKFrame_BringToFront(): frame="+frame+"\n", DKDEBUG);
		if(DKWidget_IsChildOf(id, frame)){
			//DKLog("DKWidget_AppendChild(body, "+frame+")\n", DKDEBUG);
			DKWidget_AppendChild("body", frame);
			return;
		}
	}
}

///////////////////////////////////
function DKFrame_MinimizeButton(id)
{
	DKLog("DKFrame_MinimizeButton("+id+")\n", DKDEBUG);
	var frame = DKWidget_GetParent(id);
}

///////////////////////////////////
function DKFrame_MaximizeButton(id)
{
	//DKLog("DKFrame_MaximizeButton("+id+")\n", DKDEBUG);
	var frame = DKWidget_GetParent(id);
	var top = DKWidget_GetProperty(frame, "top");
	var bottom = DKWidget_GetProperty(frame, "bottom");
	var left = DKWidget_GetProperty(frame, "left");
	var right = DKWidget_GetProperty(frame, "right");
	if(top == "0rem" && bottom == "0rem" && left == "0rem" && right == "0rem"){
		DKFrame_RestoreSize(frame)
	}
	else{
		DKFrame_StoreSize(frame);
		DKWidget_SetProperty(frame, "top", "0rem");
		DKWidget_SetProperty(frame, "left", "0rem");
		DKWidget_SetProperty(frame, "right", "0rem");
		DKWidget_SetProperty(frame, "bottom", "0rem");
		DKWidget_RemoveProperty(frame, "width");
		DKWidget_RemoveProperty(frame, "height");
	}
}

////////////////////////////////
function DKFrame_CloseButton(id)
{
	//DKLog("DKFrame_CloseButton("+id+")\n", DKDEBUG);
	var frame = DKWidget_GetParent(id);
	var children = DKWidget_GetElements(frame);
	var arry = children.split(",");
	for(var i=arry.length-1; i>0; i--){
		if(arry[i].indexOf(".html") > -1){
			//DKLog("DKFrame_CloseButton("+id+"): .html="+arry[i]+"\n", DKDEBUG);
			var file = DKWidget_GetFile(arry[i]);
			if(!file){ file = arry[i];}
			DKClose(file);
			var jsfile = file.replace(".html", ".js");
			//DKLog("DKFrame_CloseButton("+id+"): .js="+jsfile+"\n", DKDEBUG);
			DKClose(jsfile);
		}
	}
	
	DKWidget_RemoveElement(frame);
}

//////////////////////////
function DKFrame_Close(id)
{
	//DKLog("DKFrame_Close("+id+")\n", DKDEBUG);
	var frame = DKWidget_GetParent(id);
	if(!frame){
		DKLog("DKFrame_Close("+id+"): parent invalid\n", DKERROR);
	}
	//DKLog("DKFrame_Close("+id+"): frame="+frame+"\n", DKDEBUG);
	var file = DKWidget_GetFile(id);
	if(!file){
		DKLog("DKFrame_Close("+id+"): file invalid\n", DKERROR);
	}
	DKClose(file);
	var jsfile = file.replace(".html", ".js");
	//DKLog("DKFrame_CloseButton("+id+"): .js="+jsfile+"\n", DKDEBUG);
	DKClose(jsfile);
	DKWidget_RemoveElement(frame);
}

//////////////////////////////
function DKFrame_StoreSize(id)
{
	var top = DKWidget_GetProperty(id, "top");
	var bottom = DKWidget_GetProperty(id, "bottom");
	var left = DKWidget_GetProperty(id, "left");
	var right = DKWidget_GetProperty(id, "right");
	var width = DKWidget_GetProperty(id, "width");
	var height = DKWidget_GetProperty(id, "height");
	
	for(var i=0; i<sizes.length; i++){
		if(sizes[i].indexOf(id) > -1){
			sizes[i] = id+":"+top+":"+bottom+":"+left+":"+right+":"+width+":"+height;
			return;
		}
	}
	sizes.push(id+":"+top+":"+bottom+":"+left+":"+right+":"+width+":"+height);
}

////////////////////////////////
function DKFrame_RestoreSize(id)
{
	for(var i=0; i<sizes.length; i++){
		if(sizes[i].indexOf(id) > -1){
			var arry = sizes[i].split(":");
			DKWidget_SetProperty(id, "top", arry[1]);
			DKWidget_SetProperty(id, "bottom", arry[2]);
			DKWidget_SetProperty(id, "left", arry[3]);
			DKWidget_SetProperty(id, "right", arry[4]);
			DKWidget_SetProperty(id, "width", arry[5]);
			DKWidget_SetProperty(id, "height", arry[6]);
			return;
		}
	}
}

///////////////////////////
function DKFrame_CloseAll()
{
	var children = DKWidget_GetElements("body");
	var arry = children.split(",");
	for(var i=0; i<arry.length; i++){
		if(arry[i].indexOf("frame") > -1){
			DKWidget_RemoveElement(arry[i]);
		}
	}
}