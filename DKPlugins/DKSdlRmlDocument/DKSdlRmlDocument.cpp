/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
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
#include "DK/DKFile.h"
#include "DKAssets/DKAssets.h"
#include "DKSdlRmlDocument/DKSdlRmlDocument.h"

WARNING_DISABLE
#include "SDL.h"
WARNING_ENABLE


bool DKSdlRmlDocument::Init(){
	DKDEBUGFUNC();
	//Android SDL_TEXTINPUT events not working
	//SDL_StartTextInput(); 
	//SDL_EventState(SDL_TEXTINPUT, SDL_ENABLE);
	dkSdlWindow = DKSdlWindow::Instance("DKSdlWindow0");
	dkRmlDocument = DKRmlDocument::Instance("DKRmlDocument0");
	if(!dkSdlWindow || !dkRmlDocument)
		return DKERROR("DKSdlRmlDocument::Init(): INVALID OBJECTS\n");
#ifdef USE_DKSDLRMLRENDERER
	Renderer = new DKSdlRmlRenderer(dkSdlWindow->renderer, dkSdlWindow->_window);
#elif USE_DKSDLRMLOPENGL
	Renderer = new DKSdlRmlOpenGL(dkSdlWindow->renderer, dkSdlWindow->_window);
#elif USE_DKSDLRMLSHELL
	Renderer = new ShellRenderInterfaceOpenGL();
#endif
	SystemInterface = new RmlSDL2SystemInterface();
	Rml::SetRenderInterface(Renderer);
    Rml::SetSystemInterface(SystemInterface);
	DKSdlWindow::AddEventFunc(&DKSdlRmlDocument::Handle, this);
	DKSdlWindow::AddRenderFunc(&DKSdlRmlDocument::Render, this);
	DKSdlWindow::AddUpdateFunc(&DKSdlRmlDocument::Update, this);
	return true;
}

bool DKSdlRmlDocument::End(){
	DKDEBUGFUNC();
	return true;
}

bool DKSdlRmlDocument::Handle(SDL_Event *event) {
	//DKDEBUGFUNC(event);  //EXCESSIVE LOGGING
	if(!dkRmlDocument->document)
		return DKERROR("dkRmlDocument->document invalid\n");
	Rml::Element* hover;
	switch(event->type){
		case SDL_MOUSEMOTION:
			dkRmlDocument->context->ProcessMouseMove(event->motion.x, event->motion.y, SystemInterface->GetKeyModifiers());
			//if we clicked an element, end the event.
			hover = dkRmlDocument->context->GetHoverElement();
			if(hover && (!has(hover->GetId(), "iframe_")))
				return true;
            break;   
		case SDL_MOUSEBUTTONDOWN:
            dkRmlDocument->context->ProcessMouseButtonDown(SystemInterface->TranslateMouseButton(event->button.button), SystemInterface->GetKeyModifiers());
            //if we clicked an element, end the event.
			hover = dkRmlDocument->context->GetHoverElement();
			if(hover && (!has(hover->GetId(), "iframe_")))
				return true;
			break;
        case SDL_MOUSEBUTTONUP:
            dkRmlDocument->context->ProcessMouseButtonUp(SystemInterface->TranslateMouseButton(event->button.button), SystemInterface->GetKeyModifiers());
			//if we clicked an element, end the event.
			hover = dkRmlDocument->context->GetHoverElement();
			if(hover && (!has(hover->GetId(), "iframe_"))){
				//return true;
			}
			break;
        case SDL_MOUSEWHEEL:
            dkRmlDocument->context->ProcessMouseWheel(event->wheel.y * (float)- 1.0, SystemInterface->GetKeyModifiers());
            break;
#if ANDROID
        case SDL_KEYDOWN:
			//DKINFO("DKSdlRmlDocument::SDL_KEYDOWN("+toString((int)event->key.keysym.sym)+")\n");
			dkRmlDocument->context->ProcessKeyDown(SystemInterface->TranslateKey(event->key.keysym.sym), SystemInterface->GetKeyModifiers());
			if(event->key.keysym.sym == 13) //enter
				dkRmlDocument->context->ProcessTextInput("\n");
            break;
#else
		case SDL_KEYDOWN:{
			//DKINFO("DKSdlWindow::SDL_KEYDOWN("+toString(event->key.keysym.sym)+")\n");
			/*
			if(event->key.keysym.sym == 0){ return true; }
			if(event->key.keysym.sym > 96 && event->key.keysym.sym < 123){ //letter
				if(event->key.keysym.mod & KMOD_SHIFT && event->key.keysym.mod & KMOD_CAPS){ //both = lowercase
					//DKEvent::SendEvent("window", "keypress", toString(DKSdlWindow::sdlCharCode[event->key.keysym.sym]));
					dkRmlDocument->context->ProcessTextInput(DKSdlWindow::sdlCharCode[event->key.keysym.sym]);
				}
				else if(event->key.keysym.mod & KMOD_SHIFT || event->key.keysym.mod & KMOD_CAPS){ //1 = uppercase
					//DKEvent::SendEvent("window", "keypress", toString(DKSdlWindow::sdlShiftCharCode[event->key.keysym.sym]));
					dkRmlDocument->context->ProcessTextInput(DKSdlWindow::sdlShiftCharCode[event->key.keysym.sym]);
				}
				else{
					//DKEvent::SendEvent("window", "keypress", toString(DKSdlWindow::sdlCharCode[event->key.keysym.sym])); //lowercase
					dkRmlDocument->context->ProcessTextInput(DKSdlWindow::sdlCharCode[event->key.keysym.sym]);
				}
			}
			else if(event->key.keysym.mod & KMOD_SHIFT){ //other character keys
				//DKEvent::SendEvent("window", "keypress", toString(DKSdlWindow::sdlShiftCharCode[event->key.keysym.sym])); //shifted symbol
				dkRmlDocument->context->ProcessTextInput(DKSdlWindow::sdlShiftCharCode[event->key.keysym.sym]);
			}
			else{
				//DKEvent::SendEvent("window", "keypress", toString(DKSdlWindow::sdlCharCode[event->key.keysym.sym])); //symbol
				dkRmlDocument->context->ProcessTextInput(DKSdlWindow::sdlCharCode[event->key.keysym.sym]);
			}
			*/
			//DKEvent::SendEvent("window", "keydown", toString(DKSdlWindow::sdlKeyCode[event->key.keysym.sym])); //keycode
			//dkRmlDocument->context->ProcessKeyDown((Rml::Input::KeyIdentifier)DKSdlWindow::sdlKeyCode[event->key.keysym.sym], SystemInterface->GetKeyModifiers());
			dkRmlDocument->context->ProcessKeyDown(SystemInterface->TranslateKey(event->key.keysym.sym), SystemInterface->GetKeyModifiers());
			//TODO: If enter is pressed, send enter event on ProcessTextInput
			if(event->key.keysym.sym == 13) //Enter key
			//dkRmlDocument->context->ProcessTextInput(DKSdlWindow::sdlCharCode[event->key.keysym.sym]); //TEST
			dkRmlDocument->context->ProcessTextInput("\n"); //TEST2
			return false; //allow event to continue
		}
#endif
		case SDL_TEXTINPUT:
			//DKINFO("DKSdlRmlDocument::SDL_TEXTINPUT("+DKString(event->text.text)+")\n");
			dkRmlDocument->context->ProcessTextInput(event->text.text);
			break;
		case SDL_TEXTEDITING:
			//DKINFO("DKSdlRmlDocument::SDL_TEXTEDITING()\n");
			break;	
		case SDL_KEYUP:
			//dkRmlDocument->context->ProcessKeyUp((Rml::Input::KeyIdentifier)DKSdlWindow::sdlKeyCode[event->key.keysym.sym], SystemInterface->GetKeyModifiers());
			dkRmlDocument->context->ProcessKeyUp(SystemInterface->TranslateKey(event->key.keysym.sym), SystemInterface->GetKeyModifiers());
			break;
            default:
                break;
		} 
	return false; //allow event to continue
}

bool DKSdlRmlDocument::Render(){
    //DKDEBUGFUNC();  //EXCESSIVE LOGGING
	if(dkSdlWindow->width != dkRmlDocument->context->GetDimensions().x || dkSdlWindow->height != dkRmlDocument->context->GetDimensions().y){
		dkRmlDocument->context->SetDimensions(Rml::Vector2i(dkSdlWindow->width, dkSdlWindow->height));
		// Reset blending and draw a fake point just outside the screen to let SDL know that it needs to reset its state in case it wants to render a texture 
		SDL_SetRenderDrawBlendMode(dkSdlWindow->renderer, SDL_BLENDMODE_NONE);
		SDL_RenderDrawPoint(dkSdlWindow->renderer, -1, -1);
	}
	dkRmlDocument->context->Render();
	return true;
}

void DKSdlRmlDocument::Update(){
	if(!DKApp::active)
		return;
	dkRmlDocument->context->Update();
}
