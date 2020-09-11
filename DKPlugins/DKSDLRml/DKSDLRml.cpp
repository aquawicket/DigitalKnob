#include "DK/stdafx.h"
#include "SDL.h"
#include "DK/DKFile.h"
#include "DKAssets/DKAssets.h"
#include "DKSDLRml/DKSDLRml.h"

////////////////////////
bool DKSDLRml::Init()
{
	DKDEBUGFUNC();
	//Android SDL_TEXTINPUT events not working
	//SDL_StartTextInput(); 
	//SDL_EventState(SDL_TEXTINPUT, SDL_ENABLE);
	
	dkSdlWindow = DKSDLWindow::Instance("DKSDLWindow0");
	dkRml = DKRml::Instance("DKRml0");
	if(!dkSdlWindow || !dkRml){
		DKERROR("DKSDLRml::Init(): INVALID OBJECTS\n");
		return false;
	}

#ifdef RML_SHELL_RENDER
	Renderer = new ShellRenderInterfaceOpenGL();
#else
	Renderer = new RmlSDL2Renderer(dkSdlWindow->renderer, dkSdlWindow->window);
#endif

	SystemInterface = new RmlSDL2SystemInterface();

	Rml::SetRenderInterface(Renderer);
    Rml::SetSystemInterface(SystemInterface);

	DKSDLWindow::AddEventFunc(&DKSDLRml::Handle, this);
	DKSDLWindow::AddDrawFunc(&DKSDLRml::Draw, this);
	return true;
}

///////////////////////
bool DKSDLRml::End()
{
	DKDEBUGFUNC();
	return true;
}

//////////////////////////////////////////
bool DKSDLRml::Handle(SDL_Event *event)
{
	//DKDEBUGFUNC(event);
	if(!dkRml->document){ return false; }

	Rml::Element* hover;
	switch(event->type){
		case SDL_MOUSEMOTION:
			dkRml->context->ProcessMouseMove(event->motion.x, event->motion.y, SystemInterface->GetKeyModifiers());
			//if we clicked an element, end the event.
			hover = dkRml->context->GetHoverElement();
			if(hover && (!has(hover->GetId(), "iframe_"))){
				return true;
			}
            break;
                
		case SDL_MOUSEBUTTONDOWN:
            dkRml->context->ProcessMouseButtonDown(SystemInterface->TranslateMouseButton(event->button.button), SystemInterface->GetKeyModifiers());
            //if we clicked an element, end the event.
			hover = dkRml->context->GetHoverElement();
			if(hover && (!has(hover->GetId(), "iframe_"))){
				return true;
			}
			break;

        case SDL_MOUSEBUTTONUP:
            dkRml->context->ProcessMouseButtonUp(SystemInterface->TranslateMouseButton(event->button.button), SystemInterface->GetKeyModifiers());
			//if we clicked an element, end the event.
			hover = dkRml->context->GetHoverElement();
			if(hover && (!has(hover->GetId(), "iframe_"))){
				//return true;
			}
			break;

        case SDL_MOUSEWHEEL:
            dkRml->context->ProcessMouseWheel(event->wheel.y * -1, SystemInterface->GetKeyModifiers());
            break;

#ifdef ANDROID
        case SDL_KEYDOWN:
			//DKINFO("DKSDLRml::SDL_KEYDOWN("+toString((int)event->key.keysym.sym)+")\n");
			dkRml->context->ProcessKeyDown(SystemInterface->TranslateKey(event->key.keysym.sym), SystemInterface->GetKeyModifiers());
			if(event->key.keysym.sym == 13){ //enter
				dkRml->context->ProcessTextInput("\n");
			}
            break;
#else
		case SDL_KEYDOWN:{
			//DKINFO("DKSDLWindow::SDL_KEYDOWN("+toString(event->key.keysym.sym)+")\n");
			/*
			if(event->key.keysym.sym == 0){ return true; }
			if(event->key.keysym.sym > 96 && event->key.keysym.sym < 123){ //letter
				if(event->key.keysym.mod & KMOD_SHIFT && event->key.keysym.mod & KMOD_CAPS){ //both = lowercase
					//DKEvent::SendEvent("window", "keypress", toString(DKSDLWindow::sdlCharCode[event->key.keysym.sym]));
					dkRml->context->ProcessTextInput(DKSDLWindow::sdlCharCode[event->key.keysym.sym]);
				}
				else if(event->key.keysym.mod & KMOD_SHIFT || event->key.keysym.mod & KMOD_CAPS){ //1 = uppercase
					//DKEvent::SendEvent("window", "keypress", toString(DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym]));
					dkRml->context->ProcessTextInput(DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym]);
				}
				else{
					//DKEvent::SendEvent("window", "keypress", toString(DKSDLWindow::sdlCharCode[event->key.keysym.sym])); //lowercase
					dkRml->context->ProcessTextInput(DKSDLWindow::sdlCharCode[event->key.keysym.sym]);
				}
			}
			else if(event->key.keysym.mod & KMOD_SHIFT){ //other character keys
				//DKEvent::SendEvent("window", "keypress", toString(DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym])); //shifted symbol
				dkRml->context->ProcessTextInput(DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym]);
			}
			else{
				//DKEvent::SendEvent("window", "keypress", toString(DKSDLWindow::sdlCharCode[event->key.keysym.sym])); //symbol
				dkRml->context->ProcessTextInput(DKSDLWindow::sdlCharCode[event->key.keysym.sym]);
			}
			*/

			//DKEvent::SendEvent("window", "keydown", toString(DKSDLWindow::sdlKeyCode[event->key.keysym.sym])); //keycode
			//dkRml->context->ProcessKeyDown((Rml::Input::KeyIdentifier)DKSDLWindow::sdlKeyCode[event->key.keysym.sym], SystemInterface->GetKeyModifiers());
			dkRml->context->ProcessKeyDown(SystemInterface->TranslateKey(event->key.keysym.sym), SystemInterface->GetKeyModifiers());
			return false; //allow event to continue
		}
#endif
		case SDL_TEXTINPUT:
			//DKINFO("DKSDLRml::SDL_TEXTINPUT("+DKString(event->text.text)+")\n");
			dkRml->context->ProcessTextInput(event->text.text);
			break;

		case SDL_TEXTEDITING:
			//DKINFO("DKSDLRml::SDL_TEXTEDITING()\n");
			break;
			
		case SDL_KEYUP:
			//dkRml->context->ProcessKeyUp((Rml::Input::KeyIdentifier)DKSDLWindow::sdlKeyCode[event->key.keysym.sym], SystemInterface->GetKeyModifiers());
			dkRml->context->ProcessKeyUp(SystemInterface->TranslateKey(event->key.keysym.sym), SystemInterface->GetKeyModifiers());
			break;

            default:
                break;
		}  

	return false; //allow event to continue
}

////////////////////////
void DKSDLRml::Draw()
{
    //DKDEBUGFUNC();
	if(dkSdlWindow->width != dkRml->context->GetDimensions().x || dkSdlWindow->height != dkRml->context->GetDimensions().y){
		dkRml->context->SetDimensions(Rml::Vector2i(dkSdlWindow->width, dkSdlWindow->height));
		// Reset blending and draw a fake point just outside the screen to let SDL know that it needs to reset its state in case it wants to render a texture 
		SDL_SetRenderDrawBlendMode(dkSdlWindow->renderer, SDL_BLENDMODE_NONE);
		SDL_RenderDrawPoint(dkSdlWindow->renderer, -1, -1);
	}
	dkRml->context->Render();
	dkRml->context->Update();
}