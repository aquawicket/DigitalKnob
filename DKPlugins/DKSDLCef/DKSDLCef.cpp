#include "DK/stdafx.h"
#include "SDL_syswm.h"
#include <include/cef_urlrequest.h>
#include "DK/DKApp.h"
#include "DK/DKFile.h"
#include "DK/DKLog.h"
#include "DKSDLCef/DKSDLCef.h"
#ifdef WIN32
#include <delayimp.h>
#include "DK/DKWindows.h"
#endif

/////////////////////
bool DKSDLCef::Init()
{
	DKLog("DKSDLCef::Init()\n",DKDEBUG);

	cef_image = NULL;
	background_image = NULL;
	popup_image = NULL;
	dkSdlWindow = DKSDLWindow::Instance("DKSDLWindow0");
	id = data[1];
	dkCef = DKCef::Get(id);
	if(!dkSdlWindow || !dkCef){
		DKLog("DKOSGRocket::Init(): INVALID OBJECTS \n", DKERROR);
		return false;
	}

	SetupCef();
	_mouseLMBdown = false;
	_scrollFactor = 70.0f;

	DKSDLWindow::AddEventFunc(&DKSDLCef::Handle, this);
	DKSDLWindow::AddDrawFuncFirst(&DKSDLCef::Draw, this);
	DKClass::RegisterFunc(id+"::OnResize", &DKSDLCef::OnResize, this);
	DKClass::RegisterFunc("DKSDLCef::GetTexture::"+id, &DKSDLCef::GetTexture, this);
	return true;
}

////////////////////
bool DKSDLCef::End()
{
	DKLog("DKSDLCef::End()\n", DKDEBUG);

	DKApp::RemoveLoopFunc(&DKSDLCefHandler::DoFrame, cefHandler);
	DKClass::UnregisterFunc(id + "::OnResize");
	DKClass::UnregisterFunc("DKSDLCef::GetTexture::" + id);
	cefHandler = NULL;
	//cef_image = NULL;
	return true;
}



//////////////////////////////////////////////////////////////////////////////////////////
bool DKSDLCef::GetCefMouseButton(const int& button, CefBrowserHost::MouseButtonType& type)
{
	DKLog("DKSDLCef::getCefMouseButton()\n", DKDEBUG);

	if(button == 1){ type = MBT_LEFT; }
	if(button == 2){ type = MBT_MIDDLE; }
	if(button == 3){ type = MBT_RIGHT; }
	return true;
}

//////////////////////////////////////////////////////////////////////////////
bool DKSDLCef::GetScrollDeltas(SDL_Event* event, float &deltaX, float &deltaY)
{
	DKLog("DKSDLCef::getScrollDeltas(SDL_Event*, deltaX, deltaY)\n", DKDEBUG);

	deltaX = 0.0f;
	deltaY = 0.0f;

	if(event->wheel.y > 0){
		deltaY = _scrollFactor;
	}
	if(event->wheel.y < 0){
		deltaY = -_scrollFactor;
	}
	if(event->wheel.x > 0){
		deltaX = -_scrollFactor;
	}
	if(event->wheel.x < 0){
		deltaX = _scrollFactor;
	}

	return deltaX != 0.0f || deltaY != 0.0f;
}

//////////////////////////////////////////////////////////
bool DKSDLCef::GetTexture(const void* input, void* output)
{
	if(!cef_image){
		cef_image = SDL_CreateTexture(dkSdlWindow->sdlren, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_TARGET, dkCef->width, dkCef->height);
	}
	struct DKTexture{ SDL_Texture* texture; };
	DKTexture out = *(DKTexture*)output;
	out.texture = cef_image;
	*(DKTexture*)output = out;
	return true;
}

///////////////////////////////////////
bool DKSDLCef::Handle(SDL_Event* event)
{
	//DKLog("DKSDLCef::handle(SDL_Event*)\n", DKDEBUG);

	if(!dkCef->current_browser){ return false; }

	//DKLog("number_of_browsers = " + toString(dkCef->GetBrowsers()) + "\n", DKDEBUG);
	//DKLog("current_browser = "+toString(dkCef->GetCurrentBrowser())+"\n", DKDEBUG);

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
			int clicks = 1;
			if(event->button.clicks == 2){ // double click
				clicks = 2;
			}
			if(event->button.button == 3){
				_mouseLMBdown = true;
			}
			CefMouseEvent mouse_event;
            mouse_event.x = event->motion.x - dkCef->left;
			mouse_event.y = event->motion.y - dkCef->top;
			if(mouse_event.x < 0){return false;}
			if(mouse_event.x > dkCef->width){return false;}
			if(mouse_event.y < 0){return false;}
			if(mouse_event.y > dkCef->height){return false;}
			dkCef->current_browser->GetHost()->SendFocusEvent(true);
			dkCef->inFocus = true;
			//mouse_event.modifiers = _keyAdapter.getCefModifiers(event->key.keysym.mod);

			CefBrowserHost::MouseButtonType type;
			GetCefMouseButton(event->button.button, type);
			dkCef->current_browser->GetHost()->SendMouseClickEvent(mouse_event, type, false, clicks);
			return true;
		}

		case SDL_MOUSEBUTTONUP:{
			int clicks = 1;
			if(event->button.clicks == 2){ // double click
				clicks = 2;
			}
            if(event->button.button == 3){
				_mouseLMBdown = false;
			}
			CefMouseEvent mouse_event;
            mouse_event.x = event->motion.x - dkCef->left;
			mouse_event.y = event->motion.y - dkCef->top;
			if(mouse_event.x < 0){return false;}
			if(mouse_event.x > dkCef->width){return false;}
			if(mouse_event.y < 0){return false;}
			if(mouse_event.y > dkCef->height){return false;}
			dkCef->current_browser->GetHost()->SendFocusEvent(true);
			dkCef->inFocus = true;
			//mouse_event.modifiers = _keyAdapter.getCefModifiers(event->key.keysym.mod);

			CefBrowserHost::MouseButtonType type;
			GetCefMouseButton(event->button.button, type);
			dkCef->current_browser->GetHost()->SendMouseClickEvent(mouse_event, type, true, clicks);
 
			return true;
		}

		/*
		case SDL_TEXTINPUT:{
			DKLog("SDL_TEXTINPUT: event->text.text = "+toString(event->text.text)+"\n", DKINFO);
		}
		*/
		
		case SDL_KEYDOWN:{
			if(!dkCef->inFocus){ return false; }
			
			//print SDL2 key data
			/*
			DKLog("SDL_KEYDOWN: event->key.keysym.sym = "+toString(event->key.keysym.sym)+"\n", DKINFO);
			DKLog("SDL_KEYDOWN: event->key.keysym.scancode = "+toString(event->key.keysym.scancode)+"\n", DKINFO);
			DKLog("SDL_KEYDOWN: sdlKeyCode[event->key.keysym.sym] = "+toString(DKSDLWindow::sdlKeyCode[event->key.keysym.sym])+"\n", DKINFO);
			DKLog("SDL_KEYDOWN: sdlCharCode[event->key.keysym.sym] = "+toString(DKSDLWindow::sdlCharCode[event->key.keysym.sym])+"\n", DKINFO);
			DKLog("SDL_KEYDOWN: sdlShiftCharCode[event->key.keysym.sym] = "+toString(DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym])+"\n", DKINFO);
			*/
			
			CefKeyEvent KeyEvent;
       		KeyEvent.type = KEYEVENT_KEYDOWN;
			//KeyEvent.type = KEYEVENT_RAWKEYDOWN;
			KeyEvent.windows_key_code = DKSDLWindow::sdlKeyCode[event->key.keysym.sym];
#ifdef MAC
			KeyEvent.native_key_code = DKSDLWindow::sdlMacCode[event->key.keysym.sym];
#endif
			//KeyEvent.unmodified_character = DKSDLWindow::sdlKeyCode[event->key.keysym.sym];
       		KeyEvent.modifiers = _keyAdapter.getCefModifiers(event->key.keysym.mod);
		
			//DKLog("RAWKEYDOWN: windows_key_code = "+toString(KeyEvent.windows_key_code)+"\n", DKINFO);
			//DKLog("RAWKEYDOWN: modifiers = "+toString(KeyEvent.modifiers)+"\n", DKINFO);
      		dkCef->current_browser->GetHost()->SendKeyEvent(KeyEvent);

			CefKeyEvent charKeyEvent;
       		charKeyEvent.type = KEYEVENT_CHAR;
       		charKeyEvent.modifiers = _keyAdapter.getCefModifiers(event->key.keysym.mod);
      		
			if(event->key.keysym.sym > 96 && event->key.keysym.sym < 123){ //letter
				if(event->key.keysym.mod & KMOD_SHIFT && event->key.keysym.mod & KMOD_CAPS){ //both = lowercase
					charKeyEvent.windows_key_code = DKSDLWindow::sdlCharCode[event->key.keysym.sym];
					charKeyEvent.character = DKSDLWindow::sdlCharCode[event->key.keysym.sym];
				}
				else if(event->key.keysym.mod & KMOD_SHIFT || event->key.keysym.mod & KMOD_CAPS){ //1 = uppercase
					charKeyEvent.windows_key_code = DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym];
					charKeyEvent.character = DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym];
				}
				else{
					charKeyEvent.windows_key_code = DKSDLWindow::sdlCharCode[event->key.keysym.sym]; // lowercase
					charKeyEvent.character = DKSDLWindow::sdlCharCode[event->key.keysym.sym];
				}
			}
			else if(event->key.keysym.mod & KMOD_SHIFT){ //other character keys
				charKeyEvent.windows_key_code = DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym]; //shifted symbol
				charKeyEvent.character = DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym]; //shifted symbol
			}
			else{
				charKeyEvent.windows_key_code = DKSDLWindow::sdlCharCode[event->key.keysym.sym]; //symbol
				charKeyEvent.character = DKSDLWindow::sdlCharCode[event->key.keysym.sym]; //symbol
			}

			//DKLog("CHAR: windows_key_code = "+toString(charKeyEvent.windows_key_code)+"\n", DKINFO);
			//DKLog("CHAR: modifiers = "+toString(charKeyEvent.modifiers)+"\n", DKINFO);
			dkCef->current_browser->GetHost()->SendKeyEvent(charKeyEvent);
			return true;
		}

		case SDL_KEYUP:{
			CefKeyEvent KeyEvent;
       		KeyEvent.type = KEYEVENT_KEYUP;
			KeyEvent.windows_key_code = DKSDLWindow::sdlKeyCode[event->key.keysym.sym];
#ifdef MAC
			KeyEvent.native_key_code = DKSDLWindow::sdlMacCode[event->key.keysym.sym];
#endif
			//KeyEvent.unmodified_character = DKSDLWindow::sdlKeyCode[event->key.keysym.sym];
       		KeyEvent.modifiers = _keyAdapter.getCefModifiers(event->key.keysym.mod);

			//DKLog("KEYUP: windows_key_code = "+toString(KeyEvent.windows_key_code)+"\n", DKINFO);
			//DKLog("KEYUP: modifiers = "+toString(KeyEvent.modifiers)+"\n", DKINFO);
#ifndef MAC
      		dkCef->current_browser->GetHost()->SendKeyEvent(KeyEvent);
#endif
			return true;
		}

		case SDL_MOUSEMOTION:{
			/*
			if(event->motion.state & SDL_BUTTON_LMASK){
				_mouseLMBdown = true;
				DKLog("SDL_MOUSEMOTION: _mouseLMBdown = true \n", DKINFO);
			}
			else{
				_mouseLMBdown = false;
				DKLog("SDL_MOUSEMOTION: _mouseLMBdown = false \n", DKINFO);
			}
			*/

			CefMouseEvent mouse_event;
			mouse_event.x = event->motion.x - dkCef->left;
			mouse_event.y = event->motion.y - dkCef->top;
			//DKLog("Mouse: X="+toString(mouse_event.x)+" Y="+toString(mouse_event.y)+" \n", DKINFO);
			uint32 modifiers = _keyAdapter.getCefModifiers(event->key.keysym.mod);

			if (SDL_GetMouseState(NULL, NULL) & SDL_BUTTON_LMASK)
				modifiers |= EVENTFLAG_LEFT_MOUSE_BUTTON;
			if (SDL_GetMouseState(NULL, NULL) & SDL_BUTTON_MMASK)
				modifiers |= EVENTFLAG_MIDDLE_MOUSE_BUTTON;
			if (SDL_GetMouseState(NULL, NULL) & SDL_BUTTON_RMASK)
				modifiers |= EVENTFLAG_RIGHT_MOUSE_BUTTON;
	
			mouse_event.modifiers = modifiers;
			dkCef->current_browser->GetHost()->SendMouseMoveEvent(mouse_event, false);
			return true;
		}

		case SDL_MOUSEWHEEL:{
			float deltaX, deltaY;
			if(GetScrollDeltas(event, deltaX, deltaY)){
				CefMouseEvent mouse_event;
				int mouseX;
				int mouseY;
				SDL_GetMouseState(&mouseX, &mouseY);
				mouse_event.x = mouseX - dkCef->left;
				mouse_event.y = mouseY - dkCef->top;
				//DKLog("Mouse: X="+toString(mouse_event.x)+" Y="+toString(mouse_event.y)+" \n", DKINFO);
				//uint32 modifiers = _keyAdapter.getCefModifiers(event->key.keysym.mod);
				dkCef->current_browser->GetHost()->SendMouseWheelEvent(mouse_event, (int)deltaX, (int)deltaY);
			}
			return true;
		}
	}
	return false;
}

////////////////////////////////////////////////////////
bool DKSDLCef::OnResize(const void* input, void* output)
{
	DKLog("DKSDLCef::OnResize(void*)\n", DKDEBUG);

	//DKString str = *static_cast<DKString*>(data);
	DKString str = *(DKString*)input;

	//DKLog("DKSDLCef::OnResize("+str+")\n", DKWARN);

	DKStringArray arry;
	toStringArray(arry,str,",");
	if(dkCef->fullscreen){
		dkCef->top = 0;
		dkCef->left = 0;
		//SDL_DisplayMode displayMode;
		//int display = SDL_GetWindowDisplayIndex(dkSdlWindow->sdlwin);
		//SDL_GetCurrentDisplayMode(display, &displayMode);
		dkCef->width = dkSdlWindow->width;//displayMode.w;
		dkCef->height = dkSdlWindow->height;//displayMode.h;
	}
	else{
		dkCef->top = toInt(arry[0]);
		dkCef->left = toInt(arry[1]);
		dkCef->width = toInt(arry[2]);
		dkCef->height = toInt(arry[3]);
	}

	for(unsigned int i = 0; i < dkCef->browsers.size(); ++i){
		dkCef->browsers[i]->GetHost()->WasResized();
	}

	return true;
}

/////////////////////////
bool DKSDLCef::SetupCef()
{
	DKLog("DKSDLCef::SetupCef()\n", DKDEBUG);

	cefHandler = new DKSDLCefHandler();
	cefHandler->dkSdlWindow = dkSdlWindow;
	cefHandler->dkCef = dkCef;
	cefHandler->dkSdlCef = this;
	dkCef->cefHandler = cefHandler;
	dkCef->NewBrowser();
	DKApp::AppendLoopFunc(&DKSDLCefHandler::DoFrame, cefHandler);
	return true;
}

/////////////////////////////////////////////////
bool DKSDLCef::TransparentPixel(SDL_Event *event)
{
	DKLog("DKSDLCef::transparentPixel(SDL_Event*)\n", DKDEBUG);

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

/////////////////////
void DKSDLCef::Draw()
{
	//DKLog("DKSDLCef::Draw()\n", DKDEBUG);

	//NOTE: For single browser apps, we need to intercept DKCef_OnQueueNewBrowser in javascript
	//      and set url of the current_browser. All urls, will be directed to the same target.
	//      For multiple browser apps, we need to intercept DKCef_OnQueueNewBrowser in javascript
	//      and create a new browser(TAB) to put the url in.
	if(!dkCef->queue_new_browser.empty()){
		DKEvent::SendEvent("GLOBAL", "DKCef_OnQueueNewBrowser", dkCef->queue_new_browser);
		dkCef->queue_new_browser = "";
	}


	if(DKClass::DKValid("DKRocket,DKRocket0")){ return; }
	///// Draw to SDL Directly
	if(!cef_image){ return; }
	SDL_Rect texture_rect;
	texture_rect.y = dkCef->top; // the y coordinate
	texture_rect.x = dkCef->left;  //the x coordinate
	texture_rect.w = dkCef->width; //the width of the texture
	texture_rect.h = dkCef->height; //the height of the texture
	SDL_RenderCopy(dkSdlWindow->sdlren, cef_image, NULL, &texture_rect);
}