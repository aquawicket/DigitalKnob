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
	DKRemoveEvent("GLOBAL", "SaveHtmlFiles", DKDev_OnEvent);
	DKRemoveEvent("GLOBAL", "OpenFile", DKDev_OnEvent);
	DKRemoveEvent("GLOBAL", "FileChoice", DKDev_OnEvent);
	DKRemoveEvents(DKDev_OnEvent);
	DKClose("DKDev/DKDev.html");
}

/////////////////////////////
function DKDev_OnEvent(event)
{
	//DKLog("DKDev_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(devmode == false){ return; }
	
	var target = DK_GetId(event);
	if(DKDev_Ignore(target)){ return; }
	
	if(!DKWidget_ElementExists("DKDev_Box")){
		DKDev_CreateBox();
		DKDev_HideBox();
	}
	
	if(DK_Type(event, "move")){
		//DKLog("DKDev_OnEvent("+DK_GetId(event)+"): move event \n");
		if(target == "DKResizeImg"){ 
			DKDev_Resize(stored_element);
		}
		else{
			DKDev_ApplyBox(DK_GetId(event));
		}
		if(DK_GetBrowser() != "Rocket"){
			DK_StopPropagation(event);  //TODO - link to Duktape function
		}
		return;
	}
	
	if(DK_Type(event, "mousedown")){
		var target = DK_GetId(event);
		if(DKWidget_IsChildOf(target, "DKDev_RootMenu.html")){ return; }
		if(DKWidget_IsChildOf(target, "DKDev_Menu.html")){ return; }
		if(target == "DKResizeImg"){ 
			if(DK_GetBrowser() != "Rocket"){
				DK_StopPropagation(event);
			}
			return; 
		}
		DKDev_SelectElement(target);
		if(DK_GetBrowser() != "Rocket"){
			DK_StopPropagation(event);
		}
		return;
	}

	if(DK_Type(event, "contextmenu")){
		DKLog("DKDev_OnEvent(): contextmenu \n");
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
		//DKLog("stored_element = "+stored_element);
		//DKLog("storedMouseX = "+storedMouseX);
		
		//FIXME
		//DKLog("target = "+target+"\n", DKINFO)
		//if(target == "body"){  //target is always "body" in cef Mac and Linux
		//	DKCreate("DKDev/DKDev_RootMenu.js", function(){});
		//	return;
		//}

		DKCreate("DKDev/DKDev_Menu.js", function(){});
		if(DK_GetBrowser() != "Rocket"){
			DK_StopPropagation(event);
		}
		return;
	}
	if(DK_Type(event, "Clear")){
		DKDev_ClearEditor();
	}
	if(DK_Type(event, "SaveHtmlFiles")){
		DKDev_SaveHtmlFile(stored_element);
	}
	if(DK_Type(event, "OpenFile")){
		var value = DK_GetValue(event);
		DKLog("OpenFile: "+value+" \n", DKDEBUG)
		DKDev_OpenFile(value);
	}
	if(DK_Type(event, "FileChoice")){
		var value = DK_GetValue(event);
		DKLog("FileChoice: "+value+"\n");
	}
}

///////////////////
function DKDev_On()
{
	DKLog("DKDev_On \n");
	DKDev_AddDragHandles("body");
	//DKDev_ApplyBox(stored_element);
	devmode = true;
}

////////////////////
function DKDev_Off()
{
	DKLog("DKDev_Off \n");
	DKDev_RemoveDragHandles("body");
	DKDev_HideBox();
	devmode = false;
}

/////////////////////////
function DKDev_Ignore(id)
{
	//DKLog("DKDev_Ignore("+id+") \n");
	var arry = ignorelist.split(",");
	for(var i=0; i<arry.length; i++){
		if(!arry[i]){ continue; }
		if(DKWidget_IsChildOf(id, arry[i])){return true;}
	}
	return false;
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

	//resize dot
	var resizeImg = DKWidget_CreateElement(box, "img", "DKResizeImg");
	DKWidget_SetAttribute(resizeImg, "src", "DKDev/resize2.png");
	DKWidget_SetProperty(resizeImg, "position", "absolute");
	//DKWidget_SetProperty(resizeImg, "right", "-9rem");
	//DKWidget_SetProperty(resizeImg, "bottom", "-9rem");
	//DKWidget_SetProperty(resizeImg, "left", "0rem");
	//DKWidget_SetProperty(resizeImg, "top", "0rem");

	//resize handler
	//var resize = DKWidget_CreateElement(resizeImg, "handle", "DKResize");
	//DKWidget_SetProperty(resize, "position", "absolute");
	//DKWidget_SetProperty(resize, "width", "100%");
	//DKWidget_SetProperty(resize, "height", "100%");
	DKWidget_AddDragHandle(resizeImg, resizeImg);
	//DKAddEvent(resizeImg, "contextmenu", DKDev_OnEvent);
	DKAddEvent(resizeImg, "mousedown", DKDev_OnEvent);
	DKAddEvent(resizeImg, "move", DKDev_OnEvent); //TODO for libRocket
}

////////////////////////
function DKDev_HideBox()
{
	DKWidget_SetProperty("DKDev_Box", "visibility", "hidden");
}

///////////////////////////
function DKDev_ApplyBox(id)
{
	//DKLog("DKDev_ApplyBox("+id+")\n");
	if(id.indexOf("body") > -1){ return; }
	
	var parentid = DKWidget_GetParent(id);
	DKWidget_AppendChild(parentid, "DKDev_Box");
	DKWidget_SetProperty("DKDev_Box", "visibility", "visible");
	
	//DKLog("element = "+id+"\n");
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
		DKWidget_SetProperty("DKResizeImg", "left", String(DKWidget_GetOffsetWidth(id))+"rem");
	
	//}
	//else{
	//	DKWidget_RemoveProperty("DKDev_Box", "width");
	//}
	
	//if(DKWidget_HasProperty(id, "height") || document.getElementById(id).tagName.indexOf("img") > -1){
		DKWidget_SetProperty("DKDev_Box", "height", String(DKWidget_GetOffsetHeight(id))+"rem");
		DKWidget_SetProperty("DKResizeImg", "top", String(DKWidget_GetOffsetHeight(id))+"rem");
	//}
	//else{
	//	DKWidget_RemoveProperty("DKDev_Box", "height");
	//}
}

/////////////////////////
function DKDev_Resize(id)
{
	//DKLog("DKDev_Resize("+id+")\n");
	//DKLog("DKResizeImg: left = "+DKWidget_GetProperty("DKResizeImg", "left")+"\n");
	//DKLog("DKResizeImg: top = "+DKWidget_GetProperty("DKResizeImg", "top")+"\n");
	DKWidget_SetProperty(id, "width", DKWidget_GetProperty("DKResizeImg", "left"));
	DKWidget_SetProperty(id, "height", DKWidget_GetProperty("DKResizeImg", "top"));
	DKDev_ApplyBox(id);
}

////////////////////////////////
function DKDev_SelectElement(id)
{
	//DKLog("DKDev_SelectElement("+id+") \n");
	
	if(id.indexOf("body") > -1){ 
		//stored_element = "";
	}
	else{
		stored_element = id;
	}
	
	if(stored_element){
		DKDev_ApplyBox(stored_element);
	}
	else{
		DKDev_HideBox();
	}

	//DKLog("stored_element: "+stored_element+"\n");
	DKSendEvent("DKMenuRightEdit.html", "SetElement", stored_element);
	DKSendEvent("DKMenuRight.html", "SetPanel", "Edit");
}

/////////////////////////////////
function DKDev_AddDragHandles(id)
{
	DKLog("DKDev_AddDragHandles("+id+") \n");
	
	//RemoveDragHandles(id); //clear any drags first
	var elements = DKWidget_GetElements(id);
	var list = elements.split(",");
	list.unshift(id); //add the root element to the beginning
	//DKLog("AddDragHandles: "+list.toString()+"\n");
	
	for(var t=0; t<list.length; t++){
		if(!list[t]){ continue; }
		if(list[t] == "html"){ continue; }
		if(list[t] == "body"){ continue; }
		if(DKWidget_IsChildOf(list[t], "DKDev_Box")){ continue; }
		if(DKWidget_IsChildOf(list[t], "DKDev_RootMenu.html")){ continue; }
		if(DKWidget_IsChildOf(list[t], "DKDev_Menu.html")){ continue; }
		if(DKDev_Ignore(list[t])){ continue; }	
		
		if(DKWidget_AddDragHandle(list[t], list[t])){
			DKLog("DKWidget_AddDragHandle("+list[t]+","+list[t]+") \n");
			DKAddEvent(list[t], "contextmenu", DKDev_OnEvent);
			DKAddEvent(list[t], "mousedown", DKDev_OnEvent);
			DKAddEvent(list[t], "move", DKDev_OnEvent); //TODO for libRocket
		}		
	}
	
	//DKAddEvent(id, "mousedown", DKDev_OnEvent);
	//DKAddEvent(id, "contextmenu", DKDev_OnEvent);
	return true;
}

////////////////////////////////////
function DKDev_RemoveDragHandles(id)
{
	DKLog("DKDev_RemoveDragHandles() \n");
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
	DKLog("DKDev::Cut() \n");
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
	DKLog("DKDev::Copy() \n");
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
	DKLog("DKDev::Paste() \n");

	var string = DK_GetClipboard();
	if(!string){ return false; }
	
	DKLog("\n\n"+string+"\n\n");
	//replace id's with available id's
	var place = 0;
	var n = string.indexOf("id=", place);
	while(n != -1){
		place = string.indexOf("\"",n+4);
		var res = string.substring(n+4, place);
		var new_id = DKWidget_GetAvailableId(res);
		string = string.replace("id=\""+res+"\"", "id=\""+new_id+"\"");
		DKLog("Paste: renamed "+res+" to "+new_id+"\n");
		n = string.indexOf("id=", place);
	}
	DKLog("\n\n"+string+"\n\n");
	
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
	DKLog("DKDev_NewPage("+stored_element+") \n");
	
	//var id = DKWidget_GetAvailableId("NewWidget.html");
	DKCreate(".html,"+stored_element, function(){
		DKFrame_Widget("New.html");
		DKDev_AddDragHandles("New.html");
		//DKDev_SelectElement("New.html");
	});
	return true;
}


///////////////////////
function DKDev_NewDiv()
{
	DKLog("DKDev_NewDiv("+stored_element+") \n");
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
	DKLog("DKDev_NewImage("+file+") \n");
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
	DKLog("DKDev_SaveHtmlFile("+id+") \n");
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
		DKLog("DKDev_SaveHtmlFile("+id+"), Processing element("+arry2[b]+"). \n");

		if(DKWidget_GetAttribute(arry2[b], "nosave_value")){
			DKLog("DKDev_SaveHtmlFile("+id+"), nosave_value detected. \n");
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
		
	DKLog("Saving: "+file+"\n");
	var data = DKWidget_GetOuterHtml(file);
	if(data){
		var assets = DKAssets_LocalAssets();
		DKFile_StringToFile(data, assets+DKWidget_GetFile(file));
	}
	
	DKDev_AddDragHandles(file);
	DKDev_ApplyBox(stored_element);	 //replace box
}