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
#ifndef DKSdlWindow_H
#define DKSdlWindow_H

//#define SDL_MAIN_HANDLED 1 //Bypass SDL_main() //https://wiki.libsdl.org/SDL_SetMainReady
WARNING_DISABLE
#include "SDL.h"
WARNING_ENABLE

#include "DK/DK.h"
#include "DKWindow/DKWindow.h"


class DKSdlWindow : public DKWindow, public DKObjectT<DKSdlWindow>
{
public:
	DKSdlWindow();
	~DKSdlWindow();
	bool Init();
	bool End();

	// the current browsing context
	// [LegacyUnforgeable] readonly attribute WindowProxy window;
	virtual DKString window()						{ DKTODO(); return ""; }								// getter
	virtual void window(const DKString&)			{ DKERROR("DKSdlWindow.window readonly! \n"); } 		// setter
	
	// [Replaceable] readonly attribute WindowProxy self;
	virtual DKString self()							{ DKTODO(); return ""; }								// getter
	virtual void self(const DKString&)				{ DKERROR("DKSdlWindow.self readonly! \n");} 			// setter
	
	// [LegacyUnforgeable] readonly attribute Document document;
	virtual DKString document()						{ DKTODO(); return ""; }								// getter
	virtual void document(const DKString&)			{ DKERROR("DKSdlWindow.document readonly! \n");} 		// setter
	
	// attribute DOMString name;
	virtual DOMString name()						{ DKTODO(); return ""; }								// getter
	virtual void name(const DOMString&)				{ DKTODO(); } 											// setter
	
	// [PutForwards=href, LegacyUnforgeable] readonly attribute Location location;
	virtual DKString location()						{ DKTODO(); return ""; }								// getter
	virtual void location(const DKString&)			{ DKERROR("DKSdlWindow.location readonly! \n"); } 		// setter
	
	// readonly attribute History history;
	virtual DKString history()						{ DKTODO(); return ""; }								// getter
	virtual void history(const DKString&)			{ DKERROR("DKSdlWindow.history readonly! \n"); } 		// setter
	
	// readonly attribute CustomElementRegistry customElements;
	virtual DKString customElements()				{ DKTODO(); return ""; }								// getter
	virtual void customElements(const DKString&)	{ DKERROR("DKSdlWindow.customElements readonly! \n"); } // setter
	
	// [Replaceable] readonly attribute BarProp locationbar;
	virtual DKString locationbar()					{ DKTODO(); return ""; }								// getter
	virtual void locationbar(const DKString&)		{ DKERROR("DKSdlWindow.locationbar readonly! \n"); } 	// setter
	
	// [Replaceable] readonly attribute BarProp menubar;
	virtual DKString menubar()						{ DKTODO(); return ""; }								// getter
	virtual void menubar(const DKString&)			{ DKERROR("DKSdlWindow.menubar readonly! \n"); } 		// setter
	
	// [Replaceable] readonly attribute BarProp personalbar;
	virtual DKString personalbar()					{ DKTODO(); return ""; }								// getter
	virtual void personalbar(const DKString&)		{ DKERROR("DKSdlWindow.menubar readonly! \n"); } 		// setter
	
	// [Replaceable] readonly attribute BarProp scrollbars;
	virtual DKString scrollbars()					{ DKTODO(); return ""; }								// getter
	virtual void scrollbars(const DKString&)		{ DKERROR("DKSdlWindow.scrollbars readonly! \n"); } 	// setter
	
	// [Replaceable] readonly attribute BarProp statusbar;
	virtual DKString statusbar()					{ DKTODO(); return "D"; }								// getter
	virtual void statusbar(const DKString&)			{ DKERROR("DKSdlWindow.statusbar readonly! \n"); } 		// setter
	
	// [Replaceable] readonly attribute BarProp toolbar;
	virtual DKString toolbar()						{ DKTODO(); return ""; }								// getter
	virtual void toolbar(const DKString&)			{ DKERROR("DKSdlWindow.toolbar readonly! \n"); } 		// setter
	
	// attribute DOMString status;
	virtual DOMString status()						{ DKTODO(); return ""; }								// getter
	virtual void status(const DOMString&)			{ DKTODO(); } 											// setter
	
	// undefined close();
	virtual bool close() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// readonly attribute boolean closed;
	virtual bool closed()							{ DKTODO(); return ""; }								// getter
	virtual void closed(const bool&)				{ DKTODO(); } 											// setter
	
	// undefined stop();
	virtual bool stop() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// undefined focus();
	virtual bool focus() {
		DKDEBUGFUNC();
		SDL_RestoreWindow(_window);
		return true;
	}
	
	// undefined blur();
	virtual bool blur() {
		DKDEBUGFUNC();
		SDL_MinimizeWindow(_window);
		return DKTODO();
	}
	
	// other browsing contexts
	// [Replaceable] readonly attribute WindowProxy frames;
	virtual DKString frames()						{ DKTODO(); return ""; }									// getter
	virtual void frames(const DKString&)			{ DKERROR("DKSdlWindow.frames readonly! \n"); } 			// setter
	
	// [Replaceable] readonly attribute unsigned long length;
	virtual unsigned int length()					{ DKTODO(); return 0; }										// getter
	virtual void length(const unsigned int&)		{ DKERROR("DKSdlWindow.length readonly! \n"); } 			// setter
	
	// [LegacyUnforgeable] readonly attribute WindowProxy? top;
	virtual DKString top()							{ DKTODO(); return ""; }									// getter
	virtual void top(const DKString&)				{ DKERROR("DKSdlWindow.top readonly! \n"); } 				// setter
	
	// attribute any opener;
	virtual DKString opener()						{ DKTODO(); return ""; }									// getter
	virtual void opener(const DKString&)			{ DKTODO(); } 												// setter
	
	// [Replaceable] readonly attribute WindowProxy? parent;
	virtual DKString parent()						{ DKTODO(); return ""; }									// getter
	virtual void parent(const DKString&)			{ DKERROR("DKSdlWindow.parent readonly! \n"); } 			// setter
	
	// readonly attribute Element? frameElement;
	virtual DKString frameElement()					{ DKTODO(); return ""; }									// getter
	virtual void frameElement(const DKString&)		{ DKERROR("DKSdlWindow.frameElement readonly! \n"); } 		// setter
	
	// WindowProxy? open(optional USVString url = "", optional DOMString target = "_blank", optional [LegacyNullToEmptyString] DOMString features = "");
	virtual bool open(USVString& url, DOMString& target, DOMString& features) {
		DKDEBUGFUNC(url, target, features);
		return DKTODO();
	}
	
	//Since this is the global object, the IDL named getter adds a NamedPropertiesObject exotic
	//object on the prototype chain. Indeed, this does not make the global object an exotic object.
	//Indexed access is taken care of by the WindowProxy exotic object.
	// getter object (DOMString name);
	// TODO
	
	// the user agent
	// readonly attribute Navigator navigator;
	virtual DKString navigator()					{ DKTODO(); return ""; }									// getter
	virtual void navigator(const DKString&)			{ DKERROR("DKSdlWindow.navigator readonly! \n"); } 			// setter
	
	// readonly attribute Navigator clientInformation; // legacy alias of .navigator
	virtual DKString clientInformation()			{ DKTODO(); return ""; }			// getter
	virtual void clientInformation(const DKString&) { DKERROR("DKSdlWindow.clientInformation readonly! \n"); } 	// setter
	
	// readonly attribute boolean originAgentCluster;
	virtual bool originAgentCluster()				{ DKTODO(); return false; }									// getter
	virtual void originAgentCluster(const bool&)	{ DKERROR("DKSdlWindow.originAgentCluster readonly! \n"); } // setter
	
	//user prompts
	// undefined alert();
	virtual bool alert() {
		DKDEBUGFUNC();
		if(SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_INFORMATION, "alert", "alert", _window) != 0)
			return DKERROR("SDL_ShowSimpleMessageBox() failed! \n    use SDL_GetError() for more info");
		return true;
	}
	
	// undefined alert(DOMString message);
	virtual bool alert(DOMString& message) {
		DKDEBUGFUNC(message);
		if(SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_INFORMATION, "alert", message.c_str(), _window) != 0)
			return DKERROR("SDL_ShowSimpleMessageBox() failed! \n    use SDL_GetError() for more info");
		return true;
	}
	
	// boolean confirm(optional DOMString message = "");
	virtual bool confirm(DOMString& message) {
		DKDEBUGFUNC(message);
		return DKTODO();
	}
	
	// DOMString? prompt(optional DOMString message = "", optional DOMString default = "");
	virtual bool prompt(DOMString& message, DOMString _default) {
		DKDEBUGFUNC(message, _default);
		return DKTODO();
	}
	
	// undefined print();
	virtual bool print() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// undefined postMessage(any message, USVString targetOrigin, optional sequence<object> transfer = []);
	virtual bool postMessage(DKString& message, USVString& targetOrigin, DKString& transfer) {
		DKDEBUGFUNC(message, targetOrigin, transfer);
		return DKTODO();
	}
	
	// undefined postMessage(any message, optional WindowPostMessageOptions options = {});
	virtual bool postMessage(DKString& message, DKString& options) {
		DKDEBUGFUNC(message, options);
		return DKTODO();
	}
	
	// also has obsolete members
	
	// Source: Compatibility Standard (https://compat.spec.whatwg.org/)
	// partial interface Window {
	//		readonly attribute short orientation;
			virtual short orientation()							{ DKTODO(); return 0; }									// getter
			virtual void orientation(const short&)				{ DKERROR("DKSdlWindow.orientation readonly! \n"); } 	// setter
	//		
	//		attribute EventHandler onorientationchange;
			virtual DKString onorientationchange()				{ DKTODO(); return ""; }								// getter
			virtual void onorientationchange(const DKString&)	{ DKTODO(); } 											// setter
	// };
	
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// partial interface Window {
	//		[Replaceable] readonly attribute (Event or undefined) event; // legacy
			virtual DKString event()							{ DKTODO(); return ""; }								// getter
			virtual void event(const DKString&)					{ DKERROR("DKSdlWindow.event readonly! \n"); } 			// setter
	// };
	
	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// Window includes GlobalEventHandlers;

	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// Window includes WindowEventHandlers;

	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// Window includes WindowOrWorkerGlobalScope;

	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// Window includes AnimationFrameProvider;

	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// Window includes WindowSessionStorage;

	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// Window includes WindowLocalStorage;
	
	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// partial interface Window {
	//		undefined captureEvents();
			virtual bool captureEvents() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	//
	//		undefined releaseEvents();
			virtual bool releaseEvents() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	//
	//		[Replaceable, SameObject] readonly attribute External external;
			virtual DKString external()							{ DKTODO(); return ""; }	// getter
			virtual void external(const DKString&)				{ } 						// setter
	// };
	
	// Source: Cookie Store API (https://wicg.github.io/cookie-store/)
	// [SecureContext]
	// partial interface Window {
	//		[SameObject] readonly attribute CookieStore cookieStore;
			virtual DKString cookieStore()						{ DKTODO(); return ""; }	// getter
			virtual void cookieStore(const DKString&)			{ } 						// setter
	// };
	
	// Source: Digital Goods API (https://wicg.github.io/digital-goods/)
	// partial interface Window {
	//		[SecureContext] Promise<DigitalGoodsService> getDigitalGoodsService(DOMString serviceProvider);
			virtual bool getDigitalGoodsService(DKString& serviceProvider) {
				DKDEBUGFUNC(serviceProvider);
				return DKTODO();
			}
	// };
	
	// Source: Fenced frame (https://wicg.github.io/fenced-frame/)
	// partial interface Window {
	//		// Collection of fenced frame APIs
	//		readonly attribute Fence? fence;
			virtual DKString fence()							{ DKTODO(); return ""; }	// getter
			virtual void fence(const DKString&)					{ } 						// setter
	// };
	
	// Source: File System Access (https://wicg.github.io/file-system-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FileSystemFileHandle>> showOpenFilePicker(optional OpenFilePickerOptions options = {});
			virtual bool showOpenFilePicker(DKString& options) {
				DKDEBUGFUNC(options);
				return DKTODO();
			}
	//
	//		Promise<FileSystemFileHandle> showSaveFilePicker(optional SaveFilePickerOptions options = {});
			virtual bool showSaveFilePicker(DKString& options) {
				DKDEBUGFUNC(options);
				return DKTODO();
			}
	//
	//		Promise<FileSystemDirectoryHandle> showDirectoryPicker(optional DirectoryPickerOptions options = {});
			virtual bool showDirectoryPicker(DKString& options) {
				DKDEBUGFUNC(options);
				return DKTODO();
			}
	// };
	
	// Source: Local Font Access API (https://wicg.github.io/local-font-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FontData>> queryLocalFonts(optional QueryOptions options = {});
			virtual bool queryLocalFonts(DKString& options) {
				DKDEBUGFUNC(options);
				return DKTODO();
			}
	// };
	
	// Source: Manifest Incubations (https://wicg.github.io/manifest-incubations/)
	// partial interface Window {
	//		attribute EventHandler onappinstalled;
			virtual DKString onappinstalled()							{ DKTODO(); return ""; }	// getter
			virtual void onappinstalled(const DKString&)				{ DKTODO(); } 				// setter
	//
	//		attribute EventHandler onbeforeinstallprompt;
			virtual DKString onbeforeinstallprompt()					{ DKTODO(); return ""; }				// getter
			virtual void onbeforeinstallprompt(const DKString&)			{ DKTODO(); } 				// setter
	// };
	
	// Source: Portals (https://wicg.github.io/portals/)
	// partial interface Window {
	//		readonly attribute PortalHost? portalHost;
			virtual DKString portalHost()								{ DKTODO(); return ""; }	// getter
			virtual void portalHost(const DKString&)					{ DKTODO(); } 				// setter
	// };
	
	// Source: Web Speech API (https://wicg.github.io/speech-api/)
	// partial interface Window {
	//		[SameObject] readonly attribute SpeechSynthesis speechSynthesis;
			virtual DKString speechSynthesis()							{ DKTODO(); return ""; }	// getter
			virtual void speechSynthesis(const DKString&)				{ DKTODO(); } 				// setter
	// };
	
	// Source: Web App Launch Handler API (https://wicg.github.io/web-app-launch/)
	// partial interface Window {
	//		readonly attribute LaunchQueue launchQueue;
			virtual DKString launchQueue()								{ DKTODO(); return ""; }	// getter
			virtual void launchQueue(const DKString&)					{ DKTODO(); } 				// setter
	// };
	
	// Source: CSS Spatial Navigation Level 1 (https://www.w3.org/TR/css-nav-1/)
	// partial interface Window {
	//		undefined navigate(SpatialNavigationDirection dir);
			virtual bool navigate(DKString& dir) {
				DKDEBUGFUNC(dir);
				return DKTODO();
			}
	// };
	
	// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
	// partial interface Window {
	//		[NewObject] CSSStyleDeclaration getComputedStyle(Element elt, optional CSSOMString? pseudoElt);
			virtual bool getComputedStyle(DKString& elt, DKString& pseudoElt) {
				DKDEBUGFUNC(elt, pseudoElt);
				return DKTODO();
			}
	// };
	
	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface Window {
	//		[NewObject] MediaQueryList matchMedia(CSSOMString query);
			virtual bool matchMedia(DKString& mediaQueryString) {
				DKDEBUGFUNC(mediaQueryString);
				return DKTODO();
			}
	//
	//		[SameObject, Replaceable] readonly attribute Screen screen;
			virtual DKString screen()								{ DKTODO(); return ""; }	// getter
			virtual void screen(const DKString&)					{ DKTODO(); } 				// setter
	//
	//		[SameObject, Replaceable] readonly attribute VisualViewport? visualViewport;
			virtual DKString visualViewport()						{ DKTODO(); return ""; }	// getter
			virtual void visualViewport(const DKString&)			{ DKTODO(); } 				// setter
	//
	//		// browsing context
	//		undefined moveTo(long x, long y);
			virtual bool moveTo(int& x, int& y) {
				DKDEBUGFUNC(x, y);
				return DKTODO();
			}
	//
	//		undefined moveBy(long x, long y);
			virtual bool moveBy(int& x, int& y) {
				DKDEBUGFUNC(x, y);
				return DKTODO();
			}
	//
	//		undefined resizeTo(long width, long height);
			virtual bool resizeTo(int& width, int& height) {
				DKDEBUGFUNC(width, height);
				return DKTODO();
			}
	//
	//		undefined resizeBy(long x, long y);
			virtual bool resizeBy(int& x, int& y) {
				DKDEBUGFUNC(x, y);
				return DKTODO();
			}
	//
	//		// viewport
	//		[Replaceable] readonly attribute long innerWidth;
			virtual int innerWidth()						{ DKTODO(); return 0; }		// getter
			virtual void innerWidth(const int&)				{ DKTODO(); } 				// setter
	//
	//		[Replaceable] readonly attribute long innerHeight;
			virtual int innerHeight()						{ DKTODO(); return 0; }		// getter
			virtual void innerHeight(const int&)			{ DKTODO(); } 				// setter
	//
	//		// viewport scrolling
	//		[Replaceable] readonly attribute double scrollX;
			virtual double scrollX()						{ DKTODO(); return 0.0; }	// getter
			virtual void scrollX(const double&)				{ DKTODO(); } 				// setter
	//
	//		[Replaceable] readonly attribute double pageXOffset;
			virtual double pageXOffset()					{ DKTODO(); return 0.0; }	// getter
			virtual void pageXOffset(const double&)			{ DKTODO(); } 				// setter
	//
	//		[Replaceable] readonly attribute double scrollY;
			virtual double scrollY()						{ DKTODO(); return 0.0; }	// getter
			virtual void scrollY(const double&)				{ DKTODO(); } 				// setter
	//
	//		[Replaceable] readonly attribute double pageYOffset;
			virtual double pageYOffset()					{ DKTODO(); return 0.0; }	// getter
			virtual void pageYOffset(const double&)			{ DKTODO(); } 				// setter
	//
	//		undefined scroll(optional ScrollToOptions options = {});
	//		undefined scroll(unrestricted double x, unrestricted double y);
			virtual bool scroll() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	//
	//		undefined scrollTo(optional ScrollToOptions options = {});
	//		undefined scrollTo(unrestricted double x, unrestricted double y);
			virtual bool scrollTo() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	//
	//		undefined scrollBy(optional ScrollToOptions options = {});
	//		undefined scrollBy(unrestricted double x, unrestricted double y);
			virtual bool scrollBy() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	///
	//		// client
	//		[Replaceable] readonly attribute long screenX;
			virtual int screenX(){ 													// getter
				int x;
				SDL_GetWindowPosition(_window, &x, NULL);
				return x;
			}	
			virtual void screenX(const int&){ 										// setter
				DKTODO(); 
			} 
	//
	//		[Replaceable] readonly attribute long screenLeft;
			virtual int screenLeft()						{ DKTODO(); return 0; }	// getter
			virtual void screenLeft(const int&)				{ DKTODO(); } 			// setter
	//
	//		[Replaceable] readonly attribute long screenY;
			virtual int screenY()							{ DKTODO(); return 0; }	// getter
			virtual void screenY(const int&)				{ DKTODO(); } 			// setter
	//
	//		[Replaceable] readonly attribute long screenTop;
			virtual int screenTop()							{ DKTODO(); return 0; }	// getter
			virtual void screenTop(const int&)				{ DKTODO(); } 			// setter
	//
	//		[Replaceable] readonly attribute long outerWidth;
			virtual int outerWidth(){										// getter
				int width;
				SDL_GetWindowSize(_window, &width, NULL);
				return width;
			}
			virtual void outerWidth(const int& width){ 				 		// setter
				int height;
				SDL_GetWindowSize(_window, NULL, &height);
				SDL_SetWindowSize(_window, width, height);
			}
	//
	//		[Replaceable] readonly attribute long outerHeight;
			virtual int outerHeight(){										// getter
				int height;
				SDL_GetWindowSize(_window, NULL, &height);
				return height;
			}	
			virtual void outerHeight(const int& height){					// setter 
				int width;
				SDL_GetWindowSize(_window, &width, NULL);
				SDL_SetWindowSize(_window, width, height);
			} 			
	//
	//		[Replaceable] readonly attribute double devicePixelRatio;
			virtual double devicePixelRatio()				{ DKTODO(); return 0; }	// getter
			virtual void devicePixelRatio(const double&)	{ DKTODO(); } 			// setter
	// };
	
	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	// partial interface Window {
	//		[SecureContext] attribute EventHandler ondeviceorientation;
			virtual DKString ondeviceorientation()						{ DKTODO(); return ""; }	// getter
			virtual void ondeviceorientation(const DKString&)			{ DKTODO(); } 				// setter
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	// partial interface Window {
	//		[SecureContext] attribute EventHandler ondeviceorientationabsolute;
			virtual DKString ondeviceorientationabsolute()				{ DKTODO(); return ""; }	// getter
			virtual void ondeviceorientationabsolute(const DKString&)	{ DKTODO(); } 				// setter
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	//	partial interface Window {
	//		[SecureContext] attribute EventHandler ondevicemotion;
			virtual DKString ondevicemotion()							{ DKTODO(); return ""; }	// getter
			virtual void ondevicemotion(const DKString&)				{ DKTODO(); } 				// setter
	// };

	// Source: requestIdleCallback() (https://www.w3.org/TR/requestidlecallback/)
	// partial interface Window {
	//		unsigned long requestIdleCallback(IdleRequestCallback callback, optional IdleRequestOptions options = {});
			virtual bool requestIdleCallback() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	//
	//		undefined cancelIdleCallback(unsigned long handle);
			virtual bool cancelIdleCallback(DKString& handle) {
				DKDEBUGFUNC(handle);
				return DKTODO();
			}
	// };

	// Source: Selection API (https://www.w3.org/TR/selection-api/)
	// partial interface Window {
	//		Selection? getSelection();
			virtual bool getSelection() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	// };

	// Source: Window Management (https://www.w3.org/TR/window-management/)
	// partial interface Window {
	//		[SecureContext]
	//		Promise<ScreenDetails> getScreenDetails();
			virtual bool getScreenDetails() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	// };

	////// DK //////
	bool Fullscreen(const void* input, void* output);
	bool GetClipboard(const void* input, void* output);
	bool GetHandle(const void* input, void* output);
	bool GetMouseX(const void* input, void* output);
	bool GetMouseY(const void* input, void* output);
	bool GetPixelRatio(const void* input, void* output);
	bool GetWidth(const void* input, void* output);
	bool GetY(const void* input, void* output);
	bool Hide(const void* input, void* output);
	bool IsFullscreen(const void* input, void* output);
	bool IsVisible(const void* input, void* output);
	bool MessageBox(const void* input, void* output);
	bool Minimize(const void* input, void* output);
	bool Restore(const void* input, void* output);
	bool SetClipboard(const void* input, void* output);
	bool SetIcon(const void* input, void* output);
	bool SetTitle(const void* input, void* output);
	bool SetX(const void* input, void* output);
	bool SetY(const void* input, void* output);
	bool Show(const void* input, void* output);
	bool Windowed(const void* input, void* output);
	
	static int EventFilter(void* userdata, SDL_Event* event);
	static bool drawBackground(SDL_Renderer *renderer, int w, int h);
	bool handle(SDL_Event* event);
	void Process();
	
	static std::map<int,int> sdlKeyCode;
	static std::map<int,int> sdlCharCode;
	static std::map<int,int> sdlShiftCharCode;
	static std::map<int,int> sdlMacCode;
	void MapInputs();

	SDL_Window* _window;
	SDL_Renderer* renderer;
	//SDL_GLContext context;
	DKString gl_major_version;
	DKString gl_minor_version;
	DKString gl_version;
	DKString gl_vendor;
	DKString gl_renderer;
	//DKString gl_shading;
	DKString gl_extensions;

	DKString mTitle;
	int winX;
	int winY;
	int _width;
	int _height;
	int last_mouseX;
	int last_mouseY;

	static std::vector<std::function<bool(SDL_Event* event)> > event_funcs;
	static std::vector<std::function<bool()> > render_funcs;
	static std::vector<std::function<void()> > update_funcs;

	template<class T>
	static void AddEventFunc(bool (T::*func)(SDL_Event *event), T* _this){
		event_funcs.push_back(std::bind(func, _this, std::placeholders::_1));
	}

	template<class T>
	static void AddRenderFunc(bool (T::*func)(), T* _this){
		render_funcs.push_back(std::bind(func, _this));
	}

	template<class T>
	static void AddRenderFuncFirst(bool (T::*func)(), T* _this){
		render_funcs.insert(render_funcs.begin(), std::bind(func, _this));
	}

	template<class T>
	static void AddUpdateFunc(void (T::* func)(), T* _this){
		update_funcs.push_back(std::bind(func, _this));
	}
};

REGISTER_OBJECT(DKSdlWindow, true)

#endif //DKSdlWindow_H
