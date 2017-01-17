var devmode = false;
var stored_element = "body";
var ignorelist = "";
var storedMouseX;
var storedMouseY;

/////////////////////
function DKDev_Init()
{
	DKCreate("DKDev/DKDev.html");

	DKAddEvent("body", "contextmenu", DKDev_OnEvent);
	DKAddEvent("body", "click", DKDev_OnEvent);
	DKAddEvent("GLOBAL", "SaveHtmlFiles", DKDev_OnEvent);
	DKAddEvent("GLOBAL", "OpenFile", DKDev_OnEvent);
	DKAddEvent("GLOBAL", "FileChoice", DKDev_OnEvent);
	
	ignorelist += "DKBuildGUI.html,";
	ignorelist += "DKDev.html,";
	ignorelist += "DKMenuRight.html,";
	
	DKDev_CreateBox();
	DKDev_HideBox();
	DKDev_On();
}

////////////////////
function DKDev_End()
{
	DKRemoveEvent("body", "contextmenu", DKDev_OnEvent);
	DKRemoveEvent("body", "click", DKDev_OnEvent);
	DKRemoveEvent("GLOBAL", "SaveHtmlFiles", DKDev_OnEvent);
	DKRemoveEvent("GLOBAL", "OpenFile", DKDev_OnEvent);
	DKRemoveEvent("GLOBAL", "FileChoice", DKDev_OnEvent);
	DKClose("DKDev/DKDev.html");
}

///////////////////
function DKDev_On()
{
	DKLog("DKDev_On \n", DKDEBUG);
	DKDev_AddDragHandles("body");
	//DKDev_ApplyBox(stored_element);
	devmode = true;
}

////////////////////
function DKDev_Off()
{
	DKLog("DKDev_Off \n", DKDEBUG);
	DKDev_RemoveDragHandles("body");
	DKDev_HideBox();
	devmode = false;
}

/////////////////////////
function DKDev_Ignore(id)
{
	//DKLog("DKDev_Ignore("+id+") \n", DKDEBUG);
	var arry = ignorelist.split(",");
	for(var i=0; i<arry.length; i++){
		if(!arry[i]){ continue; }
		if(DKWidget_IsChildOf(id, arry[i])){return true;}
	}
	return false;
}

/////////////////////////////
function DKDev_OnEvent(event)
{
	DKLog("DKDev_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
	if(devmode == false){ return; }
	
	var target = DK_GetId(event);
	if(DKDev_Ignore(target)){ return; }
	
	if(!DKWidget_ElementExists("DKDev_Box")){
		DKDev_CreateBox();
		DKDev_HideBox();
	}
	
	if(DK_Type(event, "mousedown")){
		var target = DK_GetId(event);
		if(DKWidget_IsChildOf(target, "DKDev_RootMenu.html")){ return; }
		if(DKWidget_IsChildOf(target, "DKDev_Menu.html")){ return; }
		DKDev_SelectElement(target);
		StopPropagation(event);
		return;
	}

	if(DK_Type(event, "contextmenu")){
		var target = DK_GetId(event);
		if(DKWidget_IsChildOf(target, "DKDev_Menu.html")){ return; }
		if(DKWidget_IsChildOf(target, "DKDev_RootMenu.html")){ return; }
		if(target == "DevModeButton"){return;}
		//DKDev_SelectElement(target);
		mouseX = DKWidget_GetMouseWindowX();
		mouseY = DKWidget_GetMouseWindowY();

		if(!DKWidget_ElementExists(stored_element)){
			//stored_element = "body";
			DKDev_SelectElement("");
		}
		storedMouseX = DKWidget_GetMouseElementX(stored_element);
		storedMouseY = DKWidget_GetMouseElementY(stored_element);
		//DKLog("stored_element = "+stored_element, DKINFO);
		//DKLog("storedMouseX = "+storedMouseX, DKINFO);
		
		//FIXME
		/*
		DKLog("target = "+target+"\n", DKINFO)
		if(target == "body"){  //target is always "body" in cef Mac and Linux
			DKCreate("DKDev/DKDev_RootMenu.js", function(){});
			return;
		}
		*/

		DKCreate("DKDev/DKDev_Menu.js", function(){});
		StopPropagation(event);
		return;
	}
	if(DK_Type(event, "Clear")){
		DKDev_ClearEditor();
	}
	if(DK_Type(event, "SaveHtmlFiles")){
		DKDev_SaveHtmlFile(stored_element);
	}
	if(DK_Type(event, "OpenFile")){
		var value = DKWidget_GetValue(event);
		DKLog("OpenFile: "+value+" \n", DKDEBUG)
		DKDev_OpenFile(value);
	}
	if(DK_Type(event, "FileChoice")){
		var value = DKWidget_GetValue(event);
		DKLog("FileChoice: "+value+"\n", DKDEBUG);
	}
}

//////////////////////////
function DKDev_CreateBox()
{
	if(DKWidget_ElementExists("DKDev_Box")){ return; }
	//Control box
	var box = DKWidget_CreateElement("body", "div", "DKDev_Box");
	DKWidget_SetProperty(box, "position", "absolute");
	DKWidget_SetProperty(box, "top", "0rem"); //-1 for border
	DKWidget_SetProperty(box, "left", "0rem"); //-1 for border
	DKWidget_SetProperty(box, "right", "0rem");
	DKWidget_SetProperty(box, "bottom", "0rem");
	DKWidget_SetProperty(box, "border-style", "solid");
	DKWidget_SetProperty(box, "border-color", "red");
	DKWidget_SetProperty(box, "border-width", "1rem");
	DKWidget_SetProperty(box, "pointer-events", "none");

	/*
	//resize dot
	var resizeImg = DKWidget_CreateElement(box, "img", "DKResizeImg");
	DKWidget_SetAttribute(resizeImg, "src", "DKDev/resize2.png");
	DKWidget_SetProperty(resizeImg, "position", "absolute");
	DKWidget_SetProperty(resizeImg, "right", "-9rem");
	DKWidget_SetProperty(resizeImg, "bottom", "-9rem");

	//resize handler
	var resize = DKWidget_CreateElement(resizeImg, "handle", "DKResize");
	DKWidget_SetProperty(resize, "position", "absolute");
	DKWidget_SetProperty(resize, "width", "100%");
	DKWidget_SetProperty(resize, "height", "100%");
	*/
}

////////////////////////
function DKDev_HideBox()
{
	DKWidget_SetProperty("DKDev_Box", "visibility", "hidden");
}

///////////////////////////
function DKDev_ApplyBox(id)
{
	DKLog("DKDev_ApplyBox("+id+")\n", DKINFO);
	//DKWidget_PrependChild(id, "DKDev_Box");
	parent = document.getElementById(id).parentNode;
	DKWidget_AppendChild(parent.id, "DKDev_Box");
	DKWidget_SetProperty("DKDev_Box", "visibility", "visible");
	
	//DKWidget_SetProperty("DKDev_Box", "top", String(DKWidget_GetOffsetTop(id))+"rem");
	//DKWidget_SetProperty("DKDev_Box", "left", String(DKWidget_GetOffsetLeft(id))+"rem");
	//DKWidget_SetProperty("DKDev_Box", "width", String(DKWidget_GetOffsetWidth(id))+"rem");
	//DKWidget_SetProperty("DKDev_Box", "height", String(DKWidget_GetOffsetHeight(id))+"rem");
	
	DKLog("element = "+id+"\n", DKINFO);
	if(DKWidget_HasProperty(id, "top")){
		DKWidget_SetProperty("DKDev_Box", "top", parseInt(DKWidget_GetProperty(id, "top"))-1+"rem");
	}
	else{
		DKWidget_RemoveProperty("DKDev_Box", "top");
	}
	
	if(DKWidget_HasProperty(id, "left")){
		DKWidget_SetProperty("DKDev_Box", "left", parseInt(DKWidget_GetProperty(id, "left"))-1+"rem");
	}
	else{
		DKWidget_RemoveProperty("DKDev_Box", "left");
	}
	
	if(DKWidget_HasProperty(id, "right")){
		DKWidget_SetProperty("DKDev_Box", "right", parseInt(DKWidget_GetProperty(id, "right"))-1+"rem");
	}
	else{
		DKWidget_RemoveProperty("DKDev_Box", "right");
	}
	
	if(DKWidget_HasProperty(id, "bottom")){
		DKWidget_SetProperty("DKDev_Box", "bottom", parseInt(DKWidget_GetProperty(id, "bottom"))-1+"rem");
	}
	else{
		DKWidget_RemoveProperty("DKDev_Box", "bottom");
	}
	
	//if(DKWidget_HasProperty(id, "width") || document.getElementById(id).tagName.indexOf("img") > -1){
		DKWidget_SetProperty("DKDev_Box", "width", String(DKWidget_GetOffsetWidth(id))+"rem");
	//}
	//else{
	//	DKWidget_RemoveProperty("DKDev_Box", "width");
	//}
	
	//if(DKWidget_HasProperty(id, "height") || document.getElementById(id).tagName.indexOf("img") > -1){
		DKWidget_SetProperty("DKDev_Box", "height", String(DKWidget_GetOffsetHeight(id))+"rem");
	//}
	//else{
	//	DKWidget_RemoveProperty("DKDev_Box", "height");
	//}
}

/////////////////////////////////////
function DKDev_SelectElement(element)
{
	DKLog("DKDev_SelectElement("+element+") \n", DKINFO);

	stored_element = element;
	if(stored_element && stored_element.indexOf("body") == -1){
		DKDev_ApplyBox(stored_element);
	}
	else{
		DKDev_HideBox();
	}

	//DKLog("stored_element: "+stored_element+"\n", DKDEBUG);
	DKSendEvent("DKMenuRightEdit.html", "SetElement", stored_element);
	DKSendEvent("DKMenuRight.html", "SetPanel", "Edit");
}

/////////////////////////////////
function DKDev_AddDragHandles(id)
{
	DKLog("DKDev_AddDragHandles("+id+") \n", DKDEBUG);
	
	//RemoveDragHandles(id); //clear any drags first
	var elements = DKWidget_GetElements(id);
	var list = elements.split(",");
	list.unshift(id); //add the root element to the beginning
	//DKLog("AddDragHandles: "+list.toString()+"\n", DKDEBUG);
	
	for(var t=0; t<list.length; t++){
		if(!list[t]){ continue; }
		if(list[t] == "body"){ continue; }
		if(DKWidget_IsChildOf(list[t], "DKDev_Box")){ continue; }
		if(DKWidget_IsChildOf(list[t], "DKDev_RootMenu.html")){ continue; }
		if(DKWidget_IsChildOf(list[t], "DKDev_Menu.html")){ continue; }
		if(DKDev_Ignore(list[t])){ continue; }	
		
		if(DKWidget_AddDragHandle(list[t], list[t])){
			DKLog("DKWidget_AddDragHandle("+list[t]+","+list[t]+") \n", DKDEBUG);
			DKAddEvent(list[t], "contextmenu", DKDev_OnEvent);
			DKAddEvent(list[t], "mousedown", DKDev_OnEvent);
		}
	}
	
	return true;
}

////////////////////////////////////
function DKDev_RemoveDragHandles(id)
{
	DKLog("DKDev_RemoveDragHandles() \n", DKDEBUG);
	var elements = DKWidget_GetElements(id);
	var list = elements.split(",");
	
	for(var i=0; i<list.length; i++){
		if(DKDev_Ignore(list[i])){ continue; }		
		
		//C++ (rocket)
		var tag = DKWidget_GetTagName(list[i]);
		if(tag == "handle"){
			DKWidget_RemoveElement(list[i]);
		}
		
		//JS
		DKWidget_RemoveDragHandle(list[i]);
	}
	
	return true;
}

////////////////////////////
function DKDev_ClearEditor()
{
	var list = DKWidget_GetElements("body");
	var elements = list.split(",");
	for(var i=0; i<elements.length; i++){
		if(elements[i].indexOf(".html") != -1){                 
			DKWidget_RemoveElement(elements[i]);
		}
	}

	return true;
}


////////////////////
function DKDev_Cut()
{
	DKLog("DKDev::Cut() \n", DKDEBUG);
	DKDev_HideBox();   //FIXME: HideBox() will cause a crash when we later Remove an element
	//PrependChild("body", "DKDev_Box");

	//var temp_ele = stored_element;
	var el = DKWidget_GetElements(stored_element);
	var list = el.split(","); 
	for(var i=0; i<list.length; i++){
		DKWidget_RemoveDragHandle(list[i]);
	}

	var string = DKWidget_GetOuterHtml(stored_element);
	DK_SetClipboard(string);

	//FIXME - C++ crashes after this (dirty layout stuff)
	//DKDev_SelectElement("body");
	DKWidget_RemoveElement(stored_element);
	//DKDev_SelectElement("body"); //crash
	stored_element = "body";
	return true;
}

/////////////////////
function DKDev_Copy()
{
	DKLog("DKDev::Copy() \n", DKDEBUG);
	DKDev_HideBox();

	var el = DKWidget_GetElements(stored_element);
	var list = el.split(","); 
	for(var i=0; i<list.length; i++){
		DKWidget_RemoveDragHandle(list[i]);
	}

	var string = DKWidget_GetOuterHtml(stored_element);
	
	DK_SetClipboard(string);
	DKDev_AddDragHandles(stored_element);
	DKDev_ApplyBox(stored_element); //re-apply box outline 
	return false;
}

//////////////////////
function DKDev_Paste()
{
	DKLog("DKDev::Paste() \n", DKDEBUG);

	var string = DK_GetClipboard();
	if(!string){ return false; }
	
	DKLog("\n\n"+string+"\n\n", DKDEBUG);
	//replace id's with available id's
	var place = 0;
	var n = string.indexOf("id=", place);
	while(n != -1){
		place = string.indexOf("\"",n+4);
		var res = string.substring(n+4, place);
		var new_id = DKWidget_GetAvailableId(res);
		string = string.replace("id=\""+res+"\"", "id=\""+new_id+"\"");
		DKLog("Paste: renamed "+res+" to "+new_id+"\n", DKDEBUG);
		n = string.indexOf("id=", place);
	}
	DKLog("\n\n"+string+"\n\n", DKDEBUG);
	
	//Parse the sting into an element
	var temp = DKWidget_CreateElement("body", "temp", "temporary");
	DKWidget_SetInnerHtml(temp, string);
	
	var id = DKWidget_GetFirstChild(temp);
	//DKWidget_SetAttribute(DKWidget_GetFirstChild(temp), "id", id);
	
	DKWidget_SetProperty(id, "position", "absolute");
	DKWidget_SetProperty(id, "top", String(storedMouseY)+"rem");
	DKWidget_SetProperty(id, "left", String(storedMouseX)+"rem");
	
	DKWidget_AppendChild(stored_element, id);
	DKWidget_RemoveElement(temp);
	
	DKDev_AddDragHandles(id);
	DKDev_SelectElement(id);
	return true;
}


////////////////////////
function DKDev_NewPage()
{
	DKLog("DKDev_NewPage() \n", DKDEBUG);
	
	//var id = DKWidget_GetAvailableId("NewWidget.html");
	DKCreate(".html,"+stored_element, function(){
		DKDev_AddDragHandles("New.html");
		//DKDev_SelectElement("New.html");
		DKFrame_Widget("New.html");
	});
	return true;
}


///////////////////////
function DKDev_NewDiv()
{
	var element = DKWidget_CreateElement(stored_element, "div", "Div");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"rem");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"rem");
	DKWidget_SetProperty(element, "width", "100rem");
	DKWidget_SetProperty(element, "height", "100rem");
	DKWidget_SetProperty(element, "background-color", "blue");
	DKDev_AddDragHandles(element);
	DKDev_SelectElement(element);
	return true;
}

////////////////////////
function DKDev_NewText()
{
	var element = DKWidget_CreateElement(stored_element, "div", "Text");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"rem");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"rem");
	DKWidget_SetProperty(element, "width", "50rem");
	DKWidget_SetProperty(element, "height", "18rem");
	DKWidget_SetInnerHtml(element, "Text");
	DKDev_AddDragHandles(element);
	DKDev_SelectElement(element);
	return true;
}

//////////////////////////
function DKDev_NewButton()
{
	var element = DKWidget_CreateElement(stored_element, "button", "Button");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"rem");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"rem");
	DKWidget_SetProperty(element, "width", "50rem");
	DKWidget_SetProperty(element, "height", "22rem");
	DKWidget_SetInnerHtml(element, "Button");
	DKDev_AddDragHandles(element);
	DKDev_SelectElement(element);
	return true;
}

/////////////////////////////
function DKDev_NewImage(file)
{
	DKLog("DKDev_NewImage("+file+") \n", DKDEBUG);
	var element = DKWidget_CreateElement(stored_element, "img", "Image");
	DKWidget_SetAttribute(element, "src", file);
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"rem");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"rem");
	DKDev_AddDragHandles(element);
	DKDev_SelectElement(element);
	return true;
}

///////////////////////////
function DKDev_NewTextbox()
{
	var element = DKWidget_CreateElement(stored_element, "input", "Textbox");
	DKWidget_SetAttribute(element, "type", "text");
	DKWidget_SetAttribute(element, "value", "test");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"rem");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"rem");
	DKDev_AddDragHandles(element);
	DKDev_SelectElement(element);
	return true;
}

////////////////////////////
function DKDev_NewTextarea()
{
	var element = DKWidget_CreateElement(stored_element, "textarea", "Textarea");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"rem");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"rem");
	DKDev_AddDragHandles(element);
	DKDev_SelectElement(element);
	return true;
}

////////////////////////////
function DKDev_NewDropdown()
{
	var element = DKWidget_CreateElement(stored_element, "select", "Dropdown");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"rem");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"rem");
	DKDev_AddDragHandles(element);
	DKDev_SelectElement(element);
	return true;
}

////////////////////////////
function DKDev_NewCheckbox()
{
	var element = DKWidget_CreateElement(stored_element, "input", "Checkbox");
	DKWidget_SetAttribute(element, "type", "checkbox");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"rem");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"rem");
	DKDev_AddDragHandles(element);
	DKDev_SelectElement(element);
	return true;
}

///////////////////////////////
function DKDev_NewRadioButton()
{
	var element = DKWidget_CreateElement(stored_element, "input", "RadioButton");
	DKWidget_SetAttribute(element, "type", "radio");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"rem");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"rem");
	DKDev_AddDragHandles(element);
	DKDev_SelectElement(element);
	return true;
}

//////////////////////////
function DKDev_NewiFrame()
{
	var element = DKWidget_CreateElement(stored_element, "iframe", "DKCefFrame");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"rem");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"rem");
	DKWidget_SetProperty(element, "width", "200rem");
	DKWidget_SetProperty(element, "height", "200rem");
	DKWidget_SetProperty(element, "display", "block");
	DKDev_AddDragHandles(element);
	DKDev_SelectElement(element);
	return false;
}

///////////////////////////
function DKDev_NewVSlider()
{
	var element = DKWidget_CreateElement(stored_element, "input", "VSlider");
	DKWidget_SetAttribute(element, "type", "range");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"rem");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"rem");
	DKDev_AddDragHandles(element);
	DKDev_SelectElement(element);
	return true;
}

///////////////////////////
function DKDev_NewHSlider()
{
	var element = DKWidget_CreateElement(stored_element, "input", "HSlider");
	DKWidget_SetAttribute(element, "type", "range");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"rem");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"rem");
	DKDev_AddDragHandles(element);
	DKDev_SelectElement(element);
	return true;
}

///////////////////////////////
function DKDev_SaveHtmlFile(id)
{
	DKLog("DKDev_SaveHtmlFile("+id+") \n", DKDEBUG);
	var file = DKWidget_GetFile(id);
	if(file.indexOf(".html") == -1){
		DKLog("DKDev_SaveHtmlFile("+id+") Invalid .html file\n", DKERROR);
		return false; 
	}
	//if(DKDev_Ignore(file)){ continue; }
	DKDev_RemoveDragHandles(file);
	DKDev_HideBox();
	//var parent = DKWidget_GetParent(file);
	var list = DKWidget_GetElements(file);
	var arry2 = list.split(",");
	arry2.unshift(file);
	for(var b=0; b<arry2.length; b++){
		DKLog("DKDev_SaveHtmlFile("+id+"), Processing element("+arry2[b]+"). \n", DKINFO);

		if(DKWidget_GetAttribute(arry2[b], "nosave_value")){
			DKLog("DKDev_SaveHtmlFile("+id+"), nosave_value detected. \n", DKINFO);
			DKWidget_RemoveAttribute(arry2[b], "value"); //remove value attributes
		}
		if(!DKWidget_GetAttribute(arry2[b], "value")){
			DKWidget_RemoveAttribute(arry2[b], "value"); //remove value attributes
		}
		if(DKWidget_GetProperty(arry2[b], "overflow-x") == "visible"){
			DKWidget_RemoveProperty(arry2[b], "overflow-x"); //remove redundant property 
		}
		if(DKWidget_GetProperty(arry2[b], "overflow-y") == "visible"){
			DKWidget_RemoveProperty(arry2[b], "overflow-y"); //remove redundant property 
		}

		//FIXME - not working
		//if(DKWidget_GetProperty(arry2[b], "color") == DKWidget_GetProperty(DKWidget_GetParent(arry2[b]), "color")){
		//	DKWidget_RemoveProperty(arry2[b], "color"); //remove redundant property 
		//}
	}
		
	DKLog("Saving: "+file+"\n", DKINFO);
	var data = DKWidget_GetOuterHtml(file);
	if(data){
		var assets = DKAssets_LocalAssets();
		DKFile_StringToFile(data, assets+DKWidget_GetFile(file));
	}
	
	DKDev_AddDragHandles(file);
	DKDev_ApplyBox(stored_element);	 //replace box
}

/////////////////////////////
function DKDev_OpenFile(path)
{
	//DKLog("DKDev_OpenWidget("+path+") \n", DKDEBUG);
	if(path.indexOf(".") == -1 ){ return false; }
	if(path.indexOf(".html") != -1 ){ 
		//DKSendEvent("DKMessage.html", "GetInput", "GLOBAL,FileChoice,FileCHoice"); // To -> DKFileDialog
		//return;
		DKDev_OpenHtml(path); return true; 
	}
	if(path.indexOf(".js") != -1 ){ DKDev_OpenJS(path); return true; }
	if(path.indexOf(".png") != -1 ){ DKDev_OpenImage(path); return true; }
	if(path.indexOf(".bmp") != -1 ){ DKDev_OpenImage(path); return true; }
	if(path.indexOf(".gif") != -1 ){ DKDev_OpenImage(path); return true; }
	if(path.indexOf(".jpeg") != -1 ){ DKDev_OpenImage(path); return true; }
	if(path.indexOf(".jpg") != -1 ){ DKDev_OpenImage(path); return true; }
	if(path.indexOf(".tiff") != -1 ){ DKDev_OpenImage(path); return true; }
	if(path.indexOf(".tif") != -1 ){ DKDev_OpenImage(path); return true; }
	if(path.indexOf(".osgt") != -1 ){ DKDev_OpenModel(path); return true; }
	if(path.indexOf(".osg") != -1 ){ DKDev_OpenModel(path); return true; }
	if(path.indexOf(".wav") != -1 ){ DKDev_OpenAudio(path); return true; }
	if(path.indexOf(".mp3") != -1 ){ DKDev_OpenAudio(path); return true; }
	if(path.indexOf(".avi") != -1 ){ DKDev_OpenVideo(path); return true; }
	if(path.indexOf(".mkv") != -1 ){ DKDev_OpenVideo(path); return true; }
	if(path.indexOf(".mp4") != -1 ){ DKDev_OpenVideo(path); return true; }
	DKDev_OpenText(path); return true;
}

/////////////////////////////
function DKDev_OpenHtml(path)
{
	//DKLog("DKDev_OpenHtml("+path+") \n", DKDEBUG);
	var id = DKFile_GetFilename(path);
	DKCreate(path, function(){
		DKDev_AddDragHandles(id);
		DKFrame_Widget(id);
		//DKDev_SelectElement(id);
	});
	
	
	//FIXME
	return;
	
	//TODO - to use files outside of the data directory, we need to append the datapath
	//var the_path = path.replace(id, "");
	//DKLog("DKWidget_AppendDataPath("+the_path+") \n", DKDEBUG);
	//AppendDataPath(the_path);

	var filedata = DKFile_FileToString(path);
	if(!filedata){ return false; }
	//if(!HtmlToRml(filedata)){ return false; }

	//Parse the sting into an element
	var temp = DKWidget_CreateElement("body", "temp", "temporary");
	DKWidget_SetInnerHtml(temp, filedata);

	//if(DKWidget_GetNumChildren(temp) == 0){
	//	DKLog("Error loading path: "+id+": could not create node. \n", DKERROR);
	//	return false;
	//}

	//Make sure there is only 1 child
	//if(DKWidget_GetNumChildren(temp) > 1){
	//	DKLog("Error loading path: "+id+" has more than one root node.\n", DKERROR);
	//	return false;
	//}

	DKLog("temp: "+temp+"\n", DKDEBUG);
	var element = DKWidget_GetFirstChild(temp);
	DKLog("element = "+element+"\n", DKDEBUG);
	//DKElement* element = temp->GetFirstChild();
	//DKWidget_SetAttribute(element, "id", id);
	
	DKWidget_AppendChild("body", element);
	DKWidget_RemoveElement("temporary");
	//Show(id);
	DKDev_AddDragHandles(id);
	DKDev_SelectElement(id);
}

///////////////////////////
function DKDev_OpenJS(path)
{
	var id = DKFile_GetFilename(path);
	id = id.replace(".js",".html");
	DKCreate(path, function(){
		DKFrame_Widget(id);
	});
}

/////////////////////////////
function DKDev_OpenText(path)
{
	DKWidget_Toggle("DKNotepad.html");
	DKCreate("DKNotepad/DKNotepad.js", function(){
		DKFrame_Widget("DKNotepad.html");
		DKNotepad_Open(path);
	});
}

//////////////////////////////
function DKDev_OpenImage(path)
{
	DKDev_NewImage(path);
}

//////////////////////////////
function DKDev_OpenModel(path)
{
	DKCreate("DKOSGManipulator,,DKOSGWindow", function(){});
	DKCreate("DKOSGModel,,DKWindow,"+path, function(){});
}

//////////////////////////////
function DKDev_OpenAudio(path)
{
	DKLog("DKDev_OpenAudio("+path+") \n");
	//var file = DKFile_GetFilename(path);
	DKCreate("DKAudio", function(){
		DKAudio_PlaySound(path);
	});
	
	//DKCreate("DKOSGAudio,"+file+",DKOSGWindow,"+path);
	//DKOSGAudio_Play("DKOSGAudio,"+file);
	
	//DKCreate("DKSDLAudio,"+file+",DKSDLWindow,"+path);
	//DKSDLAudio_Play("DKSDLAudio,"+file);
}

//////////////////////////////
function DKDev_OpenVideo(path)
{
	DKCreate("DKOSGManipulator,,DKOSGWindow", function(){
		DKOSGVideo_Play(path);
	});
	//DKCreate("DKOSGVideo,,DKOSGWindow,"+path);
}