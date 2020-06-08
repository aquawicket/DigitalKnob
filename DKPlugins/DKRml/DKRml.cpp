#include "DK/stdafx.h"
#include <RmlUi/Debugger.h>
#include "DKRml/DKRml.h"
#include "DKWindow/DKWindow.h"
#include "DKCurl/DKCurl.h"
#include "DKDuktape/DKDuktape.h"
#include "DKXml/DKXml.h"

#include <RmlUi/Core/StreamMemory.h>
#include "../../3rdParty/RmlUi-master/Source/Core/PluginRegistry.h"

#define DRAG_FIX 1
DKRmlFile* DKRml::dkRmlFile = NULL;

//////////////////
bool DKRml::Init()
{
	DKDEBUGFUNC();
	DKClass::DKCreate("DKRmlJS");
	DKClass::DKCreate("DKRmlV8");
	document = NULL;

	if(!dkRmlFile){ 
		dkRmlFile = new DKRmlFile();
		Rml::Core::SetFileInterface(dkRmlFile);
	}

	//Create DKSDLRml or DKOSGRml
	if(DKClass::DKAvailable("DKSDLRml")){
		DKClass::DKCreate("DKSDLRml");
	}
	else if(DKClass::DKAvailable("DKOSGRml")){
		DKClass::DKCreate("DKOSGRml");
	}
	else{
		DKERROR("DKRml::Init(): No registered window found\n");
		return false;
	}
	
	if(DKClass::DKAvailable("DKSDLRml")){
		if(!Rml::Core::Initialise()){
			DKERROR("Rml::Core::Initialise(): failed\n");
			return false;
		}

		int w;
		if(!DKWindow::GetWidth(w)){ return false; }
		int h;
		if(!DKWindow::GetHeight(h)){ return false; }
		context = Rml::Core::CreateContext("default", Rml::Core::Vector2i(w, h));

		Rml::Controls::Initialise();
	}
	
	LoadFonts();
	
	if(DKClass::DKAvailable("DKSDLRml")){
		if(!Rml::Debugger::Initialise(context)){
			DKERROR("Rml::Debugger::Initialise(): failed\n");
			return false;
		}
	}

	DKEvents::AddRegisterEventFunc(&DKRml::RegisterEvent, this);
	DKEvents::AddUnegisterEventFunc(&DKRml::UnregisterEvent, this);
	DKEvents::AddSendEventFunc(&DKRml::SendEvent, this);
	
	DKClass::DKCreate("DKRmlJS");

	//* Load the javascript DOM
	
	//* Dom thats doesn't need a screen
	//DKClass::DKCreate("DKDomConsole");
	//DKClass::DKCreate("DKDomNavigator");
	//DKClass::DKCreate("DKDomEventTarget");
	//DKClass::DKCreate("DKDom/DKDomGlobalEventHandlers.js");
	//DKClass::DKCreate("DKDomXMLHttpRequest");
	//DKClass::DKCreate("DKDomScreen");
	//DKClass::DKCreate("DKDomWindow");
	
	//* Dom that needs a screen
	DKClass::DKCreate("DKDomWindow");
	DKClass::DKCreate("DKDomLocation");
	DKClass::DKCreate("DKDomNode");
	DKClass::DKCreate("DKDomElement");
	DKClass::DKCreate("DKDomHTMLElement");
	DKClass::DKCreate("DKDomHTMLCollection");
	DKClass::DKCreate("DKDomCSSStyleDeclaration");
	DKClass::DKCreate("DKDomDocument");
	DKClass::DKCreate("DKDomEvent");
	DKClass::DKCreate("DKDomUIEvent");
	DKClass::DKCreate("DKDomMouseEvent");

	DKString html;
	DKString workingPath = DKFile::local_assets;
	DKFile::FileToString(workingPath +"DKRml/blank.html", html);
	DKFile::ChDir(workingPath);
	LoadHtml(html);

	return true;
}

/////////////////
bool DKRml::End()
{
	DKDEBUGFUNC();
	DKEvents::RemoveRegisterEventFunc(&DKRml::RegisterEvent, this);
	DKEvents::RemoveUnegisterEventFunc(&DKRml::UnregisterEvent, this);
	DKEvents::RemoveSendEventFunc(&DKRml::SendEvent, this);
	//if(document){ 
	//	Rml::Core::Factory::ClearStyleSheetCache();
	//	document->Close(); 
	//}
	if(context){
		//context->RemoveReference();
		Rml::Core::Shutdown();
	}
	return true;
}



//////////////////////////////////////////
bool DKRml::LoadFont(const DKString& file)
{
	DKDEBUGFUNC(file);
	if(!Rml::Core::LoadFontFace(file.c_str())){
		DKERROR("DKRml::LoadFont(): Could not load "+file+"\n");
		return false;
	}
	return true;
}

///////////////////////
bool DKRml::LoadFonts()
{
	DKDEBUGFUNC();
	DKStringArray dkfiles;
	DKFile::GetDirectoryContents(DKFile::local_assets+"DKRml/", dkfiles);
	for(unsigned int i=0; i<dkfiles.size(); ++i){
		DKString extension;
		DKFile::GetExtention(dkfiles[i],extension);
		if(same(extension,".otf") || same(extension,".ttf")){
			DKString file;
			DKFile::GetFileName(dkfiles[i],file);
			LoadFont(DKFile::local_assets+"DKRml/"+file);
		}
	}

	DKStringArray files;
	DKFile::GetDirectoryContents(DKFile::local_assets, files);
	for(unsigned int i=0; i<files.size(); ++i){
		DKString extension;
		DKFile::GetExtention(files[i],extension);
		if(same(extension,".otf") || same(extension,".ttf")){
			DKString file;
			DKFile::GetFileName(files[i],file);
			LoadFont(file);
		}
	}
	return true;
}

//////////////////////////////////////////
bool DKRml::LoadHtml(const DKString& html)
{
	//// Prepair the html document for rocket
	DKString rml = html;
	rml = "<rml id=\"rml\">\n" + rml + "</rml>";

	//dkRmlToRML.TidyFile(rml,rml);
	replace(rml, "<!DOCTYPE html>", ""); //Rml doesn't like <!DOCTYPE html> tags
	replace(rml, "<meta name=\"generator\" content=", "");
	replace(rml, "\"HTML Tidy for HTML5 for Windows version 5.7.28\" />", "");

	/*
	DKINFO("\n");
	DKINFO("####### CODE GOING INTO ROCKET ##########\n");
	DKINFO(rml + "\n");
	DKINFO("#########################################\n");
	*/

	//// Clear any document and load the rml into the document
	if (document) {
		Rml::Core::Factory::ClearStyleSheetCache();
		document->Close();
	}

	//document = context->LoadDocumentFromMemory(rml.c_str());
	auto stream = std::make_unique<Rml::Core::StreamMemory>((Rml::Core::byte*)rml.c_str(), rml.size());
	stream->SetSourceURL("[document from memory]");
	
	//document = context->LoadDocument(stream.get());
	Rml::Core::PluginRegistry::NotifyDocumentOpen(context, stream->GetSourceURL().GetURL());
	Rml::Core::ElementPtr element = Rml::Core::Factory::InstanceDocumentStream(context, stream.get());
	if (!element){ return false; }

	document = static_cast<Rml::Core::ElementDocument*>(element.get());
	document->GetContext()->GetRootElement()->AppendChild(std::move(element));
	
	//Make sure we have <head> and <body> tags
	Rml::Core::ElementList heads;
	Rml::Core::ElementList bodys;
	Rml::Core::Element* head = NULL;
	Rml::Core::Element* body = NULL;
	document->GetOwnerDocument()->GetElementsByTagName(heads, "head");
	if (!heads.empty()) {
		head = heads[0];
	}
	document->GetOwnerDocument()->GetElementsByTagName(bodys, "body");
	if (!bodys.empty()) {
		body = bodys[0];
	}
	if (!head && !body) {
		document->GetOwnerDocument()->AppendChild(document->CreateElement("head"), true);
		document->GetOwnerDocument()->AppendChild(document->CreateElement("body"), true);
	}
	else if (head && !body) {
		document->GetOwnerDocument()->AppendChild(document->CreateElement("body"), true);
	}
	else if (!head && body) {
		document->GetOwnerDocument()->InsertBefore(document->CreateElement("head"), body);
	}

	//Load user agent style sheet
	DKString rml_css = DKFile::local_assets + "DKRml/DKRml.css";
	Rml::Core::SharedPtr<Rml::Core::StyleSheet> sheet = document->GetOwnerDocument()->GetStyleSheet();
	Rml::Core::SharedPtr<Rml::Core::StyleSheet> rcss = Rml::Core::Factory::InstanceStyleSheetFile(rml_css.c_str());
	if(sheet) {
		Rml::Core::SharedPtr<Rml::Core::StyleSheet> new_style_sheet = rcss->CombineStyleSheet(*sheet);
		document->GetOwnerDocument()->SetStyleSheet(std::move(new_style_sheet));
	}
	else {
		document->GetOwnerDocument()->SetStyleSheet(std::move(rcss));
	}

	//Finish loading the document
	Rml::Core::ElementUtilities::BindEventAttributes(document);
	Rml::Core::PluginRegistry::NotifyDocumentLoad(document);
	document->DispatchEvent(Rml::Core::EventId::Load, Rml::Core::Dictionary());
	document->UpdateDocument();

	if(!document){
		document = context->LoadDocumentFromMemory("");
		DKERROR("DKRml::LoadHtml(): document invalid\n");
		return false;
	}

	dkRmlToRML.PostProcess(document);
	document->Show();

#ifdef ANDROID
	//We have to make sure the fonts are loaded on ANDROID
	LoadFonts();
#endif

	DKString code = document->GetOwnerDocument()->GetContext()->GetRootElement()->GetInnerRML();
	
	/*
	DKINFO("\n");
	DKINFO("################ CODE FROM RmlUi ################\n");
	DKINFO(code+"\n");
	DKINFO("#################################################\n");
	*/

	//find the last <body occurance
	int n = code.rfind("<html");
	if(n < 0){
		DKERROR("DKRml::LoadHtml(): html tag not found\n");
		return true;
	}
	code = code.substr(n);
	replace(code, "<", "\n<");
	
	/*
	DKINFO("\n");
	DKINFO("############## last <html> element CODE FROM RmlUi ##############\n");
	DKINFO(code+"\n");
	DKINFO("#################################################################\n");
	*/

	return true;
}

////////////////////////////////////////
bool DKRml::LoadUrl(const DKString& url)
{
	DKDEBUGFUNC(url);
	DKString _url = url;
	if(has(_url,":/")){ //could be http:// , https://, file:/// or C:/
		href = _url; //absolute path including protocol
	}
	else if(has(_url,"//")){ //could be //www.site.com/style.css or //site.com/style.css
		DKERROR("DKRml::LoadUrl(): no protocol specified\n"); //absolute path without protocol
		return false;
	}
	else{
		_url = workingPath + _url;
		//DKERROR("DKRml::LoadUrl(): cannot load relative paths\n");
		//return false;
	}

	//Get the working path;
	std::size_t found = _url.find_last_of("/");
	workingPath = _url.substr(0, found + 1);
	DKWARN("DKRml::LoadUrl(): workingPath: " + workingPath + "\n");
	DKWARN("DKRml::LoadUrl(): href: " + href + "\n");

	//get the protocol
	int n = _url.find(":");
	protocol = _url.substr(0,n);
	DKWARN("DKRml::LoadUrl(): protocol: "+protocol+"\n");

	found = _url.rfind("/");
	_path = _url.substr(0,found+1);
	//DKWARN("DKRml::LoadUrl(): last / at "+toString(found)+"\n");
	DKWARN("DKRml::LoadUrl(): _path = "+_path+"\n");

	DKString html;

	if(has(_url, "http://") || has(_url, "https://")){
		DKClass::DKCreate("DKCurl");
		if(!DKCurl::Get()->HttpFileExists(_url)){
			DKERROR("Could not locate "+_url+"\n");
			return false;
		}
		if(!DKCurl::Get()->HttpToString(_url, html)){
			DKERROR("Could not get html from url "+_url+"\n");
			return false;
		}
	}
	else{
		//if(!DKFile::VerifyPath(href)){
		//	DKERROR(href+" not found!\n");
		//	return false;
		//}
		if(!DKFile::FileToString(_url, html)){
			DKERROR("DKFile::FileToString failed on "+_url+"\n");
			return false;
		}
	}

	LoadHtml(html);
	return true;
}

////////////////////////////////////////////////////
void DKRml::ProcessEvent(Rml::Core::Event& rmlEvent)
{
	//TODO - make rmlEvent accessable through javascript
	//1. Create Javascript Event object that references the rmlEvent
	DKString rmlEventAddress = eventToAddress(&rmlEvent);
	//DKString code = "new Event("+rmlEventAddress+")";
	//DKString rval;
	//DKDuktape::Get()->RunDuktape(code, rval);
	//DKINFO("DKRml::ProcessEvent(): "+code+": rval="+rval+"\n");

	//DKDEBUGFUNC(event);
	if (!rmlEvent.GetCurrentElement()) { return; } //MUST BE VALID!
	if (!rmlEvent.GetTargetElement()) { return; } //MUST BE VALID!

	Rml::Core::Element* currentElement = rmlEvent.GetCurrentElement();
	DKString currentElementAddress = elementToAddress(currentElement);

	Rml::Core::Element* targetElement = rmlEvent.GetTargetElement();
	DKString targetElementAddress = elementToAddress(targetElement);

	DKString type = rmlEvent.GetType();
	int phase = (int)rmlEvent.GetPhase(); //{ None, Capture = 1, Target = 2, Bubble = 4 };

	/*
	// Send this event back to duktape to be processed in javascript
	DKString evnt = "{type:'"+type+"', eventPhase:"+toString(phase)+"}";
	DKString code = "EventFromCPP('"+ currentElementAddress +"',"+evnt+");";
	DKString rval;
	DKDuktape::Get()->RunDuktape(code, rval);
	if(!rval.empty()){ DKINFO("DKRml::ProcessEvent(): rval = "+rval+"\n"); }
	*/

	// If the event bubbles up, ignore elements underneith 
	Rml::Core::Context* context = document->GetContext();
	Rml::Core::Element* hoverElement = NULL;
	if (context) { hoverElement = context->GetHoverElement(); }
	Rml::Core::Element* hoverParent = NULL;
	if (hoverElement) { hoverParent = hoverElement->GetParentNode(); }
	if (hoverParent) { hover = hoverParent; }
	//if(rmlEvent.GetPhase() == 1 && currentElement != hover){ return; }

	/*
	//Event Monitor
	DKString tag = currentElement->GetTagName();
	DKString id = currentElement->GetId();
	DKString target_id = targetElement->GetId();
	DKString target_tag = targetElement->GetTagName();
	DKString hover_id = hover->GetId();
	DKString string = "EVENT: " + type + " (current) " + tag + "> " + id + " (target) " + target_tag + "> " + target_id + "(hover)" + hover_id + "\n";
	DKINFO(string + "\n");
	*/

#ifdef ANDROID
	//Toggle Keyboard on text element click
	if (type == "mousedown") {
		if (same(currentElement->GetTagName(), "textarea") ||
			same(currentElement->GetTagName(), "input")) {
			CallJavaFunction("toggleKeyboard", "");
			return;
		}
	}

	//Hide Keyboard on input Enter
	if (type == "keydown" && currentElement->GetTagName() == "input") {
		int key = rmlEvent.GetParameter<int>("key_identifier", 0);
		if (key == Rml::Core::Input::KI_RETURN) { //Enter
			CallJavaFunction("toggleKeyboard", "");
			return;
		}
	}
#endif

	if (same(type, "mouseup") && rmlEvent.GetParameter<int>("button", 0) == 1) {
		type = "contextmenu";
	}

	for(unsigned int i = 0; i < DKEvents::events.size(); ++i){
		DKEvents* ev = DKEvents::events[i];
		//certain stored events are altered before comparison 
		DKString _type = ev->GetType();
		if (same(_type, "input")) { _type = "change"; }

		//// PROCESS ELEMENT EVENTS //////
		if (same(ev->GetId(), currentElementAddress) && same(_type, type)) {
			ev->data.clear();
			ev->data.push_back(rmlEventAddress);
			//ev->rEvent = &rmlEvent;

			/*
			//pass the value
			if (same(type, "keydown") || same(type, "keyup")) {
				ev->data.clear();
				ev->data.push_back(toString(rmlEvent.GetParameter<int>("key_identifier", 0)));
			}
			if (same(type, "mousedown") || same(type, "mouseup")) {
				ev->data.clear();
				ev->data.push_back(toString(rmlEvent.GetParameter<int>("button", 0)));
			}
			*/
			//FIXME - we run the risk of having event function pointers that point to nowhere
			if (!ev->event_func(ev)) {
				DKERROR("DKRml::ProcessEvent failed");
				return;
			} //call the function linked to the event
			//DKINFO("Event: "+ev->type+", "+ev->id+"\n");

			//FIXME - StopPropagation() on a mousedown even will bock the elements ability to drag
			// we need to find a way to stop propagation of the event, while allowing drag events.
#ifdef DRAG_FIX
			if (!same(type, "mousedown")) {
#endif
				if (!same(type, "keydown")) {
					rmlEvent.StopPropagation();
				}
#ifdef DRAG_FIX
			}
#endif
			//ev->rEvent = NULL;
			return;
		}
	}
}

///////////////////////////////////////////////////////////////////////////////
bool DKRml::RegisterEvent(const DKString& elementAddress, const DKString& type)
{
	DKDEBUGFUNC(elementAddress, type);
	if(elementAddress.empty()){ return false; } //no elementAddress
	if(type.empty()){ return false; } //no type
	
	Rml::Core::Element* element = addressToElement(elementAddress.c_str());
	if(!element){ return false; } //no element

	DKString _type = type;
	if(same(type, "contextmenu")){ _type = "mouseup"; }
	if(same(type, "input")){ _type = "change"; 	}
		
	//FIXME - StopPropagation() on a mousedown event will bock the elements ability to drag
	// we need to find a way to stop propagation of the event, while allowing drag events.
	// If we bubble our event upward and allow mousedown events to propagate, it works,
	// but it's a very nasty fix as every mousedown listener under the element will process
	// first and then finally process the element clicked, allowing drag.
	// WE don't want to process mousedown on other events! We want a one-shot mousedown event
	// processed for that element and stopped. And it must allow drag to bleed thru.

#ifdef DRAG_FIX
	if(same(type, "mousedown")){
		element->AddEventListener(_type.c_str(), this, true); //bubble up
	}
	else{
#endif
		element->AddEventListener(_type.c_str(), this, false);
#ifdef DRAG_FIX
	}
#endif
	return true;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
bool DKRml::SendEvent(const DKString& elementAddress, const DKString& type, const DKString& value)
{
	//DKDEBUGFUNC(id, type, value);
	if(elementAddress.empty()){ return false; }
	if(type.empty()){ return false; }
	if(!document){ return false; }
	//if(same(addressToElement(elementAddress)->GetId(),"window")){
		//DKWARN("DKRml::SendEvent(): recieved global window event\n");
	//}
	
	Rml::Core::Element* element = addressToElement(elementAddress);
	if(!element){ return false; }
	
	Rml::Core::Dictionary parameters;
	//parameters.Set("msg0", value.c_str());
	element->DispatchEvent(type.c_str(), parameters, false);
	return true;
}

/////////////////////////
bool DKRml::DebuggerOff()
{
	Rml::Debugger::SetVisible(false);
	DKINFO("Rml Debugger OFF\n");
	return true;
}

////////////////////////
bool DKRml::DebuggerOn()
{
	Rml::Debugger::SetVisible(true);
	DKINFO("Rml Debugger ON\n");
	return true;
}

////////////////////////////
bool DKRml::DebuggerToggle()
{
	DKDEBUGFUNC();
	if(Rml::Debugger::IsVisible()){ //FIXME:  always returns false
		DKRml::DebuggerOff();
	}
	else{
		DKRml::DebuggerOn();
	}
	return true;
}

/////////////////////////////////////////////////////////////////////////////////
bool DKRml::UnregisterEvent(const DKString& elementAddress, const DKString& type)
{
	DKDEBUGFUNC(elementAddress, type);
	if(elementAddress.empty()){ return false; } //no id
	if(type.empty()){ return false; } //no type
	if (same(addressToElement(elementAddress)->GetId(), "window")) { return false; }
	//if(!DKValid("DKRml0")){ return false; }

	Rml::Core::Element* element = addressToElement(elementAddress);
	if(!element){ return false; } //no element

	DKString _type = type;
	if(same(type, "contextmenu")){ _type = "mouseup"; }
	if(same(type, "input")){ _type = "change"; 	}
	element->RemoveEventListener(_type.c_str(), this, false);
	return true;
}

////////////////////////////////////////////////////////////////
Rml::Core::Event* DKRml::addressToEvent(const DKString& address)
{
	DKDEBUGFUNC(address);

	Rml::Core::Event* event;
	if (address.compare(0, 2, "0x") != 0 || address.size() <= 2 || address.find_first_not_of("0123456789abcdefABCDEF", 2) != std::string::npos) {
		DKERROR("NOTE: DKRml::addressToEvent(): the address is not a valid hex notation");
		return NULL;
	}

	//Convert a string of an address back into a pointer
	std::stringstream ss;
	ss << address.substr(2, address.size() - 2);
	int tmp(0);
	if (!(ss >> std::hex >> tmp)) {
		DKERROR("DKRml::addressToEvent(" + address + "): invalid address\n");
		return NULL;
	}
	event = reinterpret_cast<Rml::Core::Event*>(tmp);
	if (!event->GetCurrentElement()) {
		DKERROR("DKRml::addressToEvent(" + address + "): currentElement invalid\n");
		return NULL;
	}
	return event;
}

///////////////////////////////////////////////////////
DKString DKRml::eventToAddress(Rml::Core::Event* event)
{
	if (!event) {
		DKERROR("DKRml::eventToAddress(): invalid event\n");
		return NULL;
	}
	std::stringstream ss;

	const void* address = static_cast<const void*>(event);
#ifdef WIN32
	ss << "0x" << address;
#else 
	ss << address;
#endif
	return ss.str();
}

////////////////////////////////////////////////////////////////////
Rml::Core::Element* DKRml::addressToElement(const DKString& address)
{
	DKDEBUGFUNC(address);

	Rml::Core::Element* element;
	if (address == "document") {
		element = DKRml::Get()->document;
	}
	else {
		if (address.compare(0, 2, "0x") != 0 || address.size() <= 2 || address.find_first_not_of("0123456789abcdefABCDEF", 2) != std::string::npos) {
			//DKERROR("NOTE: DKRml::addressToElement(): the address is not a valid hex notation");
			return NULL;
		}

		//Convert a string of an address back into a pointer
		std::stringstream ss;
		ss << address.substr(2, address.size() - 2);
		int tmp(0);
		if (!(ss >> std::hex >> tmp)) {
			DKERROR("DKRml::addressToElement(" + address + "): invalid address\n");
			return NULL;
		}
		element = reinterpret_cast<Rml::Core::Element*>(tmp);
	}
	if (element->GetTagName().empty()) {
		return NULL;
	}
	return element;
}

/////////////////////////////////////////////////////////////
DKString DKRml::elementToAddress(Rml::Core::Element* element)
{
	if (!element) {
		DKERROR("DKRml::elementToAddress(): invalid element\n");
		return NULL;
	}
	std::stringstream ss;
	if (element == DKRml::Get()->document) {
		ss << "document";
	}
	else {
		const void* address = static_cast<const void*>(element);
#ifdef WIN32
		ss << "0x" << address;
#else 
		ss << address;
#endif
	}
	return ss.str();
}