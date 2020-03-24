#ifdef USE_DKRocket
#include "DK/stdafx.h"
#include "Controls/ElementTextSelection.h"
#include "Controls/WidgetTextInput.h"
#include "DK/DKEvent.h"
#include "DK/DKFile.h"
#include "DKThread/DKThread.h"
#include "DKRocket/DKRocketToRML.h"
#include "DKWidget/DKWidget.h"
#include "DKDebug/DKDebug.h"

#define DRAG_FIX 1
DKRocket* DKWidget::dkRocket;

/////////////////////
bool DKWidget::Init()
{
	DKDEBUGFUNC();
	DKClass::DKCreate("DKWidgetJS");
	DKClass::DKCreate("DKWidgetMySqlJS");
	root = NULL;

	//link objects
	dkRocket = DKRocket::Get();
	if(!dkRocket){
		DKERROR("DKWidget::Init(): INVALID OBJECTS\n");
		return false;
	}

	DKString _data = toString(data, ",");
	//DKINFO("DKWidget::Init("+_data+")\n");

	//data = ("DKWidget, file, parent")
	if(data.size() < 2){	
		DKERROR("DKWidget::Init("+_data+"): missing parameters\n");
	}
	if(data.size() > 3){
		DKERROR("DKWidget::Init("+_data+"): too many parameters\n");
	}

	if(data.size() < 3){
		data.push_back("body");
	}

	//make sure the parent exists
	if(!DKWidget::GetElementById(data[2])){
		DKWARN("DKWidget::Init(): the parent element ("+data[2]+") is invalid\n");
		DKWARN("DKWidget::Init(): Changing parent to \"body\"\n");
		data[2] = "body";
	}
	
	if(same(data[1],"DKWidget0")){ return true; }
	CreateWidget(data[1]);
	return true;
}

////////////////////
bool DKWidget::End()
{
	DKDEBUGFUNC();
	RemoveWidget(this);
	return true;
}

/////////////////////////////////////////////
void DKWidget::RemoveWidget(DKWidget* widget)
{
	DKDEBUGFUNC(widget);
	//TODO - any child widgets need to be deleted first
	if(!root){ return; }
	DKString id = root->GetId().CString();
	if(id.empty()){ return; }
	//DKINFO("DKWidget::RemoveWidget("+id+")\n");
	
	//Remove all child DKWidgets and events
	RemoveAllEventListeners(id);
	DKStringArray elements;
	GetElements(id, elements);
	for(unsigned int i = elements.size(); i-- > 0;){
		RemoveAllEventListeners(elements[i]);
		if(has(elements[i],".html")){ DKClass::DKClose(elements[i]); }
	}

	if(DKApp::active){
		Rocket::Core::Element* parent = root->GetParentNode();
		if(!parent){ return; }
		parent->RemoveChild(root);
	}
}

///////////////////////////////////////////
bool DKWidget::CreateWidget(DKString& file)
{
	DKDEBUGFUNC(file);
	DKString id;
	DKString html;
	DKString path = file;
	if(same(file,".html")){
		file = "New.html";
		path = "New.html";
		html = "<div id=\"" + id + "\" style=\"position:absolute;top:200rem;left:200rem;width:200rem;height:200rem;background-color:rgb(230,230,230);\"></div>";
	}
	else{
		if (!DKFile::VerifyPath(path)) { 
			DKERROR("DKWidget::CreateWidget("+file+"): file does not exist\n");
			return false;
		}
	}

	root = NULL;
	DKString file_path;
	DKFile::GetFileName(path, id);		
	DKFile::GetFilePath(path, file_path);
	DKFile::FileToString(path, html); //Convert file to a string
	//DKAssets::AppendDataPath(file_path); //If this file's path is not in the datapath list, add it

	//Prep the string into rocket compatible code
	DKString rml;
	//DKRocketToRML dkRocketToRML;
	if(!dkRocket->dkRocketToRML.HtmlToRml(html, rml)){
		return false;
	}

	//Parse the sting into an element
	Rocket::Core::ElementDocument* doc = dkRocket->document;
	if(!doc){
		DKERROR("DKWidget::CreateWidget("+path+"): could not find document\n");
		return false;
	}
	Rocket::Core::Element* temp = doc->CreateElement("temp"); //FIXME - is the memory delt with properly?
	if(!temp){
		DKERROR("DKWidget::CreateWidget("+path+"): could not find firstChild\n");
		return false;
	}
	SetInnerHtml(temp, rml);

	Rocket::Core::Element* firstChild = temp->GetFirstChild();
	if(!firstChild){
		DKERROR("DKWidget::CreateWidget("+path+"): could not find firstChild\n");
		return false;
	}
	DKString _id = firstChild->GetId().CString();

	//FIXME - the id needs to be the path from the assets folder..  i.e.  MyPlugin/MyPlugin.js
	/*
	if(!same(_id,id)){
		DKWARN("DKWidget::CreateWidget("+path+"): fixing id... "+id+"\n");
		DKString str;
		GetInnerHtml(temp, str);
		replace(str, "id=\""+_id+"\"", "id=\""+id+"\""); //Set the id to the filename (example.html)
		SetInnerHtml(temp, str);
	}
	*/

	//Add the elements to the DOM
	Trim(data[2]);

	int numChildren = temp->GetNumChildren();
	for(int i = 0; i < numChildren; i++){
		//DKINFO("AppendChild("+data[2]+", temp->GetChild(0)\n");
		Rocket::Core::Element* body = GetElementByTag("body");
		AppendChild(body, temp->GetChild(0));
	}

	//Set the root element of this widget
	Trim(id);
	root = dkRocket->document->GetElementById(_id.c_str());
	if(!root){
		DKERROR("DKWidget::CreateWidget("+path+"): root is NULL\n");
		return false;
	}

	dkRocket->dkRocketToRML.PostProcess(root);

	AttachEvents();
	AttachDrags();

	//force refresh of rocket for overflow fixes
	//root->SetContentBox(Rocket::Core::Vector2f(0,0), Rocket::Core::Vector2f(0,0));

	return true;
}

/////////////////////////////
bool DKWidget::AttachEvents()
{
	DKDEBUGFUNC();
	DKElementList elements;
	GetElements(root, elements);
	for(unsigned int i=0; i<elements.size(); ++i){
		if(same(elements[i]->GetTagName().CString(), "textarea")){
			AddEventListener(elements[i], "mousedown");
		}
		if(same(elements[i]->GetTagName().CString(), "input")){
			AddEventListener(elements[i], "mousedown");
		}
	}
	return true;
}



//////////////////   Helper functions  ///////////////////////
//by event
//////////////////////////////////////////////////////////
bool DKWidget::Type(DKEvent* event, const DKString& type)
{
	DKDEBUGFUNC(event, type);
	if(same(event->GetType(), type)){ return true; }
	return false;
}

/////////////////////////////////////////////////////
bool DKWidget::Id(DKEvent* event, const DKString& id)
{
	DKDEBUGFUNC(event, id);
	if(same(event->GetId(), id)){ return true; }
	return false;
}

/////////////////////////////////////////////////////////
bool DKWidget::Id(Rocket::Core::Element* element, const DKString& id)
{
	DKDEBUGFUNC(element, id);
	if(same(GetId(element), id)){ return true; }
	return false;
}

/////////////////////////////////////////////////////////
bool DKWidget::IdLike(DKEvent* event, const DKString& id)
{
	DKDEBUGFUNC(event, id);
	if(has(event->GetId(), id)){ return true; }
	return false;
}

///////////////////////////////////////////////////////////
bool DKWidget::Value(DKEvent* event, const DKString& value)
{
	DKDEBUGFUNC(event, value);
	if(same(event->GetValue(), value)){ return true; }
	return false;
}

///////////////////////////////////////////////
Rocket::Core::Element* DKWidget::GetElement(DKEvent* event)
{
	DKDEBUGFUNC(event);
	DKString id = event->GetId();
	Rocket::Core::Element* element = GetElementById(id);
	return element;
}

/*
/////////////////////////////////
bool DKWidget::ClearReturnEvent()
{
	DKDEBUGFUNC();
	event_type.clear();
	event_id.clear();
	event_data.clear();
	return true;
}

///////////////////////////////////////////////
bool DKWidget::StoreReturnEvent(DKEvent* event)
{
	DKDEBUGFUNC(event);
	event_id = event->GetValue(0);
	event_type = event->GetValue(1);
	
	int i = 2;
	while(!event->GetValue(i).empty()){
		event_data.push_back(event->GetValue(i));
		++i;
	}
	return true;
}
*/



//to string
////////////////////////////////////////////
DKString DKWidget::GetId(Rocket::Core::Element* element)
{
	DKDEBUGFUNC(element);
	if(!element){ return ""; }
	return element->GetId().CString();
}

////////////////////////////////////////
DKString DKWidget::GetId(DKEvent* event)
{
	DKDEBUGFUNC(event);
	Rocket::Core::Element* element = GetElement(event);
	if(!element){ return ""; }
	return element->GetId().CString();
}

///////////////////////////////////////////
DKString DKWidget::GetValue(DKEvent* event)
{
	DKDEBUGFUNC(event);
	Rocket::Core::Element* element = GetElement(event);
	return GetValue(element);
}

///////////////////////////////////////////////
DKString DKWidget::GetValue(const DKString& id)
{
	DKDEBUGFUNC(id);
	DKString value = "";
	GetValue(id, value);
	return value;
}

///////////////////////////////////////////////
DKString DKWidget::GetValue(Rocket::Core::Element* element)
{
	DKDEBUGFUNC(element);
	DKString value = "";
	GetValue(element, value);
	return value;
}

///////////////////////////////////////////////////
Rocket::Core::Element* DKWidget::GetElement(const DKString& id)
{
	DKDEBUGFUNC(id);
	return GetElementById(id);
}


/////////////////////////////////////////////////////////////////
bool DKWidget::GetOuterHtml(const DKString& id, DKString& string)
{
	DKDEBUGFUNC(id, string);
	return GetOuterHtml(GetElementById(id), string);
}

/////////////////////////////////////////////////////////////////
bool DKWidget::GetOuterHtml(Rocket::Core::Element* element, DKString& string)
{
	DKDEBUGFUNC(element, string);
	if(!element){ return false; }
	Rocket::Core::Element* parent = element->GetParentNode();
	DKString htmlstring;
	GetInnerHtml(parent, htmlstring);
	if(htmlstring.empty()){return false;}

	DKXml xml;
	if(!xml.LoadDocumentFromString(htmlstring)){ return false; }
	xml.RemoveNodes("handle");
	DKString id = element->GetId().CString();
	DKString style;
	DKWidget::BuildStyleString(id, style);
	xml.SetAttributes("//*[@id=\""+id+"\"]", "style", style); //Update the style string
	style = "";
	
	DKStringArray ids;
	GetElements(id, ids);
	for(unsigned int i=0; i < ids.size(); ++i){
		BuildStyleString(ids[i], style);
		xml.SetAttributes("//*[@id=\""+ids[i]+"\"]", "style", style); //Update the style string
		style = "";
		//TODO - rebuild options string for <select> elements
	}

	if(!xml.GetFullNode("//*[@id=\""+id+"\"]", string)){ return false; } 
	return true;
}

//by string
///////////////////////////////////////////////////////
Rocket::Core::Element* DKWidget::CreateElement(const DKString& tag)
{
	DKDEBUGFUNC(tag);
	Rocket::Core::Element* element = dkRocket->document->CreateElement(tag.c_str());
	if(!element){
		DKERROR("DKWidget::CreateElement("+tag+")\n");
		return 0;
	}
	element->SetAttribute("style","top:0rem;"); //we do this just to initialze an active style string
	return element;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
DKString DKWidget::CreateElement(const DKString& parent, const DKString& tag, const DKString& id)
{
	DKDEBUGFUNC(parent, tag, id);
	Rocket::Core::Element* element = CreateElement(tag);
	
	DKString ele_id;
	GetAvailableId(id, ele_id);

	SetAttribute(element, "id", ele_id);
	AppendChild(parent, element);

	//DKRocketToRML dkRocketToRML;
	dkRocket->dkRocketToRML.PostProcess(GetElementById(parent));

	return ele_id;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
DKString DKWidget::CreateElementFirst(const DKString& parent, const DKString& tag, const DKString& id)
{
	DKDEBUGFUNC(parent, tag, id);
	Rocket::Core::Element* element = CreateElement(tag);
	
	DKString ele_id;
	GetAvailableId(id, ele_id);

	SetAttribute(element, "id", ele_id);
	PrependChild(GetElementById(parent), element);

	//DKRocketToRML dkRocketToRML;
	dkRocket->dkRocketToRML.PostProcess(GetElementById(parent));

	return ele_id;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////
DKString DKWidget::CreateElementBefore(const DKString& element, const DKString& tag, const DKString& id)
{
	DKDEBUGFUNC(element, tag, id);
	Rocket::Core::Element* ele = CreateElement(tag);
	
	DKString ele_id;
	GetAvailableId(id, ele_id);

	SetAttribute(ele, "id", ele_id);
	InsertBefore(element, ele);

	//DKRocketToRML dkRocketToRML;
	dkRocket->dkRocketToRML.PostProcess(ele->GetParentNode());

	return ele_id;
}

////////////////////////////////////////////////////////////////
void DKWidget::GetAvailableId(const DKString& id, DKString& out)
{
	DKDEBUGFUNC(id, out);
	out = id;
	int i = 0;
	
	while(GetElementById(out)){
		//if there is a .  the number must come before
		std::size_t found = id.find_last_of(".");
		if(found != -1){
		    out = id.substr(0,found)+toString(i)+id.substr(found);
		}
		else{
			out = id+toString(i);
		}
		i++;
	}
	//DKINFO("DKWidget::GetAvailableId("+id+")-> "+out+"\n");
}

///////////////////////////////////////////////////////////////////
Rocket::Core::Element* DKWidget::GetElementById(const DKString& id)
{
	DKDEBUGFUNC(id);
	if(id.empty()){
		DKWARN("DKWidget::GetElementById(): id empty\n");
		return NULL;
	}
	Rocket::Core::ElementDocument* doc = dkRocket->document;
	if(!doc){
		return 0;
	}
	Rocket::Core::Element* element = doc->GetElementById(id.c_str());
	if(!element){
		//DKWARN("DKWidget::GetElementById("+id+"): could not find element\n");
		return 0;
	}
	return element;
}

/////////////////////////////////////////////////////////////////////
Rocket::Core::Element* DKWidget::GetElementByTag(const DKString& tag)
{
	DKDEBUGFUNC(tag);
	if(tag.empty()){
		DKWARN("DKWidget::GetElementById(): tag empty\n");
		return NULL;
	}
	Rocket::Core::ElementDocument* doc = dkRocket->document;
	if(!doc){
		return 0;
	}
	//Rocket::Core::Element* element;
	Rocket::Core::ElementList elements;
	doc->GetElementsByTagName(elements, tag.c_str());
	if(!elements[0]){
		//DKWARN("DKWidget::GetElementById("+id+"): could not find element\n");
		return 0;
	}
	return elements[0];
}

//////////////////////////////////////////////////////////
bool DKWidget::GetFile(const DKString& id, DKString& file)
{
	DKDEBUGFUNC(id, file);
	return GetFile(GetElementById(id), file);
}

////////////////////////////////////////////////////////////////
bool DKWidget::SetFile(const DKString& id, const DKString& file)
{
	DKDEBUGFUNC(id, file);
	return SetFile(GetElementById(id), file);
}

//////////////////////////////////////////
bool DKWidget::Visible(const DKString& id)
{
	DKDEBUGFUNC(id);
	return Visible(GetElementById(id));
}

/////////////////////////////////////////
bool DKWidget::Toggle(const DKString& id)
{
	DKDEBUGFUNC(id);
	return Toggle(GetElementById(id));
}

///////////////////////////////////////
bool DKWidget::Show(const DKString& id)
{
	DKDEBUGFUNC(id);
	return Show(GetElementById(id));
}

///////////////////////////////////////
bool DKWidget::Hide(const DKString& id)
{
	DKDEBUGFUNC(id);
	return Hide(GetElementById(id));
}

//////////////////////////////////////////////////////////////
bool DKWidget::GetParent(const DKString& id, DKString& parent)
{
	DKDEBUGFUNC(id, parent);
	return GetParent(GetElementById(id), parent);
}

//////////////////////////////////////////////////////////////////////
bool DKWidget::AppendChild(const DKString& parent, const DKString& id)
{
	DKDEBUGFUNC(parent, id);
	return AppendChild(GetElementById(parent), GetElementById(id));
}

///////////////////////////////////////////////////////////////////////
bool DKWidget::PrependChild(const DKString& parent, const DKString& id)
{
	DKDEBUGFUNC(parent, id);
	return PrependChild(GetElementById(parent), GetElementById(id));
}

//////////////////////////////////////////////////////////////////////
bool DKWidget::AppendChild(const DKString& parent, Rocket::Core::Element* element)
{
	DKDEBUGFUNC(parent, element);
	return AppendChild(GetElementById(parent), element);
}

////////////////////////////////////////////////////////////////////////////
bool DKWidget::InsertBefore(const DKString& parent, const DKString& element)
{
	DKDEBUGFUNC(parent, element);
	return InsertBefore(GetElementById(parent), GetElementById(element));
}

///////////////////////////////////////////////////////////////////////
bool DKWidget::InsertBefore(const DKString& parent, Rocket::Core::Element* element)
{
	DKDEBUGFUNC(parent, element);
	return InsertBefore(GetElementById(parent), element);
}

////////////////////////////////////////////////
bool DKWidget::RemoveElement(const DKString& id)
{
	DKDEBUGFUNC(id);
	//Remove all events and child events
	DKStringArray elements;
	GetElements(id, elements);
	elements.push_back(id);
	for(unsigned int i = elements.size(); i-- > 0;){
		if(has(elements[i],".html")){
			DKClass::DKClose(elements[i]);
			continue;
		}
		RemoveAllEventListeners(elements[i]);
	}                                        
	
	Rocket::Core::Element* element = GetElementById(id);
	if(!element){ return false; }
	Rocket::Core::Element* parent = element->GetParentNode();
	if(!parent){ return false; }
	parent->RemoveChild(element);
	return true;
}

/////////////////////////////////////////////////////////////////////////
bool DKWidget::AddEventListener(const DKString& id, const DKString& type)
{
	DKDEBUGFUNC(id, type);
	return AddEventListener(GetElementById(id), type);
}

////////////////////////////////////////////////////////////////////////////
bool DKWidget::RemoveEventListener(const DKString& id, const DKString& type)
{
	DKDEBUGFUNC(id, type);
	if(!RemoveEventListener(GetElementById(id), type)){ return false; }
	DKEvent::RemoveEvents(id, type);
	return true;
}

//////////////////////////////////////////////////////////
bool DKWidget::RemoveAllEventListeners(const DKString& id)
{
	DKDEBUGFUNC(id);
	return DKEvent::RemoveEvents(id);
}

//////////////////////////////////////////////////////////////////////////////////////
bool DKWidget::GetAttribute(const DKString& id, const DKString& name, DKString& value)
{
	DKDEBUGFUNC(id, name, value);
	//FIXME
#ifndef LINUX
	//if(!DKUtil::InMainThread()){ return false; } //Talking to the GUI from other threads is bad.
#endif
	return GetAttribute(GetElementById(id), name, value);
}

////////////////////////////////////////////////////////////////////////////////////////////
bool DKWidget::SetAttribute(const DKString& id, const DKString& name, const DKString& value)
{
	DKDEBUGFUNC(id, name, value);
//FIXME
#ifndef LINUX
	//if(!DKUtil::InMainThread()){ return false; }  //Talking to the GUI from other threads is bad.
#endif
	return SetAttribute(GetElementById(id), name, value);
}

/////////////////////////////////////////////////////////////////////////////////////
bool DKWidget::GetProperty(const DKString& id, const DKString& name, DKString& value)
{
	DKDEBUGFUNC(id, name, value);
	return GetProperty(GetElementById(id), name, value);
}
///////////////////////////////////////////////////////////////////////////////////////////
bool DKWidget::SetProperty(const DKString& id, const DKString& name, const DKString& value)
{
	DKDEBUGFUNC(id, name, value);
	return SetProperty(GetElementById(id), name, value);
}

////////////////////////////////////////////////////////////////
bool DKWidget::GetInnerHtml(const DKString& id, DKString& value)
{
	DKDEBUGFUNC(id, value);
	return GetInnerHtml(GetElementById(id), value);
}

////////////////////////////////////////////////////////////////
bool DKWidget::GetInnerHtmlString(const DKString& id, DKString& value)
{
	DKDEBUGFUNC(id, value);
	return GetInnerHtmlString(GetElementById(id), value);
}

//////////////////////////////////////////////////////////////////////
bool DKWidget::SetInnerHtml(const DKString& id, const DKString& value)
{
	DKDEBUGFUNC(id, value);
	return SetInnerHtml(GetElementById(id), value);
}

////////////////////////////////////////////////////////////////////////////
bool DKWidget::SetInnerHtmlString(const DKString& id, const DKString& value)
{
	DKDEBUGFUNC(id, value);
	return SetInnerHtmlString(GetElementById(id), value);
}

////////////////////////////////////////////////////////////
bool DKWidget::GetValue(const DKString& id, DKString& value)
{
	DKDEBUGFUNC(id, value);
	return GetValue(GetElementById(id), value);
}

///////////////////////////////////////////////////////
bool DKWidget::GetValue(const DKString& id, int& value)
{
	DKDEBUGFUNC(id, value);
	return GetValue(GetElementById(id), value);
}

//////////////////////////////////////////////////////////////////
bool DKWidget::SetValue(const DKString& id, const DKString& value)
{
	DKDEBUGFUNC(id, value);
	return SetValue(GetElementById(id), value);
}

/////////////////////////////////////////////////////////////
bool DKWidget::SetValue(const DKString& id, const int& value)
{
	DKDEBUGFUNC(id, value);
	return SetValue(GetElementById(id), value);
}

////////////////////////////////////////////////////////////////////
bool DKWidget::SetValue(const DKString& id, const DKProperty* value)
{
	DKDEBUGFUNC(id, value);
	return SetValue(GetElementById(id), value);
}

//////////////////////////////////////////////
bool DKWidget::ScrollToTop(const DKString& id)
{
	DKDEBUGFUNC(id);
	return ScrollToTop(GetElementById(id));
}

/////////////////////////////////////////////////
bool DKWidget::ScrollToBottom(const DKString& id)
{
	DKDEBUGFUNC(id);
	return ScrollToBottom(GetElementById(id));
}

//////////////////////////////////////////////////////////////////
bool DKWidget::GetClientWidth(const DKString& id, DKString& value)
{
	DKDEBUGFUNC(id, value);
	if (!GetClientWidth(GetElementById(id), value)) { return false; }
	return true;
}

////////////////////////////////////////////////////////////////////
bool DKWidget::GetClientHeight(const DKString& id, DKString& value)
{
	DKDEBUGFUNC(id, value);
	return GetClientHeight(GetElementById(id), value);
}












//by element
//////////////////////////////////////////////////////////
bool DKWidget::GetFile(Rocket::Core::Element* element, DKString& file)
{
	DKDEBUGFUNC(element, file);
	if(!element){ return false; }
	DKString id = element->GetId().CString();
	while(!has(id,".html") && !has(id,"body") && !id.empty()){
		GetParent(id, id);
	}
	
	std::vector<DKWidget*> instances;
	DKWidget::GetInstances(instances);
	for(unsigned int i=0; i<instances.size(); ++i){
		if(!instances[i]->root){ continue; }
		if(same(instances[i]->root->GetId().CString(), id)){
			file = instances[i]->data[1];
		}
	}
	return true;
}

////////////////////////////////////////////////////////////////
bool DKWidget::SetFile(Rocket::Core::Element* element, const DKString& file)
{
	DKDEBUGFUNC(element, file);
	if(!element){ return false; }
	DKString root = element->GetId().CString();
	while(!has(root,".html") && !has(root,"body")){
		GetParent(root, root);
	}
	
	std::vector<DKWidget*> instances;
	DKWidget::GetInstances(instances);
	for(unsigned int i=0; i<instances.size(); ++i){
		if(same(instances[i]->root->GetId().CString(), root)){
			instances[i]->data[1] = file;
		}
	}
	return true;
}

////////////////////////////////////////////
bool DKWidget::GetFocusElement(DKString& id)
{
	DKDEBUGFUNC(id);
	Rocket::Core::Element* focused = dkRocket->document->GetContext()->GetFocusElement();
	id = focused->GetId().CString();
	if(id.empty()){ return false; }
	return true;
}

/////////////////////////////////////
bool DKWidget::SetFocus(DKString& id)
{
	DKDEBUGFUNC(id);
	Rocket::Core::Element* element = dkRocket->document->GetElementById(id.c_str());
	if(!element){ 
		DKERROR("DKWidget::SetFocus("+id+")\n");
		return false; 
	}
	return element->Focus();
}

////////////////////////////////////////////
bool DKWidget::GetHoverElement(DKString& id)
{
	DKDEBUGFUNC(id);
	Rocket::Core::Element* hovered = dkRocket->document->GetContext()->GetHoverElement();
	if(!hovered){ return false; }
	id = hovered->GetId().CString();
	if(id.empty()){ return false; }
	return true;
}

//////////////////////////////////////////
bool DKWidget::Visible(Rocket::Core::Element* element)
{
	DKDEBUGFUNC(element);
	if(!element){return false;}
	return element->IsVisible();	
}

/////////////////////////////////////////
bool DKWidget::Toggle(Rocket::Core::Element* element)
{
	DKDEBUGFUNC(element);
	if(!element){return false;}
	if(element->IsVisible()){
		Hide(element);
	}
	else{
		Show(element);
	}
	return true;
}

///////////////////////////////////////
bool DKWidget::Show(Rocket::Core::Element* element)
{
	DKDEBUGFUNC(element);
	if(!element){
		//DKWARN("DKWidget::Show(): element not valid\n");
		return false;
	}
	if(!SetProperty(element, "display", "block")){ return false; }
	return true;
}

///////////////////////////////////////
bool DKWidget::Hide(Rocket::Core::Element* element)
{
	DKDEBUGFUNC(element);
	if(!element){
		//DKWARN("DKWidget::Hide(): element not valid\n");
		return false;
	}
	if(!SetProperty(element, "display", "none")){ return false; }
	return true;
}

//////////////////////////////////////////////////////////////
bool DKWidget::GetParent(Rocket::Core::Element* element, DKString& parent)
{
	DKDEBUGFUNC(element, parent);
	if(!element){return false;}
	Rocket::Core::Element* par = element->GetParentNode();
	if(!par){return false;}
	parent = GetId(par);
	return true;
}

/////////////////////////////////////////////////////////////////
bool DKWidget::AppendChild(Rocket::Core::Element* parent, Rocket::Core::Element* element)
{
	DKDEBUGFUNC(parent, element);
	if(!parent){
		DKWARN("DKWidget::AppendChild(): parent invalid\n");
		return false;
	}
	if(!element){
		DKERROR("DKWidget::AppendChild(): element invalid\n");
		return false;
	}
	
	//remove the element from the previous owner first
	Rocket::Core::Element* par = element->GetParentNode();
	if(par){ par->RemoveChild(element); }

	//save scroll positions
	std::map<DKString,float> x_scrolls;
	std::map<DKString,float> y_scrolls;
	DKElementList elements;
	DKWidget::GetElements(element, elements);
	for(unsigned int i=0; i<elements.size(); i++){
		int x;
		int y;
		elements[i]->GetOverflow(&x, &y);
		if(x){
			x_scrolls[elements[i]->GetId().CString()] = elements[i]->GetScrollLeft();
		}
		if(y){
			y_scrolls[elements[i]->GetId().CString()] = elements[i]->GetScrollTop();
		}
	}

	parent->AppendChild(element); //restore the element

	//restore scroll positions
	std::map<DKString,float>::iterator it;
	for(it = x_scrolls.begin(); it != x_scrolls.end(); it++){
		if(it->first.empty()){ continue; }
		GetElementById(it->first)->SetScrollLeft(it->second);
	}
	for(it = y_scrolls.begin(); it != y_scrolls.end(); it++){
		if(it->first.empty()){ continue; }
		GetElementById(it->first)->SetScrollTop(it->second);
	}
	
	//Fix input text elements from disapearing
	Rocket::Core::ElementList inputs;
	element->GetElementsByTagName(inputs,"input");
	for(unsigned int i=0; i<inputs.size(); i++){
		Rocket::Core::Variant* variant = inputs[i]->GetAttribute("type");
		if(!variant){ continue; }
		if(variant->Get<DKCString>() != "text"){ continue; }
		Rocket::Controls::ElementTextSelection* ele = static_cast<Rocket::Controls::ElementTextSelection*>(inputs[i]);
		Rocket::Core::ElementText* ti = static_cast<Rocket::Core::ElementText*>(ele->widget->selected_text_element);
		Rocket::Controls::WidgetTextInput* widget = reinterpret_cast<Rocket::Controls::WidgetTextInput*>(ti);
		widget->FormatElement();
	}

	return true;
}

//////////////////////////////////////////////////////////////////
bool DKWidget::PrependChild(Rocket::Core::Element* parent, Rocket::Core::Element* element)
{
	DKDEBUGFUNC(parent, element);
	if(!parent){
		DKERROR("PrependChild(): parent invalid\n");
		return false;
	}
	if(!element){
		DKERROR("PrependChild(): element invalid\n");
		return false;
	}
	
	//remove the element from the previous owner first
	Rocket::Core::Element* ele = element;
	Rocket::Core::Element* par = element->GetParentNode();
	if(par){ par->RemoveChild(element); }

	Rocket::Core::Element* first_child = parent->GetFirstChild();
	if(first_child && !samei(first_child->GetTagName().CString(),"script")){
		parent->InsertBefore(ele, first_child);
		return true;
	}
	parent->AppendChild(ele);
	return true;
}

//////////////////////////////////////////////////////////////////
bool DKWidget::InsertBefore(Rocket::Core::Element* parent, Rocket::Core::Element* element)
{
	DKDEBUGFUNC(parent, element);	
	if(!parent){
		DKERROR("InsertBefore(): parent invalid\n");
		return false;
	}
	if(!element){
		DKERROR("InsertBefore(): element invalid\n");
		return false;
	}
	
	//Store store parent, it may get removed
	Rocket::Core::Element* par_store = parent->GetParentNode();
	
	//remove the element from the previous owner first
	Rocket::Core::Element* ele = element;
	Rocket::Core::Element* par = element->GetParentNode();
	if(par){ par->RemoveChild(element); }

	//get child
	parent = par_store->GetFirstChild();
	
	DKINFO("DKWidget::InsertBefore(): "+GetId(parent)+"->InsertBefore("+GetId(ele)+","+GetId(parent)+")\n");
	//DKINFO("par_store = "+GetId(par_store)+"\n");
	par_store->InsertBefore(ele, parent);
	return true;
}

/////////////////////////////////////////////////////////////////////////
bool DKWidget::AddEventListener(Rocket::Core::Element* element, const DKString& type)
{
	DKDEBUGFUNC(element, type);
	if(!element){return false;}
	bool capture_phase = false;

#ifdef DRAG_FIX
	if(same(type,"mousedown")){ capture_phase = true; }
#endif
	element->AddEventListener(type.c_str(), dkRocket, capture_phase);
	return true;
}

////////////////////////////////////////////////////////////////////////////
bool DKWidget::RemoveEventListener(Rocket::Core::Element* element, const DKString& type)
{
	DKDEBUGFUNC(element, type);
	if(!element){return false;}
	bool capture_phase = false;

#ifdef DRAG_FIX
	if(same(type,"mousedown")){ capture_phase = true; }
#endif
	element->RemoveEventListener(type.c_str(), dkRocket, capture_phase);
	return true;	
}

//////////////////////////////////////////////////////////////////////////////////////
bool DKWidget::GetAttribute(Rocket::Core::Element* element, const DKString& name, DKString& value)
{
	DKDEBUGFUNC(element, name, value);
	if(!element){return false;}
	if(!element->HasAttribute(name.c_str())){ return false; }
	DKCString temp;
	temp = element->GetAttribute(name.c_str())->Get<DKCString>();
	value = temp.CString();
	return true;
}

////////////////////////////////////////////////////////////////////////////////////////////
bool DKWidget::SetAttribute(Rocket::Core::Element* element, const DKString& name, const DKString& value)
{
	DKDEBUGFUNC(element, name, value);
	if(!element){return false;}
	if(name.empty()){return false;}
	//if(same(name,"value")){
		//SetValue(element, value);
	//	return true;
	//}
	
	//if the type is an id, we need to rename the event id's tied to it as well.
	if(same(name,"id")){
		DKString id = element->GetId().CString();
		DKEvent::RenameEventId(id,value);
	}

	if(value.empty()){
		element->RemoveAttribute(name.c_str());
	}
	else{
		element->SetAttribute(name.c_str(), value.c_str());
	}

	if(same(name,"src")){
		//DKRocketToRML dkRocketToRML;
		dkRocket->dkRocketToRML.PostProcess(element->GetParentNode());
	}
	return true;
}

/////////////////////////////////////////////////////////////////////////////////////
bool DKWidget::GetProperty(Rocket::Core::Element* element, const DKString& name, DKString& value)
{
	DKDEBUGFUNC(element, name, value);
	value.clear();
	if(!element){return false;}
	const DKProperty* prop = element->GetProperty(name.c_str());
	if(!prop){ return false; }
	//if(prop->parser_index == -1){ return false; }
	value = element->GetProperty(name.c_str())->ToString().CString();
	if(value.empty()){return false;}
	replace(value,".0000","");
	if(same(value,"0")){return false;}
	return true;
}

///////////////////////////////////////////////////////////////////////////////////////////
bool DKWidget::SetProperty(Rocket::Core::Element* element, const DKString& name, const DKString& value)
{
	DKDEBUGFUNC(element, name, value);
	if(!element){
		DKWARN("DKWidget::SetProperty("+name+","+value+"): element invalid\n");
		return false;
	}
	if(name.empty()){
		DKERROR("DKWidget::SetProperty(): name empty\n"); 
		return false;
	}
	if(value.empty()){ element->RemoveProperty(name.c_str()); return true; }
	
	DKString finalValue = value;

	///// fix display
	if(same(name,"display")){
		if(same(value,"2")){
			finalValue = "block";
		}
	}
	
	///// adjust background alpha from to 1-255 scale
	if(same(name,"background-color")){
		if(has(value,"rgba")){
			//DKINFO("DKWidget::SetProperty() background-color has rgba()\n");
			//DKINFO(value+"\n");
			std::size_t start = value.find_last_of(",")+1;
			//DKINFO("start:"+toString(start)+"\n");
			std::size_t end = value.find_last_of(")");
			//DKINFO("end:"+toString(end)+"\n");
			int newvalue = (int)(toFloat(value.substr(start,end-start)) * 255);
			finalValue.replace(start,end-start,toString(newvalue));
			//DKINFO(finalValue+"\n");
		}
	}

	//// background-image hack
	if(same(name,"background-image")){
		DKString url = value;
		replace(url, "url(\"", "");
		replace(url, "\")", "");
		
		DKString img = CreateElementFirst(element->GetId().CString(), "img", "background-image");
		SetProperty(img, "position", "relative");
		SetProperty(img, "display", "inline");
		SetAttribute(img, "src", url);

		DKString pad_left;
		GetProperty(element, "padding-left", pad_left);
		SetProperty(img, "margin-left", "-"+pad_left);

		DKString pad_top;
		GetProperty(element, "padding-top", pad_top);
		SetProperty(img, "margin-top", "-"+pad_top);
	}
	
	if(!element->SetProperty(name.c_str(), finalValue.c_str())){
		DKERROR("DKWidget::SetProperty(): Could not set property\n");
		return false;
	}
	return true;
}

////////////////////////////////////////////////////////////////
bool DKWidget::GetInnerHtml(Rocket::Core::Element* element, DKString& value)
{
	DKDEBUGFUNC(element, value);
	if(!element){ return false; }
	value = element->GetInnerRML().CString();
	return true;
}

//////////////////////////////////////////////////////////////////////
bool DKWidget::GetInnerHtmlString(Rocket::Core::Element* element, DKString& value)
{
	DKDEBUGFUNC(element, value);
	if(!element){ return false; }
	for(int i = 0; i < element->GetNumChildren(); i++){
		DKString test = element->GetChild(i)->GetTagName().CString();
		if(has(test,"#")){

			Rocket::Core::ElementText* ele = static_cast<Rocket::Core::ElementText*>(element->GetChild(i));
			DKCString temp;
			Rocket::Core::WString cstr = ele->GetText().ToUTF8(temp);
			value = temp.CString();
			Trim(value);
			return true;
		}
	}

	return false;
}

//////////////////////////////////////////////////////////////////////
bool DKWidget::SetInnerHtml(Rocket::Core::Element* element, const DKString& value)
{
	DKDEBUGFUNC(element, value);
	//FIXME - can't clear a select element ??
	if(!element){ return false; }
	if(same(element->GetTagName().CString(), "select")){
		int e = element->GetNumChildren(true);
		for(int i=0; i<e; ++i){
			element->GetChild(i)->SetInnerRML(value.c_str());
		}
	}
	element->SetInnerRML(value.c_str());
	return true;
}

////////////////////////////////////////////////////////////////////////////
bool DKWidget::SetInnerHtmlString(Rocket::Core::Element* element, const DKString& value)
{
	DKDEBUGFUNC(element, value);
	if(!element){ return false; }
	for(int i = 0; i < element->GetNumChildren(); i++){
		DKString test = element->GetChild(i)->GetTagName().CString();
		if(has(test,"#")){

			Rocket::Core::ElementText* ele = static_cast<Rocket::Core::ElementText*>(element->GetChild(i));
			ele->SetText(value.c_str());
			return true;
		}

	}

	return false;
}

////////////////////////////////////////////////////////////
bool DKWidget::GetValue(Rocket::Core::Element* element, DKString& value)
{
	DKDEBUGFUNC(element, value);
	if(!element){
		DKERROR("DKWidget::GetValue(): element invalid\n");
		return false;
	}
	
	//Only try to get the form element of certain tags
	if(samei(element->GetTagName().CString(), "select")){
		DKElementFormControlSelect* ele = static_cast<DKElementFormControlSelect*>(element);
		value = ele->GetValue().CString();
		return true;
	}

	if(samei(element->GetTagName().CString(), "input")){
		if(samei(element->GetAttribute("type")->Get<DKCString>().CString(), "range")){
			DKElementFormControlInput* ele = static_cast<DKElementFormControlInput*>(element);
			value = ele->GetValue().CString();
			return true;
		}	
	}

	if(GetAttribute(element, "value", value)){ return true; }

	return false;
}

//////////////////////////////////////////////////////////////////
bool DKWidget::SetValue(Rocket::Core::Element* element, const DKString& value)
{
	DKDEBUGFUNC(element, value);
	if(!element){ return false; }
	DKElementFormControl* input = static_cast<DKElementFormControl*>(element);
	if(input && (same(element->GetTagName().CString(),"input") || 
				 same(element->GetTagName().CString(),"textarea") ||
				 same(element->GetTagName().CString(),"select") ) ){
		input->SetValue(value.c_str());
		return true;
	}
	SetInnerHtml(element, value);
	return true;
}

///////////////////////////////////////////////////////
bool DKWidget::GetValue(Rocket::Core::Element* element, int& value)
{
	DKDEBUGFUNC(element, value);
	if(!element){ return false; }
	DKString temp;
	if(!GetValue(element, temp)){ return false; }
	value = toInt(temp);
	return true;
}

/////////////////////////////////////////////////////////////
bool DKWidget::SetValue(Rocket::Core::Element* element, const int& value)
{
	DKDEBUGFUNC(element, value);
	if(!element){ return false; }
	DKElementFormControl* input = static_cast<DKElementFormControl*>(element);
	input->SetValue(toString(value).c_str());
	return true;
}

///////////////////////////////////////////////////////////////////
bool DKWidget::SetValue(Rocket::Core::Element* element, const DKProperty* prop)
{
	DKDEBUGFUNC(element, prop);
	if(!element){ return false; }
	DKElementFormControl* input = static_cast<DKElementFormControl*>(element);
	if(!prop || prop->parser_index == -1){
		input->SetValue("");
		return false;
	}
	else{
		input->SetValue(prop->ToString().CString());
		return true;
	}
	return false;
}

//////////////////////////////////////////////
bool DKWidget::ScrollToTop(Rocket::Core::Element* element)
{
	DKDEBUGFUNC(element);
	element->SetScrollTop(0);
	return true;
}

/////////////////////////////////////////////////
bool DKWidget::ScrollToBottom(Rocket::Core::Element* element)
{
	DKDEBUGFUNC(element);
	Rocket::Core::Element* last_child = element->GetLastChild();
	if(!last_child){
		DKERROR("DKWidget::ScrollToBottom(): last_child invalid\n");
		return false;
	}
	last_child->ScrollIntoView();
	return true;
}

//////////////////////////////////////////////////////////////////
bool DKWidget::GetClientWidth(Rocket::Core::Element* element, DKString& value)
{
	DKDEBUGFUNC(element, value);
	if(!element){
		DKERROR("DKWidget::GetClientWidth(element,"+value+"): element invalid\n");
		return false;
	}
	float width = element->GetClientWidth();
	value = toString(width);
	return true;
}

///////////////////////////////////////////////////////////////////
bool DKWidget::GetClientHeight(Rocket::Core::Element* element, DKString& value)
{
	DKDEBUGFUNC(element, value);
	if(!element){
		DKERROR("DKWidget::GetClientHeight(element,"+value+"): element invalid\n");
		return false;
	}
	float height = element->GetClientHeight();
	value = toString(height);
	return true;
}











//extra
////////////////////////////////////////////////////////////////////
bool DKWidget::IsChildOf(const DKString& id, const DKString& parent)
{	
	DKDEBUGFUNC(id, parent);
	if(id.empty()){
		DKERROR("DKWidget::IsChildOf(): id empty\n");
		return false;
	}
	if(parent.empty()){
		DKERROR("DKWidget::IsChildOf(): parent empty\n");
		return false;
	}
	if(!IsChildOf(GetElementById(id), GetElementById(parent))){ return false; }
	return true;
}

////////////////////////////////////////////////////////////////////
bool DKWidget::IsChildOf(Rocket::Core::Element* element, const DKString& parent)
{
	DKDEBUGFUNC(element, parent);
	return IsChildOf(element, GetElementById(parent));
}

///////////////////////////////////////////////////////////////
bool DKWidget::IsChildOf(Rocket::Core::Element* element, Rocket::Core::Element* parent)
{
	DKDEBUGFUNC(element, parent);
	if(!element){return false;}
	if(!parent){return false;}

	Rocket::Core::Element* ele = element;
	if(ele == parent){
		return true;
	}
	while(ele && (ele != parent)){
		if(ele == parent->GetOwnerDocument()){
			return false;
		}
		ele = ele->GetParentNode();
	}
	return true;
}

//////////////////////////////////////////
bool DKWidget::GetMouseWindowX(int& x_out)
{
	DKDEBUGFUNC(x_out);
	int mouseX = 0;
	int mouseY = 0;
	if(!DKUtil::GetMousePos(mouseX, mouseY)){ return false; }

	//Dynamic cast a DKOject to it's class
	//DKOSGWindow* window = dynamic_cast<DKOSGWindow*>(DKCreate("MainWindow"));
	//mouseX -= window->traits->x;
#ifdef DESKTOP
	//mouseX -= DKOSGWindow::Get("DKOSGWindow")->traits->x;
	int x;
	if(!DKWindow::GetX(x)){ return 0; }
	mouseX -= x;
#endif	

	x_out = mouseX;
	return true;
}

//////////////////////////////////////////
bool DKWidget::GetMouseWindowY(int& y_out)
{
	DKDEBUGFUNC(y_out);
	int mouseX = 0;
	int mouseY = 0;
	if(!DKUtil::GetMousePos(mouseX, mouseY)){ return 0; }

	//Dynamic cast a DKOject to it's class
	//DKOSGWindow* window = dynamic_cast<DKOSGWindow*>(DKCreate("MainWindow"));
	//mouseY -= window->traits->y;
#ifdef DESKTOP
	//mouseY -= DKOSGWindow::Get("DKOSGWindow")->traits->y;
	int y;
	if(!DKWindow::GetY(y)){ return false; }
	mouseY -= y;
#endif

	y_out = mouseY;
	return true;
}

//////////////////////////////////////////////////////////////////////////////////
bool DKWidget::GetMouseElementPosition(const DKString& id, int& x_out, int& y_out)
{
	DKDEBUGFUNC(id, x_out, y_out);
	return DKWidget::GetMouseElementPosition(GetElementById(id), x_out, y_out);
}

//////////////////////////////////////////////////////////////////////////////////
bool DKWidget::GetMouseElementPosition(Rocket::Core::Element* element, int& x_out, int& y_out)
{
	DKDEBUGFUNC(element, x_out, y_out);
	if(!element){ return false; }
	int mouseX;
	int mouseY;
	GetMouseWindowX(mouseX);
	GetMouseWindowY(mouseY);

	int temp_x = 0;
	int temp_y = 0;
	
	Rocket::Core::Element* ele = element;
	Rocket::Core::Element* root = GetElementById("body");
	while(ele != root){

		//When non absolute elements are involved, it's a little harder to get the actual position.
		DKString value;
		GetProperty(ele, "position", value);
		if(!same(value, "absolute")){ 
			x_out = 0;
			y_out = 0;
			return true; 
		} 

		DKString temp;
		if(!GetProperty(ele,"left",temp)){
			if(GetProperty(ele,"right",temp)){

				//Dynamic cast a DKOject to it's class
				//DKOSGWindow* window = dynamic_cast<DKOSGWindow*>(DKCreate("MainWindow"));
				//int w_width = window->width;
				//int w_width = DKOSGWindow::Get("DKOSGWindow")->width;
				int w_width;
				if(!DKWindow::GetWidth(w_width)){ return false; }

				int width = ele->GetProperty<int>("width");
				int right = ele->GetProperty<int>("right");
				temp_x += (w_width - right - width);
			}
		}
		if(!GetProperty(ele,"top",temp)){
			if(GetProperty(ele,"bottom",temp)){

				//Dynamic cast a DKOject to it's class
				//DKOSGWindow* window = dynamic_cast<DKOSGWindow*>(DKCreate("MainWindow"));
				//int w_height = window->height;
				//int w_height = DKOSGWindow::Get("DKOSGWindow")->height;
				int w_height;
				DKWindow::GetHeight(w_height);

				int height = ele->GetProperty<int>("height");
				int bottom = ele->GetProperty<int>("bottom");
				temp_y += (w_height - bottom - height);
			}
		}
		temp_x += ele->GetProperty<int>("left");
		temp_y += ele->GetProperty<int>("top");
		ele = ele->GetParentNode();
	}

	x_out = mouseX - temp_x;
	y_out = mouseY - temp_y;

	return true;
}

//////////////////////////////////////////////
bool DKWidget::MoveToFront(const DKString& id)
{
	DKDEBUGFUNC(id);
	/*
	Rocket::Core::Element* temp = root->GetElementById(id.c_str());
	if(has(id,".html")){
		temp->GetParentNode()->RemoveChild(temp);
		root->GetOwnerDocument()->AppendChild(temp);
	}
	else{
		DKString panel;
		GetPanel(id, panel);
		temp->GetParentNode()->RemoveChild(temp);
		Rocket::Core::Element* the_panel = dkRocket->document->GetElementById(panel.c_str());
		the_panel->AppendChild(temp);//items in .html files need to stay within the .html file
	}
	*/
	return false;
}

/////////////////////////////////////////////////
DKString DKWidget::Filter(const DKProperty* prop)
{
	DKDEBUGFUNC(prop);
	if(!prop){ return "";}
	DKString string = prop->ToString().CString();
	replace(string,".0000","");
	if(same(string,"0")){return "";}
	return string;
}

////////////////////////////////////////////
bool DKWidget::ValidateSize(DKString &value)
{
	DKDEBUGFUNC(value);
	if(!value.c_str()){
		DKERROR("DKStyler::ValidateField() value invalid\n");
		return false;
	}

	DKString ext = "rem";
	replace(value, "rem", "");
	replace(value, "p", "");
	if(has(value,"%")){
		replace(value,"%","");
		ext = "%";
	}

	if(IsNumber(value)){
		int ival = toInt(value);
		if(ival > 4){
			value += ext;
			return true;
		}
		value = "5";
		value += ext;
		return true;
	}

	value = "5rem";
	return false;
}

////////////////////////////////////////////////
bool DKWidget::ValidatePosition(DKString &value)
{
	DKDEBUGFUNC(value);
	if(!value.c_str()){
		DKERROR("DKStyler::ValidateField() value invalid\n");
		return false;
	}

	DKString ext = "rem";
	replace(value, "rem", "");
	replace(value, "p", "");
	if(has(value,"%")){
		replace(value,"%","");
		ext = "%";
	}

	if(IsNumber(value)){
		int ival = toInt(value);
		if(ival > 0){
			value += ext;
			return true;
		}
		value = "0";
		value += ext;
		return true;
	}

	value = "0rem";
	return false;
}

//////////////////////////////////////////////
bool DKWidget::ValidateNumber(DKString &value)
{
	DKDEBUGFUNC(value);
	if(!value.c_str()){
		DKERROR("DKStyler::ValidateField() value invalid\n");
		return false;
	}

	if(IsNumber(value)){
		return true;
	}

	value = "1";
	return false;
}

/////////////////////////////////////////////
bool DKWidget::ValidateColor(DKString &value)
{
	DKDEBUGFUNC(value);
	if(value.empty()){ return false; }
	if(has(value,"255, 255, 255, 0")){ value = ""; return false; } //transparent 

	if(has(value,"rgba")){
		replace(value, "rgba", "rgb");
	}
	if(!has(value,"rgb(")){
		value = "rgb(" + value + ")";
	}
	replace(value, ",255)", "#");
	replace(value, ",0)", "#");
	replace(value, ", 255)", "#");
	replace(value, ", 0)", "#");
	replace(value, "#", ")");
	return true;
}

///////////////////////////////////////////////////////////////////////
bool DKWidget::GetElements(const DKString& id, DKStringArray& elements)
{
	DKDEBUGFUNC(id, "DKStringArray&");
	DKElementList list;
	if(!GetElements(GetElementById(id), list)){ return false;  }
	DKString file;
	for(unsigned int i=0; i<list.size(); ++i){
		if(same(list[i]->GetTagName().CString(),"script")){ continue; }
		if(!list[i]->GetId().Empty()){
			elements.push_back(list[i]->GetId().CString());
			DKWidget::GetFile(list[i], file);
		}
		else{
			DKERROR("DKWidget::GetElements("+id+"): element found with no ID\n");
			DKString tag = list[i]->GetTagName().CString();
			DKString innerHtml = list[i]->GetInnerRML().CString();
			DKString parent = list[i]->GetParentNode()->GetId().CString();
			DKERROR("<" +tag+ ">" +innerHtml+ "</" +tag+ ">\n");
			DKERROR("PARENT: "+parent+"\n");
			if(!file.empty()){
				DKERROR("Last file loaded was "+file+"\n");

				//check to see next file
				unsigned int b = i+1;
				DKString next_file = file;
				while(same(next_file, file) && b<list.size()){
					if(!list[b]->GetId().Empty()){
						DKWidget::GetFile(list[b], next_file);
					}
					b++;
				}
				DKERROR("Next file to load is "+next_file+"\n");
			}
		}
	}
	return true;
}

///////////////////////////////////////////////////////////////////////
bool DKWidget::GetElements(const DKString& id, DKElementList& elements)
{
	DKDEBUGFUNC(id, "DKElementList&");
	return GetElements(GetElementById(id), elements);
}

//////////////////////////////////////////////////////////////////////
bool DKWidget::GetElements(Rocket::Core::Element* parent, DKElementList& elements)
{
	DKDEBUGFUNC(parent, "DKElementList&");
	if(!parent){ return false; }
	typedef std::queue<Rocket::Core::Element*> SearchQueue;
	SearchQueue search_queue;
	for (int i = 0; i < parent->GetNumChildren(); ++i)
		search_queue.push(parent->GetChild(i));

	while(!search_queue.empty()){
		Rocket::Core::Element* element = search_queue.front();
		search_queue.pop();

		if(!has(element->GetTagName().CString(), "#")){
			elements.push_back(element);
		}

		// Add all children to search.
		for (int i = 0; i < element->GetNumChildren(); i++){
			search_queue.push(element->GetChild(i));
		}
	}
	return true;
}

////////////////////////////
bool DKWidget::AttachDrags()
{
	DKDEBUGFUNC();
	DKElementList elements;
	GetElements(root, elements);
	for (unsigned int i = 0; i<elements.size(); ++i){

		//add handle to elements with a "drag"
		if (elements[i]->HasAttribute("drag")){
			AddDragHandle(elements[i]->GetId().CString(), elements[i]->GetAttribute("drag")->Get<DKCString>().CString());
		}

		//add handle to elements with a "resize"
		if (elements[i]->HasAttribute("resize")){
			Rocket::Core::Element* handle = CreateElement("handle");
			DKString file = elements[i]->GetParentNode()->GetId().CString();
			DKFile::RemoveExtention(file);
			elements[i]->GetParentNode()->GetId().CString();
			SetAttribute(handle, "id", file + "DKResize");
			SetAttribute(handle, "size_target", elements[i]->GetAttribute("resize")->Get<DKCString>().CString());
			SetProperty(handle, "position", "absolute");
			SetProperty(handle, "top", "0rem");
			SetProperty(handle, "left", "0rem");
			SetProperty(handle, "width", "100%");
			SetProperty(handle, "height", "100%");
			elements[i]->AppendChild(handle);
		}
	}

	return true;
}

//////////////////////////////////////////////////////////////////////
bool DKWidget::AddDragHandle(const DKString& id, const DKString& drag)
{
	DKDEBUGFUNC(id, drag);
	DKString handle;
	DKString first_child = GetFirstChild(id);
	if (!first_child.empty()){
		Rocket::Core::Element* element = DKWidget::GetElementById(first_child);
		if(!element){return false;}
		DKString tag = element->GetTagName().CString();
		if(same(tag, "handle")){ return false; }
		//DKINFO("DKWidget::AddDragHandle(): CreateElementBefore("+GetFirstChild(id)+",handle, DKC-handle\n");
		handle = CreateElementBefore(GetFirstChild(id), "handle", "DKC-handle");
	}
	else{
		//DKINFO("DKWidget::AddDragHandle(): CreateElement("+id+",handle, DKC-handle\n");
		handle = CreateElement(id, "handle", "DKC-handle");
	}

	SetAttribute(handle, "move_target", drag);
	SetProperty(handle, "position", "absolute");
	SetProperty(handle, "top", "0rem");
	SetProperty(handle, "left", "0rem");
	SetProperty(handle, "width", "100%");
	SetProperty(handle, "height", "100%");
	return true;
}

///////////////////////////////////////////////////
bool DKWidget::RemoveDragHandle(const DKString& id)
{
	DKDEBUGFUNC(id);
	Rocket::Core::Element* element = DKWidget::GetElementById(id);
	if(!element){ return false; }
	DKString tag = element->GetTagName().CString();
	if(same(tag, "handle")){
		DKWidget::RemoveElement(id);
	}

	return true;
}

//////////////////////////////////////////////////////////////////////////
bool DKWidget::AddResizeHandle(const DKString& id, const DKString& resize)
{
	DKDEBUGFUNC(id, resize);
	DKString handle;
	DKString first_child = GetFirstChild(id);
	if (!first_child.empty()){
		Rocket::Core::Element* element = DKWidget::GetElementById(first_child);
		if(!element){return false;}
		DKString tag = element->GetTagName().CString();
		if(same(tag, "handle")){ return false; }
		//DKINFO("DKWidget::AddDragHandle(): CreateElementBefore("+GetFirstChild(id)+",handle, DKC-handle\n");
		handle = CreateElementBefore(GetFirstChild(id), "handle", "DKC-handle");
	}
	else{
		//DKINFO("DKWidget::AddDragHandle(): CreateElement("+id+",handle, DKC-handle\n");
		handle = CreateElement(id, "handle", "DKC-handle");
	}

	SetAttribute(handle, "size_target", resize);
	SetProperty(handle, "position", "absolute");
	SetProperty(handle, "top", "0rem");
	SetProperty(handle, "left", "0rem");
	SetProperty(handle, "width", "100%");
	SetProperty(handle, "height", "100%");
	return true;
}

/////////////////////////////////////////////////////
bool DKWidget::RemoveResizeHandle(const DKString& id)
{
	DKDEBUGFUNC(id);
	Rocket::Core::Element* element = DKWidget::GetElementById(id);
	if(!element){ return false; }
	DKString tag = element->GetTagName().CString();
	if(same(tag, "handle")){
		DKWidget::RemoveElement(id);
	}
	return true;
}

////////////////////////////////////////////////////
DKString DKWidget::GetFirstChild(const DKString& id)
{
	DKDEBUGFUNC(id);
	Rocket::Core::Element* element = DKWidget::GetElementById(id);
	if(!element){ return 0; }
	Rocket::Core::Element* child = element->GetFirstChild();
	if(!child){return "";}
	return DKWidget::GetId(child);
}

///////////////////////////////////////////////////
DKString DKWidget::GetLastChild(const DKString& id)
{
	DKDEBUGFUNC(id);
	Rocket::Core::Element* element = DKWidget::GetElementById(id);
	if(!element){ return 0; }
	Rocket::Core::Element* child = element->GetLastChild();
	if(!child){return "";}
	return DKWidget::GetId(child);
}

///////////////////////////////////////////////////
bool DKWidget::GetOption(const DKString& id, int n)
{
	DKDEBUGFUNC(id, n);
	Rocket::Core::Element* element = DKWidget::GetElementById(id);
	if(!same(element->GetTagName().CString(), "select")){
		DKWARN("DKWidget::SelectOption("+id+"): not a select element\n");
		return false;
	}

	Rocket::Controls::ElementFormControlSelect* ele = static_cast<Rocket::Controls::ElementFormControlSelect*>(element);
	n = ele->GetSelection();
	return true;
}

///////////////////////////////////////////////////
bool DKWidget::SetOption(const DKString& id, int n)
{
	DKDEBUGFUNC(id, n);
	Rocket::Core::Element* element = DKWidget::GetElementById(id);
	if(!same(element->GetTagName().CString(), "select")){
		DKWARN("DKWidget::SelectOption("+id+"): not a select element\n");
		return false;
	}

	Rocket::Controls::ElementFormControlSelect* ele = static_cast<Rocket::Controls::ElementFormControlSelect*>(element);
	ele->SetSelection(n);
	return true;
}



//// Saving HTML files
////////////////////////////////////////////////////////////////////
bool DKWidget::BuildStyleString(const DKString& id, DKString &style)
{
	DKDEBUGFUNC(id, style);
	//TODO: some properties, we only need to add a style if it's different from the elements parent 
	Rocket::Core::Element* element = GetElementById(id);
	Rocket::Core::Element* parent = element->GetParentNode();
	DKString temp;
	DKString par;

	if(GetProperty(element,"display",temp) && !same(temp,"block")){ 
		style += "display:"+temp+";"; 
	}
	if(GetProperty(element,"visibility",temp) && !same(temp,"visible")){ 
		style += "visibility:"+temp+";"; 
	}
	if(GetProperty(element,"z-index",temp)){ style += "z-index:"+temp+";"; }
	if(GetProperty(element,"position",temp)){ style += "position:"+temp+";"; }
	if(GetProperty(element,"top",temp)){ style += "top:"+temp+";"; }
	if(GetProperty(element,"left",temp)){ style += "left:"+temp+";"; }
	if(GetProperty(element,"bottom",temp)){ style += "bottom:"+temp+";"; }
	if(GetProperty(element,"right",temp)){ style += "right:"+temp+";"; }
	if(GetProperty(element,"width",temp)){ style += "width:"+temp+";"; }
	if(GetProperty(element,"height",temp)){ style += "height:"+temp+";"; }
	if(GetProperty(element,"overflow-x",temp)){ style += "overflow-x:"+temp+";"; }
	if(GetProperty(element,"overflow-y",temp)){ style += "overflow-y:"+temp+";"; }
	if(GetProperty(element,"margin-top",temp)){ style += "margin-top:"+temp+";"; }
	if(GetProperty(element,"margin-left",temp)){ style += "margin-left:"+temp+";"; }
	if(GetProperty(element,"margin-bottom",temp)){ style += "margin-bottom:"+temp+";"; }
	if(GetProperty(element,"margin-right",temp)){ style += "margin-right:"+temp+";"; }
	if(GetProperty(element,"padding-top",temp)){ style += "padding-top:"+temp+";"; }
	if(GetProperty(element,"padding-left",temp)){ style += "padding-left:"+temp+";"; }
	if(GetProperty(element,"padding-bottom",temp)){ style += "padding-bottom:"+temp+";"; }
	if(GetProperty(element,"padding-right",temp)){ style += "padding-right:"+temp+";"; }
	if(GetProperty(element,"border-style",temp)){ style += "border-style:"+temp+";"; } //NOT WORKING
	if(GetProperty(element,"border-top-width",temp)){ style += "border-width:"+temp+";"; }

	if(GetProperty(element,"font-family",temp)){
		GetProperty(parent, "font-family", par);
		if(!same(temp, par)){ style += "font-family:"+temp+";"; }
	}
	if(GetProperty(element,"font-size",temp)){
		GetProperty(parent, "font-size", par);
		if(!same(temp, par)){ style += "font-size:"+temp+";"; }
	}
	if(GetProperty(element,"font-style",temp)){
		GetProperty(parent, "font-style", par);
		if(!same(temp, par)){ style += "font-style:"+temp+";"; }
	}
	if(GetProperty(element,"font-weight",temp)){
		GetProperty(parent, "font-weight", par);
		if(!same(temp, par)){ style += "font-weight:"+temp+";"; }
	}
	if(GetProperty(element,"text-align",temp)){
		GetProperty(parent, "text-align", par);
		if(!same(temp, par)){ style += "text-align:"+temp+";"; }
	}
	
	if(GetProperty(element,"border-color",temp)){ //NOT WORKING
		if(ValidateColor(temp)){
			style += "background-color:"+temp+";";
		}
	}

	if(GetProperty(element,"background-color",temp)){
		if(ValidateColor(temp)){
			style += "background-color:"+temp+";";
		}
	}

	if(GetProperty(element,"color",temp)){
		if(ValidateColor(temp)){
			style += "color:"+temp+";"; 
		}
	}

	return true;
}

////////////////////////////////////////////////////////////////////////
bool DKWidget::BuildOptionsString(const DKString& id, DKString &options)
{
	DKDEBUGFUNC(id, options);
	Rocket::Core::Element* element = GetElementById(id);
	if(element->HasAttribute("nosave_inner")){ return false; }
	Rocket::Core::Element* selectbox = element->GetChild(1);

	GetInnerHtml(selectbox, options);

	replace(options,"<option />","");
	if(!has(options,"<option>")){
		return false;	
	}
	return true;
}


#endif //USE_DKRocket