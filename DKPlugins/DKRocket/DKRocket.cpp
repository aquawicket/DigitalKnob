#include "DK/stdafx.h"
#include <Rocket/Debugger/Debugger.h>
#include "DKRocket/DKRocket.h"
#include "DKRocket/DKRocketToRML.h"
#include "DKWindow/DKWindow.h"

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

	//LoadGui("index.html");
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
bool DKRocket::LoadGui(const DKString& file)
{
	DKDEBUGFUNC(file);
	DKString path = file;
	if(!DKFile::VerifyPath(path)){
		DKERROR("DKOSGRocket::LoadGui() "+path+" not found!\n");
		return false;
	}

	if(document){ 
		Rocket::Core::Factory::ClearStyleSheetCache();
		document->Close(); 
	}

	//// Prepair the html document for rocket
	DKString filename;
	DKFile::GetFileName(path,filename);
	DKString html;
	DKFile::FileToString(path, html);
	DKString rml;

	DKRocketToRML* dkRocketToRml = new DKRocketToRML();
	dkRocketToRml->IndexToRml(html, rml);

	// Finnish loading the document
	document = context->LoadDocumentFromMemory(rml.c_str());
	if(!document){
		document = context->LoadDocumentFromMemory("");
		DKERROR("Could not load "+path+"\n");
	}

	document->Show();
	document->RemoveReference();

	dkRocketToRml->PostProcess(document);

#ifdef ANDROID
	//We have to make sure the fonts are loaded on ANDROID
	LoadFonts();
#endif
	DKINFO("Loading GUI...\n");
	//DKCreate("DKLoading.js");
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
	return LoadGui("index.html");
}

/////////////////////////////////////////////////////////////////////////////////////////
bool DKRocket::SendEvent(const DKString& id, const DKString& type, const DKString& value)
{
	//DKDEBUGFUNC(id, type, value);
	if(id.empty()){ return false; }
	if(type.empty()){ return false; }
	if(!document){ return false; }
	
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
	DKString type = event.GetType().CString();

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