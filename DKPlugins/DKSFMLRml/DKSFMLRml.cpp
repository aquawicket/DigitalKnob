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
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DKAssets/DKAssets.h"
#include "DKSFMLRml/DKSFMLRml.h"

//WARNING_DISABLE
//#include "SFML.h"
//WARNING_ENABLE

bool DKSFMLRml::Init(){
	DKDEBUGFUNC();
	//Android SFML_TEXTINPUT events not working
	//SFML_StartTextInput(); 
	//SFML_EventState(SFML_TEXTINPUT, SFML_ENABLE);
	dkSFMLWindow = DKSFMLWindow::Instance("DKSFMLWindow0");
	if (!dkSFMLWindow)
		return DKERROR("dkSFMLWindow invalid! \n")
	dkRml = DKRml::Instance("DKRml0");
	if(!dkRml)
		return DKERROR("dkRml invalid! \n");
#ifdef RML_SHELL_RENDER
	renderer = new ShellRenderInterfaceOpenGL();
#else
	//Renderer = new RmlSFMLRenderer(dkSFMLWindow->renderer, dkSFMLWindow->window);
	renderer = new RmlSFMLRenderer();
	renderer->SetWindow(&dkSFMLWindow->window);
#endif
	systemInterface = new RmlSFMLSystemInterface();
	Rml::SetRenderInterface(renderer);
    Rml::SetSystemInterface(systemInterface);
	DKSFMLWindow::AddEventFunc(&DKSFMLRml::Handle, this);
	//DKSFMLWindow::AddRenderFunc(&DKSFMLRml::Render, this);
	//DKSFMLWindow::AddUpdateFunc(&DKSFMLRml::Update, this);
	return true;
}

bool DKSFMLRml::End(){
	DKDEBUGFUNC();
	return true;
}

bool DKSFMLRml::Handle(sf::Event& event) {
	//DKDEBUGFUNC(event);  //EXCESSIVE LOGGING
	if(!dkRml->document)
		return DKERROR("dkRml->document invalid! \n");
	Rml::Element* hover;
	switch(event.type){
		case sf::Event::MouseMoved:
			dkRml->context->ProcessMouseMove(event.mouseMove.x, event.mouseMove.y, systemInterface->GetKeyModifiers());
			//if we clicked an element, end the event.
			hover = dkRml->context->GetHoverElement();
			if(hover && (!has(hover->GetId(), "iframe_")))
				return true;
            break;   
		case sf::Event::MouseButtonPressed:
            dkRml->context->ProcessMouseButtonDown(systemInterface->TranslateMouseButton(event.mouseButton.button), systemInterface->GetKeyModifiers());
            //if we clicked an element, end the event.
			hover = dkRml->context->GetHoverElement();
			if(hover && (!has(hover->GetId(), "iframe_")))
				return true;
			break;
		case sf::Event::MouseButtonReleased:
            dkRml->context->ProcessMouseButtonUp(systemInterface->TranslateMouseButton(event.mouseButton.button), systemInterface->GetKeyModifiers());
			//if we clicked an element, end the event.
			hover = dkRml->context->GetHoverElement();
			if(hover && (!has(hover->GetId(), "iframe_"))){
				//return true;
			}
			break;
		case sf::Event::MouseWheelScrolled:
            dkRml->context->ProcessMouseWheel(event.mouseWheelScroll.y * -1, systemInterface->GetKeyModifiers());
            break;
#if ANDROID
		case sf::Event::KeyPressed:
			//DKINFO("DKSFMLRml::SFML_KEYDOWN("+toString((int)event->key.keysym.sym)+")\n");
			dkRml->context->ProcessKeyDown(systemInterface->TranslateKey(event->key.keysym.sym), systemInterface->GetKeyModifiers());
			if(event.key.code == 13) //enter
				dkRml->context->ProcessTextInput("\n");
            break;
#else
		case sf::Event::KeyPressed: {
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
			//dkRml->context->ProcessKeyDown((Rml::Input::KeyIdentifier)DKSFMLWindow::SFMLKeyCode[event->key.keysym.sym], systemInterface->GetKeyModifiers());
			dkRml->context->ProcessKeyDown(systemInterface->TranslateKey(event.key.code), systemInterface->GetKeyModifiers());
			//TODO: If enter is pressed, send enter event on ProcessTextInput
			if(event.key.code == 13) //Enter key
			//dkRml->context->ProcessTextInput(DKSFMLWindow::SFMLCharCode[event->key.keysym.sym]); //TEST
			dkRml->context->ProcessTextInput("\n"); //TEST2
			return false; //allow event to continue
		}
#endif
		case sf::Event::TextEntered:
			//DKINFO("DKSFMLRml::SFML_TEXTINPUT("+DKString(event->text.text)+")\n");
			//dkRml->context->ProcessTextInput(event.text);
			break;
		//case sf::Event::TextEvent
		//	DKINFO("DKSFMLRml::SFML_TEXTEDITING()\n");
		//	break;	
		case sf::Event::KeyReleased:
			//dkRml->context->ProcessKeyUp((Rml::Input::KeyIdentifier)DKSFMLWindow::SFMLKeyCode[event->key.keysym.sym], systemInterface->GetKeyModifiers());
			dkRml->context->ProcessKeyUp(systemInterface->TranslateKey(event.key.code), systemInterface->GetKeyModifiers());
			break;
            default:
                break;
		} 
	return false; //allow event to continue
}

void DKSFMLRml::Render(){
    //DKDEBUGFUNC();  //EXCESSIVE LOGGING
	if(dkSFMLWindow->width != dkRml->context->GetDimensions().x || dkSFMLWindow->height != dkRml->context->GetDimensions().y){
		dkRml->context->SetDimensions(Rml::Vector2i(dkSFMLWindow->width, dkSFMLWindow->height));
		// Reset blending and draw a fake point just outside the screen to let SFML know that it needs to reset its state in case it wants to render a texture 
		//SFML_SetRenderDrawBlendMode(dkSFMLWindow->renderer, SFML_BLENDMODE_NONE);
		//SFML_RenderDrawPoint(dkSFMLWindow->renderer, -1, -1);
	}
	dkRml->context->Render();
}

void DKSFMLRml::Update(){
	dkRml->context->Update();
}
