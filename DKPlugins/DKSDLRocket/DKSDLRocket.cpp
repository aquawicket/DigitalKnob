#include "stdafx.h"
#include "DKSDLRocket.h"
#include "DKAssets.h"
#include "DKFile.h"
#include "SDL.h"

////////////////////////
void DKSDLRocket::Init()
{
	//Android SDL_TEXTINPUT events not working
	//SDL_StartTextInput(); 
	//SDL_EventState(SDL_TEXTINPUT, SDL_ENABLE);
	
	dkSdlWindow = DKSDLWindow::Instance("DKSDLWindow0");
	dkRocket = DKRocket::Instance("DKRocket0");
	if(!dkSdlWindow || !dkRocket){
		DKLog("DKSDLRocket::Init(): INVALID OBJECTS \n", DKERROR);
		return;
	}

	Renderer = new RocketSDL2Renderer(dkSdlWindow->sdlren, dkSdlWindow->sdlwin);
	SystemInterface = new RocketSDL2SystemInterface();

	Rocket::Core::SetRenderInterface(Renderer);
    Rocket::Core::SetSystemInterface(SystemInterface);

	DKSDLWindow::AddEventFunc(&DKSDLRocket::handle, this);
	DKSDLWindow::AddDrawFunc(&DKSDLRocket::Draw, this);
}

///////////////////////
void DKSDLRocket::End()
{

}

//////////////////////////////////////////
bool DKSDLRocket::handle(SDL_Event *event)
{
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
			//DKLog("DKSDLRocket::SDL_KEYDOWN("+toString((int)event->key.keysym.sym)+")\n", DKDEBUG);
			dkRocket->context->ProcessKeyDown(SystemInterface->TranslateKey(event->key.keysym.sym), SystemInterface->GetKeyModifiers());
			if(event->key.keysym.sym == 13){ //enter
				dkRocket->context->ProcessTextInput("\n");
			}
            break;
#else
		case SDL_KEYDOWN:{
			//DKLog("DKSDLWindow::SDL_KEYDOWN("+toString(event->key.keysym.sym)+")\n", DKDEBUG);
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
			//DKLog("DKSDLRocket::SDL_TEXTINPUT("+DKString(event->text.text)+")\n", DKDEBUG);
			dkRocket->context->ProcessTextInput(event->text.text);
			break;

		case SDL_TEXTEDITING:
			//DKLog("DKSDLRocket::SDL_TEXTEDITING()\n", DKDEBUG);
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
    //DKLog("DKSDLRocket::Draw()\n", DKDEBUG);
	if(dkSdlWindow->width != dkRocket->context->GetDimensions().x || dkSdlWindow->height != dkRocket->context->GetDimensions().y){
		dkRocket->context->SetDimensions(Rocket::Core::Vector2i(dkSdlWindow->width, dkSdlWindow->height));
		// Reset blending and draw a fake point just outside the screen to let SDL know that it needs to reset its state in case it wants to render a texture 
		SDL_SetRenderDrawBlendMode(dkSdlWindow->sdlren, SDL_BLENDMODE_NONE);
		SDL_RenderDrawPoint(dkSdlWindow->sdlren, -1, -1);
	}
	dkRocket->context->Render();
	dkRocket->context->Update();
}