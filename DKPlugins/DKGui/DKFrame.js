var sizes = [];

///////////////////////
function DKFrame_Init()
{
	DKLog("DKFrame_Init()\n", DKDEBUG);
}

//////////////////////
function DKFrame_End()
{
	DKLog("DKFrame_End()\n", DKDEBUG);
}

///////////////////////////////
function DKFrame_OnEvent(event)
{
	DKLog("DKFrame_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	if(DK_Type(event, "mousedown")){
		DKFrame_BringToFront();
		//setTimeout( function(){ DKFrame_BringToFront(); }, 1000);
	}
	if(DK_Type(event, "dblclick")){
		var id = DK_GetId(event);
		var titlebar = DKWidget_GetParent(id);
		DKFrame_MaximizeButton(titlebar);
	}
	if(DK_IdLike(event, "DKFrame_reload")){
		DKFrame_Reload(DK_GetId(event));
	}
	if(DK_IdLike(event, "DKFrame_minimize")){
		DKFrame_MinimizeButton(DK_GetId(event));
	}
	if(DK_IdLike(event, "DKFrame_maximize")){
		DKFrame_MaximizeButton(DK_GetId(event));
	}
	if(DK_IdLike(event, "DKFrame_close")){
		DKFrame_CloseButton(DK_GetId(event));
	}
	
	// FIXME - does not always fire
	if(DK_Type(event, "DKFrame_resize")){
		var frame = document.getElementById(DK_GetId(event));
		if(!frame){ 
			//DKLog("DKFrame_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+"): frame invalid\n", DKERROR);
			return; 
		}
		var child = frame.childNodes[4];
		DKWidget_SetProperty(child.id, "width", parseInt(DKWidget_GetProperty(frame.id, "width")) + "rem");
		DKWidget_SetProperty(child.id, "height", parseInt(DKWidget_GetProperty(frame.id, "height")) - 21 + "rem");
	}
}

///////////////////////////
function DKFrame_Widget(id)
{
	DKLog("DKFrame_Widget("+id+")\n", DKDEBUG);
	
	if(!DKWidget_ElementExists(id)){
		DKLog("DKFrame_Widget("+id+"): element does not exist\n", DKERROR);
		return false;
	}
	
	var title = DKFile_GetFilename(id);
	title = title.replace(".html", "");
	
	//stop if frame already exsists, multiple windows not ready yet.
	//FIXME
	//if(DKWidget_ElementExists(title+"_frame")){
	//	DKLog("DKFrame_Widget("+id+"): frame already exists\n", DKWARN);
	//	return;
	//}
	
	var width = DKWidget_GetProperty(id, "width");
	var height = DKWidget_GetProperty(id, "height");
	//DKLog("DKFrame_Widget("+id+"): width="+width+" , height="+height+"\n");

	width = width.replace("px", "");
	height = height.replace("px", "");
	width = width.replace("rem", "");
	height = height.replace("rem", "");
	
	var frame = DKFrame_CreateFrame(title, width, height);
	
	DKWidget_AppendChild(frame, id);
	DKWidget_SetProperty(id, "position", "absolute");
	DKWidget_SetProperty(id, "top", "21rem");
	DKWidget_SetProperty(id, "left", "0rem");
	DKWidget_SetProperty(id, "width", "100%");
	DKWidget_SetProperty(id, "bottom", "-1rem");
	DKWidget_RemoveProperty(id, "right");
	DKWidget_RemoveProperty(id, "height");
	
	DKFrame_CreateResize(frame);
	return frame;
}

////////////////////////////////////
function DKFrame_SetTitle(id, title)
{
	DKLog("DKFrame_SetTitle("+id+","+title+")\n", DKDEBUG);
	//TODO - add protection	
	var frame = DKWidget_GetParent(id);
	var titlebar = DKWidget_GetFirstChild(frame);
	var titlebartext = DKWidget_GetFirstChild(titlebar);
	DKWidget_SetInnerHtml(titlebartext, title);
}

//////////////////////////////////////////////////
function DKFrame_Iframe(title, url, width, height)
{
	DKLog("DKFrame_Iframe("+title+","+url+","+width+","+height+")\n", DKINFO);
	var frame = DKFrame_CreateFrame(title, width, height);

	//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	//FIXME: DKRocketToRML::PostProcess() is getting called before we can set the attributes.
	var iframe = DKWidget_CreateElement(frame, "iframe", title);
	DKWidget_SetAttribute(iframe, "src", url);
	DKWidget_SetAttribute(iframe, "width", "100%");
	DKWidget_SetAttribute(iframe, "height", "100%");
	DKWidget_SetProperty(iframe, "border-width", "0rem");
	DKWidget_SetProperty(iframe, "position", "absolute");
	DKWidget_SetProperty(iframe, "top", "21rem");
	DKWidget_SetProperty(iframe, "left", "0rem");
	DKWidget_SetProperty(iframe, "width", "100%");
	DKWidget_SetProperty(iframe, "bottom", "0rem");
	DKWidget_RemoveProperty(iframe, "height");
	DKWidget_RemoveProperty(iframe, "right");
	
	//Test re-PostProcess since we added attributes after
	var debug_test = DKWidget_CreateElement("body", "div", "div"); 
	DKWidget_RemoveElement(debug_test )
	
	//var currentBrowser = DKCef_GetCurrentBrowser();
	//DKCef_SetUrl(currentBrowser, url);
	//DKFrame_CreateResize(frame);
	//DKCef_SetFocus();
	return iframe;
}

//////////////////////////////////////////////////
function DKFrame_CreateFrame(title, width, height)
{
	DKLog("DKFrame_CreateFrame("+title+","+width+","+height+")\n", DKDEBUG);
	var window_width = parseInt(DKWindow_GetWidth());
	var window_height = parseInt(DKWindow_GetHeight());
	if(width == "100%"){ width = window_width-100; }
	if(height == "100%"){ height = window_height-21-100; }
	//if(!width){ width = "300"; }
	//if(!height){ height = "300"; }
	if(!width){ width = window_width / 2; }
	if(!height){ height = window_height / 2; }
	var newheight = parseFloat(height)+21;
	var newtop = parseFloat((window_height / 2) - (newheight / 2) - 1);
	var newleft = parseFloat((window_width / 2) - (width / 2) - 1);
	
	var frame = DKWidget_CreateElement("body", "div", "DKFrame_frame");
	DKWidget_SetProperty(frame, "position", "absolute");
	DKWidget_SetProperty(frame, "overflow", "hidden");
	DKWidget_SetProperty(frame, "top", newtop.toString()+"px");
	DKWidget_SetProperty(frame, "left", newleft.toString()+"px");
	DKWidget_SetProperty(frame, "width", width.toString()+"rem");
	DKWidget_SetProperty(frame, "height", newheight.toString()+"rem");
	DKWidget_SetProperty(frame, "background-color", "rgb(150,150,150)");
	DKWidget_SetProperty(frame, "border-color", "rgb(0,0,0)");
	DKWidget_SetProperty(frame, "border-style", "solid");
	DKWidget_SetProperty(frame, "border-width", "1rem");
	DKWidget_SetProperty(frame, "min-width", "62rem");
	DKWidget_SetProperty(frame, "min-height", "30rem");
	DKAddEvent(frame, "mousedown", DKFrame_OnEvent);
	
	//DKLog("DKFrame_Widget("+id+"): frame top="+newtop.toString()+"\n");
	//DKLog("DKFrame_Widget("+id+"): frame left="+newleft.toString()+"\n");
	//DKLog("DKFrame_Widget("+id+"): frame width="+width+"\n");
	//DKLog("DKFrame_Widget("+id+"): frame height="+newheight.toString()+"\n");
	
	var titlebar = DKWidget_CreateElement(frame, "div", "DKFrame_titlebar");
	DKWidget_SetProperty(titlebar, "position", "absolute");
	DKWidget_SetProperty(titlebar, "width", "100%");
	DKWidget_SetProperty(titlebar, "height", "21rem");
	DKWidget_SetProperty(titlebar, "background-color", "rgb(200,200,200)");
	
	var titlebartext = DKWidget_CreateElement(titlebar, "div", "DKFrame_titlebartext");
	DKWidget_SetProperty(titlebartext, "position", "absolute");
	DKWidget_SetProperty(titlebartext, "width", "100%");
	DKWidget_SetProperty(titlebartext, "height", "100%");
	DKWidget_SetProperty(titlebartext, "color", "rgb(25,25,25)");
	DKWidget_SetInnerHtml(titlebartext, title);	
	DKWidget_AddDragHandle(titlebartext, frame);
	DKAddEvent(titlebartext, "dblclick", DKFrame_OnEvent);
	
	var reload = DKWidget_CreateElement(frame, "img", "DKFrame_reload");
	DKWidget_SetAttribute(reload, "src", "DKGui/reload.png");
	DKWidget_SetProperty(reload, "position", "absolute");
	DKWidget_SetProperty(reload, "top", "1rem");
	DKWidget_SetProperty(reload, "right", "65rem");
	DKWidget_SetProperty(reload, "height", "18rem");
	DKAddEvent(reload, "click", DKFrame_OnEvent);
	
	var minimize = DKWidget_CreateElement(frame, "img", "DKFrame_minimize");
	DKWidget_SetAttribute(minimize, "src", "DKGui/minimize.png");
	DKWidget_SetProperty(minimize, "position", "absolute");
	DKWidget_SetProperty(minimize, "top", "0rem");
	DKWidget_SetProperty(minimize, "right", "42rem");
	DKWidget_SetProperty(minimize, "height", "20rem");
	DKAddEvent(minimize, "click", DKFrame_OnEvent);
	
	var maximize = DKWidget_CreateElement(frame, "img", "DKFrame_maximize");
	DKWidget_SetAttribute(maximize, "src", "DKGui/maximize.png");
	DKWidget_SetProperty(maximize, "position", "absolute");
	DKWidget_SetProperty(maximize, "top", "0rem");
	DKWidget_SetProperty(maximize, "right", "21rem");
	DKWidget_SetProperty(maximize, "height", "20rem");
	DKAddEvent(maximize, "click", DKFrame_OnEvent);
	
	var close = DKWidget_CreateElement(frame, "img", "DKFrame_close");
	DKWidget_SetAttribute(close, "src", "DKGui/close.png");
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
	DKLog("DKFrame_CreateResize("+frame+")\n", DKDEBUG);
	var resize = DKWidget_CreateElement(frame, "div", "DKFrame_resize");
	DKWidget_SetProperty(resize, "background-image", "url(\"DKGui/resize.png\")");
	DKWidget_RemoveProperty(resize, "top");
	DKWidget_SetProperty(resize, "position", "absolute");
	DKWidget_SetProperty(resize, "right", "0rem");
	DKWidget_SetProperty(resize, "bottom", "0rem");
	DKWidget_SetProperty(resize, "width", "16rem");
	DKWidget_SetProperty(resize, "height", "16rem");
	DKWidget_AddResizeHandle(resize, frame);
	DKAddEvent(frame, "resize", DKFrame_OnEvent);  //FIXME - does not fire.
	
	return resize;
}

///////////////////////////////
function DKFrame_BringToFront()
{
	DKLog("DKFrame_BringToFront()\n", DKDEBUG);
	var id = DKWidget_GetHoverElement();
	if(!id){ return; }
	
	if(DKWidget_IsChildOf(id, "DKFrame_frame")){
		if(DKWidget_GetLastChild("body") != "DKFrame_frame"){
			DKWidget_AppendChild("body", "DKFrame_frame");
			return;
		}
	}
	for(var i=0; i<100; i++){
		var frame = "DKFrame_frame"+i.toString();
		if(DKWidget_IsChildOf(id, frame)){
			if(DKWidget_GetLastChild("body") != frame){
				DKWidget_AppendChild("body", frame);
				return;
			}
		}
	}
}

///////////////////////////////////
function DKFrame_MinimizeButton(id)
{
	DKLog("DKFrame_MinimizeButton("+id+")\n", DKDEBUG);
	//TODO
	//var frame = DKWidget_GetParent(id);
}

///////////////////////////////////
function DKFrame_MaximizeButton(id)
{
	DKLog("DKFrame_MaximizeButton("+id+")\n");//, DKDEBUG);
	var frame = DKWidget_GetParent(id);
	var top = DKWidget_GetProperty(frame, "top");
	var bottom = DKWidget_GetProperty(frame, "bottom");
	var left = DKWidget_GetProperty(frame, "left");
	var right = DKWidget_GetProperty(frame, "right");
	if(top == "0rem" && bottom == "0rem" && left == "0rem" && right == "0rem" ||
		top == "0px" && bottom == "0px" && left == "0px" && right == "0px" ){
		DKFrame_RestoreSize(frame);
		
		var elements = DKWidget_GetElements(frame);
		var arry = elements.split(",");
		DKWidget_SetProperty(arry[5], "width", parseInt(DKWidget_GetProperty(frame, "width")) + "rem");
		DKWidget_SetProperty(arry[5], "height", parseInt(DKWidget_GetProperty(frame, "height")) - 21 + "rem");
	}
	else{
		DKFrame_StoreSize(frame);
		DKWidget_SetProperty(frame, "top", "0rem");
		DKWidget_SetProperty(frame, "left", "0rem");
		DKWidget_SetProperty(frame, "right", "0rem");
		DKWidget_SetProperty(frame, "bottom", "0rem");
		DKWidget_RemoveProperty(frame, "width");
		DKWidget_RemoveProperty(frame, "height");
		
		var elements = DKWidget_GetElements(frame);
		var arry = elements.split(",");
		DKWidget_SetProperty(arry[5], "width", "100%");
		DKWidget_SetProperty(arry[5], "height", "100%");
	}
}

////////////////////////////////
function DKFrame_CloseButton(id)
{
	DKLog("DKFrame_CloseButton("+id+")\n", DKDEBUG);
	DKFrame_Close(id);
}

//////////////////////////
function DKFrame_Close(id)
{
	DKLog("DKFrame_Close("+id+")\n", DKDEBUG);
	var frame = DKWidget_GetParent(id);
	//DKLog("DKFrame_Close("+id+"): frame = "+frame+"\n");
	var children = DKWidget_GetElements(frame);
	var arry = children.split(",");
	for(var i=arry.length-1; i>0; i--){
		if(arry[i].indexOf(".html") > -1){
			var file = DKWidget_GetFile(arry[i]);
			if(!file){ file = arry[i];}
			var jsfile = file.replace(".html", ".js");
			//DKLog("DKClose("+jsfile+")\n");
			DKClose(jsfile);
			var htmlfile = file.replace(".js", ".html");
			DKClose(htmlfile);
		}
	}
	
	//DKLog("DKFrame_Close("+id+"): frame="+frame+"\n");
	if(frame == "body"){
		return;
	}
	
	//remove frame events 
	var num = frame.replace("DKFrame_frame","");
	DKRemoveEvent("DKFrame_frame"+num, "mousedown", DKFrame_OnEvent);
	DKRemoveEvent("DKFrame_close"+num, "click", DKFrame_OnEvent);
	DKRemoveEvent("DKFrame_maximize"+num, "click", DKFrame_OnEvent);
	DKRemoveEvent("DKFrame_minimize"+num, "click", DKFrame_OnEvent);
	DKRemoveEvent("DKFrame_reload"+num, "click", DKFrame_OnEvent);
	DKRemoveEvent("DKFrame_titlebartext"+num, "dblclick", DKFrame_OnEvent);
	DKRemoveEvent("DKFrame_frame"+num, "resize", DKFrame_OnEvent);
	
	DKWidget_RemoveElement(frame);
}

//////////////////////////////
function DKFrame_StoreSize(id)
{
	DKLog("DKFrame_StoreSize("+id+")\n", DKDEBUG);
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
	DKLog("DKFrame_RestoreSize("+id+")\n", DKDEBUG);
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
	DKLog("DKFrame_CloseAll()\n", DKDEBUG);
	var children = DKWidget_GetElements("body");
	var arry = children.split(",");
	for(var i=0; i<arry.length; i++){
		if(arry[i].indexOf("DKFrame_frame") > -1){
			DKWidget_RemoveElement(arry[i]);
		}
	}
}

///////////////////////////
function DKFrame_Reload(id)
{
	DKLog("TODO: refresh the frame data. html, javascript and css all reloaded.");
	
	DKLog("id = "+id+"\n");
	var saved_id = id; 
	DKLog("saved_id = "+saved_id+"\n");
	var jsfile;
	var htmlfile;
	
	var frame = DKWidget_GetParent(id);
	var children = DKWidget_GetElements(frame);
	var arry = children.split(",");
	for(var i=arry.length-1; i>0; i--){
		if(arry[i].indexOf(".html") > -1){
			var file = DKWidget_GetFile(arry[i]);
			if(!file){ file = arry[i];}
			jsfile = file.replace(".html", ".js");
			htmlfile = file.replace(".js", ".html");
		}
	}
	
	DKLog("jsfile = "+jsfile+"\n");
	DKLog("htmlfile = "+htmlfile+"\n");
	
	DKFrame_Close(id);
	DKCreate(jsfile, function(){
		DKFrame_Widget(htmlfile);
	});
}