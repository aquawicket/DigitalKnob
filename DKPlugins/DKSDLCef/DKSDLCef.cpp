#include "stdafx.h"
#include "DKSDLCef.h"
#include "DKApp.h"
#include "DKLog.h"
#include "SDL_syswm.h"

#ifdef WIN32
#include <delayimp.h>
#include "DKWindows.h"
#endif

#include "DKFile.h"
#include <include/cef_urlrequest.h>

/////////////////////
void DKSDLCef::Init()
{
	DKLog("DKSDLCef::Init()\n",DKFILTER);

	cef_image = NULL;
	background_image = NULL;
	popup_image = NULL;
	dkSdlWindow = DKSDLWindow::Instance("DKSDLWindow0");
	id = data[1];
	dkCef = DKCef::Get(id);
	if(!dkSdlWindow || !dkCef){
		DKLog("DKOSGRocket::Init(): INVALID OBJECTS \n", DKERROR);
		return;
	}

	SetupCef();
	_mouseLMBdown = false;
	_scrollFactor = 70.0f;

	DKSDLWindow::AddEventFunc(&DKSDLCef::handle, this);
	DKSDLWindow::AddDrawFuncFirst(&DKSDLCef::Draw, this);
	DKClass::RegisterFunc(id+"::OnResize", &DKSDLCef::OnResize, this);
	DKClass::RegisterFunc("DKSDLCef::GetTexture::"+id, &DKSDLCef::GetTexture, this);
}

////////////////////
void DKSDLCef::End()
{
	DKLog("DKSDLCef::End()\n", DKFILTER);

	DKApp::RemoveLoopFunc(&DKSDLCefHandler::DoFrame, cefHandler);
	DKClass::UnregisterFunc(id + "::OnResize");
	DKClass::UnregisterFunc("DKSDLCef::GetTexture::" + id);
	cefHandler = NULL;
	//cef_image = NULL;
}

////////////////////////////////////
void* DKSDLCef::OnResize(void* data)
{
	DKLog("DKSDLCef::OnResize(void*)\n", DKFILTER);

	DKString str = *static_cast<DKString*>(data);

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

	return NULL;
}

/////////////////////////////////
void* DKSDLCef::GetTexture(void*)
{
	//DKLog("DKSDLCef::GetTexture(void*)\n", DKFILTER);

	if(!cef_image){
		cef_image = SDL_CreateTexture(dkSdlWindow->sdlren, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_TARGET, dkCef->width, dkCef->height);
	}
	return static_cast<void*>(cef_image);
}

/////////////////////////
void DKSDLCef::SetupCef()
{
	DKLog("DKSDLCef::SetupCef()\n", DKFILTER);

	//Top spacer for url bar
	cefHandler = new DKSDLCefHandler();
	cefHandler->dkSdlWindow = dkSdlWindow;
	cefHandler->dkCef = dkCef;
	cefHandler->dkSdlCef = this;
	dkCef->cefHandler = cefHandler;
	dkCef->NewBrowser();
	DKApp::AppendLoopFunc(&DKSDLCefHandler::DoFrame, cefHandler);
}

///////////////////////////////////////////////////////////////////////
CefBrowserHost::MouseButtonType DKSDLCef::getCefMouseButton(int button)
{
	DKLog("DKSDLCef::getCefMouseButton("+toString(button)+")\n", DKFILTER);

	if(button == 1){ return MBT_LEFT; }
	if(button == 2){ return MBT_MIDDLE; }
	/*if(button == 3){*/ return MBT_RIGHT; //}
}

///////////////////////////////////////
bool DKSDLCef::handle(SDL_Event* event)
{
	//DKLog("DKSDLCef::handle(SDL_Event*)\n", DKFILTER);

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

			dkCef->current_browser->GetHost()->SendMouseClickEvent(mouse_event, getCefMouseButton(event->button.button), false, 1);
			return true;
		}

		case SDL_MOUSEBUTTONUP:{
			if(event->button.clicks == 2){ // double click
					return true;
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
			dkCef->current_browser->GetHost()->SendMouseClickEvent(mouse_event, getCefMouseButton(event->button.button), true, 1);
 
			return true;
		}

		case SDL_KEYDOWN:{
			if(!dkCef->inFocus){ return false; }
			CefKeyEvent KeyEvent;
       		KeyEvent.type = KEYEVENT_KEYDOWN;
			KeyEvent.windows_key_code = DKSDLWindow::sdlKeyCode[event->key.keysym.sym];
       		KeyEvent.modifiers = _keyAdapter.getCefModifiers(event->key.keysym.mod);
      		dkCef->current_browser->GetHost()->SendKeyEvent(KeyEvent);

			CefKeyEvent charKeyEvent;
       		charKeyEvent.type = KEYEVENT_CHAR;
       		charKeyEvent.modifiers = _keyAdapter.getCefModifiers(event->key.keysym.mod);
      		
			if(event->key.keysym.sym > 96 && event->key.keysym.sym < 123){ //letter
				if(event->key.keysym.mod & KMOD_SHIFT && event->key.keysym.mod & KMOD_CAPS){ //both = lowercase
					charKeyEvent.windows_key_code = DKSDLWindow::sdlCharCode[event->key.keysym.sym];
				}
				else if(event->key.keysym.mod & KMOD_SHIFT || event->key.keysym.mod & KMOD_CAPS){ //1 = uppercase
					charKeyEvent.windows_key_code = DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym];
				}
				else{
					charKeyEvent.windows_key_code = DKSDLWindow::sdlCharCode[event->key.keysym.sym]; // lowercase
				}
			}
			else if(event->key.keysym.mod & KMOD_SHIFT){ //other character keys
				charKeyEvent.windows_key_code = DKSDLWindow::sdlShiftCharCode[event->key.keysym.sym]; //shifted symbol
			}
			else{
				charKeyEvent.windows_key_code = DKSDLWindow::sdlCharCode[event->key.keysym.sym]; //symbol
			}

			dkCef->current_browser->GetHost()->SendKeyEvent(charKeyEvent);
			return true;
		}

		case SDL_KEYUP:{
			CefKeyEvent KeyEvent;
       		KeyEvent.type = KEYEVENT_KEYUP;
			KeyEvent.windows_key_code = DKSDLWindow::sdlKeyCode[event->key.keysym.sym];
       		KeyEvent.modifiers = _keyAdapter.getCefModifiers(event->key.keysym.mod);
      		dkCef->current_browser->GetHost()->SendKeyEvent(KeyEvent);
			return true;
		}

		case SDL_MOUSEMOTION:{
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
			if(getScrollDeltas(event, deltaX, deltaY)){
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

/////////////////////
void DKSDLCef::Draw()
{
	//DKLog("DKSDLCef::Draw()\n", DKFILTER);

	//NOTE: For single browser apps, we need to intercept DKCef_OnQueueNewBrowser in javascript
	//      and set url of the current_browser. All urls, will be directed to the same target.
	//      For multiple browser apps, we need to intercept DKCef_OnQueueNewBrowser in javascript
	//      and create a new browser(TAB) to put the url in.
	if(!dkCef->queue_new_browser.empty()){
		DKEvent::SendEvent("GLOBAL", "DKCef_OnQueueNewBrowser", dkCef->queue_new_browser);
		dkCef->queue_new_browser = "";
	}

	/*
	///// Draw to SDL Directly
	if(!cef_image){ return; }
	SDL_Rect texture_rect;
	texture_rect.y = dkCef->top; // the y coordinate
	texture_rect.x = dkCef->left;  //the x coordinate
	texture_rect.w = dkCef->width; //the width of the texture
	texture_rect.h = dkCef->height; //the height of the texture

	SDL_RenderCopy(dkSdlWindow->sdlren, cef_image, NULL, &texture_rect);
	*/
}

//////////////////////////////////////////////////////////////////////////////
bool DKSDLCef::getScrollDeltas(SDL_Event* event, float &deltaX, float &deltaY)
{
	DKLog("DKSDLCef::getScrollDeltas(SDL_Event*, deltaX, deltaY)\n", DKFILTER);

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

/////////////////////////////////////////////////
bool DKSDLCef::transparentPixel(SDL_Event *event)
{
	DKLog("DKSDLCef::transparentPixel(SDL_Event*)\n", DKFILTER);

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