#pragma once
#ifndef DKSDLCefHandler_H
#define DKSDLCefHandler_H

#include <list>
#include <include/cef_client.h>
#include <include/cef_context_menu_handler.h>
#include <include/cef_dialog_handler.h>
#include <include/cef_display_handler.h>
#include <include/cef_download_handler.h>
#include <include/cef_drag_handler.h>
#include <include/cef_find_handler.h>
#include <include/cef_focus_handler.h>
#include <include/cef_jsdialog_handler.h>
#include <include/cef_keyboard_handler.h>
#include <include/cef_life_span_handler.h>
#include <include/cef_load_handler.h>
#include <include/cef_render_handler.h>
#include <include/cef_request_handler.h>

#include <include/cef_browser_process_handler.h>
//#include <include/cef_geolocation.h>
#include "SDL.h"

#include "DK/DK.h"
#include "DK/DKApp.h"
#include "DKCef/DKCef.h"
#include "DKSDLCef/DKSDLCefKeyboard.h"
#include "DKSDLWindow/DKSDLWindow.h"
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
						public CefContextMenuHandler,
						public CefDialogHandler,
						public CefDisplayHandler,
						public CefDownloadHandler,
						public CefDragHandler,
						public CefFindHandler,
						public CefFocusHandler,
						public CefJSDialogHandler,
						public CefKeyboardHandler,
						public CefLifeSpanHandler,
						public CefLoadHandler,
						public CefRenderHandler,
						public CefRequestHandler
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

	DKSDLWindow* dkSdlWindow;
	DKCef* dkCef;
	DKSDLCef* dkSdlCef;
	std::vector<SDL_Texture*> cef_images;
	std::vector<SDL_Texture*> background_images;

	// CefContextMenuHandler
	virtual CefRefPtr<CefContextMenuHandler> GetContextMenuHandler() override { return this; }
	void OnBeforeContextMenu(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, CefRefPtr<CefMenuModel> model) override;
	//bool RunContextMenu(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, CefRefPtr<CefMenuModel> model, CefRefPtr<CefRunContextMenuCallback> callback) override;
	bool OnContextMenuCommand(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, int command_id, CefContextMenuHandler::EventFlags event_flags) override;
	//void OnContextMenuDismissed(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame) override;

	// CefDialogHandler
	virtual CefRefPtr<CefDialogHandler> GetDialogHandler() override { return this; }
	bool OnFileDialog(CefRefPtr<CefBrowser> browser, CefDialogHandler::FileDialogMode mode, const CefString& title, const CefString& default_file_path, const std::vector<CefString>& accept_filters, int selected_accept_filter, CefRefPtr<CefFileDialogCallback> callback) override;

	// CefDisplayHandler
	virtual CefRefPtr<CefDisplayHandler> GetDisplayHandler() override { return this; }
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
	virtual CefRefPtr<CefDownloadHandler> GetDownloadHandler() override { return this; }
	void OnBeforeDownload(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDownloadItem> download_item, const CefString& suggested_name, CefRefPtr<CefBeforeDownloadCallback> callback) override;
	//void OnDownloadUpdated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDownloadItem> download_item, CefRefPtr<CefDownloadItemCallback> callback) override;

	// CefDragHandler
	virtual CefRefPtr<CefDragHandler> GetDragHandler() override { return this; }
	//bool OnDragEnter(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDragData> dragData, DragOperationsMask mask) override;
	//void OnDraggableRegionsChanged(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, const std::vector<CefDraggableRegion>& regions) override;

	// CefFindHandler
	virtual CefRefPtr<CefFindHandler> GetFindHandler() override { return this; }

	// CefFocusHandler
	virtual CefRefPtr<CefFocusHandler> GetFocusHandler() override { return this; }

	// CefJSDialogHandler
	virtual CefRefPtr<CefJSDialogHandler> GetJSDialogHandler() override { return this; }

	// CefKeyboardHandler
	virtual CefRefPtr<CefKeyboardHandler> GetKeyboardHandler() override { return this; }

	// CefLifeSpanHandler
	virtual CefRefPtr<CefLifeSpanHandler> GetLifeSpanHandler() override { return this; }
	bool OnBeforePopup(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, const CefString& target_url, const CefString& target_frame_name, CefLifeSpanHandler::WindowOpenDisposition target_disposition, bool user_gesture, const CefPopupFeatures& popupFeatures, CefWindowInfo& windowInfo, CefRefPtr<CefClient>& client, CefBrowserSettings& settings, bool* no_javascript_access);
	void OnAfterCreated(CefRefPtr<CefBrowser> browser) override;
	bool DoClose(CefRefPtr<CefBrowser> browser) override;
	void OnBeforeClose(CefRefPtr<CefBrowser> browser) override;

	// CefLoadHandler
	virtual CefRefPtr<CefLoadHandler> GetLoadHandler() override { return this; }
	void OnLoadingStateChange(CefRefPtr<CefBrowser> browser, bool isLoading, bool canGoBack, bool canGoForward) override;
	//void OnLoadStart(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, TransitionType transition_type) override;
	void OnLoadEnd(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, int httpStatusCode) override;
	void OnLoadError(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefLoadHandler::ErrorCode errorCode, const CefString& errorText, const CefString& failedUrl) override;

	// CefRenderHandler
	virtual CefRefPtr<CefRenderHandler> GetRenderHandler() override { return this; }
	//virtual CefRefPtr<CefAccessibilityHandler> GetAccessibilityHandler() override { return this; }
	//bool GetRootScreenRect(CefRefPtr<CefBrowser> browser, CefRect& rect) override;
	void GetViewRect(CefRefPtr<CefBrowser> browser, CefRect& rect) override;
	//bool GetScreenPoint(CefRefPtr<CefBrowser> browser, int viewX, int viewY, int& screenX, int& screenY) override;
	//bool GetScreenInfo(CefRefPtr<CefBrowser> browser, CefScreenInfo& screen_info) override;
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

	// CefRequestHandler
	//virtual CefRefPtr<CefRequestHandler> GetRequestHandler() override { return this; }


	bool OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefProcessId source_process, CefRefPtr<CefProcessMessage> message);

	void CloseAllBrowsers(bool force_close);
	void DoFrame();
	bool IsClosing() const { return is_closing_; }
	void OnFindResult(CefRefPtr<CefBrowser> browser, int identifier, int count, const CefRect& selectionRect, int activeMatchOrdinal, bool finalUpdate);
	bool OnPreKeyEvent(CefRefPtr<CefBrowser> browser, const CefKeyEvent& event, CefEventHandle os_event, bool* is_keyboard_shortcut);
	bool OnPrintDialog(CefRefPtr<CefBrowser> browser, bool has_selection, CefRefPtr<CefPrintDialogCallback> callback);
	bool OnPrintJob(CefRefPtr<CefBrowser> browser, const CefString& document_name, const CefString& pdf_file_path, CefRefPtr<CefPrintJobCallback> callback){ return true; }
	void OnPrintReset(CefRefPtr<CefBrowser> browser){}
	void OnPrintSettings(CefRefPtr<CefBrowser> browser, CefRefPtr<CefPrintSettings> settings, bool get_defaults){}
	void OnPrintStart(CefRefPtr<CefBrowser> browser){}
	//bool OnRequestGeolocationPermission(CefRefPtr<CefBrowser> browser, const CefString& requesting_url, int request_id, CefRefPtr<CefGeolocationCallback> callback);
	
	IMPLEMENT_REFCOUNTING(DKSDLCefHandler);
};

#endif //DKSDLCefHandler_H