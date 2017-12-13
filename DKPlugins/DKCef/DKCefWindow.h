#pragma once
#ifndef DKCefWindow_H
#define DKCefWindow_H

#ifdef LINUX
#include <gdk/gdk.h>
#endif

#include "DKCef/DKCef.h"
class DKCef;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class DKCefWindow : public CefClient, public CefRenderHandler, public CefLoadHandler, public CefLifeSpanHandler, 
					 public CefContextMenuHandler, public CefDownloadHandler, public CefDisplayHandler, 
	                 public CefKeyboardHandler, public CefGeolocationHandler, public CefFindHandler
{
public:
	DKCefWindow();
	bool TestInt(void* input, void* output);
	bool TestString(void* input, void* output);
	bool TestReturnInt(void* input, void* output);
	bool TestReturnString(void* input, void* output);
	
	bool Hide(void* input, void* output);
	bool IsVisible(void* input, void* output);
	bool Minimize(void* input, void* output);
	bool Restore(void* input, void* output);
	bool SetIcon(void* input, void* output);
	bool Show(void* input, void* output);

	DKCef* dkCef;
#ifdef WIN32
	WINDOWPLACEMENT g_wpPrev = { sizeof(g_wpPrev) };
#endif

	virtual CefRefPtr<CefContextMenuHandler> GetContextMenuHandler(){ return this; }
	virtual CefRefPtr<CefDisplayHandler> GetDisplayHandler(){ return this; }
	virtual CefRefPtr<CefDownloadHandler> GetDownloadHandler(){ return this; }
	virtual CefRefPtr<CefGeolocationHandler> GetGeolocationHandler() { return this; }
	virtual CefRefPtr<CefKeyboardHandler> GetKeyboardHandler() { return this; }
	virtual CefRefPtr<CefLifeSpanHandler> GetLifeSpanHandler(){ return this; }
	virtual CefRefPtr<CefLoadHandler> GetLoadHandler(){ return this; }
	//virtual CefRefPtr<CefRenderHandler> GetRenderHandler(){ return this; }
	virtual CefRefPtr<CefFindHandler> GetFindHandler(){ return this; }
	
	//////////////
	void DoFrame()
	{ 
		//FIXME: this breaks SDL keyboard events for Mac OSX
		CefDoMessageLoopWork(); 
	}

	///////////////////////////////////////////
	bool DoClose(CefRefPtr<CefBrowser> browser);


	//////////////////////////////////////////////////////////////
	bool GetViewRect(CefRefPtr<CefBrowser> browser, CefRect& rect)
	{
		DKLog("DKCefWindow::GetViewRect(CefBrowser, CefRect&)\n", DKDEBUG);
		
		//rect = CefRect(0, 0, dkCef->width, dkCef->height);
		return true;
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnPaint(CefRefPtr<CefBrowser> browser, PaintElementType type, const RectList &dirtyRects, const void *buffer, int width, int height)
	{
		//Test drawing text to screen
		HWND hwnd = browser->GetHost()->GetWindowHandle();
		HDC hdc = GetDC(hwnd);
		RECT rect;
		GetClientRect(hwnd, &rect);
		char * text = "this is a text string";
		DrawTextA(hdc, text, strlen(text), &rect, DT_CENTER | DT_VCENTER);
		ReleaseDC(hwnd, hdc);

		DKLog("DKCefWindow::OnPaint()\n", DKDEBUG);
	}

	//////////////////////////////////////////////////////////
	void OnPopupShow(CefRefPtr<CefBrowser> browser, bool show)
	{
		DKLog("DKCefWindow::OnPopupShow()\n", DKDEBUG);
	}

	////////////////////////////////////////////////////////////////////
	void OnPopupSize(CefRefPtr<CefBrowser> browser, const CefRect& rect)
	{
		DKLog("DKCefWindow::OnPopupSize()\n", DKDEBUG);
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnLoadingStateChange(CefRefPtr<CefBrowser> browser, bool isLoading, bool canGoBack, bool canGoForward)
	{
		DKLog("DKCefWindow::OnLoadingStateChange("+toString(isLoading)+","+toString(canGoBack)+","+toString(canGoForward)+")\n", DKDEBUG);
		
		//for (unsigned int i = 0; i<dkCef->browsers.size(); ++i) {
			//if (browser->GetIdentifier() == dkCef->browsers[i]->GetIdentifier()) {
				DKEvent::SendEvent("GLOBAL", "DKCef_OnLoadingStateChange", toString(0));
				return;
			///}
		//}
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnLoadError(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefLoadHandler::ErrorCode errorCode, const CefString& errorText, const CefString& failedUrl)
	{ 
		CEF_REQUIRE_UI_THREAD();
		DKLog("DKCefWindow::OnLoadError("+toString(errorCode)+","+errorText.ToString()+","+failedUrl.ToString()+")\n", DKDEBUG);
	}

	///////////////////////////////////////////////////////////////////////////
	void OnFullscreenModeChange(CefRefPtr<CefBrowser> browser, bool fullscreen)
	{
		DKLog("DKCefWindow::OnFullscreenModeChange()\n", DKINFO);

#ifdef WIN32
		HWND hwnd = GetActiveWindow();

		DWORD dwStyle = GetWindowLong(hwnd, GWL_STYLE);
		if(dwStyle & WS_OVERLAPPEDWINDOW){
			MONITORINFO mi = { sizeof(mi) };
			if(GetWindowPlacement(hwnd, &g_wpPrev) && GetMonitorInfo(MonitorFromWindow(hwnd, MONITOR_DEFAULTTOPRIMARY), &mi)){
				SetWindowLong(hwnd, GWL_STYLE, dwStyle & ~WS_OVERLAPPEDWINDOW);
					SetWindowPos(hwnd, HWND_TOP,
						 mi.rcMonitor.left, mi.rcMonitor.top,
						 mi.rcMonitor.right - mi.rcMonitor.left,
						 mi.rcMonitor.bottom - mi.rcMonitor.top,
						SWP_NOOWNERZORDER | SWP_FRAMECHANGED);
			}
		} 
		else{
			SetWindowLong(hwnd, GWL_STYLE, dwStyle | WS_OVERLAPPEDWINDOW);
			SetWindowPlacement(hwnd, &g_wpPrev);
			SetWindowPos(hwnd, NULL, 0, 0, 0, 0,
                 SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER |
                 SWP_NOOWNERZORDER | SWP_FRAMECHANGED);
		}
#endif

#ifdef LINUX
		//gdk_init(NULL, NULL);
		GdkWindow* gdk_window = gdk_window_foreign_new(browser->GetHost()->GetWindowHandle());
		if(!gdk_window){
		      DKLog("DKCefWindow::OnFullscreenModeChange(): gdk_window invalid\n", DKINFO);
		      return;
		}
		if(fullscreen){
		  gdk_window_fullscreen(gdk_window);
		}
		else{
		  gdk_window_unfullscreen(gdk_window);
		}
		
#endif //LINUX
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool OnBeforePopup(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, const CefString& target_url, const CefString& target_frame_name, CefLifeSpanHandler::WindowOpenDisposition target_disposition, bool user_gesture, const CefPopupFeatures& popupFeatures, CefWindowInfo& windowInfo, CefRefPtr<CefClient>& client, CefBrowserSettings& settings, bool* no_javascript_access)
	{
		DKLog("DKCefWindow::OnBeforePopup("+target_url.ToString()+","+target_frame_name.ToString()+","+toString(target_disposition)+")\n", DKDEBUG);
		return false;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnBeforeDownload(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDownloadItem> download_item, const CefString& suggested_name, CefRefPtr<CefBeforeDownloadCallback> callback)
	{
		DKLog("DKCefWindow::OnBeforeDownload("+suggested_name.ToString()+")\n", DKINFO);

#ifdef WIN32
		UNREFERENCED_PARAMETER(browser);
		UNREFERENCED_PARAMETER(download_item);
#endif
		callback->Continue(suggested_name, true);
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnBeforeContextMenu(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, CefRefPtr<CefMenuModel> model)
	{
		//DKLog("DKCefWindow::OnBeforeContextMenu()\n", DKINFO);
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool OnContextMenuCommand(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, int command_id, CefContextMenuHandler::EventFlags event_flags)
	{
		//DKLog("DKCefWindow::OnContextMenuCommand()\n", DKINFO);
		return false;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool OnConsoleMessage(CefRefPtr<CefBrowser> browser, const CefString& message, const CefString& source, int line )
	{
		DKString msg = message.ToString();
		replace(msg, "%c", "");
		//DKLog("DKCefWindow::OnConsoleMessage("+msg+","+source.ToString()+","+toString(line)+")\n", DKDEBUG);
		DKString string = message.ToString();
		replace(string,"%c","");
		DKLog("[CEF] "+string+"\n", DKINFO);
		return true;
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnCursorChange(CefRefPtr<CefBrowser> browser, CefCursorHandle cursor, CursorType type, const CefCursorInfo& custom_cursor_info)
	{
		DKLog("OnCursorChange()\n", DKINFO);
	}

	//////////////////////////////////////////////////
	void OnAfterCreated(CefRefPtr<CefBrowser> browser)
	{
		CEF_REQUIRE_UI_THREAD();
		//dkCef->browsers.push_back(browser);
	}
	
	//////////////////////////////////////////////////////
	bool OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefProcessId source_process, CefRefPtr<CefProcessMessage> message) 
	{
		//DKLog("DKCefWindow::OnProcessMessageReceived()\n", DKINFO);
		
		if(message->GetName() == "GetFunctions"){
			//DKLog("DKCefWindow::OnProcessMessageReceived(GetFunctions)\n", DKINFO);
			DKV8::GetFunctions(browser);
		}
		
		if(has(message->GetName(),"CallFunc(")){
			//DKLog("DKCefWindow::OnProcessMessageReceived(CallFunc)\n", DKINFO);
		
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

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool OnPreKeyEvent(CefRefPtr<CefBrowser> browser, const CefKeyEvent& event, CefEventHandle os_event, bool* is_keyboard_shortcut)
	{
		//DKLog("OnPreKeyEvent(): char="+toString(event.character)+", native="+toString(event.native_key_code)+", mods="+toString(event.modifiers)+"\n", DKINFO);

		if(event.type == KEYEVENT_RAWKEYDOWN){
			//DKLog("OnPreKeyEvent(): RawKeyDown: "+toString(event.character)+"\n", DKINFO);
			DKEvent::SendEvent("GLOBAL", "keydown", toString(event.character));
		}
		if(event.type == KEYEVENT_KEYDOWN){
			DKLog("OnPreKeyEvent(): KeyDown: "+toString(event.character)+"\n", DKINFO);
		}
		if(event.type == KEYEVENT_KEYUP){
			//DKLog("OnPreKeyEvent(): KeyUp: "+toString(event.character)+"\n", DKINFO);
		}
		if(event.type == KEYEVENT_CHAR){
			//DKLog("OnPreKeyEvent(): KeyChar: "+toString(event.character)+"\n", DKINFO);
			DKEvent::SendEvent("GLOBAL", "keypress", toString(event.character));
		}
		
		return false;
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool OnRequestGeolocationPermission(CefRefPtr<CefBrowser> browser, const CefString& requesting_url, int request_id, CefRefPtr< CefGeolocationCallback > callback)
	{
		DKLog("DKCefWindow::OnRequestGeolocationPermission()\n", DKINFO);
		callback->Continue(true);
		return true;
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnFindResult(CefRefPtr<CefBrowser> browser, int identifier, int count, const CefRect& selectionRect, int activeMatchOrdinal, bool finalUpdate)
	{
		DKLog("DKCefWindow::OnFindResult()\n", DKINFO);
	}

	IMPLEMENT_REFCOUNTING(DKCefWindow);
};

#endif //DKCefWindow_H