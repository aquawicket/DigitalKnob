/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#include "DK/stdafx.h"

//WARNING_DISABLE
#ifdef HAVE_rmlui_debugger
#	include <RmlUi/Debugger.h>
#endif
#include <RmlUi/Core/StreamMemory.h>
#include <Core/PluginRegistry.h>
#include <Core/XMLNodeHandlerDefault.h>
#include <Core/XMLNodeHandlerBody.h>
//WARNING_EABLE

#include "DKRml/DKRml.h"
#include "DKWindow/DKWindow.h"
#include "DKDuktape/DKDuktape.h"
#include "DKXml/DKXml.h"
#include "DKRml/DKRmlHeadInstancer.h"
#ifdef HAVE_DKCurl
#	include "DKCurl/DKCurl.h"
#endif

#define DRAG_FIX 1


DKRmlFile* DKRml::dkRmlFile = NULL;

bool DKRml::Init(){
	DKDEBUGFUNC();
	DKClass::DKCreate("DKRmlJS");
	DKClass::DKCreate("DKRmlV8");

	DKClass::DKCreate("DKRmlAudio");
	DKClass::DKCreate("DKRmlElement");
	DKClass::DKCreate("DKRmlIframe");
	DKClass::DKCreate("DKRmlTestElements");
	

	document = NULL;
	if(!dkRmlFile){ 
		dkRmlFile = new DKRmlFile();
		Rml::SetFileInterface(dkRmlFile);
	}

	//Create DKSDLRml or DKOSGRml
	if(DKClass::DKAvailable("DKSDLRml")){
		DKClass::DKCreate("DKSDLRml");
		if(!Rml::Initialise())
			return DKERROR("Rml::Initialise(): failed \n");
		int w;
		if(!DKWindow::GetWidth(w))
			return DKERROR("DKWindow::GetWidth() failed! \n");
		int h;
		if(!DKWindow::GetHeight(h))
			return DKERROR("DKWindow::GetHeight() failed! \n");
		context = Rml::CreateContext("default", Rml::Vector2i(w, h));
	}
	else if(DKClass::DKAvailable("DKOSGRml")){
		DKClass::DKCreate("DKOSGRml");
	}
	else{
		return DKERROR("No registered window found \n");
	}
#ifdef HAVE_rmlui_debugger
	if (!Rml::Debugger::Initialise(context))
		return DKERROR("Rml::Debugger::Initialise(): failed\n");
#endif
	//Add missing stylesheet properties
	//TODO - https://developer.mozilla.org/en-US/docs/Web/CSS/background-repeat
	/*Rml::PropertyId background_repeat =  unused code */ Rml::StyleSheetSpecification::RegisterProperty("background-repeat", "repeat", false)
		.AddParser("keyword", "repeat, space, round, no-repeat")
		.AddParser("string")
		.GetId(); //this supresses background-repeat warnings temporarily
	//TODO - https://developer.mozilla.org/en-US/docs/Web/CSS/border-style
	/* Rml::PropertyId border_style =  unused code */ Rml::StyleSheetSpecification::RegisterProperty("border-style", "none", false)
		.AddParser("keyword", "none, hidden")
		.AddParser("string")
		.GetId(); //this supresses border-style warnings temporarily

	context->SetDocumentsBaseTag("html");
	DKString rmlFonts = DKFile::local_assets+"DKRml";
	LoadFonts(rmlFonts);
	LoadFonts(DKFile::local_assets);
	DKEvents::AddRegisterEventFunc(&DKRml::RegisterEvent, this);
	//DKEvents::AddUnegisterEventFunc(&DKRml::UnregisterEvent, this);
	DKEvents::AddSendEventFunc(&DKRml::SendEvent, this);
	//DKClass::DKCreate("DKRmlJS");  //NOTE: already call above.   around line 23
	Rml::Factory::RegisterElementInstancer("html", new Rml::ElementInstancerGeneric<Rml::ElementDocument>);
	Rml::XMLParser::RegisterNodeHandler("html", std::make_shared<Rml::XMLNodeHandlerBody>());
	Rml::XMLParser::RegisterNodeHandler("head", std::make_shared<HeadInstancer>());
	Rml::Factory::RegisterElementInstancer("body", new Rml::ElementInstancerElement);
	Rml::XMLParser::RegisterNodeHandler("body", std::make_shared<Rml::XMLNodeHandlerDefault>());
	
	// Make sure custom_instancer is kept alive until after the call to Rml::Shutdown
	//auto custom_instancer = std::make_unique< Rml::ElementInstancerGeneric< CustomElement > >();
	//Rml::Factory::RegisterElementInstancer("custom", custom_instancer.get());

	DKString html;
	DKString workingPath = DKFile::local_assets;
	DKFile::FileToString(workingPath +"DKRml/blank.html", html);
	DKFile::ChDir(workingPath);
	LoadHtml(html);
	DKClass::DKCreate("DKDom");
	return true;
}

bool DKRml::End(){
	DKDEBUGFUNC();
	if(context){
		Rml::ReleaseTextures();
		Rml::Shutdown();
		delete Rml::GetRenderInterface();
		delete Rml::GetSystemInterface();
		delete Rml::GetFileInterface();
	}
	DKClass::DKClose("DKRmlJS");
	DKClass::DKClose("DKRmlV8");
	DKEvents::RemoveRegisterEventFunc(&DKRml::RegisterEvent, this);
	DKEvents::RemoveUnegisterEventFunc(&DKRml::UnregisterEvent, this);
	DKEvents::RemoveSendEventFunc(&DKRml::SendEvent, this);
	return true;
}

bool DKRml::GetSourceCode(DKString& source_code){
	DKDEBUGFUNC(source_code);
	source_code = document->GetContext()->GetRootElement()->GetInnerRML();
	DKINFO("######################## CODE FROM RmlUi #########################\n");
	DKINFO(source_code+"\n");
	DKINFO("##################################################################\n");
	
	// Actually, we only want the  last html node
	std::string::size_type n = source_code.rfind("<html");
	if(n < 0)
		return DKWARN("html tag not found\n");

	source_code = source_code.substr(n);
	replace(source_code, "<", "\n<"); //put all tags on a new line
	DKINFO("################## Last <html> node from RmlUi ##################\n");
	DKINFO(source_code+"\n");
	DKINFO("#################################################################\n");
	return true;
}

bool DKRml::LoadFont(const DKString& file){
	DKDEBUGFUNC(file);
	if(!Rml::LoadFontFace(file.c_str()))
		return DKERROR("Could not load "+file+"\n");
	return true;
}

bool DKRml::LoadFonts(DKString& directory){
	DKDEBUGFUNC(directory);
	
	char ch = directory.back();
	if(ch != '/')
		directory += '/'; //make sure directory has a trailing /

	DKStringArray files;
	DKFile::GetDirectoryContents(directory, files);
	for(unsigned int i=0; i<files.size(); ++i){
		if(DKFile::IsDirectory(directory+files[i]))
			continue;
		DKString extension;
		DKFile::GetExtention(files[i],extension);
		if(same(extension,".otf") || same(extension,".ttf")){
			//DKString file;
			//DKFile::GetFileName(files[i],file);
			LoadFont(directory+files[i]);
		}
	}
	return true;
}

bool DKRml::LoadHtml(const DKString& html){
	DKDEBUGFUNC(html);
	//// Prepair the html document for RmlUi

	DKString rml;
	dkRmlConverter.HtmlToRml(html, rml);

	//// Clear any document and load the rml into the document
	if (document){
		Rml::Factory::ClearStyleSheetCache();
		document->Close();
	}
	auto stream = std::make_unique<Rml::StreamMemory>((Rml::byte*)rml.c_str(), rml.size());
	stream->SetSourceURL("[document from memory]");
	Rml::PluginRegistry::NotifyDocumentOpen(context, stream->GetSourceURL().GetURL());
	document = context->CreateDocument("html");
	Rml::Element* ele = document;

	//Create DOM javascript instance of the document using the documents element address
	DKClass::DKCreate("DKDom");
	DKString rval;
	DKString document_address = elementToAddress(document);
	DKDuktape::RunDuktape("var document = new Document(\"" + document_address + "\");", rval);
	
	Rml::XMLParser parser(ele);
	parser.Parse(stream.get());
	//Make sure we have <head> and <body> tags
	Rml::ElementList heads;
	Rml::ElementList bodys;
	Rml::Element* head = NULL;
	Rml::Element* body = NULL;
	//Rml::ElementDocument* elementDocument = document->GetOwnerDocument(); unused code
	document->GetOwnerDocument()->GetElementsByTagName(heads, "head");
	if (!heads.empty())
		head = heads[0];
	document->GetOwnerDocument()->GetElementsByTagName(bodys, "body");
	if (!bodys.empty()) 
		body = bodys[0];
	if (!head && !body){
		document->GetOwnerDocument()->AppendChild(document->CreateElement("head"), true);
		document->GetOwnerDocument()->AppendChild(document->CreateElement("body"), true);
	}
	else if (head && !body)
		document->GetOwnerDocument()->AppendChild(document->CreateElement("body"), true);
	else if (!head && body)
		document->GetOwnerDocument()->InsertBefore(document->CreateElement("head"), body);
	//Load user agent style sheet
	DKString file = DKFile::local_assets + "DKRml/DKRml.css";
	const Rml::StyleSheetContainer* doc_sheet = document->GetOwnerDocument()->GetStyleSheetContainer();
	Rml::SharedPtr<Rml::StyleSheetContainer> file_sheet = Rml::Factory::InstanceStyleSheetFile(file.c_str());
	if(doc_sheet){ 
		//Combine the file_sheet and the doc_sheet into a new_sheet and load it back to the document
		Rml::SharedPtr<Rml::StyleSheetContainer> new_sheet = doc_sheet->CombineStyleSheetContainer(*file_sheet);
		document->GetOwnerDocument()->SetStyleSheetContainer(std::move(new_sheet));
	}
	else  //no current sheet, just load the file sheet
		document->GetOwnerDocument()->SetStyleSheetContainer(std::move(file_sheet));
	//Finish loading the document
	//Rml::ElementUtilities::BindEventAttributes(document);
	Rml::PluginRegistry::NotifyDocumentLoad(document);
	document->DispatchEvent(Rml::EventId::Load, Rml::Dictionary());
	document->UpdateDocument();
	if(!document){
		document = context->LoadDocumentFromMemory("");
		return DKERROR("document invalid\n");
	}
	Rml::ElementList elements;
	DKRml::Get()->document->GetElementsByTagName(elements, "body");
	if(!elements[0])
		return DKERROR("body element invalid\n");
	//dkRmlConverter.PostProcess(document);
	dkRmlConverter.PostProcess(elements[0]);
	document->Show();
#if ANDROID
	//We have to make sure the fonts are loaded on ANDROID
	LoadFonts(DKFile::local_assets);
#endif
	return true;
}

bool DKRml::LoadUrl(const DKString& url){
	DKDEBUGFUNC(url);
	DKString _url = url;
	if(has(_url,":/")) //could be http:// , https://, file:/// or C:/
		href = _url; //absolute path including protocol
	else if(has(_url,"//")){ //could be //www.site.com/style.css or //site.com/style.css
		return DKERROR("no protocol specified\n"); //absolute path without protocol
	}
	else
		_url = workingPath + _url;
	//Get the working path;
	std::string::size_type found = _url.find_last_of("/");
	workingPath = _url.substr(0, found + 1);
	DKINFO("DKRml::LoadUrl(): workingPath: " + workingPath + "\n");
	DKINFO("DKRml::LoadUrl(): href: " + href + "\n");
	//get the protocol
	std::string::size_type n = _url.find(":");
	protocol = _url.substr(0,n);
	DKINFO("DKRml::LoadUrl(): protocol: "+protocol+"\n");
	found = _url.rfind("/");
	_path = _url.substr(0,found+1);
	//DKWARN("DKRml::LoadUrl(): last / at "+toString(found)+"\n");
	DKINFO("DKRml::LoadUrl(): _path = "+_path+"\n");
	
	DKString html;
#ifdef HAVE_DKCurl
	if(has(_url, "http://") || has(_url, "https://")){
		DKClass::DKCreate("DKCurl");
		if(!DKCurl::Get()->HttpFileExists(_url))
			return DKERROR("Could not locate "+_url+"\n");
		if(!DKCurl::Get()->HttpToString(_url, html))
			return DKERROR("Could not get html from url "+_url+"\n");
	}
#endif
	if (!has(_url, "http://") && !has(_url, "https://")){
		if(!DKFile::FileToString(_url, html))
			return DKERROR("failed on "+_url+"\n");
	}
	LoadHtml(html);

	return true;
}

void DKRml::ProcessEvent(Rml::Event& rmlEvent){
	//DKDEBUGFUNC(rmlEvent);  //EXCESSIVE LOGGING
	DKString rmlEventAddress = eventToAddress(&rmlEvent);
	//DKString code = "new Event("+rmlEventAddress+")";
	//DKString rval;
	//DKDuktape::Get()->RunDuktape(code, rval);
	//DKINFO("DKRml::ProcessEvent(): "+code+": rval="+rval+"\n");
	if (!rmlEvent.GetCurrentElement())
		return;
	if (!rmlEvent.GetTargetElement())
		return;
	Rml::Element* currentElement = rmlEvent.GetCurrentElement();
	DKString currentElementAddress = elementToAddress(currentElement);
	Rml::Element* targetElement = rmlEvent.GetTargetElement();
	DKString targetElementAddress = elementToAddress(targetElement);
	DKString type = rmlEvent.GetType();
	//TODO: implement this
    //int phase = (int)rmlEvent.GetPhase(); //{ None, Capture = 1, Target = 2, Bubble = 4 };
    
    /*
	// Send this event back to duktape to be processed in javascript
	DKString evnt = "{type:'"+type+"', eventPhase:"+toString(phase)+"}";
	DKString code = "EventFromCPP('"+ currentElementAddress +"',"+evnt+");";
	DKString rval;
	DKDuktape::Get()->RunDuktape(code, rval);
	if(!rval.empty()){ DKINFO("DKRml::ProcessEvent(): rval = "+rval+"\n"); }
	*/
	// If the event bubbles up, ignore elements underneith 
	Rml::Context* context = document->GetContext();
	Rml::Element* hoverElement = NULL;
	if (context)
		hoverElement = context->GetHoverElement();
	Rml::Element* hoverParent = NULL;
	if (hoverElement)
		hoverParent = hoverElement->GetParentNode();
	if (hoverParent)
		hover = hoverParent;
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
#if ANDROID
	//Toggle Keyboard on text element click
	if (type == "mousedown"){
		if (same(currentElement->GetTagName(), "textarea") ||
			same(currentElement->GetTagName(), "input")){
			CallJavaFunction("toggleKeyboard", "");
			return;
		}
	}
	//Hide Keyboard on input Enter
	if (type == "keydown" && currentElement->GetTagName() == "input"){
		int key = rmlEvent.GetParameter<int>("key_identifier", 0);
		if (key == Rml::Input::KI_RETURN){ //Enter
			CallJavaFunction("toggleKeyboard", "");
			return;
		}
	}
#endif
	if (same(type, "mouseup") && rmlEvent.GetParameter<int>("button", 0) == 1) 
		type = "contextmenu";
	if (same(type, "change"))
		type = "input";

	//DKINFO("event type = " + type+"\n");
	for(unsigned int i = 0; i < DKEvents::events.size(); ++i){
		DKEvents* ev = DKEvents::events[i];
		
		//certain stored events are altered before comparison 
		DKString _type = ev->GetType();
		//if (same(_type, "input"))
		//	_type = "change";
		
		//// PROCESS ELEMENT EVENTS //////
		if (same(ev->GetId(), currentElementAddress) && same(_type, type)){
			ev->data.clear();
			ev->data.push_back(rmlEventAddress);
			//ev->rEvent = &rmlEvent;
			/*
			//pass the value
			if (same(type, "keydown") || same(type, "keyup")){
				ev->data.clear();
				ev->data.push_back(toString(rmlEvent.GetParameter<int>("key_identifier", 0)));
			}
			if (same(type, "mousedown") || same(type, "mouseup")){
				ev->data.clear();
				ev->data.push_back(toString(rmlEvent.GetParameter<int>("button", 0)));
			}
			*/
			//FIXME - we run the risk of having event function pointers that point to nowhere
			if (!ev->event_func(ev)){
				DKERROR("ev->event_func(ev): failed \n");
				return;
			}
		    //call the function linked to the event
			//DKINFO("Event: "+ev->type+", "+ev->id+"\n");
			//FIXME - StopPropagation() on a mousedown even will bock the elements ability to drag
			// we need to find a way to stop propagation of the event, while allowing drag events.
/*
#ifdef DRAG_FIX
			if (!same(type, "mousedown")){
#endif
				if (!same(type, "keydown")) 
					rmlEvent.StopPropagation();
#ifdef DRAG_FIX
			}
#endif
*/
			//ev->rEvent = NULL;
			return;
		}
	}
}

bool DKRml::RegisterEvent(const DKString& elementAddress, const DKString& type){
	//DKDEBUGFUNC(elementAddress, type);  //EXCESSIVE LOGGING
	if(elementAddress.empty())
		return DKERROR(elementAddress +": elementAddress empty\n"); 
	if(type.empty())
		return DKERROR("type empty\n");
	Rml::Element* element = addressToElement(elementAddress.c_str());
	if(!element)
		return DKERROR("element invalid\n");
	DKString _type = type;
	if(same(type, "contextmenu"))
		_type = "mouseup";
	if(same(type, "input"))
		_type = "change";
	//NOTE: This was an old libRocket issue and has not been tested for a long time
	//FIXME - StopPropagation() on a mousedown event will bock the elements ability to drag
	// we need to find a way to stop propagation of the event, while allowing drag events.
	// If we bubble our event upward and allow mousedown events to propagate, it works,
	// but it's a very nasty fix as every mousedown listener under the element will process
	// first and then finally process the element clicked, allowing drag.
	// WE don't want to process mousedown on other events! We want a one-shot mousedown event
	// processed for that element and stopped. And it must allow drag to bleed thru.
#ifdef DRAG_FIX
	if(same(type, "mousedown"))
		element->AddEventListener(_type.c_str(), this, true); //bubble up
	else{
#endif
		element->AddEventListener(_type.c_str(), this, false);
#ifdef DRAG_FIX
	}
#endif
	return true;
}

bool DKRml::SendEvent(const DKString& elementAddress, const DKString& type, const DKString& value){
	//DKDEBUGFUNC(id, type, value);  //EXCESSIVE LOGGING
	if(elementAddress.empty())
		return DKERROR("elementAddress invalid");
	if(type.empty())
		return DKERROR("type invalid");
	if(!document)
		return DKERROR("document invalid");
	Rml::Element* element;
	if (same("window", elementAddress)){
		element = DKRml::Get()->document->GetContext()->GetRootElement();
	}
	else if (same("sdlwindow", elementAddress)){
		element = DKRml::Get()->document->GetContext()->GetRootElement();
	}
	else {
		element = addressToElement(elementAddress);
	}
	if(!element)
		return DKERROR("element invalid\n");
	Rml::Dictionary parameters;
	parameters["value"] = value.c_str();
	element->DispatchEvent(type.c_str(), parameters, false);
	return true;
}

bool DKRml::DebuggerOff(){
#ifdef HAVE_rmlui_debugger
	Rml::Debugger::SetVisible(false);
	DKINFO("Rml Debugger OFF\n");
#else
	return DKERROR("RML Debugger not available \n");
#endif
	return true;
}

bool DKRml::DebuggerOn(){
#ifdef HAVE_rmlui_debugger
	Rml::Debugger::SetVisible(true);
	DKINFO("Rml Debugger ON\n");
#else
	return DKERROR("RML Debugger not available \n");
#endif
	return true;
}

bool DKRml::DebuggerToggle(){
	DKDEBUGFUNC();
#ifdef HAVE_rmlui_debugger
	if(Rml::Debugger::IsVisible()) //FIXME:  always returns false
		DKRml::DebuggerOff();
	else
		DKRml::DebuggerOn();
#else
	return DKERROR("RML Debugger not available \n");
#endif
	return true;
}

bool DKRml::UnregisterEvent(const DKString& elementAddress, const DKString& type){
	DKDEBUGFUNC(elementAddress, type);
	if(elementAddress.empty())
		return DKERROR("elementAddress invalid");
	if(type.empty())
		return DKERROR("type invalid");
	if (same(addressToElement(elementAddress)->GetId(), "window"))
		return DKERROR("can not Unregister window event");
	//if(!DKValid("DKRml0")){ return false; }
	Rml::Element* element = addressToElement(elementAddress);
	if(!element)
		return DKERROR("element invalid");
	DKString _type = type;
	if(same(type, "contextmenu"))
		_type = "mouseup";
	if(same(type, "input"))
		_type = "change";
	element->RemoveEventListener(_type.c_str(), this, false);
	return true;
}

Rml::Event* DKRml::addressToEvent(const DKString& address){
	//DKDEBUGFUNC(address);  //EXCESSIVE LOGGING
	Rml::Event* event;
	if (address.compare(0, 2, "0x") != 0 || address.size() <= 2 || address.find_first_not_of("0123456789abcdefABCDEF", 2) != std::string::npos){
		
		DKERROR(address+" is invalid hex notation\n");
		
		//print which oh the evaluators failed.
		if(address.compare(0, 2, "0x") != 0)
			DKERROR("address.compare(0, 2, \"0x\") != 0 \n");
		if(address.size() <= 2)
			DKERROR("(address.size() <= 2 \n");
		if(address.find_first_not_of("0x123456789abcdefABCDEF", 2) != std::string::npos)
			DKERROR("address.find_first_not_of(\"0x123456789abcdefABCDEF\", 2) != std::string::npos");

		return NULL;
	}
	//Convert a string of an address back into a pointer
	std::stringstream ss;
	ss << address.substr(2, address.size() - 2);
	//int tmp(0);
	std::uint64_t tmp;
	if (!(ss >> std::hex >> tmp)){
		DKERROR(address+": invalid address\n");
		return NULL;
	}
	event = reinterpret_cast<Rml::Event*>(tmp);
	if (!event->GetCurrentElement()){
		DKERROR(address+": currentElement invalid\n");
		return NULL;
	}
	return event;
}

DKString DKRml::eventToAddress(Rml::Event* event){
	//DKDEBUGFUNC(event);  //EXCESSIVE LOGGING
	if (!event){
		DKERROR("invalid event\n");
		return "";
	}
	const void* v_ptr = static_cast<const void*>(event);
	std::stringstream ss;
	ss << v_ptr;
	DKString address = ss.str();
	if(address.compare(0, 2, "0x") != 0){
		address.insert(0, "0x");
	}
	return address;
}

Rml::Element* DKRml::addressToElement(const DKString& address){
	//DKDEBUGFUNC(address);  //EXCESSIVE LOGGING
	
	//FIXME:  Error example (win_x86_64_mingw64_gcc)
	//		0x0x23aefc8: the address is not a valid hex notation
	//
	Rml::Element* element = nullptr;
	if (address.compare(0, 2, "0x") != 0 || address.size() <= 2 || address.find_first_not_of("0x123456789abcdefABCDEF", 2) != std::string::npos){
		
		DKERROR(address+": the address is not a valid hex notation\n");
		
		//print which oh the evaluators failed.
		if(address.compare(0, 2, "0x") != 0)
			DKERROR("address.compare(0, 2, \"0x\") != 0 \n");
		if(address.size() <= 2)
			DKERROR("(address.size() <= 2 \n");
		if(address.find_first_not_of("0x123456789abcdefABCDEF", 2) != std::string::npos)
			DKERROR("address.find_first_not_of(\"0x123456789abcdefABCDEF\", 2) != std::string::npos");
		return NULL;
	}
	//Convert a string of an address back into a pointer
	std::stringstream ss;
	ss << address.substr(2, address.size() - 2);
	std::uint64_t tmp;
	if (!(ss >> std::hex >> tmp)){
		DKERROR(address + ": invalid address\n");
		return NULL;
	}
	element = reinterpret_cast<Rml::Element*>(tmp);
	
	if (!element){
		DKERROR("invalid element\n");
		return NULL;
	}
	if (element->GetTagName().empty())
		return NULL;
	return element;
}

DKString DKRml::elementToAddress(Rml::Element* element){
	//DKDEBUGFUNC(element);  //EXCESSIVE LOGGING
	if (!element){
		DKERROR("invalid element\n");
		return "";
	}
	std::stringstream ss;
	const void* v_ptr = static_cast<const void*>(element);
	ss << v_ptr;
	DKString address = ss.str();
	if(address.compare(0, 2, "0x") != 0){
		address.insert(0, "0x");
	}

	if (same("0xDDDDDDDD", address)){
		DKERROR("ss = 0xDDDDDDDD\n");
		return "";
	}
	return address;
}

//TODO
bool DKRml::GetOuterHTML(Rml::Element* element, DKString& outerHtml){
	DKDEBUGFUNC(element, outerHtml);
	/*
	if (!element)
		return DKERROR("element invalid");
	Rml::Element* parent = element->GetParentNode();
	DKString htmlstring;
	parent->GetInnerRML(htmlstring);
	if (htmlstring.empty())
		return DKERROR("htmlstring is empty \n");
	DKXml xml;
	if (!xml.LoadDocumentFromString(htmlstring))
		return DKERROR("xml.LoadDocumentFromString() failed \n");
	xml.RemoveNodes("handle");
	DKString id = element->GetId();
	DKString style;
	BuildStyleString(id, style);
	xml.SetAttributes("//*[@id=\"" + id + "\"]", "style", style); //Update the style string
	style = "";

	DKStringArray ids;
	GetElements(id, ids);
	for (unsigned int i = 0; i < ids.size(); ++i){
		BuildStyleString(ids[i], style);
		xml.SetAttributes("//*[@id=\"" + ids[i] + "\"]", "style", style); //Update the style string
		style = "";
		//TODO - rebuild options string for <select> elements
	}

	if (!xml.GetFullNode("//*[@id=\"" + id + "\"]", outerHtml))
		return DKERROR("xml.GetFullNode() failed \n");
	return true;
	*/
	return DKERROR("not implemented\n");
}

//TODO
bool DKRml::SetOuterHTML(Rml::Element* element, const DKString& outerHtml){
	DKDEBUGFUNC(element, outerHtml);
	return DKERROR("not implemented\n");
}