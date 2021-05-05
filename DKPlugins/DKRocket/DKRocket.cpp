#include "DK/stdafx.h"
#include <Rocket/Debugger.h>
#include "DKRocket/DKRocket.h"
#include "DKWindow/DKWindow.h"
#include "DKCurl/DKCurl.h"
#include "DKDuktape/DKDuktape.h"
#include "DKXml/DKXml.h"

#include <Rocket/Core/StreamMemory.h>
#include "../../3rdParty/libRocket-master/Source/Core/PluginRegistry.h"

#define DRAG_FIX 1
DKRocketFile* DKRocket::dkRocketFile = NULL;

/////////////////////
bool DKRocket::Init()
{
	DKDEBUGFUNC();
	DKClass::DKCreate("DKRocketJS");
	DKClass::DKCreate("DKRocketV8");
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
		DKERROR("DKRocket::Init(): No registered window found\n");
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
			DKERROR("Rocket::Debugger::Initialise(): failed\n");
			return false;
		}
	}

	DKEvents::AddRegisterEventFunc(&DKRocket::RegisterEvent, this);
	DKEvents::AddUnegisterEventFunc(&DKRocket::UnregisterEvent, this);
	DKEvents::AddSendEventFunc(&DKRocket::SendEvent, this);

	//Load the javascript DOM
	DKClass::DKCreate("DKRocketLocation");
	DKClass::DKCreate("DKRocketNode");
	DKClass::DKCreate("DKRocketElement");
	DKClass::DKCreate("DKRocketHTMLElement");
	DKClass::DKCreate("DKRocketHTMLCollection");
	DKClass::DKCreate("DKRocketCSSStyleDeclaration");
	DKClass::DKCreate("DKRocketDocument");
	DKClass::DKCreate("DKRocket/DKRocketDom.js");

	DKString html;
	DKString workingPath = DKFile::local_assets;
	DKFile::FileToString(workingPath +"DKRocket/blank.html", html);
	DKFile::ChDir(workingPath);
	LoadHtml(html);

	return true;
}

////////////////////
bool DKRocket::End()
{
	DKDEBUGFUNC();
	DKEvents::RemoveRegisterEventFunc(&DKRocket::RegisterEvent, this);
	DKEvents::RemoveUnegisterEventFunc(&DKRocket::UnregisterEvent, this);
	DKEvents::RemoveSendEventFunc(&DKRocket::SendEvent, this);
	//if(document){ 
	//	Rocket::Core::Factory::ClearStyleSheetCache();
	//	document->Close(); 
	//}
	if(context){
		//context->RemoveReference();
		Rocket::Core::Shutdown();
	}
	return true;
}



/////////////////////////////////////////////
bool DKRocket::LoadFont(const DKString& file)
{
	DKDEBUGFUNC(file);
	if(!Rocket::Core::FontDatabase::LoadFontFace(file.c_str())){
		DKERROR("DKRocket::LoadFont(): Could not load "+file+"\n");
		return false;
	}
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

/////////////////////////////////////////////
bool DKRocket::LoadHtml(const DKString& html)
{
	//// Prepair the html document for rocket
	DKString rml = html;
	rml = "<rml id=\"rml\">\n" + rml + "</rml>";

	//dkRocketToRML.TidyFile(rml,rml);
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
		Rocket::Core::Factory::ClearStyleSheetCache();
		document->Close();
	}

	//document = context->LoadDocumentFromMemory(rml.c_str());
	auto stream = std::make_unique<Rocket::Core::StreamMemory>((Rocket::Core::byte*)rml.c_str(), rml.size());
	stream->SetSourceURL("[document from memory]");
	
	//document = context->LoadDocument(stream.get());
	Rocket::Core::PluginRegistry::NotifyDocumentOpen(context, stream->GetSourceURL().GetURL());
	Rocket::Core::Element* element = Rocket::Core::Factory::InstanceDocumentStream(context, stream.get());
	if (!element){ return false; }

	document = static_cast<Rocket::Core::ElementDocument*>(element);
	document->GetContext()->GetRootElement()->AppendChild(std::move(element));
	
	//Make sure we have <head> and <body> tags
	Rocket::Core::ElementList heads;
	Rocket::Core::ElementList bodys;
	Rocket::Core::Element* head = NULL;
	Rocket::Core::Element* body = NULL;
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
	DKString rml_css = DKFile::local_assets + "DKRocket/DKRocket.css";
	Rocket::Core::StyleSheet* sheet = document->GetOwnerDocument()->GetStyleSheet();
	Rocket::Core::StyleSheet* rcss = Rocket::Core::Factory::InstanceStyleSheetFile(rml_css.c_str());
	if(sheet) {
		Rocket::Core::StyleSheet* new_style_sheet = rcss->CombineStyleSheet(sheet);
		document->GetOwnerDocument()->SetStyleSheet(std::move(new_style_sheet));
	}
	else {
		document->GetOwnerDocument()->SetStyleSheet(std::move(rcss));
	}

	//Finish loading the document
	Rocket::Core::ElementUtilities::BindEventAttributes(document);
	Rocket::Core::PluginRegistry::NotifyDocumentLoad(document);
	//document->DispatchEvent(Rocket::Core::EventId::Load, Rocket::Core::Dictionary()); //FIXME
	//document->UpdateDocument(); //FIXME

	if(!document){
		document = context->LoadDocumentFromMemory("");
		DKERROR("DKRocket::LoadHtml(): document invalid\n");
		return false;
	}

	dkRocketToRML.PostProcess(document);
	document->Show();

#ifdef ANDROID
	//We have to make sure the fonts are loaded on ANDROID
	LoadFonts();
#endif

	DKString code = document->GetOwnerDocument()->GetContext()->GetRootElement()->GetInnerRML().CString();
	
	/*
	DKINFO("\n");
	DKINFO("################ CODE FROM Rocket ###############\n");
	DKINFO(code+"\n");
	DKINFO("#################################################\n");
	*/

	//find the last <html occurance
	int n = code.rfind("<html");
	if(n > 0){
		code = code.substr(n);
		replace(code, "<", "\n<");
	}
	
	/*
	DKINFO("\n");
	DKINFO("############## last <html> element CODE FROM Rocket #############\n");
	DKINFO(code+"\n");
	DKINFO("#################################################################\n");
	*/

	return true;
}

///////////////////////////////////////////
bool DKRocket::LoadUrl(const DKString& url)
{
	DKDEBUGFUNC(url);
	DKString _url = url;
	if(has(_url,":/")){ //could be http:// , https://, file:/// or C:/
		href = _url; //absolute path including protocol
	}
	else if(has(_url,"//")){ //could be //www.site.com/style.css or //site.com/style.css
		DKERROR("DKRocket::LoadUrl(): no protocol specified\n"); //absolute path without protocol
		return false;
	}
	else{
		_url = workingPath + _url;
		//DKERROR("DKRocket::LoadUrl(): cannot load relative paths\n");
		//return false;
	}

	//Get the working path;
	std::size_t found = _url.find_last_of("/");
	workingPath = _url.substr(0, found + 1);
	DKWARN("DKRocket::LoadUrl(): workingPath: " + workingPath + "\n");
	DKWARN("DKRocket::LoadUrl(): href: " + href + "\n");

	//get the protocol
	int n = _url.find(":");
	protocol = _url.substr(0,n);
	DKWARN("DKRocket::LoadUrl(): protocol: "+protocol+"\n");

	found = _url.rfind("/");
	_path = _url.substr(0,found+1);
	//DKWARN("DKRocket::LoadUrl(): last / at "+toString(found)+"\n");
	DKWARN("DKRocket::LoadUrl(): _path = "+_path+"\n");

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

//////////////////////////////////////////////////////////////////////////////////
bool DKRocket::RegisterEvent(const DKString& elementAddress, const DKString& type)
{
	DKDEBUGFUNC(elementAddress, type);
	if(elementAddress.empty()){ return false; } //no elementAddress
	if(type.empty()){ return false; } //no type
	
	Rocket::Core::Element* element = addressToElement(elementAddress.c_str());
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

/////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKRocket::SendEvent(const DKString& elementAddress, const DKString& type, const DKString& value)
{
	//DKDEBUGFUNC(id, type, value);
	if(elementAddress.empty()){ return false; }
	if(type.empty()){ return false; }
	if(!document){ return false; }
	//if(same(addressToElement(elementAddress)->GetId(),"window")){
		//DKWARN("DKRocket::SendEvent(): recieved global window event\n");
	//}
	
	Rocket::Core::Element* element = addressToElement(elementAddress);
	if(!element){ return false; }
	
	Rocket::Core::Dictionary parameters;
	//parameters.Set("msg0", value.c_str());
	element->DispatchEvent(type.c_str(), parameters, false);
	return true;
}

///////////////////////////////
bool DKRocket::ToggleDebugger()
{
	DKDEBUGFUNC();
	if(Rocket::Debugger::IsVisible()){ //FIXME:  always returns false
		Rocket::Debugger::SetVisible(false);
		DKINFO("Rocket Debugger OFF\n");
	}
	else{
		Rocket::Debugger::SetVisible(true);
		DKINFO("Rocket Debugger ON\n");
	}
	return true;
}

////////////////////////////////////////////////////////////////////////////////////
bool DKRocket::UnregisterEvent(const DKString& elementAddress, const DKString& type)
{
	DKDEBUGFUNC(elementAddress, type);
	if(elementAddress.empty()){ return false; } //no id
	if(type.empty()){ return false; } //no type
	if (same(addressToElement(elementAddress)->GetId().CString(), "window")) { return false; }
	//if(!DKValid("DKRocket0")){ return false; }

	Rocket::Core::Element* element = addressToElement(elementAddress);
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
	if(!event.GetCurrentElement()){return;} //MUST BE VALID!
	if(!event.GetTargetElement()){return;} //MUST BE VALID!

	Rocket::Core::Element* element = event.GetCurrentElement();
	DKString address = elementToAddress(element);

	DKString type = event.GetType().CString();
	int phase = event.GetPhase();

	DKString evnt = "{type:'"+type+"', eventPhase:"+toString(phase)+"}";

	/*
	//Send this event back to duktape to be processed in javascript
	DKString code = "EventFromCPP('"+address+"',"+ev nt+");";
	DKString rval;
	DKDuktape::Get()->RunDuktape(code, rval);
	if(!rval.empty()){
		DKWARN("DKRocket::ProcessEvent(): rval = "+rval+"\n");
	}
	//////////////////////////////////////////////////////////////////////
	*/

	//If the event bubbles up, ignore elements underneith 
	Rocket::Core::Context* ctx = document->GetContext();
	Rocket::Core::Element* ele = NULL;
	Rocket::Core::Element* _hover = NULL;
	if(ctx){ ele = ctx->GetHoverElement(); }
	if(ele){ _hover = ele->GetParentNode(); }
	if(_hover){ hover = _hover; }
	//if(event.GetPhase() == 1 && element != hover){ return; }

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

	for(unsigned int i = 0; i < DKEvents::events.size(); ++i){
		
		DKEvents* ev = DKEvents::events[i];
		//certain stored events are altered before comparison 
		DKString _type = ev->GetType();
		if(same(_type,"input")){ _type = "change"; }
		
		//// PROCESS ELEMENT EVENTS //////
		if(same(ev->GetId(), address) && same(_type, type)){ //.CString()
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
			if(!ev->event_func(ev)){
				DKERROR("DKRocket::ProcessEvent failed");
				return;
			} //call the function linked to the event
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

//////////////////////////////////////////////////////////////////////////
Rocket::Core::Element* DKRocket::addressToElement(const DKString& address)
{
	DKDEBUGFUNC(address);

	Rocket::Core::Element* element;
	if(address == "document"){
		element = document;
	}
	else{
		if(address.compare(0, 2, "0x") != 0 || address.size() <= 2 || address.find_first_not_of("0123456789abcdefABCDEF", 2) != std::string::npos){
			//DKERROR("NOTE: DKRocket::addressToElement(): the address is not a valid hex notation");
			return NULL;
		}

		//Convert a string of an address back into a pointer
		std::stringstream ss;
		ss << address.substr(2, address.size() - 2);
		int tmp(0);
		if(!(ss >> std::hex >> tmp)){
			DKERROR("DKRocket::addressToElement("+address+"): invalid address\n");
			return NULL;
		}
		element = reinterpret_cast<Rocket::Core::Element*>(tmp);
	}
	if(element->GetTagName().Empty()){ 
		return NULL; 
	}
	return element;
}

///////////////////////////////////////////////////////////////////
DKString DKRocket::elementToAddress(Rocket::Core::Element* element)
{
	if(!element){
		DKERROR("DKRocket::elementToAddress(): invalid element\n");
		return NULL;
	}
	std::stringstream ss;
	if(element == document){
		ss << "document";
	}
	else{
		const void* address = static_cast<const void*>(element);
		ss << "0x" << address;
	}
	return ss.str();
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
