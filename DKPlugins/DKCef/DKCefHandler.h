#pragma once
#ifndef DKCefHandler_H
#define DKCefHandler_H

#ifdef LINUX
#include <X11/Xatom.h>
#include <X11/Xlib.h>
#undef Status
//typedef cef_urlrequest_status_t Status;
#endif

#include "DKCef.h"
class DKCef;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class DKCefHandler : public CefClient, public CefRenderHandler, public CefLoadHandler, public CefLifeSpanHandler, 
						public CefContextMenuHandler, public CefDownloadHandler, public CefDisplayHandler
{
public:
	DKCefHandler(){}
	DKCef* dkCef;
#ifdef WIN32
	WINDOWPLACEMENT g_wpPrev = { sizeof(g_wpPrev) };
#endif

	//virtual CefRefPtr<CefContextMenuHandler> GetContextMenuHandler(){ return this; }
	virtual CefRefPtr<CefDisplayHandler> GetDisplayHandler(){ return this; }
	virtual CefRefPtr<CefDownloadHandler> GetDownloadHandler(){ return this; }
	virtual CefRefPtr<CefLifeSpanHandler> GetLifeSpanHandler(){ return this; }
	virtual CefRefPtr<CefLoadHandler> GetLoadHandler(){ return this; }
	//virtual CefRefPtr<CefRenderHandler> GetRenderHandler(){ return this; }
	
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
		DKLog("DKSDLCefHandler::GetViewRect(CefBrowser, CefRect&)\n", DKDEBUG);
		
		//rect = CefRect(0, 0, dkCef->width, dkCef->height);
		return true;
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnPaint(CefRefPtr<CefBrowser> browser, PaintElementType type, const RectList &dirtyRects, const void *buffer, int width, int height)
	{
		DKLog("DKCefHandler::OnPaint()\n", DKDEBUG);
	}

	//////////////////////////////////////////////////////////
	void OnPopupShow(CefRefPtr<CefBrowser> browser, bool show)
	{
		DKLog("DKCefHandler::OnPopupShow()\n", DKDEBUG);
	}

	////////////////////////////////////////////////////////////////////
	void OnPopupSize(CefRefPtr<CefBrowser> browser, const CefRect& rect)
	{
		DKLog("DKSDLCefHandler::OnPopupSize()\n", DKDEBUG);
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnLoadingStateChange(CefRefPtr<CefBrowser> browser, bool isLoading, bool canGoBack, bool canGoForward)
	{
		DKLog("DKSDLCefHandler::OnLoadingStateChange("+toString(isLoading)+","+toString(canGoBack)+","+toString(canGoForward)+")\n", DKDEBUG);
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnLoadError(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefLoadHandler::ErrorCode errorCode, const CefString& errorText, const CefString& failedUrl)
	{ 
		CEF_REQUIRE_UI_THREAD();
		DKLog("DKSDLCefHandler::OnLoadError("+toString(errorCode)+","+errorText.ToString()+","+failedUrl.ToString()+")\n", DKDEBUG);
	}

	///////////////////////////////////////////////////////////////////////////
	void OnFullscreenModeChange(CefRefPtr<CefBrowser> browser, bool fullscreen)
	{
		DKLog("DKSDLCefHandler::OnFullscreenModeChange()\n", DKINFO);

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
		::Display* display = cef_get_xdisplay();
		if(!display){ 
		      DKLog("DKSDLCefHandler::OnFullscreenModeChange(): display invalid\n", DKINFO);
		}
		::Window window = browser->GetHost()->GetWindowHandle();
		if(!window){ 
		      DKLog("DKSDLCefHandler::OnFullscreenModeChange(): window invalid\n", DKINFO);
		}
		
		
		
		Atom wm_state = XInternAtom (display, "_NET_WM_STATE", False);
		if(wm_state == None){
		      DKLog("DKSDLCefHandler::OnFullscreenModeChange(): wm_state invalid\n", DKINFO);
		}
		Atom wm_fullscreen = XInternAtom (display, "_NET_WM_STATE_FULLSCREEN", False);
		if(wm_fullscreen == None){
		      DKLog("DKSDLCefHandler::OnFullscreenModeChange(): wm_fullscreen invalid\n", DKINFO);
		}
		XChangeProperty(display, window, wm_state, XA_ATOM, 32, PropModeReplace, reinterpret_cast<unsigned char*>(&wm_fullscreen), 1);
		
		
		
		/*
		Atom window_type = XInternAtom(display, "_NET_WM_WINDOW_TYPE", False);
		long value = XInternAtom(display, "_NET_WM_WINDOW_TYPE_DOCK", False);
		XChangeProperty(display, window, window_type, XA_ATOM, 32, PropModeReplace, (unsigned char*) &value, 1);
		*/
		
		
		/*
		XResizeWindow(
		cef_get_xdisplay(),
		browser->GetHost()->GetWindowHandle(),
		300,
		300);
		*/
		
		
		/*
		Atom fullmons = XInternAtom(display, "_NET_WM_FULLSCREEN_MONITORS", False);
		XEvent xev;
		memset(&xev, 0, sizeof(xev));
		xev.type = ClientMessage;
		xev.xclient.window = window;
		xev.xclient.message_type = fullmons;
		xev.xclient.format = 32;
		xev.xclient.data.l[0] = 0; // your topmost monitor number
		xev.xclient.data.l[1] = 0; // bottommost
		xev.xclient.data.l[2] = 0; // leftmost
		xev.xclient.data.l[3] = 1; // rightmost
		xev.xclient.data.l[4] = 0; // source indication
		XSendEvent (display, DefaultRootWindow(display), False, SubstructureRedirectMask | SubstructureNotifyMask, &xev);
		XFlush(display);
		*/
#endif //LINUX
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool OnBeforePopup(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, const CefString& target_url, const CefString& target_frame_name, CefLifeSpanHandler::WindowOpenDisposition target_disposition, bool user_gesture, const CefPopupFeatures& popupFeatures, CefWindowInfo& windowInfo, CefRefPtr<CefClient>& client, CefBrowserSettings& settings, bool* no_javascript_access)
	{
		DKLog("DKSDLCefHandler::OnBeforePopup("+target_url.ToString()+","+target_frame_name.ToString()+","+toString(target_disposition)+")\n", DKDEBUG);
		return false;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnBeforeDownload(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDownloadItem> download_item, const CefString& suggested_name, CefRefPtr<CefBeforeDownloadCallback> callback)
	{
		DKLog("DKSDLCefHandler::OnBeforeDownload("+suggested_name.ToString()+")\n", DKINFO);

#ifdef WIN32
		UNREFERENCED_PARAMETER(browser);
		UNREFERENCED_PARAMETER(download_item);
#endif
		callback->Continue(suggested_name, true);
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnBeforeContextMenu(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, CefRefPtr<CefMenuModel> model)
	{
		DKLog("DKSDLCefHandler::OnBeforeContextMenu()\n", DKDEBUG);
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool OnConsoleMessage(CefRefPtr<CefBrowser> browser, const CefString& message, const CefString& source, int line )
	{
		return true;
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnCursorChange(CefRefPtr<CefBrowser> browser, CefCursorHandle cursor, CursorType type, const CefCursorInfo& custom_cursor_info)
	{
		DKLog("OnCursorChange()\n", DKINFO);
	}

	//////////////////////////////////////////////////////
	bool OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefProcessId source_process, CefRefPtr<CefProcessMessage> message) 
	{
		return true;
	}

	//////////////////////////////////////////////////
	void OnAfterCreated(CefRefPtr<CefBrowser> browser)
	{
		CEF_REQUIRE_UI_THREAD();
		//dkCef->browsers.push_back(browser);
	}

	IMPLEMENT_REFCOUNTING(DKCefHandler);
};

#endif //DKCefHandler_H