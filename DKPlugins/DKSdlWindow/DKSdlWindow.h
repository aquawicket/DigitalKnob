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
	virtual const DKString& window()							{ DKTODO(); return ""; }								// getter
	virtual void window(const DKString& window)					{ DKERROR("DKSdlWindow.window readonly! \n"); } 		// setter
	
	// [Replaceable] readonly attribute WindowProxy self;
	virtual const DKString& self()								{ DKTODO(); return ""; }								// getter
	virtual void self(const DKString& self)						{ DKERROR("DKSdlWindow.self readonly! \n");} 			// setter
	
	// [LegacyUnforgeable] readonly attribute Document document;
	virtual const DKString& document()							{ DKTODO(); return ""; }								// getter
	virtual void document(const DKString& document)				{ DKERROR("DKSdlWindow.document readonly! \n");} 		// setter
	
	// attribute DOMString name;
	virtual const DOMString& name()								{ DKTODO(); return ""; }								// getter
	virtual void name(const DOMString& name)					{ DKTODO(); } 											// setter
	
	// [PutForwards=href, LegacyUnforgeable] readonly attribute Location location;
	virtual const DKString& location()							{ DKTODO(); return ""; }								// getter
	virtual void location(const DKString& location)				{ DKERROR("DKSdlWindow.location readonly! \n"); } 		// setter
	
	// readonly attribute History history;
	virtual const DKString& history()							{ DKTODO(); return ""; }								// getter
	virtual void history(const DKString& history)				{ DKERROR("DKSdlWindow.history readonly! \n"); } 		// setter
	
	// readonly attribute CustomElementRegistry customElements;
	virtual const DKString& customElements()					{ DKTODO(); return ""; }								// getter
	virtual void customElements(const DKString& customElements)	{ DKERROR("DKSdlWindow.customElements readonly! \n"); } // setter
	
	// [Replaceable] readonly attribute BarProp locationbar;
	virtual const DKString& locationbar()						{ DKTODO(); return ""; }								// getter
	virtual void locationbar(const DKString& locationbar)		{ DKERROR("DKSdlWindow.locationbar readonly! \n"); } 	// setter
	
	// [Replaceable] readonly attribute BarProp menubar;
	virtual const DKString& menubar()							{ DKTODO(); return ""; }								// getter
	virtual void menubar(const DKString& menubar)				{ DKERROR("DKSdlWindow.menubar readonly! \n"); } 		// setter
	
	// [Replaceable] readonly attribute BarProp personalbar;
	virtual const DKString& personalbar()						{ DKTODO(); return ""; }								// getter
	virtual void personalbar(const DKString& personalbar)		{ DKERROR("DKSdlWindow.menubar readonly! \n"); } 		// setter
	
	// [Replaceable] readonly attribute BarProp scrollbars;
	virtual const DKString& scrollbars()						{ DKTODO(); return ""; }								// getter
	virtual void scrollbars(const DKString& scrollbars)			{ DKERROR("DKSdlWindow.scrollbars readonly! \n"); } 	// setter
	
	// [Replaceable] readonly attribute BarProp statusbar;
	virtual const DKString& statusbar()							{ DKTODO(); return "D"; }								// getter
	virtual void statusbar(const DKString& statusbar)			{ DKERROR("DKSdlWindow.statusbar readonly! \n"); } 		// setter
	
	// [Replaceable] readonly attribute BarProp toolbar;
	virtual const DKString& toolbar()							{ DKTODO(); return ""; }								// getter
	virtual void toolbar(const DKString& toolbar)				{ DKERROR("DKSdlWindow.toolbar readonly! \n"); } 		// setter
	
	// attribute DOMString status;
	virtual const DOMString& status()							{ DKTODO(); return ""; }								// getter
	virtual void status(const DOMString& status)				{ DKTODO(); } 											// setter
	
	// undefined close();
	virtual void close() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// readonly attribute boolean closed;
	virtual const bool& closed()								{ DKTODO(); return ""; }								// getter
	virtual void closed(const bool& closed)						{ DKTODO(); } 											// setter
	
	// undefined stop();
	virtual void stop() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// undefined focus();
	virtual void focus() {
		DKDEBUGFUNC();
		SDL_RestoreWindow(_window);
	}
	
	// undefined blur();
	virtual void blur() {
		DKDEBUGFUNC();
		SDL_MinimizeWindow(_window);
	}
	
	// other browsing contexts
	// [Replaceable] readonly attribute WindowProxy frames;
	virtual const DKString& frames()						{ DKTODO(); return ""; }									// getter
	virtual void frames(const DKString& frames)				{ DKERROR("DKSdlWindow.frames readonly! \n"); } 			// setter
	
	// [Replaceable] readonly attribute unsigned long length;
	virtual const unsigned int& length()					{ DKTODO(); return 0; }										// getter
	virtual void length(const unsigned int& length)			{ DKERROR("DKSdlWindow.length readonly! \n"); } 			// setter
	
	// [LegacyUnforgeable] readonly attribute WindowProxy? top;
	virtual const DKString& top()							{ DKTODO(); return ""; }									// getter
	virtual void top(const DKString& top)					{ DKERROR("DKSdlWindow.top readonly! \n"); } 				// setter
	
	// attribute any opener;
	virtual const DKString& opener()						{ DKTODO(); return ""; }									// getter
	virtual void opener(const DKString& opener)				{ DKTODO(); } 												// setter
	
	// [Replaceable] readonly attribute WindowProxy? parent;
	virtual const DKString& parent()						{ DKTODO(); return ""; }									// getter
	virtual void parent(const DKString& parent)				{ DKERROR("DKSdlWindow.parent readonly! \n"); } 			// setter
	
	// readonly attribute Element? frameElement;
	virtual const DKString& frameElement()					{ DKTODO(); return ""; }									// getter
	virtual void frameElement(const DKString& frameElement)	{ DKERROR("DKSdlWindow.frameElement readonly! \n"); } 		// setter
	
	// WindowProxy? open(optional USVString url = "", optional DOMString target = "_blank", optional [LegacyNullToEmptyString] DOMString features = "");
	virtual const DKString& open(const USVString& url = "", const DOMString& target = "_blank", const DOMString& features = "") {
		DKDEBUGFUNC(url, target, features);
		DKTODO();
		return "";
	}
	
	//Since this is the global object, the IDL named getter adds a NamedPropertiesObject exotic
	//object on the prototype chain. Indeed, this does not make the global object an exotic object.
	//Indexed access is taken care of by the WindowProxy exotic object.
	// getter object (DOMString name);
	// TODO
	
	// the user agent
	// readonly attribute Navigator navigator;
	virtual const DKString& navigator()									{ DKTODO(); return ""; }									// getter
	virtual void navigator(const DKString& navigator)					{ DKERROR("DKSdlWindow.navigator readonly! \n"); } 			// setter
	
	// readonly attribute Navigator clientInformation; // legacy alias of .navigator
	virtual const DKString& clientInformation()							{ DKTODO(); return ""; }									// getter
	virtual void clientInformation(const DKString& clientInformation) 	{ DKERROR("DKSdlWindow.clientInformation readonly! \n"); } 	// setter
	
	// readonly attribute boolean originAgentCluster;
	virtual const bool& originAgentCluster()							{ DKTODO(); return false; }									// getter
	virtual void originAgentCluster(const bool& originAgentCluster)		{ DKERROR("DKSdlWindow.originAgentCluster readonly! \n"); } // setter
	
	//user prompts
	// undefined alert();
	virtual void alert() {
		DKDEBUGFUNC();
		if(SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_INFORMATION, "alert", "alert", _window) != 0)
			DKERROR("SDL_ShowSimpleMessageBox() failed! \n    use SDL_GetError() for more info");
	}
	
	// undefined alert(DOMString message);
	virtual void alert(const DOMString& message) {
		DKDEBUGFUNC(message);
		if(SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_INFORMATION, "alert", message.c_str(), _window) != 0)
			DKERROR("SDL_ShowSimpleMessageBox() failed! \n    use SDL_GetError() for more info");
	}
	
	// boolean confirm(optional DOMString message = "");
	virtual const bool& confirm(const DOMString& message = "") {
		DKDEBUGFUNC(message);
		DKTODO();
		return false;
	}
	
	// DOMString? prompt(optional DOMString message = "", optional DOMString default = "");
	virtual const DOMString& prompt(const DOMString& message = "", const DOMString _default = "") {
		DKDEBUGFUNC(message, _default);
		DKTODO();
		return "";
	}
	
	// undefined print();
	virtual void print() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// undefined postMessage(any message, USVString targetOrigin, optional sequence<object> transfer = []);
	virtual void postMessage(const DKString& message, const USVString& targetOrigin, const DKString& transfer = "[]") {
		DKDEBUGFUNC(message, targetOrigin, transfer);
		DKTODO();
	}
	
	// undefined postMessage(any message, optional WindowPostMessageOptions options = {});
	virtual void postMessage(const DKString& message, const DKString& options = "{}") {
		DKDEBUGFUNC(message, options);
		DKTODO();
	}
	
	// also has obsolete members
	
	// Source: Compatibility Standard (https://compat.spec.whatwg.org/)
	// partial interface Window {
	//		readonly attribute short orientation;
			virtual const short& orientation()										{ DKTODO(); return 0; }									// getter
			virtual void orientation(const short& orientation)						{ DKERROR("DKSdlWindow.orientation readonly! \n"); } 	// setter
	//		
	//		attribute EventHandler onorientationchange;
			virtual const DKString& onorientationchange()							{ DKTODO(); return ""; }								// getter
			virtual void onorientationchange(const DKString& onorientationchange)	{ DKTODO(); } 											// setter
	// };
	
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// partial interface Window {
	//		[Replaceable] readonly attribute (Event or undefined) event; // legacy
			virtual const DKString& event()											{ DKTODO(); return ""; }								// getter
			virtual void event(const DKString& event)								{ DKERROR("DKSdlWindow.event readonly! \n"); } 			// setter
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
			virtual void captureEvents() {
				DKDEBUGFUNC();
				DKTODO();
			}
	//
	//		undefined releaseEvents();
			virtual void releaseEvents() {
				DKDEBUGFUNC();
				DKTODO();
			}
	//
	//		[Replaceable, SameObject] readonly attribute External external;
			virtual const DKString& external()							{ DKTODO(); return ""; }	// getter
			virtual void external(const DKString& external)				{ } 						// setter
	// };
	
	// Source: Cookie Store API (https://wicg.github.io/cookie-store/)
	// [SecureContext]
	// partial interface Window {
	//		[SameObject] readonly attribute CookieStore cookieStore;
			virtual const DKString& cookieStore()						{ DKTODO(); return ""; }	// getter
			virtual void cookieStore(const DKString& cookieStore)		{ } 						// setter
	// };
	
	// Source: Digital Goods API (https://wicg.github.io/digital-goods/)
	// partial interface Window {
	//		[SecureContext] Promise<DigitalGoodsService> getDigitalGoodsService(DOMString serviceProvider);
			virtual const DKString& getDigitalGoodsService(const DKString& serviceProvider) {
				DKDEBUGFUNC(serviceProvider);
				DKTODO();
				return "";
			}
	// };
	
	// Source: Fenced frame (https://wicg.github.io/fenced-frame/)
	// partial interface Window {
	//		// Collection of fenced frame APIs
	//		readonly attribute Fence? fence;
			virtual const DKString& fence()							{ DKTODO(); return ""; }	// getter
			virtual void fence(const DKString& fence)				{ } 						// setter
	// };
	
	// Source: File System Access (https://wicg.github.io/file-system-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FileSystemFileHandle>> showOpenFilePicker(optional OpenFilePickerOptions options = {});
			virtual const DKString& showOpenFilePicker(const DKString& options = "{}") {
				DKDEBUGFUNC(options);
				DKTODO();
				return "";
			}
	//
	//		Promise<FileSystemFileHandle> showSaveFilePicker(optional SaveFilePickerOptions options = {});
			virtual const DKString& showSaveFilePicker(const DKString& options = "{}") {
				DKDEBUGFUNC(options);
				DKTODO();
				return "";
			}
	//
	//		Promise<FileSystemDirectoryHandle> showDirectoryPicker(optional DirectoryPickerOptions options = {});
			virtual const DKString& showDirectoryPicker(const DKString& options = "{}") {
				DKDEBUGFUNC(options);
				DKTODO();
				return "";
			}
	// };
	
	// Source: Local Font Access API (https://wicg.github.io/local-font-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FontData>> queryLocalFonts(optional QueryOptions options = {});
			virtual const DKString& queryLocalFonts(const DKString& options = "{}") {
				DKDEBUGFUNC(options);
				DKTODO();
				return "";
			}
	// };
	
	// Source: Manifest Incubations (https://wicg.github.io/manifest-incubations/)
	// partial interface Window {
	//		attribute EventHandler onappinstalled;
			virtual const DKString& onappinstalled()									{ DKTODO(); return ""; }	// getter
			virtual void onappinstalled(const DKString& onappinstalled)					{ DKTODO(); } 				// setter
	//
	//		attribute EventHandler onbeforeinstallprompt;
			virtual const DKString& onbeforeinstallprompt()								{ DKTODO(); return ""; }	// getter
			virtual void onbeforeinstallprompt(const DKString& onbeforeinstallprompt)	{ DKTODO(); } 				// setter
	// };
	
	// Source: Portals (https://wicg.github.io/portals/)
	// partial interface Window {
	//		readonly attribute PortalHost? portalHost;
			virtual const DKString& portalHost()										{ DKTODO(); return ""; }	// getter
			virtual void portalHost(const DKString& portalHost)							{ DKTODO(); } 				// setter
	// };
	
	// Source: Web Speech API (https://wicg.github.io/speech-api/)
	// partial interface Window {
	//		[SameObject] readonly attribute SpeechSynthesis speechSynthesis;
			virtual const DKString& speechSynthesis()									{ DKTODO(); return ""; }	// getter
			virtual void speechSynthesis(const DKString& speechSynthesis)				{ DKTODO(); } 				// setter
	// };
	
	// Source: Web App Launch Handler API (https://wicg.github.io/web-app-launch/)
	// partial interface Window {
	//		readonly attribute LaunchQueue launchQueue;
			virtual const DKString& launchQueue()										{ DKTODO(); return ""; }	// getter
			virtual void launchQueue(const DKString& launchQueue)						{ DKTODO(); } 				// setter
	// };
	
	// Source: CSS Spatial Navigation Level 1 (https://www.w3.org/TR/css-nav-1/)
	// partial interface Window {
	//		undefined navigate(SpatialNavigationDirection dir);
			virtual void navigate(const DKString& dir) {
				DKDEBUGFUNC(dir);
				DKTODO();
			}
	// };
	
	// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
	// partial interface Window {
	//		[NewObject] CSSStyleDeclaration getComputedStyle(Element elt, optional CSSOMString? pseudoElt);
			virtual const DKString& getComputedStyle(const DKString& elt, const DKString& pseudoElt) {
				DKDEBUGFUNC(elt, pseudoElt);
				DKTODO();
				return "";
			}
	// };
	
	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface Window {
	//		[NewObject] MediaQueryList matchMedia(CSSOMString query);
			virtual const DKString& matchMedia(const DKString& mediaQueryString) {
				DKDEBUGFUNC(mediaQueryString);
				DKTODO();
				return "";
			}
	//
	//		[SameObject, Replaceable] readonly attribute Screen screen;
			//virtual DKString screen()									{ DKTODO(); return ""; }	// getter
			//virtual void screen(const DKString&)						{ DKTODO(); } 				// setter
	//
	//		[SameObject, Replaceable] readonly attribute VisualViewport? visualViewport;
			virtual const DKString& visualViewport()					{ DKTODO(); return ""; }	// getter
			virtual void visualViewport(const DKString& visualViewport)	{ DKTODO(); } 				// setter
	//
	//		// browsing context
	//		undefined moveTo(long x, long y);
			virtual void moveTo(const int& x, const int& y) {
				DKDEBUGFUNC(x, y);
				DKTODO();
			}
	//
	//		undefined moveBy(long x, long y);
			virtual void moveBy(const int& x, const int& y) {
				DKDEBUGFUNC(x, y);
				DKTODO();
			}
	//
	//		undefined resizeTo(long width, long height);
			virtual void resizeTo(const int& width, const int& height) {
				DKDEBUGFUNC(width, height);
				DKTODO();
			}
	//
	//		undefined resizeBy(long x, long y);
			virtual void resizeBy(const int& x, const int& y) {
				DKDEBUGFUNC(x, y);
				DKTODO();
			}

	//		// viewport
	//		[Replaceable] readonly attribute long innerWidth;
			virtual const int& innerWidth()						{ DKTODO(); return 0; }		// getter
			virtual void innerWidth(const int& innerWidth)		{ DKTODO(); } 				// setter

	//		[Replaceable] readonly attribute long innerHeight;
			virtual const int& innerHeight()					{ DKTODO(); return 0; }		// getter
			virtual void innerHeight(const int& innerHeight)	{ DKTODO(); } 				// setter

	//		// viewport scrolling
	//		[Replaceable] readonly attribute double scrollX;
			virtual const double& scrollX()						{ DKTODO(); return 0.0; }	// getter
			virtual void scrollX(const double& scrollX)			{ DKTODO(); } 				// setter

	//		[Replaceable] readonly attribute double pageXOffset;
			virtual const double& pageXOffset()					{ DKTODO(); return 0.0; }	// getter
			virtual void pageXOffset(const double& pageXOffset)	{ DKTODO(); } 				// setter

	//		[Replaceable] readonly attribute double scrollY;
			virtual const double& scrollY()						{ DKTODO(); return 0.0; }	// getter
			virtual void scrollY(const double& scrollY)			{ DKTODO(); } 				// setter

	//		[Replaceable] readonly attribute double pageYOffset;
			virtual const double& pageYOffset()					{ DKTODO(); return 0.0; }	// getter
			virtual void pageYOffset(const double& pageYOffset)	{ DKTODO(); } 				// setter
			
	//		undefined scroll(optional ScrollToOptions options = {});
			virtual void scroll(const DKString& options = "{}") {
				DKDEBUGFUNC(options);
				DKTODO();
			}
			
	//		undefined scroll(unrestricted double x, unrestricted double y);
			virtual void scroll(const double& x, const double& y) {
				DKDEBUGFUNC(x, y);
				DKTODO();
			}
	//
	//		undefined scrollTo(optional ScrollToOptions options = {});
			virtual void scrollTo(const DKString& options = "{}") {
				DKDEBUGFUNC(options);
				DKTODO();
			}
			
	//		undefined scrollTo(unrestricted double x, unrestricted double y);
			virtual void scrollTo(const double& x, const double& y) {
				DKDEBUGFUNC(x, y);
				DKTODO();
			}

	//		undefined scrollBy(optional ScrollToOptions options = {});
			virtual void scrollBy(const DKString& options = "{}") {
				DKDEBUGFUNC(options);
				DKTODO();
			}
			
	//		undefined scrollBy(unrestricted double x, unrestricted double y);
			virtual void scrollBy(const double& x, const double& y) {
				DKDEBUGFUNC(x, y);
				DKTODO();
			}
	///
	//		// client
	//		[Replaceable] readonly attribute long screenX;
			virtual const int& screenX(){ 												// getter
				int x;
				SDL_GetWindowPosition(_window, &x, NULL);
				return x;
			}	
			virtual void screenX(const int& x){ 										// setter
				int y;
				SDL_GetWindowPosition(_window, NULL, &y);
				SDL_SetWindowPosition(_window, x, y);
			} 
	//
	//		[Replaceable] readonly attribute long screenLeft;
			virtual const int& screenLeft()						{ DKTODO(); return 0; }	// getter
			virtual void screenLeft(const int& screenLeft)		{ DKTODO(); } 			// setter
	//
	//		[Replaceable] readonly attribute long screenY;
			virtual const int& screenY(){ 												// getter
				int y;
				SDL_GetWindowPosition(_window, NULL, &y);
				return y;
			}
			virtual void screenY(const int& screenY){ 									// setter
				int x;
				SDL_GetWindowPosition(_window, &x, NULL);
				SDL_SetWindowPosition(_window, x, screenY);
			}
	//
	//		[Replaceable] readonly attribute long screenTop;
			virtual const int& screenTop()						{ DKTODO(); return 0; }				// getter
			virtual void screenTop(const int& screenTop)		{ DKTODO(); } 						// setter
	//
	//		[Replaceable] readonly attribute long outerWidth;
			virtual const int& outerWidth(){														// getter
				int width;
				SDL_GetWindowSize(_window, &width, NULL);
				return width;
			}
			virtual void outerWidth(const int& outerWidth){ 				 						// setter
				int height;
				SDL_GetWindowSize(_window, NULL, &height);
				SDL_SetWindowSize(_window, outerWidth, height);
			}
	//
	//		[Replaceable] readonly attribute long outerHeight;
			virtual const int& outerHeight(){														// getter
				int height;
				SDL_GetWindowSize(_window, NULL, &height);
				return height;
			}	
			virtual void outerHeight(const int& outerHeight){										// setter 
				int width;
				SDL_GetWindowSize(_window, &width, NULL);
				SDL_SetWindowSize(_window, width, outerHeight);
			} 			
	//
	//		[Replaceable] readonly attribute double devicePixelRatio;
			virtual const double& devicePixelRatio()												{ DKTODO(); return 0; }		// getter
			virtual void devicePixelRatio(const double& devicePixelRatio)							{ DKTODO(); } 				// setter
	// };
	
	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	// partial interface Window {
	//		[SecureContext] attribute EventHandler ondeviceorientation;
			virtual const DKString& ondeviceorientation()											{ DKTODO(); return ""; }	// getter
			virtual void ondeviceorientation(const DKString& ondeviceorientation)					{ DKTODO(); } 				// setter
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	// partial interface Window {
	//		[SecureContext] attribute EventHandler ondeviceorientationabsolute;
			virtual const DKString& ondeviceorientationabsolute()									{ DKTODO(); return ""; }	// getter
			virtual void ondeviceorientationabsolute(const DKString& ondeviceorientationabsolute)	{ DKTODO(); } 				// setter
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	//	partial interface Window {
	//		[SecureContext] attribute EventHandler ondevicemotion;
			virtual const DKString& ondevicemotion()												{ DKTODO(); return ""; }	// getter
			virtual void ondevicemotion(const DKString& ondevicemotion)								{ DKTODO(); } 				// setter
	// };

	// Source: requestIdleCallback() (https://www.w3.org/TR/requestidlecallback/)
	// partial interface Window {
	//		unsigned long requestIdleCallback(IdleRequestCallback callback, optional IdleRequestOptions options = {});
			virtual const unsigned int& requestIdleCallback(const DKString& callback, const DKString& options = "{}") {
				DKDEBUGFUNC();
				DKTODO();
				return 0;
			}

	//		undefined cancelIdleCallback(unsigned long handle);
			virtual void cancelIdleCallback(const unsigned int& handle) {
				DKDEBUGFUNC(handle);
				DKTODO();
			}
	// };

	// Source: Selection API (https://www.w3.org/TR/selection-api/)
	// partial interface Window {
	//		Selection? getSelection();
			virtual const DKString& getSelection() {
				DKDEBUGFUNC();
				DKTODO();
				return "";
			}
	// };

	// Source: Window Management (https://www.w3.org/TR/window-management/)
	// partial interface Window {
	//		[SecureContext]
	//		Promise<ScreenDetails> getScreenDetails();
			virtual const DKString& getScreenDetails() {
				DKDEBUGFUNC();
				DKTODO();
				return "";
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
	bool Hide(const void* input, void* output);
	bool IsFullscreen(const void* input, void* output);
	bool IsVisible(const void* input, void* output);
	bool MessageBox(const void* input, void* output);
	bool Minimize(const void* input, void* output);
	bool Restore(const void* input, void* output);
	bool SetClipboard(const void* input, void* output);
	bool SetIcon(const void* input, void* output);
	bool SetTitle(const void* input, void* output);
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
