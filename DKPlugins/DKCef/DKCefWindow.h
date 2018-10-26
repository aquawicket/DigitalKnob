#pragma once
#ifndef DKCefWindow_H
#define DKCefWindow_H

#ifdef LINUX
#include <gdk/gdk.h>
#endif

#include "DKCef/DKCef.h"

class DKCef;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class DKCefWindow : public CefClient, 
					public CefContextMenuHandler,
					public CefDisplayHandler,
					public CefDownloadHandler,
					public CefFindHandler,
					// public CefGeolocationHandler, 
					public CefKeyboardHandler,
					public CefLifeSpanHandler, 
					public CefLoadHandler, 
					public CefPrintHandler,
					public CefRenderHandler				    
{
public:
	DKCefWindow();
	bool TestInt(const void* input, void* output);
	bool TestString(const void* input, void* output);
	bool TestReturnInt(const void* input, void* output);
	bool TestReturnString(const void* input, void* output);
	
	bool Fullscreen(const void* input, void* output);
	bool GetHandle(const void* input, void* output);
	bool GetHeight(const void* input, void* output);
	bool GetMouseX(const void* input, void* output);
	bool GetMouseY(const void* input, void* output);
	bool GetWidth(const void* input, void* output);
	bool GetX(const void* input, void* output);
	bool GetY(const void* input, void* output);
	bool Hide(const void* input, void* output);
	bool IsFullscreen(const void* input, void* output);
	bool IsVisible(const void* input, void* output);
	bool Maximize(const void* input, void* output);
	bool MessageBox(const void* input, void* output);
	bool Minimize(const void* input, void* output);
	bool Restore(const void* input, void* output);
	bool SetHeight(const void* input, void* output);
	bool SetIcon(const void* input, void* output);
	bool SetTitle(const void* input, void* output);
	bool SetWidth(const void* input, void* output);
	bool SetX(const void* input, void* output);
	bool SetY(const void* input, void* output);
	bool Show(const void* input, void* output);
	bool Windowed(const void* input, void* output);

	DKCef* dkCef;

#ifdef WIN32
	WINDOWPLACEMENT g_wpPrev = { sizeof(g_wpPrev) };
	WINDOWPLACEMENT wpc;
	LONG HWNDStyle = 0;
	LONG HWNDStyleEx = 0;
#endif
#ifdef LINUX
	bool isFullscreen = false;
#endif

	virtual CefRefPtr<CefContextMenuHandler> GetContextMenuHandler(){ return this; }
	virtual CefRefPtr<CefDisplayHandler> GetDisplayHandler(){ return this; }
	virtual CefRefPtr<CefDownloadHandler> GetDownloadHandler(){ return this; }
	virtual CefRefPtr<CefFindHandler> GetFindHandler(){ return this; }
	//virtual CefRefPtr<CefGeolocationHandler> GetGeolocationHandler() { return this; }
	virtual CefRefPtr<CefKeyboardHandler> GetKeyboardHandler() { return this; }
	virtual CefRefPtr<CefLifeSpanHandler> GetLifeSpanHandler(){ return this; }
	virtual CefRefPtr<CefLoadHandler> GetLoadHandler(){ return this; }
	virtual CefRefPtr<CefPrintHandler> GetPrintHandler(){ return this; }
	virtual CefRefPtr<CefRenderHandler> GetRenderHandler(){ return this; }
	
	///////////////////////////////////////////
	bool DoClose(CefRefPtr<CefBrowser> browser);

	//////////////
	void DoFrame();

	//////////////////////////////////////////////////////////////
	bool GetViewRect(CefRefPtr<CefBrowser> browser, CefRect& rect)
	{
		DKDEBUGFUNC(browser, "CefRect&");
		CEF_REQUIRE_UI_THREAD();
		//rect = CefRect(0, 0, dkCef->width, dkCef->height);
		return true;
	}

	//////////////////////////////////////////////////
	void OnAfterCreated(CefRefPtr<CefBrowser> browser)
	{
		DKDEBUGFUNC(browser);
		CEF_REQUIRE_UI_THREAD();
		//dkCef->browsers.push_back(browser);
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnBeforeContextMenu(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, CefRefPtr<CefMenuModel> model)
	{
		DKDEBUGFUNC(browser, frame, params, model);
		CEF_REQUIRE_UI_THREAD();
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnBeforeDownload(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDownloadItem> download_item, const CefString& suggested_name, CefRefPtr<CefBeforeDownloadCallback> callback)
	{
		DKDEBUGFUNC(browser, download_item, "const CefString&", callback);
		CEF_REQUIRE_UI_THREAD();

#ifdef WIN32
		UNREFERENCED_PARAMETER(browser);
		UNREFERENCED_PARAMETER(download_item);
#endif
		callback->Continue(suggested_name, true);
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool OnBeforePopup(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, const CefString& target_url, const CefString& target_frame_name, CefLifeSpanHandler::WindowOpenDisposition target_disposition, bool user_gesture, const CefPopupFeatures& popupFeatures, CefWindowInfo& windowInfo, CefRefPtr<CefClient>& client, CefBrowserSettings& settings, bool* no_javascript_access)
	{
		DKDEBUGFUNC(browser, frame, "const CefString&", "const CefString&", target_disposition, user_gesture, "const CefPopupFeatures&", "CefWindowInfo&", client, "CefBrowserSettings&", no_javascript_access); 
		CEF_REQUIRE_UI_THREAD();
		return false;
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool OnConsoleMessage(CefRefPtr<CefBrowser> browser, cef_log_severity_t level, const CefString& message, const CefString& source, int line)
	{
		//DKDEBUGFUNC(browser, level, "const CefString&", "const CefString&", line);
		CEF_REQUIRE_UI_THREAD();
		DKString msg = message.ToString();
		replace(msg, "%c", "");
		//DKLog("DKSDLCefHandler::OnConsoleMessage("+msg+","+source.ToString()+","+toString(line)+")\n");
		DKString string = message.ToString();
		replace(string,"%c","");
		int identifier = browser->GetIdentifier();

		if(level == LOGSEVERITY_VERBOSE){ 
			DKDEBUG("[CEF:"+toString(identifier)+"] "+string+"\n"); 
		}
		if(level == LOGSEVERITY_DEBUG){ 
			DKDEBUG("[CEF:"+toString(identifier)+"] "+string+"\n");
		}
		if(level == LOGSEVERITY_DEFAULT){ 
			DKINFO("[CEF:"+toString(identifier)+"] "+string+"\n"); 
		}
		if(level == LOGSEVERITY_INFO){ 
			DKINFO("[CEF:"+toString(identifier)+"] "+string+"\n"); 
		}
		if(level == LOGSEVERITY_WARNING){ 
			DKWARN("[CEF:"+toString(identifier)+"] "+string+"\n");
		}
		if(level == LOGSEVERITY_ERROR){ 
			DKERROR("[CEF:"+toString(identifier)+"] "+string+"\n");
		}
		if(level == LOGSEVERITY_DISABLE){ 
			return true; 
		}
		return true;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool OnContextMenuCommand(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, int command_id, CefContextMenuHandler::EventFlags event_flags)
	{
		DKDEBUGFUNC(browser, frame, params, command_id, event_flags);
		CEF_REQUIRE_UI_THREAD();
		return false;
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnCursorChange(CefRefPtr<CefBrowser> browser, CefCursorHandle cursor, CursorType type, const CefCursorInfo& custom_cursor_info)
	{
		DKDEBUGFUNC(browser, cursor, type, "const CefCursorInfo&");
#ifdef WIN32
		HWND hwnd;
		if(!DKClass::CallFunc("DKSDLWindow::GetHandle", NULL, &hwnd)){ return; }
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

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnFindResult(CefRefPtr<CefBrowser> browser, int identifier, int count, const CefRect& selectionRect, int activeMatchOrdinal, bool finalUpdate)
	{
		DKDEBUGFUNC(browser, identifier, count, "const CefRect&", activeMatchOrdinal, finalUpdate);
		CEF_REQUIRE_UI_THREAD();
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool OnFileDialog(CefRefPtr<CefBrowser> browser, CefDialogHandler::FileDialogMode mode, const CefString& title, const CefString& default_file_path, const std::vector<CefString>& accept_filters, int selected_accept_filter, CefRefPtr<CefFileDialogCallback> callback)
	{
		DKDEBUGFUNC(browser, mode, "const CefString&", "const CefString&", "const std::vector<CefString>&", selected_accept_filter, callback);
		return false;
	}

	///////////////////////////////////////////////////////////////////////////
	void OnFullscreenModeChange(CefRefPtr<CefBrowser> browser, bool fullscreen)
	{
		DKDEBUGFUNC(browser, fullscreen);
		CEF_REQUIRE_UI_THREAD();
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
		GdkWindow* gdk_window = gdk_window_foreign_new(browser->GetHost()->GetWindowHandle());
		if(!gdk_window){
			DKLog("DKCefWindow::OnFullscreenModeChange(): gdk_window invalid\n");
			return;
		}
		if(fullscreen){
			gdk_window_fullscreen(gdk_window);
			isFullscreen = true;
		}
		else{
			gdk_window_unfullscreen(gdk_window);
			isFullscreen = false;
		}
#endif //LINUX
	}

	////////////////////////////////////////////////////////////////////////////////////////////
	void OnLoadEnd(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, int httpStatusCode)
	{
		DKDEBUGFUNC(browser, frame, httpStatusCode);
		if(frame->IsMain()){
			DKEvent::SendEvent("GLOBAL", "DKCef_OnLoadEnd", toString(httpStatusCode));
		}
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnLoadError(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefLoadHandler::ErrorCode errorCode, const CefString& errorText, const CefString& failedUrl)
	{ 
		DKDEBUGFUNC(browser, frame, errorCode, "const CefString&", "const CefString&");
		CEF_REQUIRE_UI_THREAD();
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnLoadingStateChange(CefRefPtr<CefBrowser> browser, bool isLoading, bool canGoBack, bool canGoForward)
	{
		DKDEBUGFUNC(browser, isLoading, canGoBack, canGoForward);
		CEF_REQUIRE_UI_THREAD();
		DKEvent::SendEvent("GLOBAL", "DKCef_OnLoadingStateChange", toString(browser->GetIdentifier()));
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnPaint(CefRefPtr<CefBrowser> browser, PaintElementType type, const RectList& dirtyRects, const void *buffer, int width, int height)
	{
		DKDEBUGFUNC(browser, type, "const RectList&", buffer, width, height);
		CEF_REQUIRE_UI_THREAD();
	}

	//////////////////////////////////////////////////////////
	void OnPopupShow(CefRefPtr<CefBrowser> browser, bool show)
	{
		DKDEBUGFUNC(browser, show);
		CEF_REQUIRE_UI_THREAD();
	}

	////////////////////////////////////////////////////////////////////
	void OnPopupSize(CefRefPtr<CefBrowser> browser, const CefRect& rect)
	{
		DKDEBUGFUNC(browser, "const CefRect&");
		CEF_REQUIRE_UI_THREAD();
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool OnPreKeyEvent(CefRefPtr<CefBrowser> browser, const CefKeyEvent& event, CefEventHandle os_event, bool* is_keyboard_shortcut)
	{
		DKDEBUGFUNC(browser, "const CefKeyEvent&", os_event, is_keyboard_shortcut);
		CEF_REQUIRE_UI_THREAD();
		if(event.type == KEYEVENT_RAWKEYDOWN){
			//DKLog("OnPreKeyEvent(): RawKeyDown: "+toString(event.character)+"\n");
			//#ifdef WIN32
			DKEvent::SendEvent("GLOBAL", "keydown", toString(event.windows_key_code));
			//#else
			//			DKEvent::SendEvent("GLOBAL", "keydown", toString(event.character));
			//#endif
		}
		if(event.type == KEYEVENT_KEYDOWN){
			DKINFO("OnPreKeyEvent(): KeyDown: "+toString(event.character)+"\n");
		}
		if(event.type == KEYEVENT_KEYUP){
			//DKLog("OnPreKeyEvent(): KeyUp: "+toString(event.character)+"\n");
		}
		if(event.type == KEYEVENT_CHAR){
			//DKLog("OnPreKeyEvent(): KeyChar: "+toString(event.character)+"\n");
			DKEvent::SendEvent("GLOBAL", "keypress", toString(event.character));
		}

		return false;
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool OnPrintDialog(CefRefPtr<CefBrowser> browser, bool has_selection, CefRefPtr<CefPrintDialogCallback> callback)
	{
		DKDEBUGFUNC(browser, has_selection, callback);
		return true;
	}

	bool OnPrintJob(CefRefPtr<CefBrowser> browser, const CefString& document_name, const CefString& pdf_file_path, CefRefPtr<CefPrintJobCallback> callback){ return true; }
	void OnPrintReset(CefRefPtr<CefBrowser> browser){}
	void OnPrintSettings(CefRefPtr<CefBrowser> browser, CefRefPtr<CefPrintSettings> settings, bool get_defaults){}
	void OnPrintStart(CefRefPtr<CefBrowser> browser){}

	//////////////////////////////////////////////////////
	bool OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefProcessId source_process, CefRefPtr<CefProcessMessage> message) 
	{
		DKDEBUGFUNC(browser, source_process, message);
		CEF_REQUIRE_UI_THREAD();

		if(message->GetName() == "GetFunctions"){
			//DKLog("DKCefWindow::OnProcessMessageReceived(GetFunctions)\n");
			DKV8::GetFunctions(browser);
		}

		if(has(message->GetName(),"CallFunc(")){
			//DKLog("DKCefWindow::OnProcessMessageReceived(CallFunc)\n");

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

	/*
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool OnRequestGeolocationPermission(CefRefPtr<CefBrowser> browser, const CefString& requesting_url, int request_id, CefRefPtr<CefGeolocationCallback> callback)
	{
		DKDEBUGFUNC(browser, "const CefString&", request_id, callback);
		CEF_REQUIRE_UI_THREAD();
		callback->Continue(true);
		return true;
	}
	*/

	//////////////////////////////////////////////////////////////
	bool OnTooltip(CefRefPtr<CefBrowser> browser, CefString& text)
	{
		DKDEBUGFUNC(browser, "CefString&");
		CEF_REQUIRE_UI_THREAD();
		return true;
	}

	IMPLEMENT_REFCOUNTING(DKCefWindow);
};

#endif //DKCefWindow_H