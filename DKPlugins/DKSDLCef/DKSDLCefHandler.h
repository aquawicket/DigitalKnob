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
#ifndef DKSDLCefHandler_H
#define DKSDLCefHandler_H

WARNING_DISABLE
	#include <list>
	#include <include/cef_client.h>
	#include <include/cef_accessibility_handler.h>
	#include <include/cef_context_menu_handler.h>
	#include <include/cef_dialog_handler.h>
	#include <include/cef_display_handler.h>
	#include <include/cef_download_handler.h>
	#include <include/cef_drag_handler.h>
	#include <include/cef_extension_handler.h>
	#include <include/cef_find_handler.h>
	#include <include/cef_focus_handler.h>
	#include <include/cef_jsdialog_handler.h>
	#include <include/cef_keyboard_handler.h>
	#include <include/cef_life_span_handler.h>
	#include <include/cef_load_handler.h>
	#include <include/cef_print_handler.h>
	#include <include/cef_render_handler.h>
	#include <include/cef_request_context_handler.h>
	#include <include/cef_request_handler.h>
	#include <include/cef_resource_handler.h>
	#include <include/cef_resource_request_handler.h>
	//#include <include/cef_geolocation.h>
	#include "SDL.h"
WARNING_ENABLE

#include "DK/DK.h"
#include "DK/DKApp.h"
#include "DKCef/DKCef.h"
#include "DKSDLCef/DKSDLCefKeyboard.h"
#include "DKSdlWindow/DKSdlWindow.h"
#include "DKSDLCef/DKSDLCef.h"


class SourceCallback : public CefStringVisitor 
{
public:
	SourceCallback(CefRefPtr<CefBrowser> browser, DKString& string) : browser_(browser), source(string){}
	virtual void Visit(const CefString& string) override;
	
private:
	DKString& source;
	CefRefPtr<CefBrowser> browser_;
	IMPLEMENT_REFCOUNTING(SourceCallback);
};




class DKSDLCefHandler : public CefClient,
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
						public CefPrintHandler,          //Error: cannot instantiate abstract class
						public CefRenderHandler,
						public CefRequestContextHandler,
						public CefRequestHandler,
						//public CefResourceHandler,       //Error: cannot instantiate abstract class
						public CefResourceRequestHandler
{
public:

	DKSDLCefHandler();
	~DKSDLCefHandler();
	static DKSDLCefHandler* g_instance;
	static DKSDLCefHandler* GetInstance(); //Provide access to the single global instance of this object.
	
	//List of existing browser windows. Only accessed on the CEF UI thread.
	typedef std::vector<CefRefPtr<CefBrowser>> BrowserList;
	BrowserList browser_list_;
	bool is_closing_;

	DKSdlWindow* dkSdlWindow;
	DKCef* dkCef;
	DKSDLCef* dkSdlCef;
	std::vector<SDL_Texture*> cef_texture;

	// CefAccessibilityHandler
	//void OnAccessibilityTreeChange(CefRefPtr<CefValue> value) override;
	//void OnAccessibilityLocationChange(CefRefPtr<CefValue> value) override;

	// CefContextMenuHandler
	CefRefPtr<CefContextMenuHandler> GetContextMenuHandler() override { return this; }
	void OnBeforeContextMenu(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, CefRefPtr<CefMenuModel> model) override;
	//bool RunContextMenu(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, CefRefPtr<CefMenuModel> model, CefRefPtr<CefRunContextMenuCallback> callback) override;
	bool OnContextMenuCommand(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, int command_id, CefContextMenuHandler::EventFlags event_flags) override;
	//void OnContextMenuDismissed(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame) override;

	// CefDialogHandler
	CefRefPtr<CefDialogHandler> GetDialogHandler() override { return this; }
	bool OnFileDialog(CefRefPtr<CefBrowser> browser, CefDialogHandler::FileDialogMode mode, const CefString& title, const CefString& default_file_path, const std::vector<CefString>& accept_filters, int selected_accept_filter, CefRefPtr<CefFileDialogCallback> callback) override;

	// CefDisplayHandler
	CefRefPtr<CefDisplayHandler> GetDisplayHandler() override { return this; }
	//void OnAddressChange(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, const CefString& url) override;
	//void OnTitleChange(CefRefPtr<CefBrowser> browser,	const CefString& title) override;
	//void OnFaviconURLChange(CefRefPtr<CefBrowser> browser, const std::vector<CefString>& icon_urls) override;
	void OnFullscreenModeChange(CefRefPtr<CefBrowser> browser, bool fullscreen) override;
	bool OnTooltip(CefRefPtr<CefBrowser> browser, CefString& text) override;
	//void OnStatusMessage(CefRefPtr<CefBrowser> browser, const CefString& value) override;
	bool OnConsoleMessage(CefRefPtr<CefBrowser> browser, cef_log_severity_t level, const CefString& message, const CefString& source, int line) override;
	//bool OnAutoResize(CefRefPtr<CefBrowser> browser, const CefSize& new_size) override;
	//void OnLoadingProgressChange(CefRefPtr<CefBrowser> browser, double progress) override;

	// CefDownloadHandler
	CefRefPtr<CefDownloadHandler> GetDownloadHandler() override { return this; }
	void OnBeforeDownload(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDownloadItem> download_item, const CefString& suggested_name, CefRefPtr<CefBeforeDownloadCallback> callback) override;
	//void OnDownloadUpdated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDownloadItem> download_item, CefRefPtr<CefDownloadItemCallback> callback) override;

	// CefDragHandler
	CefRefPtr<CefDragHandler> GetDragHandler() override { return this; }
	//bool OnDragEnter(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDragData> dragData, DragOperationsMask mask) override;
	//void OnDraggableRegionsChanged(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, const std::vector<CefDraggableRegion>& regions) override;

	// CefExtensionHandler
	//CefRefPtr<CefExtensionHandler> GetExtensionHandler() override { return this; }
	//void OnExtensionLoadFailed(cef_errorcode_t result) override;
	//void OnExtensionLoaded(CefRefPtr<CefExtension> extension) override;
	//void OnExtensionUnloaded(CefRefPtr<CefExtension> extension) override;
	//bool OnBeforeBackgroundBrowser(CefRefPtr<CefExtension> extension, const CefString& url, CefRefPtr<CefClient>& client, CefBrowserSettings& settings) override;
	//bool OnBeforeBrowser(CefRefPtr<CefExtension> extension, CefRefPtr<CefBrowser> browser, CefRefPtr<CefBrowser> active_browser, int index, const CefString& url, bool active, CefWindowInfo& windowInfo, CefRefPtr<CefClient>& client, CefBrowserSettings& settings) override;
	//CefRefPtr<CefBrowser> GetActiveBrowser(CefRefPtr<CefExtension> extension, CefRefPtr<CefBrowser> browser, bool include_incognito) override;
	//bool CanAccessBrowser(CefRefPtr<CefExtension> extension, CefRefPtr<CefBrowser> browser, bool include_incognito, CefRefPtr<CefBrowser> target_browser) override;
	//bool GetExtensionResource(CefRefPtr<CefExtension> extension, CefRefPtr<CefBrowser> browser, const CefString& file, CefRefPtr<CefGetExtensionResourceCallback> callback) override;

	// CefFindHandler
	CefRefPtr<CefFindHandler> GetFindHandler() override { return this; }
	void OnFindResult(CefRefPtr<CefBrowser> browser, int identifier, int count, const CefRect& selectionRect, int activeMatchOrdinal, bool finalUpdate) override;

	// CefFocusHandler
	CefRefPtr<CefFocusHandler> GetFocusHandler() override { return this; }
	//void OnTakeFocus(CefRefPtr<CefBrowser> browser, bool next) override;
	//bool OnSetFocus(CefRefPtr<CefBrowser> browser, FocusSource source) override;
	//void OnGotFocus(CefRefPtr<CefBrowser> browser) override;

	// CefJSDialogHandler
	CefRefPtr<CefJSDialogHandler> GetJSDialogHandler() override { return this; }
	//bool OnJSDialog(CefRefPtr<CefBrowser> browser, const CefString& origin_url, JSDialogType dialog_type, const CefString& message_text, const CefString& default_prompt_text, CefRefPtr<CefJSDialogCallback> callback, bool& suppress_message) override;
	//bool OnBeforeUnloadDialog(CefRefPtr<CefBrowser> browser, const CefString& message_text, bool is_reload, CefRefPtr<CefJSDialogCallback> callback) override;
	//void OnResetDialogState(CefRefPtr<CefBrowser> browser) override;
	//void OnDialogClosed(CefRefPtr<CefBrowser> browser) override;

	// CefKeyboardHandler
	CefRefPtr<CefKeyboardHandler> GetKeyboardHandler() override { return this; }
	bool OnPreKeyEvent(CefRefPtr<CefBrowser> browser, const CefKeyEvent& event, CefEventHandle os_event, bool* is_keyboard_shortcut) override;
	//bool OnKeyEvent(CefRefPtr<CefBrowser> browser, const CefKeyEvent& event, CefEventHandle os_event) override;

	// CefLifeSpanHandler
	CefRefPtr<CefLifeSpanHandler> GetLifeSpanHandler() override { return this; }
	bool OnBeforePopup(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, const CefString& target_url, const CefString& target_frame_name, CefLifeSpanHandler::WindowOpenDisposition target_disposition, bool user_gesture, const CefPopupFeatures& popupFeatures, CefWindowInfo& windowInfo, CefRefPtr<CefClient>& client, CefBrowserSettings& settings, bool* no_javascript_access);
	void OnAfterCreated(CefRefPtr<CefBrowser> browser) override;
	bool DoClose(CefRefPtr<CefBrowser> browser) override;
	void OnBeforeClose(CefRefPtr<CefBrowser> browser) override;

	// CefLoadHandler
	CefRefPtr<CefLoadHandler> GetLoadHandler() override { return this; }
	void OnLoadingStateChange(CefRefPtr<CefBrowser> browser, bool isLoading, bool canGoBack, bool canGoForward) override;
	//void OnLoadStart(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, TransitionType transition_type) override;
	void OnLoadEnd(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, int httpStatusCode) override;
	void OnLoadError(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefLoadHandler::ErrorCode errorCode, const CefString& errorText, const CefString& failedUrl) override;

	// CefPrintHandler
	//CefRefPtr<CefPrintHandler> GetPrintHandler() override { return this; }
	void OnPrintStart(CefRefPtr<CefBrowser> browser) override {
		DKDEBUGFUNC(browser);
	};
	void OnPrintSettings(CefRefPtr<CefBrowser> browser, CefRefPtr<CefPrintSettings> settings, bool get_defaults) override {
		DKDEBUGFUNC(browser, settings, get_defaults);
	}
	bool OnPrintDialog(CefRefPtr<CefBrowser> browser, bool has_selection, CefRefPtr<CefPrintDialogCallback> callback) override;
	bool OnPrintJob(CefRefPtr<CefBrowser> browser, const CefString& document_name, const CefString& pdf_file_path, CefRefPtr<CefPrintJobCallback> callback) override { 
		DKDEBUGFUNC(browser, document_name, pdf_file_path, callback);
		return true; 
	}
	void OnPrintReset(CefRefPtr<CefBrowser> browser) override {
		DKDEBUGFUNC(browser);
	};
	//CefSize GetPdfPaperSize(int device_units_per_inch) override;

	// CefRenderHandler
	CefRefPtr<CefRenderHandler> GetRenderHandler() override { return this; }
	//CefRefPtr<CefAccessibilityHandler> GetAccessibilityHandler() override { return this; }
	//bool GetRootScreenRect(CefRefPtr<CefBrowser> browser, CefRect& rect) override;
	void GetViewRect(CefRefPtr<CefBrowser> browser, CefRect& rect) override;
	//bool GetScreenPoint(CefRefPtr<CefBrowser> browser, int viewX, int viewY, int& screenX, int& screenY) override;
	bool GetScreenInfo(CefRefPtr<CefBrowser> browser, CefScreenInfo& screen_info) override;
	void OnPopupShow(CefRefPtr<CefBrowser> browser, bool show) override;
	void OnPopupSize(CefRefPtr<CefBrowser> browser, const CefRect& rect) override;
	void OnPaint(CefRefPtr<CefBrowser> browser, PaintElementType type, const RectList& dirtyRects, const void* buffer, int width, int height) override;
	//void OnAcceleratedPaint(CefRefPtr<CefBrowser> browser, PaintElementType type, const RectList& dirtyRects, void* shared_handle) override;
	void OnCursorChange(CefRefPtr<CefBrowser> browser, CefCursorHandle cursor, CursorType type, const CefCursorInfo& custom_cursor_info) override;
	//bool StartDragging(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDragData> drag_data, DragOperationsMask allowed_ops, int x, int y) override;
	//void UpdateDragCursor(CefRefPtr<CefBrowser> browser, DragOperation operation) override;
	//void OnScrollOffsetChanged(CefRefPtr<CefBrowser> browser, double x, double y) override;
	//void OnImeCompositionRangeChanged(CefRefPtr<CefBrowser> browser, const CefRange& selected_range, const RectList& character_bounds) override;
	//void OnTextSelectionChanged(CefRefPtr<CefBrowser> browser, const CefString& selected_text, const CefRange& selected_range) override;
	//void OnVirtualKeyboardRequested(CefRefPtr<CefBrowser> browser, TextInputMode input_mode) override;

	// CefRenderProcessHandler   //Located in DKCefApp.h
	//CefRefPtr<CefRenderProcessHandler> GetRenderProcessHandler() override { return this; }
	//void OnRenderThreadCreated(CefRefPtr<CefListValue> extra_info) override;
	//void OnWebKitInitialized() override;
	//void OnBrowserCreated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDictionaryValue> extra_info) override;
	//void OnBrowserDestroyed(CefRefPtr<CefBrowser> browser) override;
	//virtual CefRefPtr<CefLoadHandler> GetLoadHandler() override;
	//void OnContextCreated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context) override;
	//void OnContextReleased(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context) override;
	//void OnUncaughtException(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context, CefRefPtr<CefV8Exception> exception, CefRefPtr<CefV8StackTrace> stackTrace) override;
	//void OnFocusedNodeChanged(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefDOMNode> node) override;
	bool OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefProcessId source_process, CefRefPtr<CefProcessMessage> message) override;
	
	// CefRequestContextHandler
	//CefRefPtr<CefRequestContextHandler> GetRequestContextHandler() override { return this; }
	//void OnRequestContextInitialized(CefRefPtr<CefRequestContext> request_context) override;
	//bool OnBeforePluginLoad(const CefString& mime_type, const CefString& plugin_url, bool is_main_frame, const CefString& top_origin_url, CefRefPtr<CefWebPluginInfo> plugin_info, PluginPolicy* plugin_policy) override;
	//CefRefPtr<CefResourceRequestHandler> GetResourceRequestHandler(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefRequest> request, bool is_navigation, bool is_download, const CefString& request_initiator, bool& disable_default_handling) override;

	// CefRequestHandler
	CefRefPtr<CefRequestHandler> GetRequestHandler() override { return this; }
	//bool OnBeforeBrowse(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefRequest> request, bool user_gesture, bool is_redirect) override;
	//bool OnOpenURLFromTab(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, const CefString& target_url, WindowOpenDisposition target_disposition, bool user_gesture) override;
	//CefRefPtr<CefResourceRequestHandler> GetResourceRequestHandler(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefRequest> request, bool is_navigation, bool is_download, const CefString& request_initiator, bool& disable_default_handling) override;
	//bool GetAuthCredentials(CefRefPtr<CefBrowser> browser, const CefString& origin_url, bool isProxy, const CefString& host, int port, const CefString& realm, const CefString& scheme, CefRefPtr<CefAuthCallback> callback) override;
	//bool OnQuotaRequest(CefRefPtr<CefBrowser> browser, const CefString& origin_url, int64 new_size, CefRefPtr<CefRequestCallback> callback) override;
	//bool OnCertificateError(CefRefPtr<CefBrowser> browser, cef_errorcode_t cert_error, const CefString& request_url, CefRefPtr<CefSSLInfo> ssl_info, CefRefPtr<CefRequestCallback> callback) override;
	//bool OnSelectClientCertificate(CefRefPtr<CefBrowser> browser, bool isProxy, const CefString& host, int port, const X509CertificateList& certificates, CefRefPtr<CefSelectClientCertificateCallback> callback) override;
	//void OnPluginCrashed(CefRefPtr<CefBrowser> browser, const CefString& plugin_path) override;
	//void OnRenderViewReady(CefRefPtr<CefBrowser> browser) override;
	//void OnRenderProcessTerminated(CefRefPtr<CefBrowser> browser, TerminationStatus status) override;

	// CefResourceHandler
	//CefRefPtr<CefResourceHandler> GetResourceHandler() override { return this; }
	//bool Open(CefRefPtr<CefRequest> request, bool& handle_request, CefRefPtr<CefCallback> callback) override;
	//bool ProcessRequest(CefRefPtr<CefRequest> request, CefRefPtr<CefCallback> callback) override;
	//void GetResponseHeaders(CefRefPtr<CefResponse> response, int64& response_length, CefString& redirectUrl) override;
	//bool Skip(int64 bytes_to_skip, int64& bytes_skipped, CefRefPtr<CefResourceSkipCallback> callback) override;
	//bool Read(void* data_out, int bytes_to_read, int& bytes_read, CefRefPtr<CefResourceReadCallback> callback) override;
	//bool ReadResponse(void* data_out, int bytes_to_read, int& bytes_read, CefRefPtr<CefCallback> callback) override;
	//void Cancel() override;

	// CefResourceRequestHandler
	//CefRefPtr<CefResourceRequestHandler> GetResourceRequestHandler() override { return this; }
	//CefRefPtr<CefCookieAccessFilter> GetCookieAccessFilter(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefRequest> request) override;
	//ReturnValue OnBeforeResourceLoad(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefRequest> request, CefRefPtr<CefRequestCallback> callback) override;
	//CefRefPtr<CefResourceHandler> GetResourceHandler( CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefRequest> request) override;
	//void OnResourceRedirect(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefRequest> request, CefRefPtr<CefResponse> response, CefString& new_url) override;
	//bool OnResourceResponse(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefRequest> request, CefRefPtr<CefResponse> response) override;
	//CefRefPtr<CefResponseFilter> GetResourceResponseFilter(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefRequest> request, CefRefPtr<CefResponse> response) override;
	//void OnResourceLoadComplete(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefRequest> request, CefRefPtr<CefResponse> response, URLRequestStatus status, int64 received_content_length) override;
	//void OnProtocolExecution(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefRequest> request, bool& allow_os_execution) override;


	// Miscellaneous
	void CloseAllBrowsers(bool force_close);
	void DoFrame();
	bool IsClosing() const { return is_closing_; }
	//bool OnRequestGeolocationPermission(CefRefPtr<CefBrowser> browser, const CefString& requesting_url, int request_id, CefRefPtr<CefGeolocationCallback> callback);
	
	IMPLEMENT_REFCOUNTING(DKSDLCefHandler);
};

#endif //DKSDLCefHandler_H