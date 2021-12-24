#include "DK/stdafx.h"
//#include "SFML.h"
#include "DK/DKFile.h"
#include "DKAssets/DKAssets.h"
#include "DKSFMLRml/DKSFMLRml.h"

bool DKSFMLRml::Init(){
	DKDEBUGFUNC();
	//Android SFML_TEXTINPUT events not working
	//SFML_StartTextInput(); 
	//SFML_EventState(SFML_TEXTINPUT, SFML_ENABLE);
	dkSFMLWindow = DKSFMLWindow::Instance("DKSFMLWindow0");
	dkRml = DKRml::Instance("DKRml0");
	if(!dkSFMLWindow || !dkRml)
		return DKERROR("DKSFMLRml::Init(): INVALID OBJECTS\n");
#ifdef RML_SHELL_RENDER
	Renderer = new ShellRenderInterfaceOpenGL();
#else
	Renderer = new RmlSFML2Renderer(dkSFMLWindow->renderer, dkSFMLWindow->window);
#endif
	SystemInterface = new RmlSFML2SystemInterface();
	Rml::SetRenderInterface(Renderer);
    Rml::SetSystemInterface(SystemInterface);
	DKSFMLWindow::AddEventFunc(&DKSFMLRml::Handle, this);
	DKSFMLWindow::AddRenderFunc(&DKSFMLRml::Render, this);
	DKSFMLWindow::AddUpdateFunc(&DKSFMLRml::Update, this);
	return true;
}

bool DKSFMLRml::End(){
	DKDEBUGFUNC();
	return true;
}

bool DKSFMLRml::Handle(SFML_Event *event) {
	//DKDEBUGFUNC(event);
	if(!dkRml->document)
		return DKERROR("dkRml->document invalid");
	Rml::Element* hover;
	switch(event->type){
		case SFML_MOUSEMOTION:
			dkRml->context->ProcessMouseMove(event->motion.x, event->motion.y, SystemInterface->GetKeyModifiers());
			//if we clicked an element, end the event.
			hover = dkRml->context->GetHoverElement();
			if(hover && (!has(hover->GetId(), "iframe_")))
				return true;
            break;   
		case SFML_MOUSEBUTTONDOWN:
            dkRml->context->ProcessMouseButtonDown(SystemInterface->TranslateMouseButton(event->button.button), SystemInterface->GetKeyModifiers());
            //if we clicked an element, end the event.
			hover = dkRml->context->GetHoverElement();
			if(hover && (!has(hover->GetId(), "iframe_")))
				return true;
			break;
        case SFML_MOUSEBUTTONUP:
            dkRml->context->ProcessMouseButtonUp(SystemInterface->TranslateMouseButton(event->button.button), SystemInterface->GetKeyModifiers());
			//if we clicked an element, end the event.
			hover = dkRml->context->GetHoverElement();
			if(hover && (!has(hover->GetId(), "iframe_"))){
				//return true;
			}
			break;
        case SFML_MOUSEWHEEL:
            dkRml->context->ProcessMouseWheel(event->wheel.y * -1, SystemInterface->GetKeyModifiers());
            break;
#ifdef ANDROID
        case SFML_KEYDOWN:
			//DKINFO("DKSFMLRml::SFML_KEYDOWN("+toString((int)event->key.keysym.sym)+")\n");
			dkRml->context->ProcessKeyDown(SystemInterface->TranslateKey(event->key.keysym.sym), SystemInterface->GetKeyModifiers());
			if(event->key.keysym.sym == 13) //enter
				dkRml->context->ProcessTextInput("\n");
            break;
#else
		case SFML_KEYDOWN:{
			//DKINFO("DKSFMLWindow::SFML_KEYDOWN("+toString(event->key.keysym.sym)+")\n");
			/*
			if(event->key.keysym.sym == 0){ return true; }
			if(event->key.keysym.sym > 96 && event->key.keysym.sym < 123){ //letter
				if(event->key.keysym.mod & KMOD_SHIFT && event->key.keysym.mod & KMOD_CAPS){ //both = lowercase
					//DKEvent::SendEvent("window", "keypress", toString(DKSFMLWindow::SFMLCharCode[event->key.keysym.sym]));
					dkRml->context->ProcessTextInput(DKSFMLWindow::SFMLCharCode[event->key.keysym.sym]);
				}
				else if(event->key.keysym.mod & KMOD_SHIFT || event->key.keysym.mod & KMOD_CAPS){ //1 = uppercase
					//DKEvent::SendEvent("window", "keypress", toString(DKSFMLWindow::SFMLShiftCharCode[event->key.keysym.sym]));
					dkRml->context->ProcessTextInput(DKSFMLWindow::SFMLShiftCharCode[event->key.keysym.sym]);
				}
				else{
					//DKEvent::SendEvent("window", "keypress", toString(DKSFMLWindow::SFMLCharCode[event->key.keysym.sym])); //lowercase
					dkRml->context->ProcessTextInput(DKSFMLWindow::SFMLCharCode[event->key.keysym.sym]);
				}
			}
			else if(event->key.keysym.mod & KMOD_SHIFT){ //other character keys
				//DKEvent::SendEvent("window", "keypress", toString(DKSFMLWindow::SFMLShiftCharCode[event->key.keysym.sym])); //shifted symbol
				dkRml->context->ProcessTextInput(DKSFMLWindow::SFMLShiftCharCode[event->key.keysym.sym]);
			}
			else{
				//DKEvent::SendEvent("window", "keypress", toString(DKSFMLWindow::SFMLCharCode[event->key.keysym.sym])); //symbol
				dkRml->context->ProcessTextInput(DKSFMLWindow::SFMLCharCode[event->key.keysym.sym]);
			}
			*/
			//DKEvent::SendEvent("window", "keydown", toString(DKSFMLWindow::SFMLKeyCode[event->key.keysym.sym])); //keycode
			//dkRml->context->ProcessKeyDown((Rml::Input::KeyIdentifier)DKSFMLWindow::SFMLKeyCode[event->key.keysym.sym], SystemInterface->GetKeyModifiers());
			dkRml->context->ProcessKeyDown(SystemInterface->TranslateKey(event->key.keysym.sym), SystemInterface->GetKeyModifiers());
			//TODO: If enter is pressed, send enter event on ProcessTextInput
			if(event->key.keysym.sym == 13) //Enter key
			//dkRml->context->ProcessTextInput(DKSFMLWindow::SFMLCharCode[event->key.keysym.sym]); //TEST
			dkRml->context->ProcessTextInput("\n"); //TEST2
			return false; //allow event to continue
		}
#endif
		case SFML_TEXTINPUT:
			//DKINFO("DKSFMLRml::SFML_TEXTINPUT("+DKString(event->text.text)+")\n");
			dkRml->context->ProcessTextInput(event->text.text);
			break;
		case SFML_TEXTEDITING:
			//DKINFO("DKSFMLRml::SFML_TEXTEDITING()\n");
			break;	
		case SFML_KEYUP:
			//dkRml->context->ProcessKeyUp((Rml::Input::KeyIdentifier)DKSFMLWindow::SFMLKeyCode[event->key.keysym.sym], SystemInterface->GetKeyModifiers());
			dkRml->context->ProcessKeyUp(SystemInterface->TranslateKey(event->key.keysym.sym), SystemInterface->GetKeyModifiers());
			break;
            default:
                break;
		} 
	return false; //allow event to continue
}

void DKSFMLRml::Render(){
    //DKDEBUGFUNC();
	if(dkSFMLWindow->width != dkRml->context->GetDimensions().x || dkSFMLWindow->height != dkRml->context->GetDimensions().y){
		dkRml->context->SetDimensions(Rml::Vector2i(dkSFMLWindow->width, dkSFMLWindow->height));
		// Reset blending and draw a fake point just outside the screen to let SFML know that it needs to reset its state in case it wants to render a texture 
		SFML_SetRenderDrawBlendMode(dkSFMLWindow->renderer, SFML_BLENDMODE_NONE);
		SFML_RenderDrawPoint(dkSFMLWindow->renderer, -1, -1);
	}
	dkRml->context->Render();
}

void DKSFMLRml::Update(){
	dkRml->context->Update();
}
