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

#pragma once
#ifndef DKCEFWindow_H
#define DKCEFWindow_H
   
#include "DKCef/DKCef.h"

//#define USE_GDK 1 
WARNING_DISABLE
	#if LINUX
		#if USE_GDK
			#include <gdk/gdk.h>
		#endif
	#endif
WARNING_ENABLE


class DKCef;
class DKCEFWindow : public CefClient,
		//public CefAccessibilityHandler, //Error: cannot instantiate abstract class
		public CefContextMenuHandler,
		public CefDialogHandler,
		public CefDisplayHandler,
		public CefDownloadHandler,
		public CefDragHandler,
		public CefExtensionHandler,
		public CefFindHandler,
		public CefFocusHandler,
		public CefJSDialogHandler,
		public CefKeyboardHandler,
		public CefLifeSpanHandler,
		public CefLoadHandler,
		public CefPrintHandler,
		public CefRenderHandler,
		//public CefRequestContextHandler,
		public CefRequestHandler,
		//public CefResourceHandler,       //Error: cannot instantiate abstract class
		public CefResourceRequestHandler
{
public:
	DKCEFWindow();
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

#if WIN
	WINDOWPLACEMENT g_wpPrev = { sizeof(g_wpPrev) };
	WINDOWPLACEMENT wpc;
	LONG HWNDStyle = 0;
	LONG HWNDStyleEx = 0;
#endif
#if LINUX
	bool isFullscreen = false;
#endif

	virtual CefRefPtr<CefContextMenuHandler> GetContextMenuHandler() override { return this; }
	virtual CefRefPtr<CefDisplayHandler> GetDisplayHandler() override { return this; }
	virtual CefRefPtr<CefDownloadHandler> GetDownloadHandler() override { return this; }
	virtual CefRefPtr<CefFindHandler> GetFindHandler() override { return this; }
	virtual CefRefPtr<CefKeyboardHandler> GetKeyboardHandler() override { return this; }
	virtual CefRefPtr<CefLifeSpanHandler> GetLifeSpanHandler() override { return this; }
	virtual CefRefPtr<CefLoadHandler> GetLoadHandler() override { return this; }
	//virtual CefRefPtr<CefPrintHandler> GetPrintHandler() { return this; }
	virtual CefRefPtr<CefRenderHandler> GetRenderHandler() override { return this; }
	
	// DK
	void DoFrame();

	// CefLifeSpanHandler
	bool DoClose(CefRefPtr<CefBrowser> browser) override;
	void OnAfterCreated(CefRefPtr<CefBrowser> browser) override;
	bool OnBeforePopup(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, const CefString& target_url, const CefString& target_frame_name, CefLifeSpanHandler::WindowOpenDisposition target_disposition, bool user_gesture, const CefPopupFeatures& popupFeatures, CefWindowInfo& windowInfo, CefRefPtr<CefClient>& client, CefBrowserSettings& settings, CefRefPtr<CefDictionaryValue>& extra_info, bool* no_javascript_access) override;
	
	// CefRenderHandler
	void GetViewRect(CefRefPtr<CefBrowser> browser, CefRect& rect) override;
	void OnCursorChange(CefRefPtr<CefBrowser> browser, CefCursorHandle cursor, CursorType type, const CefCursorInfo& custom_cursor_info) override;
	void OnPaint(CefRefPtr<CefBrowser> browser, PaintElementType type, const RectList& dirtyRects, const void* buffer, int width, int height) override;
	void OnPopupShow(CefRefPtr<CefBrowser> browser, bool show) override;
	void OnPopupSize(CefRefPtr<CefBrowser> browser, const CefRect& rect) override;

	// CefContextMenuHandler
	void OnBeforeContextMenu(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, CefRefPtr<CefMenuModel> model) override;
	bool OnContextMenuCommand(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, int command_id, CefContextMenuHandler::EventFlags event_flags) override;

	// CefDownloadHandler
	void OnBeforeDownload(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDownloadItem> download_item, const CefString& suggested_name, CefRefPtr<CefBeforeDownloadCallback> callback) override;

	// CefDisplayHandler
	bool OnConsoleMessage(CefRefPtr<CefBrowser> browser, cef_log_severity_t level, const CefString& message, const CefString& source, int line) override;
	void OnFullscreenModeChange(CefRefPtr<CefBrowser> browser, bool fullscreen) override;
	bool OnTooltip(CefRefPtr<CefBrowser> browser, CefString& text) override;

	// CefFindHandler
	void OnFindResult(CefRefPtr<CefBrowser> browser, int identifier, int count, const CefRect& selectionRect, int activeMatchOrdinal, bool finalUpdate) override;

	// CefDialogHandler
	bool OnFileDialog(CefRefPtr<CefBrowser> browser, CefDialogHandler::FileDialogMode mode, const CefString& title, const CefString& default_file_path, const std::vector<CefString>& accept_filters, int selected_accept_filter, CefRefPtr<CefFileDialogCallback> callback) override;

	// CefLoadHandler
	void OnLoadEnd(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, int httpStatusCode) override;
	void OnLoadError(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefLoadHandler::ErrorCode errorCode, const CefString& errorText, const CefString& failedUrl) override;
	void OnLoadingStateChange(CefRefPtr<CefBrowser> browser, bool isLoading, bool canGoBack, bool canGoForward) override;

	// CefKeyboardHandler
	bool OnPreKeyEvent(CefRefPtr<CefBrowser> browser, const CefKeyEvent& event, CefEventHandle os_event, bool* is_keyboard_shortcut) override;

	// CefPrintHandler
	bool OnPrintDialog(CefRefPtr<CefBrowser> browser, bool has_selection, CefRefPtr<CefPrintDialogCallback> callback) override;
	bool OnPrintJob(CefRefPtr<CefBrowser> browser, const CefString& document_name, const CefString& pdf_file_path, CefRefPtr<CefPrintJobCallback> callback) override { 
		DKDEBUGFUNC(browser, document_name, pdf_file_path, callback);
		return true; 
	}
	void OnPrintReset(CefRefPtr<CefBrowser> browser) override {}
	void OnPrintSettings(CefRefPtr<CefBrowser> browser, CefRefPtr<CefPrintSettings> settings, bool get_defaults) override {
		DKDEBUGFUNC(browser, settings, get_defaults);
	}
	void OnPrintStart(CefRefPtr<CefBrowser> browser) override {}

	// CefRenderProcessHandler 
	bool OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefProcessId source_process, CefRefPtr<CefProcessMessage> message) override;

	// CefGeolocationHandler
	/*
	bool OnRequestGeolocationPermission(CefRefPtr<CefBrowser> browser, const CefString& requesting_url, int request_id, CefRefPtr<CefGeolocationCallback> callback){
		DKDEBUGFUNC(browser, "const CefString&", request_id, callback);
		CEF_REQUIRE_UI_THREAD();
		callback->Continue(true);
		return true;
	}
	*/

	IMPLEMENT_REFCOUNTING(DKCEFWindow);
};

#endif //DKCEFWindow_H
