#include "DK/stdafx.h"
#include <Rocket/Debugger/Debugger.h>
#include "DKRocket/DKRocket.h"
#include "DKWindow/DKWindow.h"
#include "DKCurl/DKCurl.h"
#include "DKDuktape/DKDuktape.h"
#include "DKXml/DKXml.h"

#define DRAG_FIX 1
DKRocketFile* DKRocket::dkRocketFile = NULL;

/////////////////////
bool DKRocket::Init()
{
	DKDEBUGFUNC();
	DKClass::DKCreate("DKRocketJS");
	DKClass::DKCreate("DKRocketV8");
	//dkRocketToRML = new DKRocketToRML();
	document = NULL;

	if(!dkRocketFile){ 
		dkRocketFile = new DKRocketFile();
		Rocket::Core::SetFileInterface(dkRocketFile);
	}

	//Create DKSDLRocket or DKOSGRocket
	if(DKClass::DKAvailable("DKSDLRocket")){
		DKClass::DKCreate("DKSDLRocket");
	}
	else if(DKClass::DKAvailable("DKOSGRocket")){
		DKClass::DKCreate("DKOSGRocket");
	}
	else{
		DKERROR("DKRocket::Init(): No registered rocket window found\n");
		return false;
	}
	
	if(DKClass::DKAvailable("DKSDLRocket")){
		if(!Rocket::Core::Initialise()){
			DKERROR("Rocket::Core::Initialise(): failed\n");
			return false;
		}

		int w;
		if(!DKWindow::GetWidth(w)){ return false; }
		int h;
		if(!DKWindow::GetHeight(h)){ return false; }
		context = Rocket::Core::CreateContext("default", Rocket::Core::Vector2i(w, h));

		Rocket::Controls::Initialise();
	}
	
	LoadFonts();
	
	if(DKClass::DKAvailable("DKSDLRocket")){
		if(!Rocket::Debugger::Initialise(context)){
			DKERROR("Rocket::Core::Initialise(): failed\n");
			return false;
		}
	}

	DKEvent::AddRegisterEventFunc(&DKRocket::RegisterEvent, this);
	DKEvent::AddUnegisterEventFunc(&DKRocket::UnregisterEvent, this);
	DKEvent::AddSendEventFunc(&DKRocket::SendEvent, this);
	return true;
}

////////////////////
bool DKRocket::End()
{
	DKDEBUGFUNC();
	DKEvent::RemoveRegisterEventFunc(&DKRocket::RegisterEvent, this);
	DKEvent::RemoveUnegisterEventFunc(&DKRocket::UnregisterEvent, this);
	DKEvent::RemoveSendEventFunc(&DKRocket::SendEvent, this);
	//if(document){ 
	//	Rocket::Core::Factory::ClearStyleSheetCache();
	//	document->Close(); 
	//}
	if(context){
		context->RemoveReference();
		Rocket::Core::Shutdown();
	}
	return true;
}



/////////////////////////////////////////////
bool DKRocket::LoadFont(const DKString& file)
{
	DKDEBUGFUNC(file);
	if(!Rocket::Core::FontDatabase::LoadFontFace(file.c_str())){
		DKERROR("Could not load "+file+"\n");
		return false;
	}
	//fonts_loaded = true;
	return true;
}

//////////////////////////
bool DKRocket::LoadFonts()
{
	DKDEBUGFUNC();
	DKStringArray dkfiles;
	DKFile::GetDirectoryContents(DKFile::local_assets+"DKRocket/", dkfiles);
	for(unsigned int i=0; i<dkfiles.size(); ++i){
		DKString extension;
		DKFile::GetExtention(dkfiles[i],extension);
		if(same(extension,".otf") || same(extension,".ttf")){
			DKString file;
			DKFile::GetFileName(dkfiles[i],file);
			LoadFont(DKFile::local_assets+"DKRocket/"+file);
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

////////////////////////////////////////////
bool DKRocket::LoadUrl(const DKString& url)
{
	DKDEBUGFUNC(url);
	DKString path = url;
	_url = path;
	int found = _url.find_last_of("/");
	_path = _url.substr(0,found+1);
	//DKWARN("DKRocket::LoadUrl(): last / at "+toString(found)+"\n");
	DKWARN("DKRocket::LoadUrl(): _path = "+_path+"\n");

	DKString html;

	if(has(path, "http://") || has(path, "https://")){
		DKClass::DKCreate("DKCurl");
		if(!DKCurl::Get()->HttpFileExists(path)){
			DKERROR("Could not locate "+path+"\n");
			return false;
		}
		if(!DKCurl::Get()->HttpToString(path, html)){
			DKERROR("Could not get html from url "+path+"\n");
			return false;
		}
	}
	else{
		if(!DKFile::VerifyPath(path)){
			DKERROR(path+" not found!\n");
			return false;
		}
		if(!DKFile::FileToString(path, html)){
			DKERROR("DKFile::FileToString failed on "+path+"\n");
			return false;
		}
	}

	//// Prepair the html document for rocket
	DKString rml;
	dkRocketToRML.IndexToRml(html, rml);

	DKINFO("####### CODE GOING INTO ROCKET ##########\n");
	DKINFO(rml+"\n");
	DKINFO("#########################################\n");

	//// Clear any document and load the rml into the document
	if(document){ 
		Rocket::Core::Factory::ClearStyleSheetCache();
		document->Close(); 
	}
	document = context->LoadDocumentFromMemory(rml.c_str());
	if(!document){
		document = context->LoadDocumentFromMemory("");
		DKERROR("Could not load "+path+"\n");
	}
	document->Show();
	document->RemoveReference();

	//Set up the dom
	DKClass::DKCreate("DKLocation");
	DKClass::DKCreate("DKNode");
	DKClass::DKCreate("DKElement");
	DKClass::DKCreate("DKHTMLElement");
	DKClass::DKCreate("DKCSSStyleDeclaration");
	DKClass::DKCreate("DKDocument");
	DKClass::DKCreate("DKRocket/DKDom.js");
	dkRocketToRML.PostProcess(document);

#ifdef ANDROID
	//We have to make sure the fonts are loaded on ANDROID
	LoadFonts();
#endif

	//DKString code = document->GetInnerRML().CString();
	DKString code = document->GetContext()->GetRootElement()->GetInnerRML().CString();
	
	//find the last <html occurance
	std::size_t n = code.rfind("<html");
	code = code.substr(n);

	replace(code, "<", "\n<");
	DKINFO("########## ROCKET RML CODE ##########\n");
	DKINFO(code+"\n");
	DKINFO("#####################################\n");
	return true;
}

//////////////////////////////////////////////////////////////////////
bool DKRocket::RegisterEvent(const DKString& id, const DKString& type)
{
	DKDEBUGFUNC(id, type);
	if(id.empty()){ return false; } //no id
	if(type.empty()){ return false; } //no type
	
	Rocket::Core::Element* element = document->GetElementById(id.c_str());
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
bool DKRocket::Reload()
{
	DKDEBUGFUNC();
	return LoadUrl("index.html");
}

/////////////////////////////////////////////////////////////////////////////////////////
bool DKRocket::SendEvent(const DKString& id, const DKString& type, const DKString& value)
{
	//DKDEBUGFUNC(id, type, value);
	if(id.empty()){ return false; }
	if(type.empty()){ return false; }
	if(!document){ return false; }
	if(same(id,"GLOBAL")){
		//DKWARN("DKRocket::SendEvent(): recieved GLOBAL event\n");
	}
	
	Rocket::Core::Element* element = document->GetElementById(id.c_str());
	if(!element){ return false; }
	
	Rocket::Core::Dictionary parameters;
	parameters.Set("msg0", value.c_str());
	element->DispatchEvent(type.c_str(), parameters, false);
	return true;
}

///////////////////////////////
bool DKRocket::ToggleDebugger()
{
	DKDEBUGFUNC();
	if(Rocket::Debugger::IsVisible()){
		Rocket::Debugger::SetVisible(false);
		DKINFO("Rocket Debugger OFF\n");
	}
	else{
		Rocket::Debugger::SetVisible(true);
		DKINFO("Rocket Debugger ON\n");
	}
	return true;
}

////////////////////////////////////////////////////////////////////////
bool DKRocket::UnregisterEvent(const DKString& id, const DKString& type)
{
	DKDEBUGFUNC(id, type);
	if(id.empty()){ return false; } //no id
	if(type.empty()){ return false; } //no type
	if(same(id,"GLOBAL")){ return false; }
	//if(!DKValid("DKRocket0")){ return false; }

	Rocket::Core::Element* element = document->GetElementById(id.c_str());
	if(!element){ return false; } //no element

	DKString _type = type;
	if(same(type, "contextmenu")){ _type = "mouseup"; }
	if(same(type, "input")){ _type = "change"; 	}
	element->RemoveEventListener(_type.c_str(), this, false);
	return true;
}



///////////////////////////////////////////////////////
void DKRocket::ProcessEvent(Rocket::Core::Event& event)
{
	//DKDEBUGFUNC(event);
	if(!event.GetCurrentElement()){return;} //MUST!
	if(!event.GetTargetElement()){return;} //MUST!

	Rocket::Core::Element* element = event.GetCurrentElement();
	const void* address = static_cast<const void*>(element);
	std::stringstream ss;
	ss << address;  
	DKString str = ss.str();

	/*
	Rocket::Core::Element* targ_element = event.GetCurrentElement();
	const void* address2 = static_cast<const void*>(targ_element);
	std::stringstream ss2;
	ss2 << address2;  
	DKString str2 = ss2.str();
	*/

	DKString type = event.GetType().CString();
	int phase = event.GetPhase();

	DKString evnt = "{type:'"+type+"', eventPhase:"+toString(phase)+"}";

	//Send this event back to duktape to be processed in javascript
	DKString code = "EventFromRocket('"+str+"',"+evnt+");";
	DKString rval;
	DKDuktape::Get()->RunDuktape(code, rval);
	if(!rval.empty()){
		DKWARN("DKRocket::ProcessEvent(): rval = "+rval+"\n");
	}
	//////////////////////////////////////////////////////////////////////


	//If the event bubbles up, ignore elements underneith 
	Rocket::Core::Context* ctx = document->GetContext();
	Rocket::Core::Element* ele = NULL;
	Rocket::Core::Element* _hover = NULL;
	if(ctx){ ele = ctx->GetHoverElement(); }
	if(ele){ _hover = ele->GetParentNode(); }
	if(_hover){ hover = _hover; }
	if(event.GetPhase() == 1 && element != hover){ return; }

	/*
	//Event Monitor
	Rocket::Core::Element* target = event.GetTargetElement();
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
		if(key == Rocket::Core::Input::KI_RETURN){ //Enter
			CallJavaFunction("toggleKeyboard", "");
			return;
		}	
	}
#endif

	//Rocket::Core::Element* element = event.GetCurrentElement();
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
		if(same(ev->GetId(), element->GetId().CString()) && same(_type, type)){
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

/////////////////////////////////////////////////////////////////////////////
Rocket::Core::Element* DKRocket::getElementByAddress(const DKString& address)
{
	DKDEBUGFUNC(address);
	//Convert a string of an address back into a pointer
	std::stringstream ss;
	ss << address;
	int tmp(0);
	if(!(ss >> std::hex >> tmp)){
		DKERROR("DKRocketJS::getElementByAddress("+address+"): invalide address\n");
		return NULL;
	}
	Rocket::Core::Element* element = reinterpret_cast<Rocket::Core::Element*>(tmp);
	return element;

	/*
	//get element from list of elements under body with mattching address
	Rocket::Core::Element* body = DKRocket::Get()->document->GetParentNode(); //TEST: This needs to be recursive
	Rocket::Core::ElementList elements;
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
	DKERROR("DKRocketJS::getElementByAddress("+address+"): element not found\n");
	return NULL;
	*/
}

//////////////////////////////////////////////////////////////////////////////////////////////
bool DKRocket::GetElements(Rocket::Core::Element* parent, Rocket::Core::ElementList& elements)
{
	DKDEBUGFUNC(parent, "DKElementList&");
	if(!parent){ return false; }
	typedef std::queue<Rocket::Core::Element*> SearchQueue;
	SearchQueue search_queue;

	elements.push_back(DKRocket::Get()->document->GetFirstChild()->GetParentNode()); //add the body tag first
	for(int i = 0; i < parent->GetNumChildren(); ++i)
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