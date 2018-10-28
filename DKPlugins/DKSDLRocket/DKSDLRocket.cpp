#include "DK/stdafx.h"
#include "SDL.h"
#include "DK/DKFile.h"
#include "DKAssets/DKAssets.h"
#include "DKSDLRocket/DKSDLRocket.h"

////////////////////////
bool DKSDLRocket::Init()
{
	DKDEBUGFUNC();
	//Android SDL_TEXTINPUT events not working
	//SDL_StartTextInput(); 
	//SDL_EventState(SDL_TEXTINPUT, SDL_ENABLE);
	
	dkSdlWindow = DKSDLWindow::Instance("DKSDLWindow0");
	dkRocket = DKRocket::Instance("DKRocket0");
	if(!dkSdlWindow || !dkRocket){
		DKERROR("DKSDLRocket::Init(): INVALID OBJECTS\n");
		return false;
	}

#ifdef ROCKET_SHELL_RENDER
	Renderer = new ShellRenderInterfaceOpenGL();
#else
	Renderer = new RocketSDL2Renderer(dkSdlWindow->renderer, dkSdlWindow->window);
#endif

	SystemInterface = new RocketSDL2SystemInterface();

	Rocket::Core::SetRenderInterface(Renderer);
    Rocket::Core::SetSystemInterface(SystemInterface);

	DKSDLWindow::AddEventFunc(&DKSDLRocket::Handle, this);
	DKSDLWindow::AddDrawFunc(&DKSDLRocket::Draw, this);
	return true;
}

///////////////////////
bool DKSDLRocket::End()
{
	DKDEBUGFUNC();
	return true;
}

//////////////////////////////////////////
bool DKSDLRocket::Handle(SDL_Event *event)
{
	//DKDEBUGFUNC(event);
	if(!dkRocket->document){ return false; }

	Rocket::Core::Element* hover;
	switch(event->type){
		case SDL_MOUSEMOTION:
			dkRocket->context->ProcessMouseMove(event->motion.x, event->motion.y, SystemInterface->GetKeyModifiers());
			//if we clicked an element, end the event.
			hover = dkRocket->context->GetHoverElement();
			if(hover && (!has(hover->GetId().CString(), "iframe_"))){
				return true;
			}
            break;
                
		case SDL_MOUSEBUTTONDOWN:
            dkRocket->context->ProcessMouseButtonDown(SystemInterface->TranslateMouseButton(event->button.button), SystemInterface->GetKeyModifiers());
            //if we clicked an element, end the event.
			hover = dkRocket->context->GetHoverElement();
			if(hover && (!has(hover->GetId().CString(), "iframe_"))){
				return true;
			}
			break;

        case SDL_MOUSEBUTTONUP:
            dkRocket->context->ProcessMouseButtonUp(SystemInterface->TranslateMouseButton(event->button.button), SystemInterface->GetKeyModifiers());
			//if we clicked an element, end the event.
			hover = dkRocket->context->GetHoverElement();
			if(hover && (!has(hover->GetId().CString(), "iframe_"))){
				//return true;
			}
			break;

        case SDL_MOUSEWHEEL:
            dkRocket->context->ProcessMouseWheel(event->wheel.y * -1, SystemInterface->GetKeyModifiers());
            break;

#ifndef ANDROID
        case SDL_KEYDOWN:
			//DKINFO("DKSDLRocket::SDL_KEYDOWN("+toString((int)event->key.keysym.sym)+")\n");
			dkRocket->context->ProcessKeyDown(SystemInterface->TranslateKey(event->key.keysym.sym), SystemInterface->GetKeyModifiers());
			if(event->key.keysym.sym == 13){ //enter
				dkRocket->context->ProcessTextInput("\n");
			}
            break;
#else
		case SDL_KEYDOWN:{
			//DKINFO("DKSDLWindow::SDL_KEYDOWN("+toString(event->key.keysym.sym)+")\n");
			if(event->key.keysym.sym == 0){ return true; }
			if(event->key.keysym.sym > 96 && event->key.keysym.sym < 123){ //letter
				if(event->key.keysym.mod & KMOD_SHIFT && event->key.keysym.mod & KMOD_CAPS){ //both = lowercase
					//DKEvent::SendEvent("GLOBAL", "keypress", toString(DKSDLWindow::sdlCharCode[event->key.keysym.sym]));
					dkRocket->context->ProcessTextInput(DKSDLWindow::sdlCharCode[event->key.keysym.sym]);
				}
				else if(event->key.keysym.mod & KMOD_SHIFT || event->key.keysym.mod & KMOD_CAPS){ //1 = uppercase
					//DKEvent::SendEvent("GLOBAL", "keypress", toString(DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym]));
					dkRocket->context->ProcessTextInput(DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym]);
				}
				else{
					//DKEvent::SendEvent("GLOBAL", "keypress", toString(DKSDLWindow::sdlCharCode[event->key.keysym.sym])); //lowercase
					dkRocket->context->ProcessTextInput(DKSDLWindow::sdlCharCode[event->key.keysym.sym]);
				}
			}
			else if(event->key.keysym.mod & KMOD_SHIFT){ //other character keys
				//DKEvent::SendEvent("GLOBAL", "keypress", toString(DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym])); //shifted symbol
				dkRocket->context->ProcessTextInput(DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym]);
			}
			else{
				//DKEvent::SendEvent("GLOBAL", "keypress", toString(DKSDLWindow::sdlCharCode[event->key.keysym.sym])); //symbol
				dkRocket->context->ProcessTextInput(DKSDLWindow::sdlCharCode[event->key.keysym.sym]);
			}
			//DKEvent::SendEvent("GLOBAL", "keydown", toString(DKSDLWindow::sdlKeyCode[event->key.keysym.sym])); //keycode
			dkRocket->context->ProcessKeyDown((Rocket::Core::Input::KeyIdentifier)DKSDLWindow::sdlKeyCode[event->key.keysym.sym], SystemInterface->GetKeyModifiers());
			return false; //allow event to continue
		}
#endif
		case SDL_TEXTINPUT:
			//DKINFO("DKSDLRocket::SDL_TEXTINPUT("+DKString(event->text.text)+")\n");
			dkRocket->context->ProcessTextInput(event->text.text);
			break;

		case SDL_TEXTEDITING:
			//DKINFO("DKSDLRocket::SDL_TEXTEDITING()\n");
			break;
			
		case SDL_KEYUP:
            dkRocket->context->ProcessKeyUp(SystemInterface->TranslateKey(event->key.keysym.sym), SystemInterface->GetKeyModifiers());
            break;

            default:
                break;
		}  

	return false; //allow event to continue
}

////////////////////////
void DKSDLRocket::Draw()
{
    //DKDEBUGFUNC();
	if(dkSdlWindow->width != dkRocket->context->GetDimensions().x || dkSdlWindow->height != dkRocket->context->GetDimensions().y){
		dkRocket->context->SetDimensions(Rocket::Core::Vector2i(dkSdlWindow->width, dkSdlWindow->height));
		// Reset blending and draw a fake point just outside the screen to let SDL know that it needs to reset its state in case it wants to render a texture 
		SDL_SetRenderDrawBlendMode(dkSdlWindow->renderer, SDL_BLENDMODE_NONE);
		SDL_RenderDrawPoint(dkSdlWindow->renderer, -1, -1);
	}
	dkRocket->context->Render();
	dkRocket->context->Update();
}