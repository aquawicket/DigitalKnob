#pragma once
#ifndef DKOSGCef_H
#define DKOSGCef_H
#include "DK/DK.h"
#include "DK/DKApp.h"
#include "DKCef/DKOSGCefKeyboard.h"
#include "DKCef/DKCef.h"
#include "DKOSGWindow/DKOSGWindow.h"
#include <osg/MatrixTransform>
#include <osgViewer/ViewerEventHandlers>
#include <include/cef_client.h>
#include <include/cef_render_handler.h>
#include <include/cef_browser_process_handler.h>
#include <include/cef_display_handler.h>

class DKOSGCefHandler;

class DKOSGCef : public osgGA::GUIEventHandler, public DKObjectT<DKOSGCef>
{
public:
	bool Init();
	bool End();

	void* GetTexture(void*);
	void* OnResize(void* data);
	void SetupCef();
	void SetupOsg();

	bool getScrollDeltas(const osgGA::GUIEventAdapter& ea, float &deltaX, float &deltaY);
	bool handle(const osgGA::GUIEventAdapter& ea, osgGA::GUIActionAdapter& aa);
	bool transparentPixel(osgViewer::View* view, const osgGA::GUIEventAdapter& ea);
	CefBrowserHost::MouseButtonType getCefMouseButton(int button);
	
	void setSize(unsigned int width, unsigned int height);

	DKString id;
	DKOSGWindow* dkOsgWindow;
	DKCef* dkCef;
	bool _mouseLMBdown;
	DKOSGCefKeyboard _keyAdapter;
	float _scrollFactor;

	osg::ref_ptr<osg::Camera> cefCam;
	osg::ref_ptr<osg::Image> cef_image;
	DKOSGCefHandler* cefHandler;
	osg::MatrixTransform* modelViewMat;
};


class DKOSGCefHandler : public CefClient, public CefRenderHandler, 
	public CefLoadHandler, public CefLifeSpanHandler, public CefContextMenuHandler,
	public CefDownloadHandler, public CefDisplayHandler
{
public:
	DKOSGCefHandler(osg::Image* cef_image){ this->cef_image = cef_image; }
	osg::Image* cef_image;
	DKOSGCef* dkosgcef;

	virtual CefRefPtr<CefContextMenuHandler> GetContextMenuHandler(){ return this; }
	virtual CefRefPtr<CefDisplayHandler> GetDisplayHandler(){ return this; }
	virtual CefRefPtr<CefDownloadHandler> GetDownloadHandler(){ return this; }
	virtual CefRefPtr<CefLifeSpanHandler> GetLifeSpanHandler(){ return this; }
	virtual CefRefPtr<CefLoadHandler> GetLoadHandler(){ return this; }
	virtual CefRefPtr<CefRenderHandler> GetRenderHandler(){ return this; }
	
	void DoFrame(){ CefDoMessageLoopWork(); }

	bool GetViewRect(CefRefPtr<CefBrowser> browser, CefRect &rect){
		rect = CefRect(0, 0, DKCef::Get(dkosgcef->id)->width, DKCef::Get(dkosgcef->id)->height);
		return true;
	}

	void OnPaint(CefRefPtr<CefBrowser> browser, PaintElementType type, const RectList &dirtyRects, const void *buffer, int width, int height){
		if (browser->GetIdentifier() != DKCef::Get(dkosgcef->id)->current_browser->GetIdentifier()){ return; }
		if (type == PET_VIEW && dirtyRects.size() > 0){
			cef_image->setImage(width, height, 1, 4, GL_BGRA, GL_UNSIGNED_BYTE, (unsigned char*)(buffer), osg::Image::NO_DELETE);
		}
	}

	void OnLoadingStateChange(CefRefPtr<CefBrowser> browser, bool isLoading, bool canGoBack, bool canGoForward){
		//DKLog("BrowserClient::OnLoadingStateChange()\n");
		DKEvent::SendEvent("GLOBAL", "DKCef_OnLoadingStateChange", "");
	}

	void OnLoadError(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefLoadHandler::ErrorCode errorCode, const CefString& errorText, const CefString& failedUrl){ 
		DKEvent::SendEvent("GLOBAL", "DKCef_OnLoadError", toString(errorCode));
	}

	void OnFullscreenModeChange(CefRefPtr<CefBrowser> browser, bool fullscreen){
		DKEvent::SendEvent("GLOBAL", "DKCef_OnFullscreen", toString(fullscreen));
	}
	
	bool OnBeforePopup(CefRefPtr<CefBrowser> browser,
		CefRefPtr<CefFrame> frame,
		const CefString& target_url,
		const CefString& target_frame_name,
		WindowOpenDisposition target_disposition,
		bool user_gesture,
		const CefPopupFeatures& popupFeatures,
		CefWindowInfo& windowInfo,
		CefRefPtr<CefClient>& client,
		CefBrowserSettings& settings,
		bool* no_javascript_access) {
		DKLog("DKOSGCefHandler::OnBeforePopup()\n", DKINFO);
		//windowInfo.windowless_rendering_enabled = TRUE;
		//DKOSGCef::Instance("DKOSGCef")->NewBrowser();
		return false;
	}

	void OnBeforeDownload(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDownloadItem> download_item, const CefString& suggested_name, CefRefPtr<CefBeforeDownloadCallback> callback){
		UNREFERENCED_PARAMETER(browser);
		UNREFERENCED_PARAMETER(download_item);
		callback->Continue(suggested_name, true);
	}

	void OnBeforeContextMenu(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, CefRefPtr<CefMenuModel> model){
		DKLog("OnBeforeContextMenu \n", DKINFO);
		model->Clear(); //remove original context menu
		DKString data;
		data += params->GetSelectionText();
		data += ",";
		data += params->GetSourceUrl();
		data += ",";
		data += params->GetLinkUrl();
		SendEvent("GLOBAL", "DKCef_ContextMenu", data);
	}

	IMPLEMENT_REFCOUNTING(DKOSGCefHandler);
};

REGISTER_OBJECT(DKOSGCef, true);

#endif //DKOSGCef_H