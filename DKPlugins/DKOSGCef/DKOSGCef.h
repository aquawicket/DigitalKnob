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
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#pragma once
#ifndef DKOSGCef_H
#define DKOSGCef_H
#include "DK/DK.h"
#include "DK/DKApp.h"
#include "DKOSGCef/DKOSGCefKeyboard.h"
#include "DKCef/DKCef.h"
#include "DKOSGWindow/DKOSGWindow.h"

//WARNING_DISABLE
#include <osg/MatrixTransform>
#include <osgViewer/ViewerEventHandlers>
#include <include/cef_client.h>
#include <include/cef_render_handler.h>
#include <include/cef_browser_process_handler.h>
#include <include/cef_display_handler.h>
//WARNING_ENABLE


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
	DKOSGCefHandler(osg::Image* cef_image){ 
		DKDEBUGFUNC(cef_image);
		this->cef_image = cef_image; 
	}
	osg::Image* cef_image;
	DKOSGCef* dkosgcef;

	virtual CefRefPtr<CefContextMenuHandler> GetContextMenuHandler(){ 
		DKDEBUGFUNC(); 
		return this; 
	}
	virtual CefRefPtr<CefDisplayHandler> GetDisplayHandler(){ 
		DKDEBUGFUNC(); 
		return this; 
	}
	virtual CefRefPtr<CefDownloadHandler> GetDownloadHandler(){ 
		DKDEBUGFUNC(); 
		return this; 
	}
	virtual CefRefPtr<CefLifeSpanHandler> GetLifeSpanHandler(){ 
		DKDEBUGFUNC(); 
		return this; 
	}
	virtual CefRefPtr<CefLoadHandler> GetLoadHandler(){ 
		DKDEBUGFUNC(); 
		return this; 
	}
	virtual CefRefPtr<CefRenderHandler> GetRenderHandler(){ 
		DKDEBUGFUNC(); 
		return this; 
	}
	
	void DoFrame(){
		//DKDEBUGFUNC();  //EXCESSIVE LOGGING
		CefDoMessageLoopWork(); 
	}

	bool GetViewRect(CefRefPtr<CefBrowser> browser, CefRect &rect){
		DKDEBUGFUNC(browser, rect);
		rect = CefRect(0, 0, DKCef::Get(dkosgcef->id)->width, DKCef::Get(dkosgcef->id)->height);
		return true;
	}

	void OnPaint(CefRefPtr<CefBrowser> browser, PaintElementType type, const RectList &dirtyRects, const void *buffer, int width, int height){
		//DKDEBUGFUNC(browser, type, dirtyRects, buffer, width, height); //EXCESSIVE LOGGING
		if (browser->GetIdentifier() != DKCef::Get(dkosgcef->id)->current_browser->GetIdentifier()){ return; }
		if (type == PET_VIEW && dirtyRects.size() > 0){
			cef_image->setImage(width, height, 1, 4, GL_BGRA, GL_UNSIGNED_BYTE, (unsigned char*)(buffer), osg::Image::NO_DELETE);
		}
	}

	void OnLoadingStateChange(CefRefPtr<CefBrowser> browser, bool isLoading, bool canGoBack, bool canGoForward){
		DKDEBUGFUNC(browser, isLoading, canGoBack, canGoForward);
		DKEvents::SendEvent("GLOBAL", "DKCef_OnLoadingStateChange", "");
	}

	void OnLoadError(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefLoadHandler::ErrorCode errorCode, const CefString& errorText, const CefString& failedUrl){
		DKDEBUGFUNC(browser, frame, errorCode, errorText, failedUrl);
		DKEvents::SendEvent("GLOBAL", "DKCef_OnLoadError", toString(errorCode));
	}

	void OnFullscreenModeChange(CefRefPtr<CefBrowser> browser, bool fullscreen){
		DKDEBUGFUNC(browser, fullscreen);
		DKEvents::SendEvent("GLOBAL", "DKCef_OnFullscreen", toString(fullscreen));
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
			//DKDEBUGFUNC(browser, frame, target_url, target_frame_name, target_disposition, user_gesture, popupFeatures, windowInfo, client, settings, no_javascript_access);
			//windowInfo.windowless_rendering_enabled = TRUE;
			//DKOSGCef::Instance("DKOSGCef")->NewBrowser();
			return false;
	}

	void OnBeforeDownload(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDownloadItem> download_item, const CefString& suggested_name, CefRefPtr<CefBeforeDownloadCallback> callback){
		DKDEBUGFUNC(browser, download_item, suggested_name, callback);
		callback->Continue(suggested_name, true);
	}

	void OnBeforeContextMenu(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, CefRefPtr<CefMenuModel> model){
		DKDEBUGFUNC(browser, frame, params, model);
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
