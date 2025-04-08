/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
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

#include "DK/stdafx.h"
#include "DKSDLCef/DKSDLCefHandler.h"
#include "DKCef/DKCef.h"

//WARNING_DISABLE
	#include <sstream>
	#include <string>
	#include "include/base/cef_bind.h"
	#include "include/wrapper/cef_closure_task.h"
	#include "include/wrapper/cef_helpers.h"
//WARNING_ENABLE


DKSDLCefHandler* DKSDLCefHandler::g_instance = NULL;

void SourceCallback::Visit(const CefString& string){
	DKDEBUGFUNC(string);
	source = string.ToString();
	//replace(source, "<", "&lt;");
	//replace(source, ">", "&gt;");
	//std::stringstream ss;
	//ss << "<html><body bgcolor=\"white\">Source:<pre>" << source << "</pre></body></html>";
	//browser_->GetMainFrame()->LoadString(ss.str(), "http://tests/getsource");
	//DKINFO(source+"\n");

	replace(source, "\"", "\\\"");
	replace(source, "\'", "\\\'");
	replace(source, "\n", "");
	/*
	replace(source, "&", "\\\&");
	replace(source, "\"", "\\\"");
	replace(source, "\'", "\\\'");
	replace(source, "<", "\\\<");
	replace(source, ">", "\\\>");
	*/

	//DKEvent::SendEvent("window", "DKCef_SourceReceived", source);
	//DKFile::StringToFile(source, "source.html");
}



DKSDLCefHandler::DKSDLCefHandler(): is_closing_(false){
	DKDEBUGFUNC();
	DCHECK(!g_instance);
	g_instance = this;
}

DKSDLCefHandler::~DKSDLCefHandler(){
	DKDEBUGFUNC();
	g_instance = NULL;
}

DKSDLCefHandler* DKSDLCefHandler::GetInstance(){
	DKDEBUGFUNC();
	return g_instance;
}

void DKSDLCefHandler::CloseAllBrowsers(bool force_close){
	DKDEBUGFUNC(force_close);
	if(!CefCurrentlyOn(TID_UI)){
		// Execute on the UI thread.
		CefPostTask(TID_UI, base::Bind(&DKSDLCefHandler::CloseAllBrowsers, this, force_close));
		return;
	}

	if(browser_list_.empty())
		return;

	BrowserList::const_iterator it = browser_list_.begin();
	for(; it != browser_list_.end(); ++it)
		(*it)->GetHost()->CloseBrowser(force_close);
}

bool DKSDLCefHandler::DoClose(CefRefPtr<CefBrowser> browser){
	DKDEBUGFUNC(browser);
	CEF_REQUIRE_UI_THREAD();

	// Closing the main window requires special handling. See the DoClose()
	// documentation in the CEF header for a detailed destription of this
	// process.
	if (browser_list_.size() == 1)
		is_closing_ = true; // Set a flag to indicate that the window close should be allowed.

	// Allow the close. For windowed browsers this will result in the OS close
	// event being sent.
	return false;
}

void DKSDLCefHandler::DoFrame(){
	//DKDEBUGFUNC();  //EXCESSIVE LOGGING
	CEF_REQUIRE_UI_THREAD();
	if(!DKApp::active)
		return;
	CefDoMessageLoopWork(); //FIXME: this breaks SDL keyboard events for Mac OSX
}

void DKSDLCefHandler::GetViewRect(CefRefPtr<CefBrowser> browser, CefRect& rect){
	DKDEBUGFUNC(browser, rect);
	if(dkCef->dkBrowsers.size() < 1){ //No Browsers
		DKERROR("DKSDLCefHandler::GetViewRect: No browsers found.");
		return; 
	}

	unsigned int i;
	for(i=0; i<dkCef->dkBrowsers.size(); i++){
		if(dkCef->dkBrowsers[i].browser->IsSame(browser)){ break; } //found
		if(i >= dkCef->dkBrowsers.size()-1){ //not found
			DKERROR("DKSDLCefHandler::GetViewRect: browser not found.");
			return; 
		} 
	}
	rect = CefRect(0, 0, dkCef->dkBrowsers[i].width, dkCef->dkBrowsers[i].height);
	DKDEBUGRETURN(browser, dkCef->dkBrowsers[i].id, dkCef->dkBrowsers[i].top, dkCef->dkBrowsers[i].left, dkCef->dkBrowsers[i].width, dkCef->dkBrowsers[i].height);
}

void DKSDLCefHandler::OnBeforeClose(CefRefPtr<CefBrowser> browser){
	DKDEBUGFUNC(browser);
	CEF_REQUIRE_UI_THREAD();

	// Remove from the list of existing browsers.
	/*
	BrowserList::iterator bit = browser_list_.begin();
	for (; bit != browser_list_.end(); ++bit){
		if ((*bit)->IsSame(browser)){
			browser_list_.erase(bit);
			break;
		}
	}
	*/

	for(unsigned int i=0; i<browser_list_.size(); i++){
		if(browser_list_[i]->IsSame(browser)){
			browser_list_.erase(browser_list_.begin()+i);
			cef_texture.erase(cef_texture.begin()+i);
			break;
		}
	}
}

void DKSDLCefHandler::OnAfterCreated(CefRefPtr<CefBrowser> browser){
	DKDEBUGFUNC(browser);
	CEF_REQUIRE_UI_THREAD();
	browser_list_.push_back(browser); //Add to the list of existing browsers.
	cef_texture.push_back(NULL);
	
	dkCef->current_browser = browser;
	if (!dkCef->dkBrowsers.size()){
		DKERROR("DKSDLCefHandler::OnAfterCreated(): !dkCef->dkBrowsers.size()\n");
		return;
	}
	dkCef->dkBrowsers[dkCef->dkBrowsers.size()-1].browser = browser;
}

void DKSDLCefHandler::OnBeforeContextMenu(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, CefRefPtr<CefMenuModel> model){
	DKDEBUGFUNC(browser, frame, params, model);
	model->Clear(); //remove original context menu
	DKString data;
	data += params->GetSelectionText();
	data += ";";
	data += params->GetSourceUrl();
	data += ";";
	data += params->GetLinkUrl();
	DKEvents::SendEvent("window", "DKCef_ContextMenu", data);
	DKDEBUGRETURN(data);
}

void DKSDLCefHandler::OnBeforeDownload(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDownloadItem> download_item, const CefString& suggested_name, CefRefPtr<CefBeforeDownloadCallback> callback){
	DKDEBUGFUNC(browser, download_item, suggested_name, callback);
	//DKINFO("OriginalUrl: "+download_item->GetOriginalUrl().ToString()+")\n");
	callback->Continue(suggested_name, true);
}

// TODO
bool DKSDLCefHandler::OnBeforePopup(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, const CefString& target_url, const CefString& target_frame_name, CefLifeSpanHandler::WindowOpenDisposition target_disposition, bool user_gesture, const CefPopupFeatures& popupFeatures, CefWindowInfo& windowInfo, CefRefPtr<CefClient>& client, CefBrowserSettings& settings, bool* no_javascript_access){
	DKDEBUGFUNC(browser, frame, target_url, target_frame_name, target_disposition, user_gesture, popupFeatures, /*windowInfo,*/ client, settings, no_javascript_access);
	DK_UNUSED(windowInfo);
	return false; //DISABLED

	/*
	//DKEvent::SendEvent("window", "DKCef_OnBeforePopup", target_url);
	if(target_disposition == WOD_NEW_FOREGROUND_TAB){
		//dkCef->queue_new_browser = target_url;
	}
	else{
		dkCef->current_browser->GetMainFrame()->LoadURL(target_url.c_str());
	}
	return true;
	*/
}

bool DKSDLCefHandler::OnConsoleMessage(CefRefPtr<CefBrowser> browser, cef_log_severity_t level, const CefString& message, const CefString& source, int line){
	return dkCef->OnConsoleMessage(browser, level, message, source, line);
}

bool DKSDLCefHandler::OnContextMenuCommand(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, int command_id, CefContextMenuHandler::EventFlags event_flags){
	DKDEBUGFUNC(browser, frame, params, command_id, event_flags);
	CEF_REQUIRE_UI_THREAD();
	return false;
}

void DKSDLCefHandler::OnCursorChange(CefRefPtr<CefBrowser> browser, CefCursorHandle cursor, CursorType type, const CefCursorInfo& custom_cursor_info){
	DKDEBUGFUNC(browser, cursor, type, custom_cursor_info);
	//FIXME
#	if WIN
		HWND hwnd;
		if(!DKClass::CallFunc("DKSDLWindow::GetHandle", NULL, &hwnd)){ return; }
		if(!::IsWindow(hwnd)){ return; }
		SetClassLongPtr(hwnd, GCLP_HCURSOR, static_cast<LONG>(reinterpret_cast<LONG_PTR>(cursor)));
		SetCursor(cursor);
#	endif
#	if LINUX
		//Display* dpy;// = glfwGetX11Display();
		//Cursor c;
		//c = XCreateFontCursor(dpy, XC_xterm); 
		//XDefineCursor(dpy, w, c);
#	endif
}

void DKSDLCefHandler::OnFindResult(CefRefPtr<CefBrowser> browser, int identifier, int count, const CefRect& selectionRect, int activeMatchOrdinal, bool finalUpdate){
	DKDEBUGFUNC(browser, identifier, count, selectionRect, activeMatchOrdinal, finalUpdate);
	CEF_REQUIRE_UI_THREAD();
}

bool DKSDLCefHandler::OnFileDialog(CefRefPtr<CefBrowser> browser, CefDialogHandler::FileDialogMode mode, const CefString& title, const CefString& default_file_path, const std::vector<CefString>& accept_filters, int selected_accept_filter, CefRefPtr<CefFileDialogCallback> callback){
	DKDEBUGFUNC(browser, mode, title, default_file_path, accept_filters, selected_accept_filter, callback);
	return false;
}

void DKSDLCefHandler::OnFullscreenModeChange(CefRefPtr<CefBrowser> browser, bool fullscreen){
	DKDEBUGFUNC(browser, fullscreen);
	if(fullscreen){
		dkCef->fullscreen = true;
		//SDL_SetWindowFullscreen(dkSdlWindow->sdlwin, SDL_WINDOW_FULLSCREEN_DESKTOP);
	}
	else{
		dkCef->fullscreen = false;
		//SDL_SetWindowFullscreen(dkSdlWindow->sdlwin, 0);
	}
	DKEvents::SendEvent("window", "DKCef_OnFullscreen", toString(fullscreen));
}

void DKSDLCefHandler::OnLoadEnd(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, int httpStatusCode){
	DKDEBUGFUNC(browser, frame, httpStatusCode);
	if(frame->IsMain())
		DKEvents::SendEvent("window", "DKCef_OnLoadEnd", toString(httpStatusCode));

	//FIXME - causes facebook to hang
	//store the page source in dkCef->source
	/*
	if(httpStatusCode == 0){
		dkCef->source.clear();
		CefRefPtr<SourceCallback> sourceCallback = new SourceCallback(browser, dkCef->source);
		browser->GetMainFrame()->GetSource(sourceCallback);
	}
	*/

/*
	CefRefPtr<CefProcessMessage> msg = CefProcessMessage::Create("TestMessage");
	CefRefPtr<CefListValue> args = msg->GetArgumentList(); // Retrieve the argument list object.
#	ifndef DEBUG
		browser->SendProcessMessage(PID_BROWSER, msg);
#	endif
*/
}

void DKSDLCefHandler::OnLoadError(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefLoadHandler::ErrorCode errorCode, const CefString& errorText, const CefString& failedUrl){
	DKDEBUGFUNC(browser, frame, errorCode, "const CefString&", "const CefString&");
	if(errorCode == ERR_ABORTED){ return; } // Don't display an error for downloaded files.

	// Display a load error message.
	std::stringstream ss;
	ss << "<html><body bgcolor=\"white\">"
		"<h2>Failed to load URL "
		<< std::string(failedUrl) << " with error " << std::string(errorText)
		<< " (" << errorCode << ").</h2></body></html>";
	//frame->LoadString(ss.str(), failedUrl); //FIXME
	
	DKEvents::SendEvent("window", "DKCef_OnLoadError", toString(errorCode));
}

void DKSDLCefHandler::OnLoadingStateChange(CefRefPtr<CefBrowser> browser, bool isLoading, bool canGoBack, bool canGoForward){
	DKDEBUGFUNC(browser, isLoading, canGoBack, canGoForward);
	for(unsigned int i=0; i<dkCef->dkBrowsers.size(); ++i){
		if(browser->GetIdentifier() == dkCef->dkBrowsers[i].browser->GetIdentifier()){
			DKEvents::SendEvent("window", "DKCef_OnLoadingStateChange", toString(i));
			return;
		}
	}

	/*
	if(!isLoading){
		dkCef->source.clear();
		CefRefPtr<SourceCallback> sourceCallback = new SourceCallback(browser, dkCef->source);
		browser->GetMainFrame()->GetSource(sourceCallback);
	}
	*/
}

void DKSDLCefHandler::OnPaint(CefRefPtr<CefBrowser> browser, PaintElementType type, const RectList& dirtyRects, const void *buffer, int width, int height){
	//DKDEBUGFUNC(browser, type, dirtyRects, buffer, width, height);  //EXCESSIVE LOGGING
	//if(browser->GetIdentifier() != dkCef->current_browser->GetIdentifier())
		//return;
	bool found = false;
	unsigned int n=0;
	for(n=0; n<browser_list_.size(); ++n){
		if(browser_list_[n]->IsSame(browser)){
			found = true;
			break;
		}
	}
	if(!found)
		return;

	if(type == PET_VIEW){
		if(dirtyRects.size() == 0)
			return;

		int w2, h2;
		SDL_QueryTexture(cef_texture[n], NULL, NULL, &w2, &h2);
		if (w2 != width || h2 != height)
			cef_texture[n] = SDL_CreateTexture(dkSdlWindow->renderer, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STREAMING, width, height);
		SDL_SetTextureBlendMode(cef_texture[n], SDL_BLENDMODE_BLEND);
		unsigned char* texture_data;
		int texture_pitch;
		if (SDL_LockTexture(cef_texture[n], NULL, (void**)&texture_data, &texture_pitch) != 0){
			DKERROR("SDL_LockTexture(cef_texture[n]...) failed\n");
			return;
		}
		std::memcpy(texture_data, buffer, width * height * 4); //copies cef bitmap to sdl texture
		SDL_UnlockTexture(cef_texture[n]);
	}
	/*
	else if(type == PET_POPUP){ //FIXME
		DKINFO("DKSDLCefHandler::OnPaint(): type == PET_POPUP\n");
		//if(dirtyRects.size() == 0){ return; }
		if(!dkSdlCef->popup_image)
			dkSdlCef->popup_image = SDL_CreateTexture(dkSdlWindow->renderer, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STREAMING, width, height);
		int w, h;
		SDL_QueryTexture(dkSdlCef->popup_image, NULL, NULL, &w, &h);
		if(w != width || h != height)
			dkSdlCef->popup_image = SDL_CreateTexture(dkSdlWindow->renderer, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STREAMING, width, height);
		void* mPixels;
		int mPitch;
		if(SDL_LockTexture(dkSdlCef->popup_image, NULL, &mPixels, &mPitch) == 0){
			//copies popup bitmap to sdl texture
			std::memcpy(mPixels, buffer, width * height * 4);
			SDL_UnlockTexture(dkSdlCef->popup_image);
		}
	}
	*/
	/*
	if(cef_texture[n]){
		SDL_SetRenderTarget(dkSdlWindow->renderer, cef_texture[n]);
		SDL_SetRenderDrawColor(dkSdlWindow->renderer, 255, 255, 255, 255);
		SDL_RenderFillRect(dkSdlWindow->renderer, NULL);
		SDL_RenderCopy(dkSdlWindow->renderer, cef_texture[n], NULL, NULL);
		if(dkSdlCef->popup_image){
			SDL_Rect popup;
			popup.x = dkSdlCef->popup_rect.x;
			popup.y = dkSdlCef->popup_rect.y;
			popup.w = dkSdlCef->popup_rect.width;
			popup.h = dkSdlCef->popup_rect.height;
			SDL_RenderCopy(dkSdlWindow->renderer, dkSdlCef->popup_image, NULL, &popup);	
		}
		SDL_SetRenderTarget(dkSdlWindow->renderer, NULL);
	}
	*/
}

void DKSDLCefHandler::OnPopupShow(CefRefPtr<CefBrowser> browser, bool show){
	DKDEBUGFUNC(browser, show);
	
	//TODO
	return;
	/*
	if(!show){
		dkSdlCef->popup_image = NULL;
		return;
	}
	*/
}

void DKSDLCefHandler::OnPopupSize(CefRefPtr<CefBrowser> browser, const CefRect& rect){
	DKDEBUGFUNC(browser, rect);
	
	//TODO
	return;
	/*
	if(rect.width <= 0 || rect.height <= 0){ return; }
	dkSdlCef->popup_rect = rect;
	*/
}

bool DKSDLCefHandler::OnPreKeyEvent(CefRefPtr<CefBrowser> browser, const CefKeyEvent& event, CefEventHandle os_event, bool* is_keyboard_shortcut){
	DKDEBUGFUNC(browser, "const CefKeyEvent&", os_event, is_keyboard_shortcut);
	CEF_REQUIRE_UI_THREAD();
	if(event.type == KEYEVENT_RAWKEYDOWN){
		//DKINFO("OnPreKeyEvent(): RawKeyDown: "+toString(event.character)+"\n");
		//#if WIN
			DKEvents::SendEvent("window", "keydown", toString(event.windows_key_code));
		//#else
		//	DKEvent::SendEvent("window", "keydown", toString(event.character));
		//#endif
	}
	if(event.type == KEYEVENT_KEYDOWN){
		DKINFO("OnPreKeyEvent(): KeyDown: "+toString(event.character)+"\n");
	}
	if(event.type == KEYEVENT_KEYUP){
		//DKINFO("OnPreKeyEvent(): KeyUp: "+toString(event.character)+"\n");
	}
	if(event.type == KEYEVENT_CHAR){
		//DKINFO("OnPreKeyEvent(): KeyChar: "+toString(event.character)+"\n");
		DKEvents::SendEvent("window", "keypress", toString(event.character));
	}
	return false;
}

bool DKSDLCefHandler::OnPrintDialog(CefRefPtr<CefBrowser> browser, bool has_selection, CefRefPtr<CefPrintDialogCallback> callback){
	DKDEBUGFUNC(browser, has_selection, callback);
	return true;
}

bool DKSDLCefHandler::OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefProcessId source_process, CefRefPtr<CefProcessMessage> message){
	DKDEBUGFUNC(browser, source_process, message);
#ifndef DEBUG
	CEF_REQUIRE_UI_THREAD();
#endif
	//This area is only for multi-process messages, return if using single-process
	if(DKV8::singleprocess){
		DKWARN("DKSDLCefHandler::OnProcessMessageReceived("+message->GetName().ToString()+"): message system disabled in single-process mode\n");
		return false;
	}

	CefRefPtr<CefListValue> args = message->GetArgumentList();
	std::string str = "DKSDLCefHandler::OnProcessMessageReceived(): "; 
	str += message->GetName();
	str += "(";
	for(unsigned int i=0; i<args->GetSize(); i++){
		if(args->GetType(i) == VTYPE_INVALID)
			str += "invalid";
		if(args->GetType(i) == VTYPE_NULL)
			str += "null";
		if(args->GetType(i) == VTYPE_BOOL)
			str += toString(args->GetBool(i));
		if (args->GetType(i) == VTYPE_INT)
			str += toString(args->GetInt(i));
		if(args->GetType(i) == VTYPE_DOUBLE)
			str += toString(args->GetDouble(i));
		if(args->GetType(i) == VTYPE_STRING)
			str += args->GetString(i).ToString();
		if(args->GetType(i) == VTYPE_BINARY)
			str += "binary";
		if(args->GetType(i) == VTYPE_DICTIONARY)
			str += "dictionary";
		if (args->GetType(i) == VTYPE_LIST)
			str += "list";
		if(i < args->GetSize()-1)
			str += ",";
	}
	str += ")";
	DKINFO(str+"\n");
	if(DKString(message->GetName()) == "OnBrowserCreated"){
		DKV8::GetFunctions(browser);
		return false;
	}
	if(DKString(message->GetName()) == "OnContextCreated")
		return false;
	DKV8::Execute(browser, DKString(message->GetName()), args);
	return false;
}

/*
bool DKSDLCefHandler::OnRequestGeolocationPermission(CefRefPtr<CefBrowser> browser, const CefString& requesting_url, int request_id, CefRefPtr<CefGeolocationCallback> callback){
	DKDEBUGFUNC(browser, "const CefString&", id, callback);
	CEF_REQUIRE_UI_THREAD();
	callback->Continue(true);
	return true;
}
*/

bool DKSDLCefHandler::OnTooltip(CefRefPtr<CefBrowser> browser, CefString& text){
	DKDEBUGFUNC(browser, text);
	CEF_REQUIRE_UI_THREAD();
	return true;
}

bool DKSDLCefHandler::GetScreenInfo(CefRefPtr<CefBrowser> browser, CefScreenInfo& screen_info){
	DKDEBUGFUNC(browser, screen_info);
	CEF_REQUIRE_UI_THREAD();
	return true;
}