#include "DK/stdafx.h"
#include <sstream>
#include <string>
#include "include/base/cef_bind.h"
#include "include/wrapper/cef_closure_task.h"
#include "include/wrapper/cef_helpers.h"
#include "DKSDLCef/DKSDLCefHandler.h"

DKSDLCefHandler* DKSDLCefHandler::g_instance = NULL;


///////////////////////////////////////////////////
void SourceCallback::Visit(const CefString& string)
{
	DKDebug("const CefString&");
	source = string.ToString();
	//replace(source, "<", "&lt;");
	//replace(source, ">", "&gt;");
	//std::stringstream ss;
	//ss << "<html><body bgcolor=\"white\">Source:<pre>" << source << "</pre></body></html>";
	//browser_->GetMainFrame()->LoadString(ss.str(), "http://tests/getsource");
	//DKLog(source+"\n");

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

	//DKEvent::SendEvent("GLOBAL", "DKCef_SourceReceived", source);
	//DKFile::StringToFile(source, "source.html");
}




//////////////////////////////////////////////////////
DKSDLCefHandler::DKSDLCefHandler(): is_closing_(false) 
{
	DKDebug();
	DCHECK(!g_instance);
	g_instance = this;
}

///////////////////////////////////
DKSDLCefHandler::~DKSDLCefHandler() 
{
	DKDebug();
	g_instance = NULL;
}

///////////////////////////////////////////////
DKSDLCefHandler* DKSDLCefHandler::GetInstance() 
{
	DKDebug();
	return g_instance;
}

////////////////////////////////////////////////////////
void DKSDLCefHandler::CloseAllBrowsers(bool force_close)
{
	DKDebug(force_close);
	if(!CefCurrentlyOn(TID_UI)){
		// Execute on the UI thread.
		CefPostTask(TID_UI, base::Bind(&DKSDLCefHandler::CloseAllBrowsers, this, force_close));
		return;
	}

	if(browser_list_.empty()){ return; }

	BrowserList::const_iterator it = browser_list_.begin();
	for(; it != browser_list_.end(); ++it){
		(*it)->GetHost()->CloseBrowser(force_close);
	}
}

////////////////////////////////////////////////////////////
bool DKSDLCefHandler::DoClose(CefRefPtr<CefBrowser> browser) 
{
	DKDebug(browser);
	CEF_REQUIRE_UI_THREAD();

	// Closing the main window requires special handling. See the DoClose()
	// documentation in the CEF header for a detailed destription of this
	// process.
	if (browser_list_.size() == 1) {
		// Set a flag to indicate that the window close should be allowed.
		is_closing_ = true;
	}

	// Allow the close. For windowed browsers this will result in the OS close
	// event being sent.
	return false;
}

///////////////////////////////
void DKSDLCefHandler::DoFrame()
{ 
	//DKDebug();
	CefDoMessageLoopWork(); //FIXME: this breaks SDL keyboard events for Mac OSX
}

///////////////////////////////////////////////////////////////////////////////
bool DKSDLCefHandler::GetViewRect(CefRefPtr<CefBrowser> browser, CefRect& rect)
{
	//DKDebug(browser, "CefRect&");
	if(dkCef->dkBrowsers.size() < 1){ return true; }

	unsigned int i;
	for(i=0; i<dkCef->dkBrowsers.size(); i++){
		if(dkCef->dkBrowsers[i].browser->IsSame(browser)){ break; } //found
		if(i >= dkCef->dkBrowsers.size()-1){ return true; } //not found
	}
	rect = CefRect(0, 0, dkCef->dkBrowsers[i].width, dkCef->dkBrowsers[i].height);
	//DKLog("DKSDLCefHandler::GetViewRect(): "+dkCef->dkBrowsers[i].id+": 0,0,"+toString(dkCef->dkBrowsers[i].width)+","+toString(dkCef->dkBrowsers[i].height)+"\n");
	return true;
}

//////////////////////////////////////////////////////////////////
void DKSDLCefHandler::OnBeforeClose(CefRefPtr<CefBrowser> browser)
{
	DKDebug(browser);
	CEF_REQUIRE_UI_THREAD();

	// Remove from the list of existing browsers.
	/*
	BrowserList::iterator bit = browser_list_.begin();
	for (; bit != browser_list_.end(); ++bit) {
		if ((*bit)->IsSame(browser)) {
			browser_list_.erase(bit);
			break;
		}
	}
	*/

	for(unsigned int i=0; i<browser_list_.size(); i++){
		if(browser_list_[i]->IsSame(browser)){
			browser_list_.erase(browser_list_.begin()+i);
			cef_images.erase(cef_images.begin()+i);
			background_images.erase(background_images.begin()+i);
			break;
		}
	}
}

///////////////////////////////////////////////////////////////////
void DKSDLCefHandler::OnAfterCreated(CefRefPtr<CefBrowser> browser)
{
	DKDebug(browser);
	CEF_REQUIRE_UI_THREAD();
	browser_list_.push_back(browser); //Add to the list of existing browsers.
	cef_images.push_back(NULL);
	background_images.push_back(NULL);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DKSDLCefHandler::OnBeforeContextMenu(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, CefRefPtr<CefMenuModel> model)
{
	DKDebug(browser, frame, params, model);
	model->Clear(); //remove original context menu

	DKString data;
	data += params->GetSelectionText();
	data += ";";
	data += params->GetSourceUrl();
	data += ";";
	data += params->GetLinkUrl();
	//DKLog("DKSDLCefHandler::OnBeforeContextMenu(): data = "+data+"\n");

	DKEvent::SendEvent("GLOBAL", "DKCef_ContextMenu", data);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DKSDLCefHandler::OnBeforeDownload(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDownloadItem> download_item, const CefString& suggested_name, CefRefPtr<CefBeforeDownloadCallback> callback)
{
	DKDebug(browser, download_item, "const CefString&", callback);
	//DKLog("OriginalUrl: "+download_item->GetOriginalUrl().ToString()+")\n");
	UNREFERENCED_PARAMETER(browser);
	UNREFERENCED_PARAMETER(download_item);
	callback->Continue(suggested_name, true);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKSDLCefHandler::OnBeforePopup(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, const CefString& target_url, const CefString& target_frame_name, CefLifeSpanHandler::WindowOpenDisposition target_disposition, bool user_gesture, const CefPopupFeatures& popupFeatures, CefWindowInfo& windowInfo, CefRefPtr<CefClient>& client, CefBrowserSettings& settings, bool* no_javascript_access)
{
	//TODO
	DKDebug(browser, frame, "const CefString&", "const CefString&", target_disposition, user_gesture, "const CefPopupFeatures&", "CefWindowInfo&", client, "CefBrowserSettings&", no_javascript_access);
	
	return false; //DISABLED

	//DKEvent::SendEvent("GLOBAL", "DKCef_OnBeforePopup", target_url);
	if(target_disposition == WOD_NEW_FOREGROUND_TAB){
		//dkCef->queue_new_browser = target_url;
	}
	else{
		dkCef->current_browser->GetMainFrame()->LoadURL(target_url.c_str());
	}
	return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKSDLCefHandler::OnConsoleMessage(CefRefPtr<CefBrowser> browser, cef_log_severity_t level, const CefString& message, const CefString& source, int line)
{
	DKDebug(browser, level, "const CefString&", "const CefString&", line);
	CEF_REQUIRE_UI_THREAD();
	DKString msg = message.ToString();
	replace(msg, "%c", "");
	//DKLog("DKSDLCefHandler::OnConsoleMessage("+msg+","+source.ToString()+","+toString(line)+")\n");
	DKString string = message.ToString();
	replace(string,"%c","");
	int identifier = browser->GetIdentifier();
	DKLog("[CEF:"+toString(identifier)+"] "+string+"\n");
	return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKSDLCefHandler::OnContextMenuCommand(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, int command_id, CefContextMenuHandler::EventFlags event_flags)
{
	DKDebug(browser, frame, params, command_id, event_flags);
	CEF_REQUIRE_UI_THREAD();
	return false;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DKSDLCefHandler::OnCursorChange(CefRefPtr<CefBrowser> browser, CefCursorHandle cursor, CursorType type, const CefCursorInfo& custom_cursor_info)
{
	DKDebug(browser, cursor, type, "const CefCursorInfo&");
	//FIXME
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DKSDLCefHandler::OnFindResult(CefRefPtr<CefBrowser> browser, int identifier, int count, const CefRect& selectionRect, int activeMatchOrdinal, bool finalUpdate)
{
	DKDebug(browser, identifier, count, "CefRect&", activeMatchOrdinal, finalUpdate);
	CEF_REQUIRE_UI_THREAD();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKSDLCefHandler::OnFileDialog(CefRefPtr<CefBrowser> browser, CefDialogHandler::FileDialogMode mode, const CefString& title, const CefString& default_file_path, const std::vector<CefString>& accept_filters, int selected_accept_filter, CefRefPtr<CefFileDialogCallback> callback)
{
	DKDebug(browser, mode, "const CefString&", "const CefString&", "const std::vector<CefString>&", selected_accept_filter, callback);
	return false;
}

////////////////////////////////////////////////////////////////////////////////////////////
void DKSDLCefHandler::OnFullscreenModeChange(CefRefPtr<CefBrowser> browser, bool fullscreen)
{
	DKDebug(browser, fullscreen);
	if(fullscreen){
		dkCef->fullscreen = true;
		//SDL_SetWindowFullscreen(dkSdlWindow->sdlwin, SDL_WINDOW_FULLSCREEN_DESKTOP);
	}
	else{
		dkCef->fullscreen = false;
		//SDL_SetWindowFullscreen(dkSdlWindow->sdlwin, 0);
	}
	DKEvent::SendEvent("GLOBAL", "DKCef_OnFullscreen", toString(fullscreen));
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DKSDLCefHandler::OnLoadEnd(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, int httpStatusCode)
{
	DKDebug(browser, frame, httpStatusCode);
	if(frame->IsMain()){
		DKEvent::SendEvent("GLOBAL", "DKCef_OnLoadEnd", toString(httpStatusCode));
	}

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
#ifndef DEBUG
	browser->SendProcessMessage(PID_BROWSER, msg);
#endif
*/
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DKSDLCefHandler::OnLoadError(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefLoadHandler::ErrorCode errorCode, const CefString& errorText, const CefString& failedUrl)
{ 
	DKDebug(browser, frame, errorCode, "const CefString&", "const CefString&");
	if(errorCode == ERR_ABORTED){ return; } // Don't display an error for downloaded files.

	// Display a load error message.
	std::stringstream ss;
	ss << "<html><body bgcolor=\"white\">"
		"<h2>Failed to load URL "
		<< std::string(failedUrl) << " with error " << std::string(errorText)
		<< " (" << errorCode << ").</h2></body></html>";
	frame->LoadString(ss.str(), failedUrl);
	
	DKEvent::SendEvent("GLOBAL", "DKCef_OnLoadError", toString(errorCode));
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DKSDLCefHandler::OnLoadingStateChange(CefRefPtr<CefBrowser> browser, bool isLoading, bool canGoBack, bool canGoForward)
{
	DKDebug(browser, isLoading, canGoBack, canGoForward);
	for(unsigned int i=0; i<dkCef->dkBrowsers.size(); ++i){
		if(browser->GetIdentifier() == dkCef->dkBrowsers[i].browser->GetIdentifier()){
			DKEvent::SendEvent("GLOBAL", "DKCef_OnLoadingStateChange", toString(i));
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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DKSDLCefHandler::OnPaint(CefRefPtr<CefBrowser> browser, PaintElementType type, const RectList& dirtyRects, const void *buffer, int width, int height)
{
	//DKDebug(browser, type, "const RectList&", buffer, width, height);
	//if(browser->GetIdentifier() != dkCef->current_browser->GetIdentifier()){ return; }
	bool found = false;
	unsigned int b=0;
	for(b=0; b<browser_list_.size(); ++b){
		if(browser_list_[b]->IsSame(browser)){
			found = true;
			break;
		}
	}
	if(!found){ return; }

	if(type == PET_VIEW){
		if(dirtyRects.size() == 0){ return; }
		int w, h;
		SDL_QueryTexture(cef_images[b], NULL, NULL, &w, &h);
		if(w != width || h != height){
			cef_images[b] = SDL_CreateTexture(dkSdlWindow->renderer, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_TARGET, width, height);
		}

		int w2, h2;
		SDL_QueryTexture(background_images[b], NULL, NULL, &w2, &h2);
		if (w2 != width || h2 != height) {
			background_images[b] = SDL_CreateTexture(dkSdlWindow->renderer, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STREAMING, width, height);
		}

		unsigned char * texture_data = NULL;
		int texture_pitch = 0;
		if(SDL_LockTexture(background_images[b], NULL, (void **)&texture_data, &texture_pitch) == 0){
			//copies whole cef bitmap to sdl texture
			std::memcpy(texture_data, buffer, width * height * 4);
			SDL_UnlockTexture(background_images[b]);
		}
	}

	else if(type == PET_POPUP){ //FIXME
		DKLog("DKSDLCefHandler::OnPaint(): type == PET_POPUP\n");
		//if(dirtyRects.size() == 0){ return; }
		if(!dkSdlCef->popup_image){
			dkSdlCef->popup_image = SDL_CreateTexture(dkSdlWindow->renderer, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STREAMING, width, height);
		}
		int w, h;
		SDL_QueryTexture(dkSdlCef->popup_image, NULL, NULL, &w, &h);
		if(w != width || h != height){
			dkSdlCef->popup_image = SDL_CreateTexture(dkSdlWindow->renderer, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STREAMING, width, height);
		}
		void* mPixels;
		int mPitch;
		if(SDL_LockTexture(dkSdlCef->popup_image, NULL, &mPixels, &mPitch) == 0){
			//copies popup bitmap to sdl texture
			std::memcpy(mPixels, buffer, width * height * 4);
			SDL_UnlockTexture(dkSdlCef->popup_image);
		}
	}

	if(cef_images[b]) {	
		SDL_SetRenderTarget(dkSdlWindow->renderer, cef_images[b]);
		SDL_RenderCopy(dkSdlWindow->renderer, background_images[b], NULL, NULL);
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
}

///////////////////////////////////////////////////////////////////////////
void DKSDLCefHandler::OnPopupShow(CefRefPtr<CefBrowser> browser, bool show)
{
	DKDebug(browser, show);
	//TODO
	return;

	if(!show){
		dkSdlCef->popup_image = NULL;
		return;
	}
}

/////////////////////////////////////////////////////////////////////////////////////
void DKSDLCefHandler::OnPopupSize(CefRefPtr<CefBrowser> browser, const CefRect& rect)
{
	DKDebug(browser, "const CefRect&");
	//TODO
	return;

	if(rect.width <= 0 || rect.height <= 0){ return; }
	dkSdlCef->popup_rect = rect;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKSDLCefHandler::OnPreKeyEvent(CefRefPtr<CefBrowser> browser, const CefKeyEvent& event, CefEventHandle os_event, bool* is_keyboard_shortcut)
{
	DKDebug(browser, "const CefKeyEvent&", os_event, is_keyboard_shortcut);
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
		DKLog("OnPreKeyEvent(): KeyDown: "+toString(event.character)+"\n");
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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKSDLCefHandler::OnPrintDialog(CefRefPtr<CefBrowser> browser, bool has_selection, CefRefPtr<CefPrintDialogCallback> callback)
{
	DKDebug(browser, has_selection, callback);
	return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKSDLCefHandler::OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefProcessId source_process, CefRefPtr<CefProcessMessage> message) 
{
	DKDebug(browser, source_process, message);
#ifndef DEBUG
	CEF_REQUIRE_UI_THREAD();
#endif
	//This area is only for multi-process messages, return if using single-process
	if(DKV8::singleprocess){
		DKLog("DKSDLCefHandler::OnProcessMessageReceived("+message->GetName().ToString()+"): message system disabled in single-process mode\n");
		return false;
	}

	CefRefPtr<CefListValue> args = message->GetArgumentList();
	std::string str = "DKSDLCefHandler::OnProcessMessageReceived(): "; 
	str += message->GetName();
	str += "(";
	for(unsigned int i=0; i<args->GetSize(); i++){
		if(args->GetType(i) == VTYPE_INVALID){
			str += "invalid";
		}
		if(args->GetType(i) == VTYPE_NULL){
			str += "null";
		}
		if(args->GetType(i) == VTYPE_BOOL){
			str += toString(args->GetBool(i));
		}
		if(args->GetType(i) == VTYPE_INT){
			str += toString(args->GetInt(i));
		}
		if(args->GetType(i) == VTYPE_DOUBLE){
			str += toString(args->GetDouble(i));
		}
		if(args->GetType(i) == VTYPE_STRING){
			str += args->GetString(i).ToString();
		}
		if(args->GetType(i) == VTYPE_BINARY){
			str += "binary";
		}
		if(args->GetType(i) == VTYPE_DICTIONARY){
			str += "dictionary";
		}
		if(args->GetType(i) == VTYPE_LIST){
			str += "list";
		}

		if(i < args->GetSize()-1){
			str += ",";
		}
	}
	str += ")";
	DKLog(str+"\n");

	if(DKString(message->GetName()) == "OnBrowserCreated"){
		DKV8::GetFunctions(browser);
		return false;
	}
	if(DKString(message->GetName()) == "OnContextCreated"){
		return false;
	}

	DKV8::Execute(browser, DKString(message->GetName()), args);

	return false;
}

/*
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKSDLCefHandler::OnRequestGeolocationPermission(CefRefPtr<CefBrowser> browser, const CefString& requesting_url, int request_id, CefRefPtr<CefGeolocationCallback> callback)
{
	DKDebug(browser, "const CefString&", id, callback);
	CEF_REQUIRE_UI_THREAD();
	callback->Continue(true);
	return true;
}
*/

///////////////////////////////////////////////////////////////////////////////
bool DKSDLCefHandler::OnTooltip(CefRefPtr<CefBrowser> browser, CefString& text)
{
	DKDebug(browser, "CefString&");
	CEF_REQUIRE_UI_THREAD();
	return true;
}