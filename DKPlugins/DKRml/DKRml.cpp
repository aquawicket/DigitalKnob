#include "DK/stdafx.h"
#include <RmlUi/Debugger.h>
#include "DKRml/DKRml.h"
#include "DKWindow/DKWindow.h"
#include "DKCurl/DKCurl.h"
#include "DKDuktape/DKDuktape.h"
#include "DKXml/DKXml.h"

#include <RmlUi/Core/StreamMemory.h>
#include "C:/digitalknob/DK/3rdParty/RmlUi-master/Source/Core/PluginRegistry.h"

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

	DKEvent::AddRegisterEventFunc(&DKRml::RegisterEvent, this);
	DKEvent::AddUnegisterEventFunc(&DKRml::UnregisterEvent, this);
	DKEvent::AddSendEventFunc(&DKRml::SendEvent, this);

	//Load the javascript DOM
	DKClass::DKCreate("DKLocation");
	DKClass::DKCreate("DKNode");
	DKClass::DKCreate("DKElement");
	DKClass::DKCreate("DKHTMLElement");
	DKClass::DKCreate("DKCSSStyleDeclaration");
	DKClass::DKCreate("DKDocument");
	DKClass::DKCreate("DKRml/DKDom.js");

	DKString html;
	DKFile::FileToString(DKFile::local_assets+"DKRml/blank.html", html);
	DKFile::ChDir(DKFile::local_assets);
	LoadHtml(html);

	return true;
}

/////////////////
bool DKRml::End()
{
	DKDEBUGFUNC();
	DKEvent::RemoveRegisterEventFunc(&DKRml::RegisterEvent, this);
	DKEvent::RemoveUnegisterEventFunc(&DKRml::UnregisterEvent, this);
	DKEvent::RemoveSendEventFunc(&DKRml::SendEvent, this);
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

	DKINFO("\n");
	DKINFO("####### CODE GOING INTO ROCKET ##########\n");
	DKINFO(rml + "\n");
	DKINFO("#########################################\n");

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
	if (!element)
		return nullptr;
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
	document->SetStyleSheet(Rml::Core::Factory::InstanceStyleSheetFile(rml_css));

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

	DKString code = document->GetContext()->GetRootElement()->GetInnerRML();
	DKINFO("\n");
	DKINFO("################ CODE FROM RmlUi ################\n");
	DKINFO(code+"\n");
	DKINFO("#################################################\n");

	//find the last <body occurance
	int n = code.rfind("<html");
	code = code.substr(n);
	replace(code, "<", "\n<");
	DKINFO("\n");
	DKINFO("############## last <html> element CODE FROM RmlUi ##############\n");
	DKINFO(code+"\n");
	DKINFO("#################################################################\n");
	return true;
}

////////////////////////////////////////
bool DKRml::LoadUrl(const DKString& url)
{
	DKDEBUGFUNC(url);
	DKString _url = url;
	if(has(_url,":/")){ //could be http:// , https://, file:/// or C:/
		href = _url; //absolute path including protocol
		DKWARN("DKRml::LoadUrl(): href: "+href+"\n");
	}
	else if(has(_url,"//")){ //could be //www.site.com/style.css or //site.com/style.css
		DKERROR("DKRml::LoadUrl(): no protocol specified\n"); //absolute path without protocol
		return false;
	}
	else{
		//_url = DKFile::local_assets += _url;
		DKERROR("DKRml::LoadUrl(): cannot load relative paths\n");
		return false;
	}

	//get the protocol
	int n = _url.find(":");
	protocol = _url.substr(0,n);
	DKWARN("DKRml::LoadUrl(): protocol: "+protocol+"\n");

	int found = _url.rfind("/");
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

///////////////////////////////////////////////////////////////////
bool DKRml::RegisterEvent(const DKString& id, const DKString& type)
{
	DKDEBUGFUNC(id, type);
	if(id.empty()){ return false; } //no id
	if(type.empty()){ return false; } //no type
	
	Rml::Core::Element* element = getElementByAddress(id.c_str());
	//Rml::Core::Element* element = document->GetElementById(id.c_str());
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

///////////////////////
bool DKRml::Reload()
{
	DKDEBUGFUNC();
	return LoadUrl("index.html");
}

//////////////////////////////////////////////////////////////////////////////////////
bool DKRml::SendEvent(const DKString& id, const DKString& type, const DKString& value)
{
	//DKDEBUGFUNC(id, type, value);
	if(id.empty()){ return false; }
	if(type.empty()){ return false; }
	if(!document){ return false; }
	if(same(id,"window")){
		//DKWARN("DKRml::SendEvent(): recieved GLOBAL event\n");
	}
	
	Rml::Core::Element* element = document->GetElementById(id.c_str());
	if(!element){ return false; }
	
	Rml::Core::Dictionary parameters;
	//parameters.Set("msg0", value.c_str());
	element->DispatchEvent(type.c_str(), parameters, false);
	return true;
}

////////////////////////////
bool DKRml::ToggleDebugger()
{
	DKDEBUGFUNC();
	if(Rml::Debugger::IsVisible()){ //FIXME:  always returns false
		Rml::Debugger::SetVisible(false);
		DKINFO("Rml Debugger OFF\n");
	}
	else{
		Rml::Debugger::SetVisible(true);
		DKINFO("Rml Debugger ON\n");
	}
	return true;
}

/////////////////////////////////////////////////////////////////////
bool DKRml::UnregisterEvent(const DKString& id, const DKString& type)
{
	DKDEBUGFUNC(id, type);
	if(id.empty()){ return false; } //no id
	if(type.empty()){ return false; } //no type
	if(same(id,"window")){ return false; }
	//if(!DKValid("DKRml0")){ return false; }

	Rml::Core::Element* element = document->GetElementById(id.c_str());
	if(!element){ return false; } //no element

	DKString _type = type;
	if(same(type, "contextmenu")){ _type = "mouseup"; }
	if(same(type, "input")){ _type = "change"; 	}
	element->RemoveEventListener(_type.c_str(), this, false);
	return true;
}



/////////////////////////////////////////////////
void DKRml::ProcessEvent(Rml::Core::Event& event)
{
	//DKDEBUGFUNC(event);
	if(!event.GetCurrentElement()){return;} //MUST!
	if(!event.GetTargetElement()){return;} //MUST!

	Rml::Core::Element* element = event.GetCurrentElement();
	const void* address = static_cast<const void*>(element);
	std::stringstream ss;
	ss << address;  
	DKString str = ss.str();

	/*
	Rml::Core::Element* targ_element = event.GetCurrentElement();
	const void* address2 = static_cast<const void*>(targ_element);
	std::stringstream ss2;
	ss2 << address2;  
	DKString str2 = ss2.str();
	*/

	DKString type = event.GetType(); //.CString();
	Rml::Core::EventPhase phase = event.GetPhase();

	DKString evnt = "{type:'"+type+"', eventPhase:"+toString((int)phase)+"}";

	//Send this event back to duktape to be processed in javascript
	DKString code = "EventFromCPP('"+str+"',"+evnt+");";
	DKString rval;
	DKDuktape::Get()->RunDuktape(code, rval);
	if(!rval.empty()){
		DKWARN("DKRml::ProcessEvent(): rval = "+rval+"\n");
	}
	//////////////////////////////////////////////////////////////////////


	//If the event bubbles up, ignore elements underneith 
	Rml::Core::Context* ctx = document->GetContext();
	Rml::Core::Element* ele = NULL;
	Rml::Core::Element* _hover = NULL;
	if(ctx){ ele = ctx->GetHoverElement(); }
	if(ele){ _hover = ele->GetParentNode(); }
	if(_hover){ hover = _hover; }
	//if(event.GetPhase() == 1 && element != hover){ return; }

	/*
	//Event Monitor
	Rml::Core::Element* target = event.GetTargetElement();
	DKString tag = element->GetTagName().CString();
	DKString id = element->GetId().CString();
	DKString target_id = target->GetId().CString();
	DKString target_tag = target->GetTagName().CString();
	DKString hover_id = hover->GetId().CString();
	DKString string = "EVENT: " + type + " (current) " + tag + "> " + id + " (target) " + target_tag + "> " + target_id + "(hover)" +hover_id+"\n";
	DKINFO(string+"\n");
	*/

#ifdef ANDROID
	//Toggle Keyboard on text element click
	if(event.GetType() == "mousedown"){	
		if(same(event.GetCurrentElement()->GetTagName().CString(), "textarea") ||
			same(event.GetCurrentElement()->GetTagName().CString(), "input")){
			CallJavaFunction("toggleKeyboard", "");
			return;
		}
	}

	//Hide Keyboard on input Enter
	if(event.GetType() == "keydown" && event.GetCurrentElement()->GetTagName() == "input"){
		int key = event.GetParameter<int>("key_identifier", 0);
		if(key == Rml::Core::Input::KI_RETURN){ //Enter
			CallJavaFunction("toggleKeyboard", "");
			return;
		}	
	}
#endif

	//Rml::Core::Element* element = event.GetCurrentElement();
	//DKString id = element->GetId().CString();
	//DKString type = event.GetType().CString();

	if(same(type, "mouseup") && event.GetParameter<int>("button", 0) == 1){
		type = "contextmenu";
	}

	for(unsigned int i = 0; i < DKEvent::events.size(); ++i){
		
		DKEvent* ev = DKEvent::events[i];
		//certain stored events are altered before comparison 
		DKString _type = ev->GetType();
		if(same(_type,"input")){ _type = "change"; }
		
		//// PROCESS ELEMENT EVENTS //////
		if(same(ev->GetId(), element->GetId()) && same(_type, type)){ //.CString()
			//ev->rEvent = &event;

			//pass the value
			if(same(type,"keydown") || same(type,"keyup")){
				ev->data.clear();
				ev->data.push_back(toString(event.GetParameter<int>("key_identifier", 0)));
			}
			if(same(type,"mousedown") || same(type,"mouseup")){
				ev->data.clear();
				ev->data.push_back(toString(event.GetParameter<int>("button", 0)));
			}
			//FIXME - we run the risk of having event function pointers that point to nowhere
			ev->event_func(ev); //call the function linked to the event
			//DKINFO("Event: "+ev->type+", "+ev->id+"\n");

			//FIXME - StopPropagation() on a mousedown even will bock the elements ability to drag
			// we need to find a way to stop propagation of the event, while allowing drag events.
#ifdef DRAG_FIX
			if(!same(type,"mousedown")){
#endif
				if(!same(type,"keydown")){
					event.StopPropagation();
				}
#ifdef DRAG_FIX
			}
#endif
			//ev->rEvent = NULL;
			return;
		}
	}
}

///////////////////////////////////////////////////////////////////////
Rml::Core::Element* DKRml::getElementByAddress(const DKString& address)
{
	DKDEBUGFUNC(address);
	//Convert a string of an address back into a pointer
	std::stringstream ss;
	ss << address;
	int tmp(0);
	if(!(ss >> std::hex >> tmp)){
		DKERROR("DKRml::getElementByAddress("+address+"): invalid address\n");
		return NULL;
	}
	Rml::Core::Element* element = reinterpret_cast<Rml::Core::Element*>(tmp);
	return element;

	/*
	//get element from list of elements under body with mattching address
	Rml::Core::Element* body = DKRml::Get()->document->GetParentNode(); //TEST: This needs to be recursive
	Rml::Core::ElementList elements;
	GetElements(body, elements);
	for(unsigned int i=0; i<elements.size(); i++){
		const void* addr = static_cast<const void*>(elements[i]);
		std::stringstream ss;
		ss << addr;  
		DKString str = ss.str(); 
		if(same(address, str)){
			return elements[i];
		}
	}
	DKERROR("DKRmlJS::getElementByAddress("+address+"): element not found\n");
	return NULL;
	*/
}

/////////////////////////////////////////////////////////////////////////////////////
bool DKRml::GetElements(Rml::Core::Element* parent, Rml::Core::ElementList& elements)
{
	DKDEBUGFUNC(parent, "DKElementList&");
	if(!parent){ return false; }
	typedef std::queue<Rml::Core::Element*> SearchQueue;
	SearchQueue search_queue;

	elements.push_back(DKRml::Get()->document->GetFirstChild()->GetParentNode()); //add the body tag first
	for(int i = 0; i < parent->GetNumChildren(); ++i)
		search_queue.push(parent->GetChild(i));

	while(!search_queue.empty()){
		Rml::Core::Element* element = search_queue.front();
		search_queue.pop();

		if(!has(element->GetTagName(), "#")){ //.CString()
			elements.push_back(element);
		}

		// Add all children to search.
		for (int i = 0; i < element->GetNumChildren(); i++){
			search_queue.push(element->GetChild(i));
		}
	}
	return true;
}