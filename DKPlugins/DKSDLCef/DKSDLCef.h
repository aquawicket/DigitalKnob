#pragma once
#ifndef DKSDLCef_H
#define DKSDLCef_H

#include <include/cef_client.h>
#include <include/cef_render_handler.h>
#include <include/cef_browser_process_handler.h>
#include <include/cef_display_handler.h>
#include "SDL.h"

#include "DK/DK.h"
#include "DK/DKApp.h"
#include "DKCef/DKCef.h"
#include "DKSDLCef/DKSDLCefKeyboard.h"
#include "DKSDLWindow/DKSDLWindow.h"

#ifndef WIN32
#define  UNREFERENCED_PARAMETER(P) (P)
#endif

#ifdef LINUX
//#include <X11/cursorfont.h>
#endif

class DKSDLCefHandler;

///////////////////////////////////////////
class DKSDLCef : public DKObjectT<DKSDLCef>
{
public:
	bool Init();
	bool End();

	bool GetCefMouseButton(const int& button, CefBrowserHost::MouseButtonType& type);
	bool GetScrollDeltas(SDL_Event *event, float &deltaX, float &deltaY);
	bool GetTexture(const void* input, void* output);
	bool Handle(SDL_Event *event);
	bool OnResize(const void* input, void* output);
	bool SetupCef();
	bool TransparentPixel(SDL_Event *event);
	void Draw();
	
	DKSDLWindow* dkSdlWindow;
	DKCef* dkCef;
	DKString id;
	bool _mouseLMBdown;
	DKSDLCefKeyboard _keyAdapter;
	float _scrollFactor;

	SDL_Texture* cef_image;
	SDL_Texture* background_image;
	SDL_Texture* popup_image;
	CefRect popup_rect;
	DKSDLCefHandler* cefHandler;
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class DKSDLCefHandler : public CefClient, public CefRenderHandler, public CefLoadHandler, public CefLifeSpanHandler, 
						public CefContextMenuHandler, public CefDownloadHandler, public CefDisplayHandler
{
public:
	DKSDLCefHandler(){}
	DKSDLWindow* dkSdlWindow;
	DKCef* dkCef;
	DKSDLCef* dkSdlCef;

	virtual CefRefPtr<CefContextMenuHandler> GetContextMenuHandler(){ return this; }
	virtual CefRefPtr<CefDisplayHandler> GetDisplayHandler(){ return this; }
	virtual CefRefPtr<CefDownloadHandler> GetDownloadHandler(){ return this; }
	virtual CefRefPtr<CefLifeSpanHandler> GetLifeSpanHandler(){ return this; }
	virtual CefRefPtr<CefLoadHandler> GetLoadHandler(){ return this; }
	virtual CefRefPtr<CefRenderHandler> GetRenderHandler(){ return this; }
	
	/////////////////////////////////////////
	void DoFrame()
	{ 
		//FIXME: this breaks SDL keyboard events for Mac OSX
		CefDoMessageLoopWork(); 
	}

	//////////////////////////////////////////////////////////////
	bool GetViewRect(CefRefPtr<CefBrowser> browser, CefRect& rect)
	{
		DKLog("DKSDLCefHandler::GetViewRect(CefBrowser, CefRect&)\n", DKDEBUG);
		
		rect = CefRect(0, 0, dkCef->width, dkCef->height);
		return true;
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnPaint(CefRefPtr<CefBrowser> browser, PaintElementType type, const RectList &dirtyRects, const void *buffer, int width, int height)
	{
		//DKLog("DKSDLCefHandler::OnPaint()\n", DKDEBUG);

		if(browser->GetIdentifier() != dkCef->current_browser->GetIdentifier()){ return; }
		if(type == PET_VIEW){
			if(dirtyRects.size() == 0){ return; }
			
			int w, h;
			SDL_QueryTexture(dkSdlCef->cef_image, NULL, NULL, &w, &h);
			if(w != width || h != height){
				dkSdlCef->cef_image = SDL_CreateTexture(dkSdlWindow->sdlren, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_TARGET, width, height);
			}

			if (!dkSdlCef->background_image) {
				dkSdlCef->background_image = SDL_CreateTexture(dkSdlWindow->sdlren, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STREAMING, width, height);
			}
			int w2, h2;
			SDL_QueryTexture(dkSdlCef->background_image, NULL, NULL, &w2, &h2);
			if (w2 != width || h2 != height) {
				dkSdlCef->background_image = SDL_CreateTexture(dkSdlWindow->sdlren, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STREAMING, width, height);
			}

			unsigned char * texture_data = NULL;
			int texture_pitch = 0;
			if(SDL_LockTexture(dkSdlCef->background_image, NULL, (void **)&texture_data, &texture_pitch) == 0){
				//copies whole cef bitmap to sdl texture
				std::memcpy(texture_data, buffer, width * height * 4);
				SDL_UnlockTexture(dkSdlCef->background_image);
			}
		}
		
		else if(type == PET_POPUP){ //FIXME
			//if(dirtyRects.size() == 0){ return; }
			if(!dkSdlCef->popup_image){
				dkSdlCef->popup_image = SDL_CreateTexture(dkSdlWindow->sdlren, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STREAMING, width, height);
			}
			int w, h;
			SDL_QueryTexture(dkSdlCef->popup_image, NULL, NULL, &w, &h);
			if(w != width || h != height){
				dkSdlCef->popup_image = SDL_CreateTexture(dkSdlWindow->sdlren, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STREAMING, width, height);
			}
			void* mPixels;
			int mPitch;
			if(SDL_LockTexture(dkSdlCef->popup_image, NULL, &mPixels, &mPitch) == 0){
				//copies popup bitmap to sdl texture
				std::memcpy(mPixels, buffer, width * height * 4);
				SDL_UnlockTexture(dkSdlCef->popup_image);
			}
		}

		if(dkSdlCef->cef_image) {	
			SDL_SetRenderTarget(dkSdlWindow->sdlren, dkSdlCef->cef_image);
			SDL_RenderCopy(dkSdlWindow->sdlren, dkSdlCef->background_image, NULL, NULL);
			if(dkSdlCef->popup_image){
				SDL_Rect popup;
				popup.x = dkSdlCef->popup_rect.x;
				popup.y = dkSdlCef->popup_rect.y;
				popup.w = dkSdlCef->popup_rect.width;
				popup.h = dkSdlCef->popup_rect.height;
				SDL_RenderCopy(dkSdlWindow->sdlren, dkSdlCef->popup_image, NULL, &popup);	
			}
			SDL_SetRenderTarget(dkSdlWindow->sdlren, NULL);
		}
	}

	//////////////////////////////////////////////////////////
	void OnPopupShow(CefRefPtr<CefBrowser> browser, bool show)
	{
		DKLog("DKSDLCefHandler::OnPopupShow()\n", DKDEBUG);

		if(!show){
			dkSdlCef->popup_image = NULL;
			return;
		}
	}

	////////////////////////////////////////////////////////////////////
	void OnPopupSize(CefRefPtr<CefBrowser> browser, const CefRect& rect)
	{
		DKLog("DKSDLCefHandler::OnPopupSize()\n", DKDEBUG);

		if(rect.width <= 0 || rect.height <= 0){ return; }
		dkSdlCef->popup_rect = rect;
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnLoadingStateChange(CefRefPtr<CefBrowser> browser, bool isLoading, bool canGoBack, bool canGoForward)
	{
		DKLog("DKSDLCefHandler::OnLoadingStateChange("+toString(isLoading)+","+toString(canGoBack)+","+toString(canGoForward)+")\n", DKDEBUG);

		for(unsigned int i=0; i<dkCef->browsers.size(); ++i){
			if(browser->GetIdentifier() == dkCef->browsers[i]->GetIdentifier()){
				DKEvent::SendEvent("GLOBAL", "DKCef_OnLoadingStateChange", toString(i));
				return;
			}
		}
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnLoadError(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefLoadHandler::ErrorCode errorCode, const CefString& errorText, const CefString& failedUrl)
	{ 
		DKLog("DKSDLCefHandler::OnLoadError("+toString(errorCode)+","+errorText.ToString()+","+failedUrl.ToString()+")\n", DKDEBUG);

		DKEvent::SendEvent("GLOBAL", "DKCef_OnLoadError", toString(errorCode));
	}

	///////////////////////////////////////////////////////////////////////////
	void OnFullscreenModeChange(CefRefPtr<CefBrowser> browser, bool fullscreen)
	{
		DKLog("DKSDLCefHandler::OnFullscreenModeChange()\n", DKDEBUG);

		if(fullscreen){
			dkCef->fullscreen = true;
			//SDL_SetWindowFullscreen(dkSdlWindow->sdlwin, SDL_WINDOW_FULLSCREEN_DESKTOP);
		}
		else{
			dkCef->fullscreen = false;
			//SDL_SetWindowFullscreen(dkSdlWindow->sdlwin, 0);
		}
		DKEvent::SendEvent("GLOBAL", "DKCef_OnFullscreen", toString(fullscreen));
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool OnBeforePopup(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, const CefString& target_url, const CefString& target_frame_name, CefLifeSpanHandler::WindowOpenDisposition target_disposition, bool user_gesture, const CefPopupFeatures& popupFeatures, CefWindowInfo& windowInfo, CefRefPtr<CefClient>& client, CefBrowserSettings& settings, bool* no_javascript_access)
	{
		DKLog("DKSDLCefHandler::OnBeforePopup("+target_url.ToString()+","+target_frame_name.ToString()+","+toString(target_disposition)+")\n", DKDEBUG);

		//DKEvent::SendEvent("GLOBAL", "DKCef_OnBeforePopup", target_url);
		if(target_disposition == WOD_NEW_FOREGROUND_TAB){
			dkCef->queue_new_browser = target_url;
		}
		else{
			dkCef->current_browser->GetMainFrame()->LoadURL(target_url.c_str());
		}
		return true;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnBeforeDownload(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDownloadItem> download_item, const CefString& suggested_name, CefRefPtr<CefBeforeDownloadCallback> callback)
	{
		DKLog("DKSDLCefHandler::OnBeforeDownload("+suggested_name.ToString()+")\n", DKDEBUG);

		//DKLog("OriginalUrl: "+download_item->GetOriginalUrl().ToString()+")\n", DKDEBUG);
		UNREFERENCED_PARAMETER(browser);
		UNREFERENCED_PARAMETER(download_item);
		callback->Continue(suggested_name, true);
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnBeforeContextMenu(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, CefRefPtr<CefMenuModel> model)
	{
		DKLog("DKSDLCefHandler::OnBeforeContextMenu("+dkCef->id+")\n", DKDEBUG);

		model->Clear(); //remove original context menu
		
		DKString data;
		data += params->GetSelectionText();
		data += ",";
		data += params->GetSourceUrl();
		data += ",";
		data += params->GetLinkUrl();

		DKEvent::SendEvent("GLOBAL", "DKCef_ContextMenu", data);
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool OnConsoleMessage(CefRefPtr<CefBrowser> browser, const CefString& message, const CefString& source, int line )
	{
		DKString msg = message.ToString();
		replace(msg, "%c", "");
		//DKLog("DKSDLCefHandler::OnConsoleMessage("+msg+","+source.ToString()+","+toString(line)+")\n", DKDEBUG);
		DKString string = message.ToString();
		replace(string,"%c","");
		DKLog("[CEF] "+string+"\n", DKINFO);
		return true;
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnCursorChange(CefRefPtr<CefBrowser> browser, CefCursorHandle cursor, CursorType type, const CefCursorInfo& custom_cursor_info)
	{
		//FIXME
		//DKLog("OnCursorChange()\n", DKINFO);
#ifdef WIN32
		HWND hwnd;
		if(!DKClass::CallFunc("DKSDLWindow::GetHwnd", NULL, &hwnd)){ return; }
		if(!::IsWindow(hwnd)){ return; }
		SetClassLongPtr(hwnd, GCLP_HCURSOR, static_cast<LONG>(reinterpret_cast<LONG_PTR>(cursor)));
		SetCursor(cursor);
#endif
#ifdef LINUX
		//Display* dpy;// = glfwGetX11Display();
		//Cursor c;
		//c = XCreateFontCursor(dpy, XC_xterm); 
		//XDefineCursor(dpy, w, c);
#endif
	}

	//////////////////////////////////////////////////////
	bool OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefProcessId source_process, CefRefPtr<CefProcessMessage> message) 
	{
		//DKLog("DKSDLCefHandler::OnProcessMessageReceived()\n", DKINFO);
		
		if(message->GetName() == "GetFunctions"){
			//DKLog("DKSDLCefHandler::OnProcessMessageReceived(GetFunctions)\n", DKINFO);
			DKV8::GetFunctions(browser);
		}
		
		if(has(message->GetName(),"CallFunc(")){
			//DKLog("DKSDLCefHandler::OnProcessMessageReceived(CallFunc)\n", DKINFO);
		
			//get function name
			DKString func = message->GetName();
			replace(func,"CallFunc(", "");
			replace(func,")", "");

			//get arguments
			CefRefPtr<CefListValue> arguments = message->GetArgumentList();
			DKV8::Execute(browser, func, arguments);
		}

		return false;
	}

	IMPLEMENT_REFCOUNTING(DKSDLCefHandler);
};

REGISTER_OBJECT(DKSDLCef, true);

#endif //DKSDLCef_H