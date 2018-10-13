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
	DKLog("DKWidget::Init() \n", DKDEBUG);
	
	DKClass::DKCreate("DKWidgetJS");
	DKClass::DKCreate("DKWidgetMySqlJS");
	root = NULL;

	//link objects
	dkRocket = DKRocket::Get("DKRocket0");
	if(!dkRocket){
		DKLog("DKWidget::Init(): INVALID OBJECTS \n", DKERROR);
		return false;
	}

	DKString _data = toString(data, ",");
	//DKLog("DKWidget::Init("+_data+")\n", DKDEBUG);

	//data = ("DKWidget, file, parent")
	if(data.size() < 2){	
		DKLog("DKWidget::Init("+_data+"): missing parameters. \n", DKERROR);
	}
	if(data.size() > 3){
		DKLog("DKWidget::Init("+_data+"): too many parameters. \n", DKERROR);
	}

	if(data.size() < 3){
		data.push_back("body");
	}

	//make sure the parent exists
	if(!DKWidget::GetElementById(data[2])){
		DKLog("DKWidget::Init(): the parent element ("+data[2]+") is invalid. \n", DKWARN);
		DKLog("DKWidget::Init(): Changing parent to \"body\" \n", DKWARN);
		data[2] = "body";
	}
	
	if(same(data[1],"DKWidget0")){ return true; }
	CreateWidget(data[1]);
	return true;
}

////////////////////
bool DKWidget::End()
{
	RemoveWidget(this);
	return true;
}

/////////////////////////////////////////////
void DKWidget::RemoveWidget(DKWidget* widget)
{
	//TODO - any child widgets need to be deleted first
	if(!root){ return; }
	DKString id = root->GetId().CString();
	if(id.empty()){ return; }
	//DKLog("DKWidget::RemoveWidget("+id+")\n", DKINFO);
	
	//Remove all child DKWidgets and events
	RemoveAllEventListeners(id);
	DKStringArray elements;
	GetElements(id, elements);
	for(unsigned int i = elements.size(); i-- > 0;){
		RemoveAllEventListeners(elements[i]);
		if(has(elements[i],".html")){ DKClass::DKClose(elements[i]); }
	}

	if(DKApp::active){
		DKElement* parent = root->GetParentNode();
		if(!parent){ return; }
		parent->RemoveChild(root);
	}
}

///////////////////////////////////////////
bool DKWidget::CreateWidget(DKString& file)
{
	//DKLog("DKWidget::CreateWidget("+file+")\n", DKDEBUG);

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
			DKLog("DKWidget::CreateWidget("+file+"): file does not exist", DKERROR);
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
	DKRocketToRML dkRocketToRML;
	if(!dkRocketToRML.HtmlToRml(html, rml)){
		return false;
	}

	//Parse the sting into an element
	Rocket::Core::ElementDocument* doc = dkRocket->document;
	if(!doc){
		DKLog("DKWidget::CreateWidget("+path+"): could not find documant \n", DKERROR);
		return false;
	}
	DKElement* temp = doc->CreateElement("temp"); //FIXME - is the memory delt with properly?
	if(!temp){
		DKLog("DKWidget::CreateWidget("+path+"): could not find firstChild \n", DKERROR);
		return false;
	}
	SetInnerHtml(temp, rml);

	DKElement* firstChild = temp->GetFirstChild();
	if(!firstChild){
		DKLog("DKWidget::CreateWidget("+path+"): could not find firstChild \n", DKERROR);
		return false;
	}
	DKString _id = firstChild->GetId().CString();

	//FIXME - the id needs to be the path from the assets folder..  i.e.  MyPlugin/MyPlugin.js
	/*
	if(!same(_id,id)){
		DKLog("DKWidget::CreateWidget("+path+"): fixing id... "+id+"\n", DKWARN);
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
		//DKLog("AppendChild("+data[2]+", temp->GetChild(0)\n", DKDEBUG);
		AppendChild(data[2], temp->GetChild(0));
	}

	//Set the root element of this widget
	Trim(id);
	root = dkRocket->document->GetElementById(_id.c_str());

	dkRocketToRML.PostProcess(root);

	AttachEvents();
	AttachDrags();

	//force refresh of rocket for overflow fixes
	root->SetContentBox(Rocket::Core::Vector2f(0,0), Rocket::Core::Vector2f(0,0));

	return true;
}

/////////////////////////////
bool DKWidget::AttachEvents()
{
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
	if(same(event->GetType(), type)){ return true; }
	return false;
}

/////////////////////////////////////////////////////
bool DKWidget::Id(DKEvent* event, const DKString& id)
{
	if(same(event->GetId(), id)){ return true; }
	return false;
}

/////////////////////////////////////////////////////////
bool DKWidget::Id(DKElement* element, const DKString& id)
{
	if(same(GetId(element), id)){ return true; }
	return false;
}

/////////////////////////////////////////////////////////
bool DKWidget::IdLike(DKEvent* event, const DKString& id)
{
	if(has(event->GetId(), id)){ return true; }
	return false;
}

///////////////////////////////////////////////////////////
bool DKWidget::Value(DKEvent* event, const DKString& value)
{
	if(same(event->GetValue(), value)){ return true; }
	return false;
}

///////////////////////////////////////////////
DKElement* DKWidget::GetElement(DKEvent* event)
{
	DKString id = event->GetId();
	DKElement* element = GetElementById(id);
	return element;
}

/*
/////////////////////////////////
bool DKWidget::ClearReturnEvent()
{
	event_type.clear();
	event_id.clear();
	event_data.clear();
	return true;
}

///////////////////////////////////////////////
bool DKWidget::StoreReturnEvent(DKEvent* event)
{
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
DKString DKWidget::GetId(DKElement* element)
{
	if(!element){ return ""; }
	return element->GetId().CString();
}

////////////////////////////////////////
DKString DKWidget::GetId(DKEvent* event)
{
	DKElement* element = GetElement(event);
	if(!element){ return ""; }
	return element->GetId().CString();
}

///////////////////////////////////////////
DKString DKWidget::GetValue(DKEvent* event)
{
	DKElement* element = GetElement(event);
	return GetValue(element);
}

///////////////////////////////////////////////
DKString DKWidget::GetValue(const DKString& id)
{
	DKString value = "";
	GetValue(id, value);
	return value;
}

///////////////////////////////////////////////
DKString DKWidget::GetValue(DKElement* element)
{
	DKString value = "";
	GetValue(element, value);
	return value;
}

///////////////////////////////////////////////////
DKElement* DKWidget::GetElement(const DKString& id)
{
	return GetElementById(id);
}


/////////////////////////////////////////////////////////////////
bool DKWidget::GetOuterHtml(const DKString& id, DKString& string)
{
	return GetOuterHtml(GetElementById(id), string);
}

/////////////////////////////////////////////////////////////////
bool DKWidget::GetOuterHtml(DKElement* element, DKString& string)
{
	if(!element){ return false; }
	DKElement* parent = element->GetParentNode();
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
DKElement* DKWidget::CreateElement(const DKString& tag)
{
	DKElement* element = dkRocket->document->CreateElement(tag.c_str());
	if(!element){
		DKLog("DKWidget::CreateElement("+tag+")\n", DKERROR);
		return 0;
	}
	element->SetAttribute("style","top:0rem;"); //we do this just to initialze an active style string
	return element;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
DKString DKWidget::CreateElement(const DKString& parent, const DKString& tag, const DKString& id)
{
	DKElement* element = CreateElement(tag);
	
	DKString ele_id;
	GetAvailableId(id, ele_id);

	DKWidget::SetAttribute(element, "id", ele_id);
	DKWidget::AppendChild(parent, element);

	DKRocketToRML dkRocketToRML;
	dkRocketToRML.PostProcess(GetElementById(parent));

	return ele_id;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
DKString DKWidget::CreateElementFirst(const DKString& parent, const DKString& tag, const DKString& id)
{
	DKElement* element = CreateElement(tag);
	
	DKString ele_id;
	GetAvailableId(id, ele_id);

	DKWidget::SetAttribute(element, "id", ele_id);
	DKWidget::PrependChild(GetElementById(parent), element);

	DKRocketToRML dkRocketToRML;
	dkRocketToRML.PostProcess(GetElementById(parent));

	return ele_id;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////
DKString DKWidget::CreateElementBefore(const DKString& element, const DKString& tag, const DKString& id)
{
	DKLog("DKWidget::CreateElementBefore("+element+","+tag+","+id+")\n", DKDEBUG);
	DKElement* ele = CreateElement(tag);
	
	DKString ele_id;
	GetAvailableId(id, ele_id);

	DKWidget::SetAttribute(ele, "id", ele_id);
	DKWidget::InsertBefore(element, ele);

	DKRocketToRML dkRocketToRML;
	dkRocketToRML.PostProcess(ele->GetParentNode());

	return ele_id;
}

////////////////////////////////////////////////////////////////
void DKWidget::GetAvailableId(const DKString& id, DKString& out)
{
	out = id;
	int i = 0;
	
	while(DKWidget::GetElementById(out)){
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
	//DKLog("DKWidget::GetAvailableId("+id+")-> "+out+"\n");
}

///////////////////////////////////////////////////////
DKElement* DKWidget::GetElementById(const DKString& id)
{
	if(id.empty()){
		DKLog("DKWidget::GetElementById(): id empty. \n",DKWARN);
		return NULL;
	}
	Rocket::Core::ElementDocument* doc = dkRocket->document;
	if(!doc){
		return 0;
	}
	DKElement* element = doc->GetElementById(id.c_str());
	if(!element){
		//DKLog("DKWidget::GetElementById("+id+"): could not find element. \n", DKWARN);
		return 0;
	}
	return element;
}

//////////////////////////////////////////////////////////
bool DKWidget::GetFile(const DKString& id, DKString& file)
{
	return GetFile(GetElementById(id), file);
}

////////////////////////////////////////////////////////////////
bool DKWidget::SetFile(const DKString& id, const DKString& file)
{
	return SetFile(GetElementById(id), file);
}

//////////////////////////////////////////
bool DKWidget::Visible(const DKString& id)
{
	return Visible(GetElementById(id));
}

/////////////////////////////////////////
bool DKWidget::Toggle(const DKString& id)
{
	return Toggle(GetElementById(id));
}

///////////////////////////////////////
bool DKWidget::Show(const DKString& id)
{
	return Show(GetElementById(id));
}

///////////////////////////////////////
bool DKWidget::Hide(const DKString& id)
{
	return Hide(GetElementById(id));
}

//////////////////////////////////////////////////////////////
bool DKWidget::GetParent(const DKString& id, DKString& parent)
{
	return GetParent(GetElementById(id), parent);
}

//////////////////////////////////////////////////////////////////////
bool DKWidget::AppendChild(const DKString& parent, const DKString& id)
{
	return AppendChild(GetElementById(parent), GetElementById(id));
}

///////////////////////////////////////////////////////////////////////
bool DKWidget::PrependChild(const DKString& parent, const DKString& id)
{
	return PrependChild(GetElementById(parent), GetElementById(id));
}

//////////////////////////////////////////////////////////////////////
bool DKWidget::AppendChild(const DKString& parent, DKElement* element)
{
	return AppendChild(GetElementById(parent), element);
}

////////////////////////////////////////////////////////////////////////////
bool DKWidget::InsertBefore(const DKString& parent, const DKString& element)
{
	return InsertBefore(GetElementById(parent), GetElementById(element));
}

///////////////////////////////////////////////////////////////////////
bool DKWidget::InsertBefore(const DKString& parent, DKElement* element)
{
	return InsertBefore(GetElementById(parent), element);
}

////////////////////////////////////////////////
bool DKWidget::RemoveElement(const DKString& id)
{
	DKLog("DKWidget::RemoveElement("+id+")\n", DKDEBUG);

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
	
	DKElement* element = GetElementById(id);
	if(!element){ return false; }
	DKElement* parent = element->GetParentNode();
	if(!parent){ return false; }
	parent->RemoveChild(element);
	return true;
}

/////////////////////////////////////////////////////////////////////////
bool DKWidget::AddEventListener(const DKString& id, const DKString& type)
{
	return AddEventListener(GetElementById(id), type);
}

////////////////////////////////////////////////////////////////////////////
bool DKWidget::RemoveEventListener(const DKString& id, const DKString& type)
{
	if(!RemoveEventListener(GetElementById(id), type)){ return false; }
	DKEvent::RemoveEvents(id, type);
	return true;
}

//////////////////////////////////////////////////////////
bool DKWidget::RemoveAllEventListeners(const DKString& id)
{
	return DKEvent::RemoveEvents(id);
}

//////////////////////////////////////////////////////////////////////////////////////
bool DKWidget::GetAttribute(const DKString& id, const DKString& name, DKString& value)
{
	//FIXME
#ifndef LINUX
	//if(!DKUtil::InMainThread()){ return false; } //Talking to the GUI from other threads is bad.
#endif
	return GetAttribute(GetElementById(id), name, value);
}

////////////////////////////////////////////////////////////////////////////////////////////
bool DKWidget::SetAttribute(const DKString& id, const DKString& name, const DKString& value)
{
//FIXME
#ifndef LINUX
	//if(!DKUtil::InMainThread()){ return false; }  //Talking to the GUI from other threads is bad.
#endif
	return SetAttribute(GetElementById(id), name, value);
}

/////////////////////////////////////////////////////////////////////////////////////
bool DKWidget::GetProperty(const DKString& id, const DKString& name, DKString& value)
{
	return GetProperty(GetElementById(id), name, value);
}
///////////////////////////////////////////////////////////////////////////////////////////
bool DKWidget::SetProperty(const DKString& id, const DKString& name, const DKString& value)
{
	DKLog("DKWidget::SetProperty("+id+","+name+","+value+")\n", DKDEBUG);
	return SetProperty(GetElementById(id), name, value);
}

////////////////////////////////////////////////////////////////
bool DKWidget::GetInnerHtml(const DKString& id, DKString& value)
{
	return GetInnerHtml(GetElementById(id), value);
}

////////////////////////////////////////////////////////////////
bool DKWidget::GetInnerHtmlString(const DKString& id, DKString& value)
{
	return GetInnerHtmlString(GetElementById(id), value);
}

//////////////////////////////////////////////////////////////////////
bool DKWidget::SetInnerHtml(const DKString& id, const DKString& value)
{
	return SetInnerHtml(GetElementById(id), value);
}

////////////////////////////////////////////////////////////////////////////
bool DKWidget::SetInnerHtmlString(const DKString& id, const DKString& value)
{
	return SetInnerHtmlString(GetElementById(id), value);
}

////////////////////////////////////////////////////////////
bool DKWidget::GetValue(const DKString& id, DKString& value)
{
	return GetValue(GetElementById(id), value);
}

///////////////////////////////////////////////////////
bool DKWidget::GetValue(const DKString& id, int& value)
{
	return GetValue(GetElementById(id), value);
}

//////////////////////////////////////////////////////////////////
bool DKWidget::SetValue(const DKString& id, const DKString& value)
{
	return SetValue(GetElementById(id), value);
}

/////////////////////////////////////////////////////////////
bool DKWidget::SetValue(const DKString& id, const int& value)
{
	return SetValue(GetElementById(id), value);
}

////////////////////////////////////////////////////////////////////
bool DKWidget::SetValue(const DKString& id, const DKProperty* value)
{
	return SetValue(GetElementById(id), value);
}

//////////////////////////////////////////////
bool DKWidget::ScrollToTop(const DKString& id)
{
	return ScrollToTop(GetElementById(id));
}

/////////////////////////////////////////////////
bool DKWidget::ScrollToBottom(const DKString& id)
{
	return ScrollToBottom(GetElementById(id));
}

//////////////////////////////////////////////////////////////////
bool DKWidget::GetClientWidth(const DKString& id, DKString& value)
{
	if (!GetClientWidth(GetElementById(id), value)) { return false; }
	return true;
}

////////////////////////////////////////////////////////////////////
bool DKWidget::GetClientHeight(const DKString& id, DKString& value)
{
	return GetClientHeight(GetElementById(id), value);
}












//by element
//////////////////////////////////////////////////////////
bool DKWidget::GetFile(DKElement* element, DKString& file)
{
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

	return 1;
}

////////////////////////////////////////////////////////////////
bool DKWidget::SetFile(DKElement* element, const DKString& file)
{
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

	return 1;
}

////////////////////////////////////////////
bool DKWidget::GetFocusElement(DKString& id)
{
	DKElement* focused = dkRocket->document->GetContext()->GetFocusElement();
	id = focused->GetId().CString();
	if(id.empty()){ return false; }
	return true;
}

/////////////////////////////////////
bool DKWidget::SetFocus(DKString& id)
{
	DKElement* element = dkRocket->document->GetElementById(id.c_str());
	if(!element){ 
		DKLog("DKWidget::SetFocus("+id+")\n", DKERROR);
		return false; 
	}
	return element->Focus();
}

////////////////////////////////////////////
bool DKWidget::GetHoverElement(DKString& id)
{
	DKElement* hovered = dkRocket->document->GetContext()->GetHoverElement();
	if(!hovered){ return false; }
	id = hovered->GetId().CString();
	if(id.empty()){ return false; }
	return true;
}

//////////////////////////////////////////
bool DKWidget::Visible(DKElement* element)
{
	if(!element){return false;}
	return element->IsVisible();	
}

/////////////////////////////////////////
bool DKWidget::Toggle(DKElement* element)
{
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
bool DKWidget::Show(DKElement* element)
{
	if(!element){
		//DKLog("DKWidget::Show(): element not valid \n", DKWARN);
		return false;
	}
	if(!SetProperty(element, "display", "block")){ return false; }
	return true;
}

///////////////////////////////////////
bool DKWidget::Hide(DKElement* element)
{
	if(!element){
		//DKLog("DKWidget::Hide(): element not valid \n", DKWARN);
		return false;
	}
	if(!SetProperty(element, "display", "none")){ return false; }
	return true;
}

//////////////////////////////////////////////////////////////
bool DKWidget::GetParent(DKElement* element, DKString& parent)
{
	if(!element){return false;}
	DKElement* par = element->GetParentNode();
	if(!par){return false;}
	parent = GetId(par);
	return true;
}

/////////////////////////////////////////////////////////////////
bool DKWidget::AppendChild(DKElement* parent, DKElement* element)
{
	if(!parent){
		DKLog("DKWidget::AppendChild(): parent invalid\n", DKWARN);
		return false;
	}
	if(!element){
		DKLog("DKWidget::AppendChild(): element invalid\n", DKERROR);
		return false;
	}
	
	//remove the element from the previous owner first
	DKElement* par = element->GetParentNode();
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
bool DKWidget::PrependChild(DKElement* parent, DKElement* element)
{
	if(!parent){
		DKLog("PrependChild(): parent invalid\n", DKERROR);
		return false;
	}
	if(!element){
		DKLog("PrependChild(): element invalid\n", DKERROR);
		return false;
	}
	
	//remove the element from the previous owner first
	DKElement* ele = element;
	DKElement* par = element->GetParentNode();
	if(par){ par->RemoveChild(element); }

	DKElement* first_child = parent->GetFirstChild();
	if(first_child && !samei(first_child->GetTagName().CString(),"script")){
		parent->InsertBefore(ele, first_child);
		return true;
	}
	parent->AppendChild(ele);
	return true;
}

//////////////////////////////////////////////////////////////////
bool DKWidget::InsertBefore(DKElement* parent, DKElement* element)
{
	DKLog("DKWidget::InsertBefore("+GetId(parent)+","+GetId(element)+")\n", DKDEBUG);
	
	if(!parent){
		DKLog("InsertBefore(): parent invalid\n", DKERROR);
		return false;
	}
	if(!element){
		DKLog("InsertBefore(): element invalid\n", DKERROR);
		return false;
	}
	
	//Store store parent, it may get removed
	DKElement* par_store = parent->GetParentNode();
	
	//remove the element from the previous owner first
	DKElement* ele = element;
	DKElement* par = element->GetParentNode();
	if(par){ par->RemoveChild(element); }

	//get child
	parent = par_store->GetFirstChild();
	
	DKLog("DKWidget::InsertBefore(): "+GetId(parent)+"->InsertBefore("+GetId(ele)+","+GetId(parent)+")\n", DKDEBUG);
	//DKLog("par_store = "+GetId(par_store)+" \n", DKINFO);
	par_store->InsertBefore(ele, parent);
	return true;
}

/////////////////////////////////////////////////////////////////////////
bool DKWidget::AddEventListener(DKElement* element, const DKString& type)
{
	if(!element){return false;}
	bool capture_phase = false;

#ifdef DRAG_FIX
	if(same(type,"mousedown")){ capture_phase = true; }
#endif
	element->AddEventListener(type.c_str(), dkRocket, capture_phase);
	return true;
}

////////////////////////////////////////////////////////////////////////////
bool DKWidget::RemoveEventListener(DKElement* element, const DKString& type)
{
	if(!element){return false;}
	bool capture_phase = false;

#ifdef DRAG_FIX
	if(same(type,"mousedown")){ capture_phase = true; }
#endif
	element->RemoveEventListener(type.c_str(), dkRocket, capture_phase);
	return true;	
}

//////////////////////////////////////////////////////////////////////////////////////
bool DKWidget::GetAttribute(DKElement* element, const DKString& name, DKString& value)
{
	if(!element){return false;}
	if(!element->HasAttribute(name.c_str())){ return false; }
	DKCString temp;
	temp = element->GetAttribute(name.c_str())->Get<DKCString>();
	value = temp.CString();
	return true;
}

////////////////////////////////////////////////////////////////////////////////////////////
bool DKWidget::SetAttribute(DKElement* element, const DKString& name, const DKString& value)
{
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
	return true;
}

/////////////////////////////////////////////////////////////////////////////////////
bool DKWidget::GetProperty(DKElement* element, const DKString& name, DKString& value)
{
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
bool DKWidget::SetProperty(DKElement* element, const DKString& name, const DKString& value)
{
	DKLog("DKWidget::SetProperty("+name+","+value+")\n", DKDEBUG);
	if(!element){
		DKLog("DKWidget::SetProperty("+name+","+value+"): element invalid\n", DKWARN);
		return false;
	}
	if(name.empty()){
		DKLog("DKWidget::SetProperty(): name empty. \n", DKERROR); 
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
			//DKLog("DKWidget::SetProperty() background-color has rgba()\n", DKINFO);
			//DKLog(value+"\n", DKINFO);
			std::size_t start = value.find_last_of(",")+1;
			//DKLog("start:"+toString(start)+"\n", DKINFO);
			std::size_t end = value.find_last_of(")");
			//DKLog("end:"+toString(end)+"\n", DKINFO);
			int newvalue = (int)(toFloat(value.substr(start,end-start)) * 255);
			finalValue.replace(start,end-start,toString(newvalue));
			//DKLog(finalValue+"\n", DKINFO);
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
		DKLog("DKWidget::SetProperty(): Could not set property. \n", DKERROR);
		return false;
	}
	return true;
}

////////////////////////////////////////////////////////////////
bool DKWidget::GetInnerHtml(DKElement* element, DKString& value)
{
	if(!element){ return false; }
	value = element->GetInnerRML().CString();
	return true;
}

//////////////////////////////////////////////////////////////////////
bool DKWidget::GetInnerHtmlString(DKElement* element, DKString& value)
{
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
bool DKWidget::SetInnerHtml(DKElement* element, const DKString& value)
{
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
bool DKWidget::SetInnerHtmlString(DKElement* element, const DKString& value)
{
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
bool DKWidget::GetValue(DKElement* element, DKString& value)
{
	if(!element){
		DKLog("DKWidget::GetValue(): element invalid. \n", DKERROR);
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
bool DKWidget::SetValue(DKElement* element, const DKString& value)
{
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
bool DKWidget::GetValue(DKElement* element, int& value)
{
	if(!element){ return false; }
	DKString temp;
	if(!GetValue(element, temp)){ return false; }
	value = toInt(temp);
	return true;
}

/////////////////////////////////////////////////////////////
bool DKWidget::SetValue(DKElement* element, const int& value)
{
	if(!element){ return false; }
	DKElementFormControl* input = static_cast<DKElementFormControl*>(element);
	input->SetValue(toString(value).c_str());
	return true;
}

///////////////////////////////////////////////////////////////////
bool DKWidget::SetValue(DKElement* element, const DKProperty* prop)
{
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
bool DKWidget::ScrollToTop(DKElement* element)
{
	//DKLog("DKWidget::ScrollToTop(): not implemented\n",DKERROR);
	element->SetScrollTop(0);
	return true;
}

/////////////////////////////////////////////////
bool DKWidget::ScrollToBottom(DKElement* element)
{
	//DKLog("DKWidget::ScrollToBottom(): not implemented\n",DKERROR);
	DKElement* last_child = element->GetLastChild();
	if(!last_child){
		DKLog("DKWidget::ScrollToBottom(): last_child invalid \n", DKERROR);
		return false;
	}
	last_child->ScrollIntoView();
	return true;
}

//////////////////////////////////////////////////////////////////
bool DKWidget::GetClientWidth(DKElement* element, DKString& value)
{
	if(!element){
		DKLog("DKWidget::GetClientWidth(element,"+value+"): element invalid\n", DKWARN);
		return false;
	}
	float width = element->GetClientWidth();
	value = toString(width);
	return true;
}

///////////////////////////////////////////////////////////////////
bool DKWidget::GetClientHeight(DKElement* element, DKString& value)
{
	if(!element){
		DKLog("DKWidget::GetClientHeight(element,"+value+"): element invalid\n", DKWARN);
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
	if(id.empty()){
		DKLog("DKWidget::IsChildOf(): id empty \n", DKERROR);
		return false;
	}
	if(parent.empty()){
		DKLog("DKWidget::IsChildOf(): parent empty \n", DKERROR);
		return false;
	}
	if(!IsChildOf(GetElementById(id), GetElementById(parent))){ return false; }
	return true;
}

////////////////////////////////////////////////////////////////////
bool DKWidget::IsChildOf(DKElement* element, const DKString& parent)
{
	return IsChildOf(element, GetElementById(parent));
}

///////////////////////////////////////////////////////////////
bool DKWidget::IsChildOf(DKElement* element, DKElement* parent)
{
	if(!element){return false;}
	if(!parent){return false;}

	DKElement* ele = element;
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
	return DKWidget::GetMouseElementPosition(GetElementById(id), x_out, y_out);
}

//////////////////////////////////////////////////////////////////////////////////
bool DKWidget::GetMouseElementPosition(DKElement* element, int& x_out, int& y_out)
{
	if(!element){ return false; }

	int mouseX;
	int mouseY;
	GetMouseWindowX(mouseX);
	GetMouseWindowY(mouseY);

	int temp_x = 0;
	int temp_y = 0;
	
	DKElement* ele = element;
	DKElement* root = GetElementById("body");
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
	/*
	DKElement* temp = root->GetElementById(id.c_str());
	if(has(id,".html")){
		temp->GetParentNode()->RemoveChild(temp);
		root->GetOwnerDocument()->AppendChild(temp);
	}
	else{
		DKString panel;
		GetPanel(id, panel);
		temp->GetParentNode()->RemoveChild(temp);
		DKElement* the_panel = dkRocket->document->GetElementById(panel.c_str());
		the_panel->AppendChild(temp);//items in .html files need to stay within the .html file
	}
	*/
	return false;
}

/////////////////////////////////////////////////
DKString DKWidget::Filter(const DKProperty* prop)
{
	if(!prop){ return "";}
	DKString string = prop->ToString().CString();
	replace(string,".0000","");
	if(same(string,"0")){return "";}
	return string;
}

////////////////////////////////////////////
bool DKWidget::ValidateSize(DKString &value)
{
	if(!value.c_str()){
		DKLog("DKStyler::ValidateField() value invalid! \n", DKERROR);
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
	if(!value.c_str()){
		DKLog("DKStyler::ValidateField() value invalid! \n", DKERROR);
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
	if(!value.c_str()){
		DKLog("DKStyler::ValidateField() value invalid! \n", DKERROR);
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
			DKLog("DKWidget::GetElements("+id+"): element found with no ID \n", DKERROR);
			DKString tag = list[i]->GetTagName().CString();
			DKString innerHtml = list[i]->GetInnerRML().CString();
			DKString parent = list[i]->GetParentNode()->GetId().CString();
			DKLog("<" +tag+ ">" +innerHtml+ "</" +tag+ ">\n", DKERROR);
			DKLog("PARENT: "+parent+"\n", DKERROR);
			if(!file.empty()){
				DKLog("Last file loaded was "+file+"\n", DKERROR);

				//check to see next file
				unsigned int b = i+1;
				DKString next_file = file;
				while(same(next_file, file) && b<list.size()){
					if(!list[b]->GetId().Empty()){
						DKWidget::GetFile(list[b], next_file);
					}
					b++;
				}
				DKLog("Next file to load is "+next_file+"\n", DKERROR);
			}
		}
	}
	return true;
}

///////////////////////////////////////////////////////////////////////
bool DKWidget::GetElements(const DKString& id, DKElementList& elements)
{
	return GetElements(GetElementById(id), elements);
}

//////////////////////////////////////////////////////////////////////
bool DKWidget::GetElements(DKElement* parent, DKElementList& elements)
{
	if(!parent){ return false; }
	typedef std::queue<DKElement*> SearchQueue;
	SearchQueue search_queue;
	for (int i = 0; i < parent->GetNumChildren(); ++i)
		search_queue.push(parent->GetChild(i));

	while(!search_queue.empty()){
		DKElement* element = search_queue.front();
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
	DKElementList elements;
	GetElements(root, elements);
	for (unsigned int i = 0; i<elements.size(); ++i){

		//add handle to elements with a "drag"
		if (elements[i]->HasAttribute("drag")){
			AddDragHandle(elements[i]->GetId().CString(), elements[i]->GetAttribute("drag")->Get<DKCString>().CString());
		}

		//add handle to elements with a "resize"
		if (elements[i]->HasAttribute("resize")){
			DKElement* handle = CreateElement("handle");
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
	DKString handle;
	DKString first_child = GetFirstChild(id);
	if (!first_child.empty()){
		DKElement* element = DKWidget::GetElementById(first_child);
		if(!element){return false;}
		DKString tag = element->GetTagName().CString();
		if(same(tag, "handle")){ return false; }
		//DKLog("DKWidget::AddDragHandle(): CreateElementBefore("+GetFirstChild(id)+",handle, DKC-handle \n");
		handle = CreateElementBefore(GetFirstChild(id), "handle", "DKC-handle");
	}
	else{
		//DKLog("DKWidget::AddDragHandle(): CreateElement("+id+",handle, DKC-handle \n");
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
	DKElement* element = DKWidget::GetElementById(id);
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
	DKString handle;
	DKString first_child = GetFirstChild(id);
	if (!first_child.empty()){
		DKElement* element = DKWidget::GetElementById(first_child);
		if(!element){return false;}
		DKString tag = element->GetTagName().CString();
		if(same(tag, "handle")){ return false; }
		//DKLog("DKWidget::AddDragHandle(): CreateElementBefore("+GetFirstChild(id)+",handle, DKC-handle \n");
		handle = CreateElementBefore(GetFirstChild(id), "handle", "DKC-handle");
	}
	else{
		//DKLog("DKWidget::AddDragHandle(): CreateElement("+id+",handle, DKC-handle \n");
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
	DKElement* element = DKWidget::GetElementById(id);
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
	DKElement* element = DKWidget::GetElementById(id);
	if(!element){ return 0; }
	DKElement* child = element->GetFirstChild();
	if(!child){return "";}
	return DKWidget::GetId(child);
}

///////////////////////////////////////////////////
DKString DKWidget::GetLastChild(const DKString& id)
{
	DKElement* element = DKWidget::GetElementById(id);
	if(!element){ return 0; }
	DKElement* child = element->GetLastChild();
	if(!child){return "";}
	return DKWidget::GetId(child);
}

///////////////////////////////////////////////////
bool DKWidget::GetOption(const DKString& id, int n)
{
	DKElement* element = DKWidget::GetElementById(id);
	if(!same(element->GetTagName().CString(), "select")){
		DKLog("DKWidget::SelectOption("+id+"): not a select element. \n", DKINFO);
		return false;
	}

	Rocket::Controls::ElementFormControlSelect* ele = static_cast<Rocket::Controls::ElementFormControlSelect*>(element);
	n = ele->GetSelection();
	return true;
}

///////////////////////////////////////////////////
bool DKWidget::SetOption(const DKString& id, int n)
{
	DKElement* element = DKWidget::GetElementById(id);
	if(!same(element->GetTagName().CString(), "select")){
		DKLog("DKWidget::SelectOption("+id+"): not a select element. \n", DKINFO);
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
	//TODO: some properties, we only need to add a style if it's different from the elements parent 
	DKElement* element = GetElementById(id);
	DKElement* parent = element->GetParentNode();
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
	DKElement* element = GetElementById(id);
	if(element->HasAttribute("nosave_inner")){ return false; }
	DKElement* selectbox = element->GetChild(1);

	GetInnerHtml(selectbox, options);

	replace(options,"<option />","");
	if(!has(options,"<option>")){
		return false;	
	}
	return true;
}


#endif //USE_DKRocket