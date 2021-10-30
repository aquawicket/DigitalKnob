#pragma once
#ifndef DKSDLCefHandler_H
#define DKSDLCefHandler_H

#include <list>
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

class DKSDLCefHandler : public CefClient, public CefRenderHandler, public CefLoadHandler, public CefLifeSpanHandler, 
	public CefContextMenuHandler, public CefDownloadHandler, public CefDisplayHandler, 
	public CefDialogHandler
{
public:

	DKSDLCefHandler();
	~DKSDLCefHandler();
	static DKSDLCefHandler* g_instance;
	static DKSDLCefHandler* GetInstance(); //Provide access to the single global instance of this object.
	
	//List of existing browser windows. Only accessed on the CEF UI thread.
	//typedef std::list<CefRefPtr<CefBrowser>> BrowserList;
	typedef std::vector<CefRefPtr<CefBrowser>> BrowserList;
	BrowserList browser_list_;
	bool is_closing_;

	DKSDLWindow* dkSdlWindow;
	DKCef* dkCef;
	DKSDLCef* dkSdlCef;
	std::vector<SDL_Texture*> cef_images;
	std::vector<SDL_Texture*> background_images;

	virtual CefRefPtr<CefContextMenuHandler> GetContextMenuHandler() override { return this; }
	virtual CefRefPtr<CefDialogHandler> GetDialogHandler() override { return this; }
	virtual CefRefPtr<CefDisplayHandler> GetDisplayHandler(){ return this; }
	virtual CefRefPtr<CefDownloadHandler> GetDownloadHandler() override { return this; }
	virtual CefRefPtr<CefLifeSpanHandler> GetLifeSpanHandler() override { return this; }
	virtual CefRefPtr<CefLoadHandler> GetLoadHandler() override { return this; }
	virtual CefRefPtr<CefRenderHandler> GetRenderHandler() override { return this; }

	void CloseAllBrowsers(bool force_close);
	bool DoClose(CefRefPtr<CefBrowser> browser) override;
	void DoFrame();
	void GetViewRect(CefRefPtr<CefBrowser> browser, CefRect& rect) override;
	bool IsClosing() const { return is_closing_; }
	void OnAfterCreated(CefRefPtr<CefBrowser> browser) override;
	void OnBeforeClose(CefRefPtr<CefBrowser> browser) override;
	void OnBeforeContextMenu(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, CefRefPtr<CefMenuModel> model) override;
	void OnBeforeDownload(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDownloadItem> download_item, const CefString& suggested_name, CefRefPtr<CefBeforeDownloadCallback> callback) override;
	bool OnBeforePopup(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, const CefString& target_url, const CefString& target_frame_name, CefLifeSpanHandler::WindowOpenDisposition target_disposition, bool user_gesture, const CefPopupFeatures& popupFeatures, CefWindowInfo& windowInfo, CefRefPtr<CefClient>& client, CefBrowserSettings& settings, bool* no_javascript_access);
	bool OnConsoleMessage(CefRefPtr<CefBrowser> browser, cef_log_severity_t level, const CefString& message, const CefString& source, int line) override;
	bool OnContextMenuCommand(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, int command_id, CefContextMenuHandler::EventFlags event_flags) override;
	void OnCursorChange(CefRefPtr<CefBrowser> browser, CefCursorHandle cursor, CursorType type, const CefCursorInfo& custom_cursor_info) override;
	void OnFindResult(CefRefPtr<CefBrowser> browser, int identifier, int count, const CefRect& selectionRect, int activeMatchOrdinal, bool finalUpdate);
	bool OnFileDialog(CefRefPtr<CefBrowser> browser, CefDialogHandler::FileDialogMode mode, const CefString& title, const CefString& default_file_path, const std::vector<CefString>& accept_filters, int selected_accept_filter, CefRefPtr<CefFileDialogCallback> callback) override;
	void OnFullscreenModeChange(CefRefPtr<CefBrowser> browser, bool fullscreen) override;
	void OnLoadEnd(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, int httpStatusCode) override;
	void OnLoadError(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefLoadHandler::ErrorCode errorCode, const CefString& errorText, const CefString& failedUrl) override;
	void OnLoadingStateChange(CefRefPtr<CefBrowser> browser, bool isLoading, bool canGoBack, bool canGoForward) override;
	void OnPaint(CefRefPtr<CefBrowser> browser, PaintElementType type, const RectList &dirtyRects, const void *buffer, int width, int height) override;
	void OnPopupShow(CefRefPtr<CefBrowser> browser, bool show) override;
	void OnPopupSize(CefRefPtr<CefBrowser> browser, const CefRect& rect) override;
	bool OnPreKeyEvent(CefRefPtr<CefBrowser> browser, const CefKeyEvent& event, CefEventHandle os_event, bool* is_keyboard_shortcut);
	bool OnPrintDialog(CefRefPtr<CefBrowser> browser, bool has_selection, CefRefPtr<CefPrintDialogCallback> callback);
	bool OnPrintJob(CefRefPtr<CefBrowser> browser, const CefString& document_name, const CefString& pdf_file_path, CefRefPtr<CefPrintJobCallback> callback){ return true; }
	void OnPrintReset(CefRefPtr<CefBrowser> browser){}
	void OnPrintSettings(CefRefPtr<CefBrowser> browser, CefRefPtr<CefPrintSettings> settings, bool get_defaults){}
	void OnPrintStart(CefRefPtr<CefBrowser> browser){}
	bool OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefProcessId source_process, CefRefPtr<CefProcessMessage> message) ;
	//bool OnRequestGeolocationPermission(CefRefPtr<CefBrowser> browser, const CefString& requesting_url, int request_id, CefRefPtr<CefGeolocationCallback> callback);
	bool OnTooltip(CefRefPtr<CefBrowser> browser, CefString& text) override;

	IMPLEMENT_REFCOUNTING(DKSDLCefHandler);
};

#endif //DKSDLCefHandler_H