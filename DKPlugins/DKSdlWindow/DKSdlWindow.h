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


class DKSdlWindow : virtual public DKWindow//, public DKObjectT<DKSdlWindow>
{
public:
	DKSdlWindow();
	~DKSdlWindow();

	/*
	// the current browsing context
	// [LegacyUnforgeable] readonly attribute WindowProxy window;
	virtual const DKString& window() override								{ DKTODO(); return ""; }								// getter
	virtual void window(const DKString& window) override					{ DKERROR("DKSdlWindow.window readonly! \n"); } 		// setter
	
	// [Replaceable] readonly attribute WindowProxy self;
	virtual const DKString& self() override									{ DKTODO(); return ""; }								// getter
	virtual void self(const DKString& self) override						{ DKERROR("DKSdlWindow.self readonly! \n");} 			// setter
	
	// [LegacyUnforgeable] readonly attribute Document document;
	virtual const DKString& document() override								{ DKTODO(); return ""; }								// getter
	virtual void document(const DKString& document) override				{ DKERROR("DKSdlWindow.document readonly! \n");} 		// setter
	
	// attribute DOMString name;
	virtual const DOMString& name() override								{ DKTODO(); return ""; }								// getter
	virtual void name(const DOMString& name) override						{ DKTODO(); } 											// setter
	
	// [PutForwards=href, LegacyUnforgeable] readonly attribute Location location;
	virtual const DKString& location() override								{ DKTODO(); return ""; }								// getter
	virtual void location(const DKString& location) override				{ DKERROR("DKSdlWindow.location readonly! \n"); } 		// setter
	
	// readonly attribute History history;
	virtual const DKString& history() override								{ DKTODO(); return ""; }								// getter
	virtual void history(const DKString& history) override					{ DKERROR("DKSdlWindow.history readonly! \n"); } 		// setter
	
	// readonly attribute CustomElementRegistry customElements;
	virtual const DKString& customElements() override						{ DKTODO(); return ""; }								// getter
	virtual void customElements(const DKString& customElements) override	{ DKERROR("DKSdlWindow.customElements readonly! \n"); } // setter
	
	// [Replaceable] readonly attribute BarProp locationbar;
	virtual const DKString& locationbar() override							{ DKTODO(); return ""; }								// getter
	virtual void locationbar(const DKString& locationbar) override			{ DKERROR("DKSdlWindow.locationbar readonly! \n"); } 	// setter
	
	// [Replaceable] readonly attribute BarProp menubar;
	virtual const DKString& menubar() override								{ DKTODO(); return ""; }								// getter
	virtual void menubar(const DKString& menubar) override					{ DKERROR("DKSdlWindow.menubar readonly! \n"); } 		// setter
	
	// [Replaceable] readonly attribute BarProp personalbar;
	virtual const DKString& personalbar() override							{ DKTODO(); return ""; }								// getter
	virtual void personalbar(const DKString& personalbar) override			{ DKERROR("DKSdlWindow.menubar readonly! \n"); } 		// setter
	
	// [Replaceable] readonly attribute BarProp scrollbars;
	virtual const DKString& scrollbars() override							{ DKTODO(); return ""; }								// getter
	virtual void scrollbars(const DKString& scrollbars)	override			{ DKERROR("DKSdlWindow.scrollbars readonly! \n"); } 	// setter
	
	// [Replaceable] readonly attribute BarProp statusbar;
	virtual const DKString& statusbar()	override							{ DKTODO(); return "D"; }								// getter
	virtual void statusbar(const DKString& statusbar) override				{ DKERROR("DKSdlWindow.statusbar readonly! \n"); } 		// setter
	
	// [Replaceable] readonly attribute BarProp toolbar;
	virtual const DKString& toolbar() override								{ DKTODO(); return ""; }								// getter
	virtual void toolbar(const DKString& toolbar) override					{ DKERROR("DKSdlWindow.toolbar readonly! \n"); } 		// setter
	
	// attribute DOMString status;
	virtual const DOMString& status() override								{ DKTODO(); return ""; }								// getter
	virtual void status(const DOMString& status) override					{ DKTODO(); } 											// setter
	
	// undefined close();
	virtual void close() override {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// readonly attribute boolean closed;
	virtual const bool& closed() override									{ DKTODO(); return ""; }								// getter
	virtual void closed(const bool& closed)	override						{ DKTODO(); } 											// setter
	
	// undefined stop();
	virtual void stop() override {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// undefined focus();
	virtual void focus() override {
		DKDEBUGFUNC();
		SDL_RestoreWindow(_window);
	}
	
	// undefined blur();
	virtual void blur() override {
		DKDEBUGFUNC();
		SDL_MinimizeWindow(_window);
	}
	
	// other browsing contexts
	// [Replaceable] readonly attribute WindowProxy frames;
	virtual const DKString& frames() override								{ DKTODO(); return ""; }									// getter
	virtual void frames(const DKString& frames) override					{ DKERROR("DKSdlWindow.frames readonly! \n"); } 			// setter
	
	// [Replaceable] readonly attribute unsigned long length;
	virtual const unsigned int& length() override							{ DKTODO(); return 0; }										// getter
	virtual void length(const unsigned int& length)	override				{ DKERROR("DKSdlWindow.length readonly! \n"); } 			// setter
	
	// [LegacyUnforgeable] readonly attribute WindowProxy? top;
	virtual const DKString& top() override									{ DKTODO(); return ""; }									// getter
	virtual void top(const DKString& top) override							{ DKERROR("DKSdlWindow.top readonly! \n"); } 				// setter
	
	// attribute any opener;
	virtual const DKString& opener() override								{ DKTODO(); return ""; }									// getter
	virtual void opener(const DKString& opener)	override					{ DKTODO(); } 												// setter
	
	// [Replaceable] readonly attribute WindowProxy? parent;
	virtual const DKString& parent() override								{ DKTODO(); return ""; }									// getter
	virtual void parent(const DKString& parent) override					{ DKERROR("DKSdlWindow.parent readonly! \n"); } 			// setter
	
	// readonly attribute Element? frameElement;
	virtual const DKString& frameElement() override							{ DKTODO(); return ""; }									// getter
	virtual void frameElement(const DKString& frameElement) override		{ DKERROR("DKSdlWindow.frameElement readonly! \n"); } 		// setter
	
	// WindowProxy? open(optional USVString url = "", optional DOMString target = "_blank", optional [LegacyNullToEmptyString] DOMString features = "");
	virtual const DKString& open(const USVString& url = "", const DOMString& target = "_blank", const DOMString& features = "") override {
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
	virtual const DKString& navigator()	override								{ DKTODO(); return ""; }									// getter
	virtual void navigator(const DKString& navigator) override					{ DKERROR("DKSdlWindow.navigator readonly! \n"); } 			// setter
	
	// readonly attribute Navigator clientInformation; // legacy alias of .navigator
	virtual const DKString& clientInformation()	override						{ DKTODO(); return ""; }									// getter
	virtual void clientInformation(const DKString& clientInformation) override	{ DKERROR("DKSdlWindow.clientInformation readonly! \n"); } 	// setter
	
	// readonly attribute boolean originAgentCluster;
	virtual const bool& originAgentCluster() override							{ DKTODO(); return false; }									// getter
	virtual void originAgentCluster(const bool& originAgentCluster)	override	{ DKERROR("DKSdlWindow.originAgentCluster readonly! \n"); } // setter
	
	//user prompts
	// undefined alert();
	virtual void alert() override {
		DKDEBUGFUNC();
		if(SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_INFORMATION, "alert", "alert", _window) != 0)
			DKERROR("SDL_ShowSimpleMessageBox() failed! \n    use SDL_GetError() for more info");
	}
	
	// undefined alert(DOMString message);
	virtual void alert(const DOMString& message) override {
		DKDEBUGFUNC(message);
		if(SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_INFORMATION, "alert", message.c_str(), _window) != 0)
			DKERROR("SDL_ShowSimpleMessageBox() failed! \n    use SDL_GetError() for more info");
	}
	
	// boolean confirm(optional DOMString message = "");
	virtual const bool& confirm(const DOMString& message = "") override {
		DKDEBUGFUNC(message);
		DKTODO();
		return false;
	}
	
	// DOMString? prompt(optional DOMString message = "", optional DOMString default = "");
	virtual const DOMString& prompt(const DOMString& message = "", const DOMString _default = "") override {
		DKDEBUGFUNC(message, _default);
		DKTODO();
		return "";
	}
	
	// undefined print();
	virtual void print() override {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// undefined postMessage(any message, USVString targetOrigin, optional sequence<object> transfer = []);
	virtual void postMessage(const DKString& message, const USVString& targetOrigin, const DKString& transfer = "[]") override {
		DKDEBUGFUNC(message, targetOrigin, transfer);
		DKTODO();
	}
	
	// undefined postMessage(any message, optional WindowPostMessageOptions options = {});
	virtual void postMessage(const DKString& message, const DKString& options = "{}") override {
		DKDEBUGFUNC(message, options);
		DKTODO();
	}
	
	// also has obsolete members
	
	// Source: Compatibility Standard (https://compat.spec.whatwg.org/)
	// partial interface Window {
	//		readonly attribute short orientation;
			virtual const short& orientation() override										{ DKTODO(); return 0; }									// getter
			virtual void orientation(const short& orientation) override						{ DKERROR("DKSdlWindow.orientation readonly! \n"); } 	// setter
	//		
	//		attribute EventHandler onorientationchange;
			virtual const DKString& onorientationchange() override							{ DKTODO(); return ""; }								// getter
			virtual void onorientationchange(const DKString& onorientationchange) override	{ DKTODO(); } 											// setter
	// };
	
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// partial interface Window {
	//		[Replaceable] readonly attribute (Event or undefined) event; // legacy
			virtual const DKString& event()	override										{ DKTODO(); return ""; }								// getter
			virtual void event(const DKString& event) override								{ DKERROR("DKSdlWindow.event readonly! \n"); } 			// setter
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
			virtual void captureEvents() override {
				DKDEBUGFUNC();
				DKTODO();
			}
	//
	//		undefined releaseEvents();
			virtual void releaseEvents() override {
				DKDEBUGFUNC();
				DKTODO();
			}
	//
	//		[Replaceable, SameObject] readonly attribute External external;
			virtual const DKString& external() override							{ DKTODO(); return ""; }	// getter
			virtual void external(const DKString& external)	override			{ } 						// setter
	// };
	
	// Source: Cookie Store API (https://wicg.github.io/cookie-store/)
	// [SecureContext]
	// partial interface Window {
	//		[SameObject] readonly attribute CookieStore cookieStore;
			virtual const DKString& cookieStore() override						{ DKTODO(); return ""; }	// getter
			virtual void cookieStore(const DKString& cookieStore) override		{ } 						// setter
	// };
	
	// Source: Digital Goods API (https://wicg.github.io/digital-goods/)
	// partial interface Window {
	//		[SecureContext] Promise<DigitalGoodsService> getDigitalGoodsService(DOMString serviceProvider);
			virtual const DKString& getDigitalGoodsService(const DKString& serviceProvider) override {
				DKDEBUGFUNC(serviceProvider);
				DKTODO();
				return "";
			}
	// };
	
	// Source: Fenced frame (https://wicg.github.io/fenced-frame/)
	// partial interface Window {
	//		// Collection of fenced frame APIs
	//		readonly attribute Fence? fence;
			virtual const DKString& fence()	override								{ DKTODO(); return ""; }	// getter
			virtual void fence(const DKString& fence) override						{ } 						// setter
	// };
	
	// Source: File System Access (https://wicg.github.io/file-system-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FileSystemFileHandle>> showOpenFilePicker(optional OpenFilePickerOptions options = {});
			virtual const DKString& showOpenFilePicker(const DKString& options = "{}") override {
				DKDEBUGFUNC(options);
				DKTODO();
				return "";
			}
	//
	//		Promise<FileSystemFileHandle> showSaveFilePicker(optional SaveFilePickerOptions options = {});
			virtual const DKString& showSaveFilePicker(const DKString& options = "{}") override {
				DKDEBUGFUNC(options);
				DKTODO();
				return "";
			}
	//
	//		Promise<FileSystemDirectoryHandle> showDirectoryPicker(optional DirectoryPickerOptions options = {});
			virtual const DKString& showDirectoryPicker(const DKString& options = "{}") override {
				DKDEBUGFUNC(options);
				DKTODO();
				return "";
			}
	// };
	
	// Source: Local Font Access API (https://wicg.github.io/local-font-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FontData>> queryLocalFonts(optional QueryOptions options = {});
			virtual const DKString& queryLocalFonts(const DKString& options = "{}") override {
				DKDEBUGFUNC(options);
				DKTODO();
				return "";
			}
	// };
	
	// Source: Manifest Incubations (https://wicg.github.io/manifest-incubations/)
	// partial interface Window {
	//		attribute EventHandler onappinstalled;
			virtual const DKString& onappinstalled() override									{ DKTODO(); return ""; }	// getter
			virtual void onappinstalled(const DKString& onappinstalled)	override				{ DKTODO(); } 				// setter
	//
	//		attribute EventHandler onbeforeinstallprompt;
			virtual const DKString& onbeforeinstallprompt()	override							{ DKTODO(); return ""; }	// getter
			virtual void onbeforeinstallprompt(const DKString& onbeforeinstallprompt) override	{ DKTODO(); } 				// setter
	// };
	
	// Source: Portals (https://wicg.github.io/portals/)
	// partial interface Window {
	//		readonly attribute PortalHost? portalHost;
			virtual const DKString& portalHost() override										{ DKTODO(); return ""; }	// getter
			virtual void portalHost(const DKString& portalHost)	override						{ DKTODO(); } 				// setter
	// };
	
	// Source: Web Speech API (https://wicg.github.io/speech-api/)
	// partial interface Window {
	//		[SameObject] readonly attribute SpeechSynthesis speechSynthesis;
			virtual const DKString& speechSynthesis() override									{ DKTODO(); return ""; }	// getter
			virtual void speechSynthesis(const DKString& speechSynthesis) override				{ DKTODO(); } 				// setter
	// };
	
	// Source: Web App Launch Handler API (https://wicg.github.io/web-app-launch/)
	// partial interface Window {
	//		readonly attribute LaunchQueue launchQueue;
			virtual const DKString& launchQueue() override										{ DKTODO(); return ""; }	// getter
			virtual void launchQueue(const DKString& launchQueue) override						{ DKTODO(); } 				// setter
	// };
	
	// Source: CSS Spatial Navigation Level 1 (https://www.w3.org/TR/css-nav-1/)
	// partial interface Window {
	//		undefined navigate(SpatialNavigationDirection dir);
			virtual void navigate(const DKString& dir) override {
				DKDEBUGFUNC(dir);
				DKTODO();
			}
	// };
	
	// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
	// partial interface Window {
	//		[NewObject] CSSStyleDeclaration getComputedStyle(Element elt, optional CSSOMString? pseudoElt);
			virtual const DKString& getComputedStyle(const DKString& elt, const DKString& pseudoElt) override {
				DKDEBUGFUNC(elt, pseudoElt);
				DKTODO();
				return "";
			}
	// };
	
	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface Window {
	//		[NewObject] MediaQueryList matchMedia(CSSOMString query);
			virtual const DKString& matchMedia(const DKString& mediaQueryString) override {
				DKDEBUGFUNC(mediaQueryString);
				DKTODO();
				return "";
			}
	//
	//		[SameObject, Replaceable] readonly attribute Screen screen;
			//virtual DKString screen()	override									{ DKTODO(); return ""; }	// getter
			//virtual void screen(const DKString&) override							{ DKTODO(); } 				// setter
	//
	//		[SameObject, Replaceable] readonly attribute VisualViewport? visualViewport;
			virtual const DKString& visualViewport() override						{ DKTODO(); return ""; }	// getter
			virtual void visualViewport(const DKString& visualViewport)	override 	{ DKTODO(); } 				// setter
	//
	//		// browsing context
	//		undefined moveTo(long x, long y);
			virtual void moveTo(const int& x, const int& y) override {
				DKDEBUGFUNC(x, y);
				DKTODO();
			}
	//
	//		undefined moveBy(long x, long y);
			virtual void moveBy(const int& x, const int& y) override {
				DKDEBUGFUNC(x, y);
				DKTODO();
			}
	//
	//		undefined resizeTo(long width, long height);
			virtual void resizeTo(const int& width, const int& height) override {
				DKDEBUGFUNC(width, height);
				DKTODO();
			}
	//
	//		undefined resizeBy(long x, long y);
			virtual void resizeBy(const int& x, const int& y) override {
				DKDEBUGFUNC(x, y);
				DKTODO();
			}

	//		// viewport
	//		[Replaceable] readonly attribute long innerWidth;
			virtual const int& innerWidth()	override						{ DKTODO(); return 0; }		// getter
			virtual void innerWidth(const int& innerWidth) override			{ DKTODO(); } 				// setter

	//		[Replaceable] readonly attribute long innerHeight;
			virtual const int& innerHeight() override						{ DKTODO(); return 0; }		// getter
			virtual void innerHeight(const int& innerHeight) override		{ DKTODO(); } 				// setter

	//		// viewport scrolling
	//		[Replaceable] readonly attribute double scrollX;
			virtual const double& scrollX() override						{ DKTODO(); return 0.0; }	// getter
			virtual void scrollX(const double& scrollX) override			{ DKTODO(); } 				// setter

	//		[Replaceable] readonly attribute double pageXOffset;
			virtual const double& pageXOffset() override					{ DKTODO(); return 0.0; }	// getter
			virtual void pageXOffset(const double& pageXOffset) override	{ DKTODO(); } 				// setter

	//		[Replaceable] readonly attribute double scrollY;
			virtual const double& scrollY()	override						{ DKTODO(); return 0.0; }	// getter
			virtual void scrollY(const double& scrollY) override			{ DKTODO(); } 				// setter

	//		[Replaceable] readonly attribute double pageYOffset;
			virtual const double& pageYOffset()	override					{ DKTODO(); return 0.0; }	// getter
			virtual void pageYOffset(const double& pageYOffset)	override	 { DKTODO(); } 				// setter
			
	//		undefined scroll(optional ScrollToOptions options = {});
			virtual void scroll(const DKString& options = "{}") override {
				DKDEBUGFUNC(options);
				DKTODO();
			}
			
	//		undefined scroll(unrestricted double x, unrestricted double y);
			virtual void scroll(const double& x, const double& y) override {
				DKDEBUGFUNC(x, y);
				DKTODO();
			}
	//
	//		undefined scrollTo(optional ScrollToOptions options = {});
			virtual void scrollTo(const DKString& options = "{}") override {
				DKDEBUGFUNC(options);
				DKTODO();
			}
			
	//		undefined scrollTo(unrestricted double x, unrestricted double y);
			virtual void scrollTo(const double& x, const double& y) override {
				DKDEBUGFUNC(x, y);
				DKTODO();
			}

	//		undefined scrollBy(optional ScrollToOptions options = {});
			virtual void scrollBy(const DKString& options = "{}") override {
				DKDEBUGFUNC(options);
				DKTODO();
			}
			
	//		undefined scrollBy(unrestricted double x, unrestricted double y);
			virtual void scrollBy(const double& x, const double& y) override {
				DKDEBUGFUNC(x, y);
				DKTODO();
			}
	///
	//		// client
	//		[Replaceable] readonly attribute long screenX;
			virtual const int& screenX() override { 												// getter
				int x;
				SDL_GetWindowPosition(_window, &x, NULL);
				return x;
			}	
			virtual void screenX(const int& x) override { 										// setter
				int y;
				SDL_GetWindowPosition(_window, NULL, &y);
				SDL_SetWindowPosition(_window, x, y);
			} 
	//
	//		[Replaceable] readonly attribute long screenLeft;
			virtual const int& screenLeft()	override					{ DKTODO(); return 0; }	// getter
			virtual void screenLeft(const int& screenLeft) override		{ DKTODO(); } 			// setter
	//
	//		[Replaceable] readonly attribute long screenY;
			virtual const int& screenY() override { 												// getter
				int y;
				SDL_GetWindowPosition(_window, NULL, &y);
				return y;
			}
			virtual void screenY(const int& screenY) override { 									// setter
				int x;
				SDL_GetWindowPosition(_window, &x, NULL);
				SDL_SetWindowPosition(_window, x, screenY);
			}
	//
	//		[Replaceable] readonly attribute long screenTop;
			virtual const int& screenTop() override						{ DKTODO(); return 0; }				// getter
			virtual void screenTop(const int& screenTop) override		{ DKTODO(); } 						// setter
	//
	//		[Replaceable] readonly attribute long outerWidth;
			virtual const int& outerWidth() override {														// getter
				int width;
				SDL_GetWindowSize(_window, &width, NULL);
				return width;
			}
			virtual void outerWidth(const int& outerWidth) override { 				 						// setter
				int height;
				SDL_GetWindowSize(_window, NULL, &height);
				SDL_SetWindowSize(_window, outerWidth, height);
			}
	//
	//		[Replaceable] readonly attribute long outerHeight;
			virtual const int& outerHeight() override {														// getter
				int height;
				SDL_GetWindowSize(_window, NULL, &height);
				return height;
			}	
			virtual void outerHeight(const int& outerHeight) override {										// setter 
				int width;
				SDL_GetWindowSize(_window, &width, NULL);
				SDL_SetWindowSize(_window, width, outerHeight);
			} 			
	//
	//		[Replaceable] readonly attribute double devicePixelRatio;
			virtual const double& devicePixelRatio() override												{ DKTODO(); return 0; }		// getter
			virtual void devicePixelRatio(const double& devicePixelRatio) override							{ DKTODO(); } 				// setter
	// };
	
	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	// partial interface Window {
	//		[SecureContext] attribute EventHandler ondeviceorientation;
			virtual const DKString& ondeviceorientation() override											{ DKTODO(); return ""; }	// getter
			virtual void ondeviceorientation(const DKString& ondeviceorientation) override					{ DKTODO(); } 				// setter
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	// partial interface Window {
	//		[SecureContext] attribute EventHandler ondeviceorientationabsolute;
			virtual const DKString& ondeviceorientationabsolute() override									{ DKTODO(); return ""; }	// getter
			virtual void ondeviceorientationabsolute(const DKString& ondeviceorientationabsolute) override	{ DKTODO(); } 				// setter
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	//	partial interface Window {
	//		[SecureContext] attribute EventHandler ondevicemotion;
			virtual const DKString& ondevicemotion() override										{ DKTODO(); return ""; }	// getter
			virtual void ondevicemotion(const DKString& ondevicemotion) override					{ DKTODO(); } 				// setter
	// };

	// Source: requestIdleCallback() (https://www.w3.org/TR/requestidlecallback/)
	// partial interface Window {
	//		unsigned long requestIdleCallback(IdleRequestCallback callback, optional IdleRequestOptions options = {});
			virtual const unsigned int& requestIdleCallback(const DKString& callback, const DKString& options = "{}") override {
				DKDEBUGFUNC();
				DKTODO();
				return 0;
			}

	//		undefined cancelIdleCallback(unsigned long handle);
			virtual void cancelIdleCallback(const unsigned int& handle) override {
				DKDEBUGFUNC(handle);
				DKTODO();
			}
	// };

	// Source: Selection API (https://www.w3.org/TR/selection-api/)
	// partial interface Window {
	//		Selection? getSelection();
			virtual const DKString& getSelection() override {
				DKDEBUGFUNC();
				DKTODO();
				return "";
			}
	// };

	// Source: Window Management (https://www.w3.org/TR/window-management/)
	// partial interface Window {
	//		[SecureContext]
	//		Promise<ScreenDetails> getScreenDetails();
			virtual const DKString& getScreenDetails() override {
				DKDEBUGFUNC();
				DKTODO();
				return "";
			}
	// };
	*/

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

//REGISTER_OBJECT(DKSdlWindow, true)

#endif //DKSdlWindow_H
