var MenuRight_element = "";

///////////////////////////////
function DKMenuRightEdit_Init()
{
	DKCreate("DKDev/DKMenuRightEdit.html,DKMenuRight.html", function(){});
	DKAddEvent("DKMenuRightEdit.html", "SetElement", DKMenuRightEdit_OnEvent);
	DKAddEvent("DKMenuRightEdit.html", "background_color", DKMenuRightEdit_OnEvent);
	DKAddEvent("DKMenuRightEdit.html", "foreground_color", DKMenuRightEdit_OnEvent);
	//DKAddEvent("drag", DKMenuRightEdit_OnEvent);
	//DKAddEvent("keydown", DKMenuRightEdit_OnEvent);
	DKAddEvent("InfoTab", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("PositionTab", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("ColorTab", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("TextTab", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("InnerHtmlTab", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("SaveHtml", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("DKParent", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("display-block", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("display-inline-block", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("display-inline", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("display-none", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("position-auto", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("position-relative", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("position-absolute", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("position-fixed", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("overflow-visible", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("overflow-hidden", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("overflow-scroll", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("overflow-auto", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("DKBGColor", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("DKFGColor", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("InfoFile", "input", DKMenuRightEdit_OnEvent);
	DKAddEvent("InfoId", "input", DKMenuRightEdit_OnEvent);
	DKAddEvent("width_box", "input", DKMenuRightEdit_OnEvent);
	DKAddEvent("height_box", "input", DKMenuRightEdit_OnEvent);
	DKAddEvent("top_Textbox", "input", DKMenuRightEdit_OnEvent);
	DKAddEvent("left_Textbox", "input", DKMenuRightEdit_OnEvent);
	DKAddEvent("right_Textbox", "input", DKMenuRightEdit_OnEvent);
	DKAddEvent("bottom_Textbox", "input", DKMenuRightEdit_OnEvent);
	DKAddEvent("topMargin_Textbox", "input", DKMenuRightEdit_OnEvent);
	DKAddEvent("leftMargin_Textbox", "input", DKMenuRightEdit_OnEvent);
	DKAddEvent("rightMargin_Textbox", "input", DKMenuRightEdit_OnEvent);
	DKAddEvent("bottomMargin_Textbox", "input", DKMenuRightEdit_OnEvent);
	DKAddEvent("FontSize_Textbox", "input", DKMenuRightEdit_OnEvent);
	DKAddEvent("InnerHtmlText", "input", DKMenuRightEdit_OnEvent);
	DKAddEvent("ValueBox", "input", DKMenuRightEdit_OnEvent);
	DKAddEvent("bold_Image", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("italic_Image", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("align-left_Image", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("align-center_Image", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("align-right_Image", "click", DKMenuRightEdit_OnEvent);
	DKAddEvent("align-justify_Image", "click", DKMenuRightEdit_OnEvent);	
}

//////////////////////////////
function DKMenuRightEdit_End()
{
	DKRemoveEvents(DKMenuRightEdit_OnEvent);
	DKClose("DKDev/DKMenuRightEdit.html");
}

///////////////////////////////////////
function DKMenuRightEdit_OnEvent(event)
{
	DKLog("DKMenuRightEdit_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "SetElement")){
		DKMenuRightEdit_SetElement(DK_GetValue(event));
	}
	if(DK_Id(event,"InfoTab")){
		DKWidget_Toggle("InfoSection");
	}
	if(DK_Id(event,"PositionTab")){
		DKWidget_Toggle("PositionSection");
		DKWidget_Toggle("PositionSection2");
		DKWidget_Toggle("MarginSection");
	}
	if(DK_Id(event,"ColorTab")){
		DKWidget_Toggle("ColorSection");
	}
	if(DK_Id(event,"TextTab")){
		DKWidget_Toggle("TextSection");
	}
	if(DK_Id(event,"InnerHtmlTab")){
		DKWidget_Toggle("InnerHtmlSection");
	}
	if(DK_Id(event,"DKParent")){
		DKMenuRightEdit_SetElement(DKWidget_GetInnerHtml("DKParent"));
    }
	if(DK_Id(event,"display-block")){
		DKMenuRightEdit_SetDisplay("block");
	}
	if(DK_Id(event,"display-inline-block")){
		DKMenuRightEdit_SetDisplay("inline-block");
	}
	if(DK_Id(event,"display-inline")){
		DKMenuRightEdit_SetDisplay("inline");
	}
	if(DK_Id(event,"display-none")){
		DKMenuRightEdit_SetDisplay("none");
	}
	if(DK_Id(event,"position-auto")){
		DKMenuRightEdit_SetPosition("static");
	}
	if(DK_Id(event,"position-relative")){
		DKMenuRightEdit_SetPosition("relative");
	}
	if(DK_Id(event,"position-absolute")){
		DKMenuRightEdit_SetPosition("absolute");
	}
	if(DK_Id(event,"position-fixed")){
		DKMenuRightEdit_SetPosition("fixed");
	}
	if(DK_Id(event,"overflow-visible")){
		DKMenuRightEdit_SetOverflow("visible");
	}
	if(DK_Id(event,"overflow-hidden")){
		DKMenuRightEdit_SetOverflow("hidden");
	}
	if(DK_Id(event,"overflow-scroll")){
		DKMenuRightEdit_SetOverflow("scroll");
	}
	if(DK_Id(event,"overflow-auto")){
		DKMenuRightEdit_SetOverflow("auto");
	}
	if(DK_Id(event,"DKBGColor")){
		DKCreate("DKColorPicker/DKColorPicker.js", function(){
			DKFrame_Widget("DKColorPicker.html");
			DKSendEvent("DKColorPicker.html", "GetColor", "DKMenuRightEdit.html,background_color");
		});
	}
	if(DK_Id(event,"DKFGColor")){
		DKCreate("DKColorPicker/DKColorPicker.js", function(){
			DKFrame_Widget("DKColorPicker.html");
			DKSendEvent("DKColorPicker.html", "GetColor", "DKMenuRightEdit.html,foreground_color");
		});
	}
	if(DK_Type(event,"background_color")){
		var color = DK_GetValue(event);
		color = DKWidget_ValidateColor(color);
		//DKLog("\n\n"+color+"\n")
		DKWidget_SetProperty("DKBGColor", "background-color", color);
		DKWidget_SetProperty(MenuRight_element, "background-color", color);
	}
	if(DK_Type(event,"foreground_color")){
		var color = DK_GetValue(event);
		color = DKWidget_ValidateColor(color);
		DKWidget_SetProperty("DKFGColor", "background-color", color);
		DKWidget_SetProperty(MenuRight_element, "color", color);
	}
	if(DK_Id(event, "InfoFile")){
		//DKLog(DK_GetValue(event)+"\n");
		DKWidget_SetFile(MenuRight_element, DK_GetValue(event));
	}
	if(DK_Id(event, "InfoId")){
		DKWidget_SetAttribute(MenuRight_element, "id", DK_GetValue(event));
		MenuRight_element = DK_GetValue(event);
	}
	if(DK_Id(event, "width_box")){
		var value = DK_GetValue(event);
		value = DKMenuRightEdit_ValidatePosition(value);
		DKWidget_SetProperty(MenuRight_element, "width", value);
	}
	if(DK_Id(event, "height_box")){
		var value = DK_GetValue(event);
		value = DKMenuRightEdit_ValidatePosition(value);
		DKWidget_SetProperty(MenuRight_element, "height", value);
	}
	if(DK_Id(event, "top_Textbox")){
		var value = DK_GetValue(event);
		value = DKMenuRightEdit_ValidatePosition(value);
		DKWidget_SetProperty(MenuRight_element, "top", value);
	}
	if(DK_Id(event, "left_Textbox")){
		var value = DK_GetValue(event);
		value = DKMenuRightEdit_ValidatePosition(value);
		DKWidget_SetProperty(MenuRight_element, "left", value);
	}
	if(DK_Id(event, "right_Textbox")){
		var value = DK_GetValue(event);
		value = DKMenuRightEdit_ValidatePosition(value);
		DKWidget_SetProperty(MenuRight_element, "right", value);
	}
	if(DK_Id(event, "bottom_Textbox")){
		var value = DK_GetValue(event);
		value = DKMenuRightEdit_ValidatePosition(value);
		DKWidget_SetProperty(MenuRight_element, "bottom", value);
	}
	if(DK_Id(event, "topMargin_Textbox")){
		var value = DK_GetValue(event);
		value = DKMenuRightEdit_ValidatePosition(value);
		DKWidget_SetProperty(MenuRight_element, "margin-top", value);
	}
	if(DK_Id(event, "leftMargin_Textbox")){
		var value = DK_GetValue(event);
		value = DKMenuRightEdit_ValidatePosition(value);
		DKWidget_SetProperty(MenuRight_element, "margin-left", value);
	}
	if(DK_Id(event, "rightMargin_Textbox")){
		var value = DK_GetValue(event);
		value = DKMenuRightEdit_ValidatePosition(value);
		DKWidget_SetProperty(MenuRight_element, "margin-right", value);
	}
	if(DK_Id(event, "bottomMargin_Textbox")){
		var value = DK_GetValue(event);
		value = DKMenuRightEdit_ValidatePosition(value);
		DKWidget_SetProperty(MenuRight_element, "margin-bottom", value);
	}
	if(DK_Id(event, "FontSize_Textbox")){
		var value = DK_GetValue(event);
		value = DKMenuRightEdit_ValidatePosition(value);
		DKWidget_SetProperty(MenuRight_element, "font-size", value);
	}
	if(DK_Id(event,"SaveHtml")){
		DKSendEvent("GLOBAL", "SaveHtmlFiles", "");
		StopPropagation(event);
	}
	if(DK_Id(event,"bold_Image")){
		if(DKWidget_GetProperty(MenuRight_element, "font-weight") == "bold"){
			DKWidget_SetProperty(MenuRight_element, "font-weight", "normal");
			DKWidget_SetAttribute("bold_Image", "src", "DKDev/bold.png");
		}
		else{
			DKWidget_SetProperty(MenuRight_element, "font-weight", "bold");
			DKWidget_SetAttribute("bold_Image", "src", "DKDev/bold-select.png");
		}
	}
	if(DK_Id(event,"italic_Image")){
		if(DKWidget_GetProperty(MenuRight_element, "font-style") == "italic"){
			DKWidget_SetProperty(MenuRight_element, "font-style", "normal");
			DKWidget_SetAttribute("italic_Image", "src", "DKDev/italic.png");
		}
		else{
			DKWidget_SetProperty(MenuRight_element, "font-style", "italic");
			DKWidget_SetAttribute("italic_Image", "src", "DKDev/italic-select.png");
		}
	}
	if(DK_Id(event,"align-left_Image")){
		DKMenuRightEdit_SetTextAlign("left");
	}
	if(DK_Id(event,"align-center_Image")){
		DKMenuRightEdit_SetTextAlign("center");
	}
	if(DK_Id(event,"align-right_Image")){
		DKMenuRightEdit_SetTextAlign("right");
	}
	if(DK_Id(event,"align-justify_Image")){
		DKMenuRightEdit_SetTextAlign("justify");
	}
	if(DK_Id(event,"ValueBox")){
		var value = DK_GetValue(event);
		DKWidget_SetValue(MenuRight_element, value);
	}
	if(DK_Id(event,"InnerHtmlText")){
		DKWidget_SetInnerHtmlString(MenuRight_element, DK_GetValue(event));
    }
}

///////////////////////////////////////
function DKMenuRightEdit_SetElement(id)
{
	DKLog("DKMenuRightEdit_SetElement("+id+") \n");
	
	MenuRight_element = id;

	var file = DKWidget_GetFile(id);
	DKWidget_SetValue("InfoFile", file);

	DKWidget_SetValue("InfoId", id);
	
	var parId = DKWidget_GetParent(MenuRight_element);
	DKWidget_SetInnerHtml("DKParent", parId);
	
	var display = DKWidget_GetProperty(MenuRight_element, "display");
	DKMenuRightEdit_SetDisplay(display);
	
	var overflow = DKWidget_GetProperty(MenuRight_element, "overflow-x");
	DKMenuRightEdit_SetOverflow(overflow);
	
	var position = DKWidget_GetProperty(MenuRight_element, "position");
	DKMenuRightEdit_SetPosition(position);
	
	var textalign = DKWidget_GetProperty(MenuRight_element, "text-align");
	DKMenuRightEdit_SetTextAlign(textalign);
	 
	DKWidget_SetValue("width_box", DKWidget_GetProperty(MenuRight_element, "width"));
	DKWidget_SetValue("height_box", DKWidget_GetProperty(MenuRight_element, "height"));
	DKWidget_SetValue("top_Textbox", DKWidget_GetProperty(MenuRight_element, "top"));
	DKWidget_SetValue("left_Textbox", DKWidget_GetProperty(MenuRight_element, "left"));
	DKWidget_SetValue("right_Textbox", DKWidget_GetProperty(MenuRight_element, "right"));
	DKWidget_SetValue("bottom_Textbox", DKWidget_GetProperty(MenuRight_element, "bottom"));
	DKWidget_SetValue("topMargin_Textbox", DKWidget_GetProperty(MenuRight_element, "margin-top"));
	DKWidget_SetValue("leftMargin_Textbox", DKWidget_GetProperty(MenuRight_element, "margin-left"));
	DKWidget_SetValue("rightMargin_Textbox", DKWidget_GetProperty(MenuRight_element, "margin-right"));
	DKWidget_SetValue("bottomMargin_Textbox", DKWidget_GetProperty(MenuRight_element, "margin-bottom"));
	DKWidget_SetValue("FontSize_Textbox", DKWidget_GetProperty(MenuRight_element, "font-size"));
	DKWidget_SetValue("ValueBox", DKWidget_GetValue(MenuRight_element));
	
	var bgColor = DKWidget_GetProperty(MenuRight_element, "background-color");
	bgColor = DKWidget_ValidateColor(bgColor);
	DKWidget_SetProperty("DKBGColor", "background-color", bgColor);

	var fgColor = DKWidget_GetProperty(MenuRight_element, "color");
	fgColor = DKWidget_ValidateColor(fgColor);
	DKWidget_SetProperty("DKFGColor", "background-color", fgColor);
	
	if(DKWidget_GetProperty(MenuRight_element, "font-weight") == "bold"){
		DKWidget_SetAttribute("bold_Image", "src", "DKDev/bold-select.png");
	}
	else{
		DKWidget_SetAttribute("bold_Image", "src", "DKDev/bold.png");
	}
	
	if(DKWidget_GetProperty(MenuRight_element, "font-style") == "italic"){
		DKWidget_SetAttribute("italic_Image", "src", "DKDev/italic-select.png");
	}
	else{
		DKWidget_SetAttribute("italic_Image", "src", "DKDev/italic.png");
	}
	
	var innerHtml = DKWidget_GetInnerHtmlString(MenuRight_element);
	DKWidget_SetValue("InnerHtmlText", innerHtml);
}

////////////////////////////////////////////
function DKMenuRightEdit_SetDisplay(display)
{
	DKWidget_SetAttribute("display-block", "src", "DKDev/display-block.png");
	DKWidget_SetAttribute("display-inline-block", "src", "DKDev/display-inline-block.png");
	DKWidget_SetAttribute("display-inline", "src", "DKDev/display-inline.png");
	DKWidget_SetAttribute("display-none", "src", "DKDev/display-none.png");
	if(!display){ display = "block"; } //default 
	if(display == "block"){
		DKWidget_SetAttribute("display-block", "src", "DKDev/display-block-select.png");
	}
	if(display == "inline-block"){
		DKWidget_SetAttribute("display-inline-block", "src", "DKDev/display-inline-block-select.png");
	}
	if(display == "inline"){
		DKWidget_SetAttribute("display-inline", "src", "DKDev/display-inline-select.png");
	}
	if(display == "none"){
		DKWidget_SetAttribute("display-none", "src", "DKDev/display-none-select.png");
	}

	if(MenuRight_element){
		DKWidget_SetProperty(MenuRight_element, "display", display);
	}
	return true;
}

//////////////////////////////////////////////
function DKMenuRightEdit_SetOverflow(overflow)
{
	DKWidget_SetAttribute("overflow-visible", "src", "DKDev/overflow-visible.png");
	DKWidget_SetAttribute("overflow-hidden", "src", "DKDev/overflow-hidden.png");
	DKWidget_SetAttribute("overflow-scroll", "src", "DKDev/overflow-scroll.png");
	DKWidget_SetAttribute("overflow-auto", "src", "DKDev/overflow-auto.png");
	if(!overflow){ overflow = "visible"; } //default
	if(overflow == "visible"){
		DKWidget_SetAttribute("overflow-visible", "src", "DKDev/overflow-visible-select.png");
	}
	if(overflow == "hidden"){
		DKWidget_SetAttribute("overflow-hidden", "src", "DKDev/overflow-hidden-select.png");
	}
	if(overflow == "scroll"){
		DKWidget_SetAttribute("overflow-scroll", "src", "DKDev/overflow-scroll-select.png");
	}
	if(overflow == "auto"){
		DKWidget_SetAttribute("overflow-auto", "src", "DKDev/overflow-auto-select.png");
	}

	DKWidget_SetProperty(MenuRight_element, "overflow-x", overflow);
	DKWidget_SetProperty(MenuRight_element, "overflow-y", overflow);
	return true;
}

//////////////////////////////////////////////
function DKMenuRightEdit_SetPosition(position)
{
	DKWidget_SetAttribute("position-auto", "src", "DKDev/position-auto.png");
	DKWidget_SetAttribute("position-relative", "src", "DKDev/position-relative.png");
	DKWidget_SetAttribute("position-absolute", "src", "DKDev/position-absolute.png");
	DKWidget_SetAttribute("position-fixed", "src", "DKDev/position-fixed.png");
	if(!position || position == "0"){ position = "static"; } //default
	if(position == "static"){
		DKWidget_SetAttribute("position-auto", "src", "DKDev/position-auto-select.png");
	}
	if(position == "relative"){
		DKWidget_SetAttribute("position-relative", "src", "DKDev/position-relative-select.png");
	}
	if(position == "absolute"){
		DKWidget_SetAttribute("position-absolute", "src", "DKDev/position-absolute-select.png");
	}
	if(position == "fixed"){
		DKWidget_SetAttribute("position-fixed", "src", "DKDev/position-fixed-select.png");
	}

	DKWidget_SetProperty(MenuRight_element, "position", position);
	return true;
}

////////////////////////////////////////////
function DKMenuRightEdit_SetTextAlign(align)
{
	DKWidget_SetAttribute("align-left_Image", "src", "DKDev/align-left.png");
	DKWidget_SetAttribute("align-center_Image", "src", "DKDev/align-center.png");
	DKWidget_SetAttribute("align-right_Image", "src", "DKDev/align-right.png");
	DKWidget_SetAttribute("align-justify_Image", "src", "DKDev/align-justify.png");
	
	if(!align || align == "0"){ align = ""; } //default
	if(align == "left"){
		DKWidget_SetAttribute("align-left_Image", "src", "DKDev/align-left-select.png");
	}
	if(align == "center"){
		DKWidget_SetAttribute("align-center_Image", "src", "DKDev/align-center-select.png");
	}
	if(align == "right"){
		DKWidget_SetAttribute("align-right_Image", "src", "DKDev/align-right-select.png");
	}
	if(align == "justify"){
		DKWidget_SetAttribute("align-justify_Image", "src", "DKDev/align-justify-select.png");
	}

	DKWidget_SetProperty(MenuRight_element, "text-align", align);
	return true;
}

////////////////////////////////////////////////
function DKMenuRightEdit_ValidatePosition(value)
{
	if(!value){ return value; }
	if(value == "auto"){ return value; }
	var ext = "rem";
	value = value.replace("rem", "");
	value = value.replace("re", "");
	value = value.replace("r", "");
	if(value.indexOf("%") > -1){
		value = value.replace("%", "");
		ext = "%";
	}

	if(!isNaN(value)){
		if(value > 0){
			value += ext;
			return value;
		}
		value = "0";
		value += ext;
		return value;
	}

	value = "0rem";
	return value;
}
