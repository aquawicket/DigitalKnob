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
#include "DK/DKApp.h"
#include "DK/DKFile.h"
#include "DK/DKLog.h"
#include "DKSDLCef/DKSDLCef.h"
#include "DKSDLCef/DKSDLCefHandler.h"
#if WIN
	#include "DK/DKWindows.h"
#endif

WARNING_DISABLE
	#include "SDL_syswm.h"
	#include <include/cef_urlrequest.h>
	#if WIN
		#include <delayimp.h>
	#endif
WARNING_ENABLE


bool DKSDLCef::Init() {
	DKDEBUGFUNC();
	popup_image = NULL;
	dkSdlWindow = DKSDLWindow::Instance("DKSDLWindow0");
	//id = data[1];
	dkCef = DKCef::Get();
	if(!dkSdlWindow)
		return DKERROR("dkSdlWindow is invalid\n");
	if(!dkCef)
		return DKERROR("dlCef is invalid\n");
	SetupCef();
	_mouseLMBdown = false;
	_scrollFactor = 120.0f;

	DKSDLWindow::AddEventFunc(&DKSDLCef::Handle, this);
	DKSDLWindow::AddRenderFuncFirst(&DKSDLCef::Draw, this);
	DKClass::RegisterFunc("DKSDLCef::OnClick", &DKSDLCef::OnClick, this);
	DKClass::RegisterFunc("DKSDLCef::OnMouseOver", &DKSDLCef::OnMouseOver, this);
	DKClass::RegisterFunc("DKSDLCef::OnResize", &DKSDLCef::OnResize, this);
	DKClass::RegisterFunc("DKSDLCef::GetTexture", &DKSDLCef::GetTexture, this);
	return true;
}

bool DKSDLCef::End() {
	DKDEBUGFUNC();
	DKApp::RemoveLoopFunc(&DKSDLCefHandler::DoFrame, cefHandler);
	DKClass::UnregisterFunc("DKSDLCef::OnResize");
	DKClass::UnregisterFunc("DKSDLCef::GetTexture");
	cefHandler = NULL;
	return true;
}

bool DKSDLCef::GetCefMouseButton(const int& button, CefBrowserHost::MouseButtonType& type) {
	DKDEBUGFUNC(button, type);
	if(button == 1){ type = MBT_LEFT; }
	if(button == 2){ type = MBT_MIDDLE; }
	if(button == 3){ type = MBT_RIGHT; }
	return true;
}

bool DKSDLCef::GetScrollDeltas(SDL_Event* event, float &deltaX, float &deltaY) {
	DKDEBUGFUNC(event, deltaX, deltaY);
	deltaX = 0.0f;
	deltaY = 0.0f;
	if(event->wheel.y > 0)
		deltaY = _scrollFactor;
	if(event->wheel.y < 0)
		deltaY = -_scrollFactor;
	if(event->wheel.x > 0)
		deltaX = -_scrollFactor;
	if(event->wheel.x < 0)
		deltaX = _scrollFactor;
	return deltaX != 0.0f || deltaY != 0.0f;
}

bool DKSDLCef::GetTexture(const void* input, void* output) {
	DKString id = *(DKString*)input;
	//DKDEBUGFUNC(id, "void* output"); // EXCESSIVE LOGGING
	//replace(id, "[CEF]", "");
	int browser;
	if(!dkCef->GetBrowserNumber(id, browser))
		return DKERROR("browser is invalid\n");
	if (!cefHandler->cef_texture[browser]) {
		DKREDINFO("cefHandler->cef_texture[browser] is invalid\n");
		return false;
	}
	struct DKTexture{ SDL_Texture* texture; };
	DKTexture out = *(DKTexture*)output;
	out.texture = cefHandler->cef_texture[browser];
	*(DKTexture*)output = out;
	return true;
}

bool DKSDLCef::Handle(SDL_Event* event) {
	//DKDEBUGFUNC(event);  //EXCESSIVE LOGGING
	int browser_index;
	if (!dkCef->GetCurrentBrowser(browser_index))
		return false;// DKERROR("browser_index is invalid\n");
	
	//DKINFO("DKSDLCef::Handle(): GetCurrentBrowser = "+toString(i)+"\n");
	//DKINFO("number_of_browsers = "+toString(dkCef->GetBrowsers())+"\n");
	//DKINFO("current_browser = "+toString(dkCef->GetCurrentBrowser())+"\n");
	//switch(event->type){
		//case SDL_MOUSEMOTION:
		//case SDL_DRAG:
		//case SDL_MOUSEBUTTONDOWN:
		//case SDL_MOUSEBUTTONUP:
		//case SDL_MOUSEBUTTONDOUBLECLICK:
		//case SDL_MOUSEWHEEL:
		//{
			//if(transparentPixel(event) && !_mouseLMBdown){
				//if(event->type == SDL_MOUSEBUTTONUP){
					//dkCef->current_browser->GetHost()->SendFocusEvent(false);
					//dkCef->inFocus = false;
				//}
				//return false;
			//}
		//}
	//}

	switch(event->type){
		case SDL_MOUSEBUTTONDOWN:{
			//DKINFO("DKSDLCef::Handle(): CurrentBrowser = "+toString(i)+"\n");
			int clicks = 1;
			if(event->button.clicks == 2)// double click
				clicks = 2;
			if(event->button.button == 3)
				_mouseLMBdown = true;
			CefMouseEvent mouse_event;
            mouse_event.x = event->motion.x - dkCef->dkBrowsers[browser_index].left;
			mouse_event.y = event->motion.y - dkCef->dkBrowsers[browser_index].top;
			if(mouse_event.x < 0) 
				return false;
			if(mouse_event.x > dkCef->dkBrowsers[browser_index].width)
				return false;
			if(mouse_event.y < 0)
				return false;
			if(mouse_event.y > dkCef->dkBrowsers[browser_index].height)
				return false;
			dkCef->SetFocus(browser_index);
			//mouse_event.modifiers = _keyAdapter.getCefModifiers(event->key.keysym.mod);

			CefBrowserHost::MouseButtonType type;
			GetCefMouseButton(event->button.button, type);
			dkCef->dkBrowsers[browser_index].browser->GetHost()->SendMouseClickEvent(mouse_event, type, false, clicks);
			return true;
		}

		case SDL_MOUSEBUTTONUP:{
			int clicks = 1;
			if(event->button.clicks == 2) // double click
				clicks = 2;
            if(event->button.button == 3)
				_mouseLMBdown = false;
			CefMouseEvent mouse_event;
            mouse_event.x = event->motion.x - dkCef->dkBrowsers[browser_index].left;
			mouse_event.y = event->motion.y - dkCef->dkBrowsers[browser_index].top;
			if(mouse_event.x < 0)
				return false;
			if(mouse_event.x > dkCef->dkBrowsers[browser_index].width)
				return false;
			if(mouse_event.y < 0)
				return false;
			if(mouse_event.y > dkCef->dkBrowsers[browser_index].height)
				return false;
			dkCef->SetFocus(browser_index);
			//mouse_event.modifiers = _keyAdapter.getCefModifiers(event->key.keysym.mod);

			CefBrowserHost::MouseButtonType type;
			GetCefMouseButton(event->button.button, type);
			dkCef->dkBrowsers[browser_index].browser->GetHost()->SendMouseClickEvent(mouse_event, type, true, clicks);
 
			return true;
		}

		/*
		case SDL_TEXTINPUT:{
			DKINFO("SDL_TEXTINPUT: event->text.text = "+toString(event->text.text)+"\n");
		}
		*/
		
		case SDL_KEYDOWN:{
			if(dkCef->keyboardFocus < 0)
				return false;
			//print SDL2 key data
			/*
			DKINFO("SDL_KEYDOWN: event->key.keysym.sym = "+toString(event->key.keysym.sym)+"\n");
			DKINFO("SDL_KEYDOWN: event->key.keysym.scancode = "+toString(event->key.keysym.scancode)+"\n");
			DKINFO("SDL_KEYDOWN: sdlKeyCode[event->key.keysym.sym] = "+toString(DKSDLWindow::sdlKeyCode[event->key.keysym.sym])+"\n");
			DKINFO("SDL_KEYDOWN: sdlCharCode[event->key.keysym.sym] = "+toString(DKSDLWindow::sdlCharCode[event->key.keysym.sym])+"\n");
			DKINFO("SDL_KEYDOWN: sdlShiftCharCode[event->key.keysym.sym] = "+toString(DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym])+"\n");
			*/
			
			CefKeyEvent KeyEvent;
       		KeyEvent.type = KEYEVENT_KEYDOWN;
			//KeyEvent.type = KEYEVENT_RAWKEYDOWN;
			KeyEvent.windows_key_code = DKSDLWindow::sdlKeyCode[event->key.keysym.sym];
#if MAC
			KeyEvent.native_key_code = DKSDLWindow::sdlMacCode[event->key.keysym.sym];
#endif
			//KeyEvent.unmodified_character = DKSDLWindow::sdlKeyCode[event->key.keysym.sym];
       		KeyEvent.modifiers = _keyAdapter.getCefModifiers(event->key.keysym.mod);
		
			//DKINFO("RAWKEYDOWN: windows_key_code = "+toString(KeyEvent.windows_key_code)+"\n");
			//DKINFO("RAWKEYDOWN: modifiers = "+toString(KeyEvent.modifiers)+"\n");
			dkCef->dkBrowsers[dkCef->keyboardFocus].browser->GetHost()->SendKeyEvent(KeyEvent);

			CefKeyEvent charKeyEvent;
       		charKeyEvent.type = KEYEVENT_CHAR;
       		charKeyEvent.modifiers = _keyAdapter.getCefModifiers(event->key.keysym.mod);
      		
			if(event->key.keysym.sym > 96 && event->key.keysym.sym < 123){ //letter
				if(event->key.keysym.mod & KMOD_SHIFT && event->key.keysym.mod & KMOD_CAPS){ //both = lowercase
					charKeyEvent.windows_key_code = DKSDLWindow::sdlCharCode[event->key.keysym.sym];
					charKeyEvent.character = (char16)DKSDLWindow::sdlCharCode[event->key.keysym.sym];
				}
				else if(event->key.keysym.mod & KMOD_SHIFT || event->key.keysym.mod & KMOD_CAPS){ //1 = uppercase
					charKeyEvent.windows_key_code = DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym];
					charKeyEvent.character = (char16)DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym];
				}
				else{
					charKeyEvent.windows_key_code = DKSDLWindow::sdlCharCode[event->key.keysym.sym]; // lowercase
					charKeyEvent.character = (char16)DKSDLWindow::sdlCharCode[event->key.keysym.sym];
				}
			}
			else if(event->key.keysym.mod & KMOD_SHIFT){ //other character keys
				charKeyEvent.windows_key_code = DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym]; //shifted symbol
				charKeyEvent.character = (char16)DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym]; //shifted symbol
			}
			else{
				charKeyEvent.windows_key_code = DKSDLWindow::sdlCharCode[event->key.keysym.sym]; //symbol
				charKeyEvent.character = (char16)DKSDLWindow::sdlCharCode[event->key.keysym.sym]; //symbol
			}

			//DKINFO("CHAR: windows_key_code = "+toString(charKeyEvent.windows_key_code)+"\n");
			//DKINFO("CHAR: modifiers = "+toString(charKeyEvent.modifiers)+"\n");
			dkCef->dkBrowsers[dkCef->keyboardFocus].browser->GetHost()->SendKeyEvent(charKeyEvent);
			return true;
		}

		case SDL_KEYUP:{
			if(dkCef->keyboardFocus < 0)
				return false;
			CefKeyEvent KeyEvent;
       		KeyEvent.type = KEYEVENT_KEYUP;
			KeyEvent.windows_key_code = DKSDLWindow::sdlKeyCode[event->key.keysym.sym];
#			ifdef MAC
				KeyEvent.native_key_code = DKSDLWindow::sdlMacCode[event->key.keysym.sym];
#			endif
			//KeyEvent.unmodified_character = DKSDLWindow::sdlKeyCode[event->key.keysym.sym];
       		KeyEvent.modifiers = _keyAdapter.getCefModifiers(event->key.keysym.mod);

			//DKINFO("KEYUP: windows_key_code = "+toString(KeyEvent.windows_key_code)+"\n");
			//DKINFO("KEYUP: modifiers = "+toString(KeyEvent.modifiers)+"\n");
#			ifndef MAC
				dkCef->dkBrowsers[dkCef->keyboardFocus].browser->GetHost()->SendKeyEvent(KeyEvent);
#			endif
			return true;
		}
					   
		case SDL_MOUSEMOTION:{
			/*
			if(event->motion.state & SDL_BUTTON_LMASK){
				_mouseLMBdown = true;
				DKINFO("SDL_MOUSEMOTION: _mouseLMBdown = true\n");
			}
			else{
				_mouseLMBdown = false;
				DKINFO("SDL_MOUSEMOTION: _mouseLMBdown = false\n");
			}
			*/

			/*
			// detect which browser the mouse is over
			CefMouseEvent mouse_event;
			CefRefPtr<CefBrowser> browser;
			for(int i=0; i<dkCef->dkBrowsers.size(); i++){
				mouse_event.x = event->motion.x - dkCef->dkBrowsers[i].left;
				mouse_event.y = event->motion.y - dkCef->dkBrowsers[i].top;
				if(mouse_event.x < 0){continue;}
				if(mouse_event.x > dkCef->dkBrowsers[i].width){continue;}
				if(mouse_event.y < 0){continue;}
				if(mouse_event.y > dkCef->dkBrowsers[i].height){continue;}
				browser = dkCef->dkBrowsers[i].browser;
				break;
			}
			*/

			CefMouseEvent mouse_event;
			mouse_event.x = event->motion.x - dkCef->dkBrowsers[browser_index].left;
			mouse_event.y = event->motion.y - dkCef->dkBrowsers[browser_index].top;
			//DKINFO("Mouse: X="+toString(mouse_event.x)+" Y="+toString(mouse_event.y)+"\n");
			uint32 modifiers = _keyAdapter.getCefModifiers(event->key.keysym.mod);

			if (SDL_GetMouseState(NULL, NULL) & SDL_BUTTON_LMASK)
				modifiers |= EVENTFLAG_LEFT_MOUSE_BUTTON;
			if (SDL_GetMouseState(NULL, NULL) & SDL_BUTTON_MMASK)
				modifiers |= EVENTFLAG_MIDDLE_MOUSE_BUTTON;
			if (SDL_GetMouseState(NULL, NULL) & SDL_BUTTON_RMASK)
				modifiers |= EVENTFLAG_RIGHT_MOUSE_BUTTON;
	
			mouse_event.modifiers = modifiers;
			dkCef->dkBrowsers[browser_index].browser->GetHost()->SendMouseMoveEvent(mouse_event, false);
			return true;
		}

		case SDL_MOUSEWHEEL:{
			float deltaX, deltaY;
			if(GetScrollDeltas(event, deltaX, deltaY)){
				CefMouseEvent mouse_event;
				int mouseX;
				int mouseY;
				SDL_GetMouseState(&mouseX, &mouseY);
				mouse_event.x = mouseX - dkCef->dkBrowsers[browser_index].left;
				mouse_event.y = mouseY - dkCef->dkBrowsers[browser_index].top;
				//DKINFO("Mouse: X="+toString(mouse_event.x)+" Y="+toString(mouse_event.y)+"\n");
				//uint32 modifiers = _keyAdapter.getCefModifiers(event->key.keysym.mod);
				dkCef->dkBrowsers[browser_index].browser->GetHost()->SendMouseWheelEvent(mouse_event, (int)deltaX, (int)deltaY);
			}
			return true;
		}
	}
	return false;
}

bool DKSDLCef::OnClick(const void* input, void* output) {
	DKDEBUGFUNC(input, output);
	DKString str = *(DKString*)input;
	DKStringArray arry;
	toStringArray(arry,str,","); // id,top,left,width,height
	int browser;
	if(!dkCef->GetBrowserNumber(arry[0], browser))
		return DKERROR("browser is invalid\n");
	OnResize(input, NULL);
	dkCef->SetFocus(browser);
	dkCef->SetKeyboardFocus(browser);
	return false;
}

bool DKSDLCef::OnMouseOver(const void* input, void* output) {
	DKDEBUGFUNC(input, output);
	DKString str = *(DKString*)input;
	DKStringArray arry;
	toStringArray(arry,str,","); // id,top,left,width,height
	int browser;
	if(!dkCef->GetBrowserNumber(arry[0], browser))
		return DKERROR("browser is invalid\n");
	//work with the browser here
	OnResize(input, NULL);
	dkCef->SetFocus(browser);
	return true; 
}

bool DKSDLCef::OnResize(const void* input, void* output) {
	DKDEBUGFUNC(input, output);
	DKString str = *(DKString*)input;
	DKStringArray arry;
	toStringArray(arry,str,","); // id,top,left,width,height
	//DKINFO("DKSDLCef::OnResize("+arry[0]+","+arry[1]+","+arry[2]+","+arry[3]+","+arry[4]+")\n");
	int browser;
	if(!dkCef->GetBrowserNumber(arry[0], browser))
		return DKERROR("browser is invalid\n");
	if(dkCef->fullscreen){
		dkCef->dkBrowsers[browser].top = 0;
		dkCef->dkBrowsers[browser].left = 0;
		//SDL_DisplayMode displayMode;
		//int display = SDL_GetWindowDisplayIndex(dkSdlWindow->sdlwin);
		//SDL_GetCurrentDisplayMode(display, &displayMode);
		dkCef->dkBrowsers[browser].width = dkSdlWindow->width;//displayMode.w;
		dkCef->dkBrowsers[browser].height = dkSdlWindow->height;//displayMode.h;
	}
	else{
		dkCef->dkBrowsers[browser].top = toInt(arry[1]); //top
		dkCef->dkBrowsers[browser].left = toInt(arry[2]); //left
		dkCef->dkBrowsers[browser].width = toInt(arry[3]); //width
		dkCef->dkBrowsers[browser].height = toInt(arry[4]); //height
	}
	dkCef->dkBrowsers[browser].browser->GetHost()->WasResized();
	dkCef->dkBrowsers[browser].browser->GetHost()->Invalidate(PET_VIEW);
	return true;
}

bool DKSDLCef::SetupCef() {
	DKDEBUGFUNC();
	cefHandler = new DKSDLCefHandler();
	cefHandler->dkSdlWindow = dkSdlWindow;
	cefHandler->dkCef = dkCef;
	cefHandler->dkSdlCef = this;
	dkCef->cefHandler = cefHandler;
	DKApp::AppendLoopFunc(&DKSDLCefHandler::DoFrame, cefHandler);
	//CefRunMessageLoop();
	return true;
}

bool DKSDLCef::TransparentPixel(SDL_Event *event) {
	DKDEBUGFUNC(event);
	// TODO
	/*
	osg::Image* image = cef_image.get();//cefHandler->getImage();
	if (image && image->getPixelFormat()){
		int x = ea.getX();
		int y = ea.getWindowHeight() - ea.getY();
		if (x >= 0 && x < image->s() && y >= 0 && y < image->t()){
			//TODO
			//ImageUtils::PixelReader ia(image);
			//osg::Vec4 color = ia(x, y);
			//return color.a() == 0.0;
		}
	}
	*/
	return false;
}

bool DKSDLCef::Draw() {
	//DKDEBUGFUNC();  //EXCESSIVE LOGGING
	if (DKClass::DKValid("DKRml,DKRml0"))
		return false; //We have a valid DKRml instance, so we are drawing to rml textures instead of striaght to SDL
	if (!cefHandler->cef_texture.size())
		return DKERROR("!cef_texture.size()\n");
	if (!cefHandler->cef_texture[0])
		return DKREDINFO("cefHandler->cef_texture[0] is invalid! \n");

	SDL_Rect texture_rect;
	texture_rect.y = dkCef->dkBrowsers[0].top; // the y coordinate
	texture_rect.x = dkCef->dkBrowsers[0].left;  //the x coordinate
	texture_rect.w = dkCef->dkBrowsers[0].width; //the width of the texture
	texture_rect.h = dkCef->dkBrowsers[0].height; //the height of the texture
	
	SDL_SetRenderTarget(dkSdlWindow->renderer, NULL);
	SDL_RenderCopy(dkSdlWindow->renderer, cefHandler->cef_texture[0], NULL, &texture_rect);
	return true;
}
