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
#ifndef DKConsoleWindow_H
#define DKConsoleWindow_H

#include "DK/DK.h"
#include "DKWindow/DKWindow.h"

#if WIN
	#include <windows.h>
	#include <tchar.h>
	#include <stdio.h>
#endif


class DKConsoleWindow : public DKWindow //, public DKObjectT<DKConsoleWindow>
{
public:
	DKConsoleWindow();
	~DKConsoleWindow();
	
	// the current browsing context
	// [LegacyUnforgeable] readonly attribute WindowProxy window;
	// TODO
	
	// [Replaceable] readonly attribute WindowProxy self;
	// TODO
	
	// [LegacyUnforgeable] readonly attribute Document document;
	// TODO
	
	// attribute DOMString name;
	// TODO
	
	// [PutForwards=href, LegacyUnforgeable] readonly attribute Location location;
	// TODO
	
	// readonly attribute History history;
	// TODO
	
	// readonly attribute CustomElementRegistry customElements;
	// TODO
	
	// [Replaceable] readonly attribute BarProp locationbar;
	// TODO
	
	// [Replaceable] readonly attribute BarProp menubar;
	// TODO
	
	// [Replaceable] readonly attribute BarProp personalbar;
	// TODO
	
	// [Replaceable] readonly attribute BarProp scrollbars;
	// TODO
	
	// [Replaceable] readonly attribute BarProp statusbar;
	// TODO
	
	// [Replaceable] readonly attribute BarProp toolbar;
	// TODO
	
	// attribute DOMString status;
	// TODO
	
	// undefined close();
	void close() override {
		DKDEBUGFUNC();
		#if WIN
			ShowWindow(GetConsoleWindow(), SW_HIDE);
		#endif
	}
	
	// readonly attribute boolean closed;
	// TODO

	// undefined stop();
	// TODO
	
	// undefined focus();
	void focus() override {
		DKDEBUGFUNC();
		#if WIN
			ShowWindow(GetConsoleWindow(), SW_SHOW);
		#endif
	}
	
	// undefined blur();
	void blur() override {
		DKDEBUGFUNC();
		#if WIN
			ShowWindow(GetConsoleWindow(), SW_SHOWMINNOACTIVE);
		#endif
	}
	
	// other browsing contexts
	// [Replaceable] readonly attribute WindowProxy frames;
	// TODO
	
	// [Replaceable] readonly attribute unsigned long length;
	// TODO
	
	// [LegacyUnforgeable] readonly attribute WindowProxy? top;
	// TODO
	
	// attribute any opener;
	// TODO
	
	// [Replaceable] readonly attribute WindowProxy? parent;
	// TODO
	
	// readonly attribute Element? frameElement;
	// TODO
	
	// WindowProxy? open(optional USVString url = "", optional DOMString target = "_blank", optional [LegacyNullToEmptyString] DOMString features = "");
	// TODO
	
	//Since this is the global object, the IDL named getter adds a NamedPropertiesObject exotic
	//object on the prototype chain. Indeed, this does not make the global object an exotic object.
	//Indexed access is taken care of by the WindowProxy exotic object.
	// getter object (DOMString name);
	// TODO
	
	// the user agent
	// readonly attribute Navigator navigator;
	// TODO
	
	// readonly attribute Navigator clientInformation; // legacy alias of .navigator
	// TODO
	
	// readonly attribute boolean originAgentCluster;
	// TODO
	
	//user prompts
	// undefined alert();
	// TODO
	
	// undefined alert(DOMString message);
	// TODO
	
	// boolean confirm(optional DOMString message = "");
	// TODO
	
	// DOMString? prompt(optional DOMString message = "", optional DOMString default = "");
	// TODO
	
	// undefined print();
	// TODO
	
	// undefined postMessage(any message, USVString targetOrigin, optional sequence<object> transfer = []);
	// TODO
	
	// undefined postMessage(any message, optional WindowPostMessageOptions options = {});
	// TODO
	
	// also has obsolete members
	
	// Source: Compatibility Standard (https://compat.spec.whatwg.org/)
	// partial interface Window {
	//		readonly attribute short orientation;
			// TODO
	//		
	//		attribute EventHandler onorientationchange;
			// TODO
	// };
	
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// partial interface Window {
	//		[Replaceable] readonly attribute (Event or undefined) event; // legacy
			// TODO
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
			// TODO
	//
	//		undefined releaseEvents();
			// TODO
	//
	//		[Replaceable, SameObject] readonly attribute External external;
			// TODO
	// };
	
	// Source: Cookie Store API (https://wicg.github.io/cookie-store/)
	// [SecureContext]
	// partial interface Window {
	//		[SameObject] readonly attribute CookieStore cookieStore;
			// TODO
	// };

	// Source: Digital Goods API (https://wicg.github.io/digital-goods/)
	// partial interface Window {
	//		[SecureContext] Promise<DigitalGoodsService> getDigitalGoodsService(DOMString serviceProvider);
			// TODO
	// };

	// Source: Fenced frame (https://wicg.github.io/fenced-frame/)
	// partial interface Window {
	//		// Collection of fenced frame APIs
	//		readonly attribute Fence? fence;
			// TODO
	// };
	
	// Source: File System Access (https://wicg.github.io/file-system-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FileSystemFileHandle>> showOpenFilePicker(optional OpenFilePickerOptions options = {});
			// TODO

	//		Promise<FileSystemFileHandle> showSaveFilePicker(optional SaveFilePickerOptions options = {});
			// TODO
	//
	//		Promise<FileSystemDirectoryHandle> showDirectoryPicker(optional DirectoryPickerOptions options = {});
			// TODO
	// };
	
	// Source: Local Font Access API (https://wicg.github.io/local-font-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FontData>> queryLocalFonts(optional QueryOptions options = {});
			// TODO
	// };
	
	// Source: Manifest Incubations (https://wicg.github.io/manifest-incubations/)
	// partial interface Window {
	//		attribute EventHandler onappinstalled;
			// TODO

	//		attribute EventHandler onbeforeinstallprompt;
			// TODO
	// };

	// Source: Portals (https://wicg.github.io/portals/)
	// partial interface Window {
	//		readonly attribute PortalHost? portalHost;
			// TODO
	// };

	// Source: Web Speech API (https://wicg.github.io/speech-api/)
	// partial interface Window {
	//		[SameObject] readonly attribute SpeechSynthesis speechSynthesis;
			// TODO
	// };

	// Source: Web App Launch Handler API (https://wicg.github.io/web-app-launch/)
	// partial interface Window {
	//		readonly attribute LaunchQueue launchQueue;
			// TODO
	// };

	// Source: CSS Spatial Navigation Level 1 (https://www.w3.org/TR/css-nav-1/)
	// partial interface Window {
	//		undefined navigate(SpatialNavigationDirection dir);
			// TODO
	// };

	// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
	// partial interface Window {
	//		[NewObject] CSSStyleDeclaration getComputedStyle(Element elt, optional CSSOMString? pseudoElt);
			// TODO
	// };
	
	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface Window {
	//		[NewObject] MediaQueryList matchMedia(CSSOMString query);
			// TODO

	//		[SameObject, Replaceable] readonly attribute Screen screen;
			// TODO
			

	//		[SameObject, Replaceable] readonly attribute VisualViewport? visualViewport;
			// TODO

	//		// browsing context
	//		undefined moveTo(long x, long y);
			virtual void moveTo(const int& x, const int& y) override {
				DKDEBUGFUNC(x, y);
				#if WIN
					RECT rect;
					GetWindowRect(GetConsoleWindow(), &rect);
					int nWidth = rect.right - rect.left;
					int nHeight = rect.bottom - rect.top;
					if (!MoveWindow(GetConsoleWindow(), x, y, nWidth, nHeight, TRUE))
						DKERROR("MoveWindow() failed");
				#endif
			}

	//		undefined moveBy(long x, long y);
			virtual void moveBy(const int& x, const int& y) override {
				DKDEBUGFUNC(x, y);
				#if WIN
					RECT rect;
					GetWindowRect(GetConsoleWindow(), &rect);
					int new_x = rect.left + x;
					int new_y = rect.top + y;
					int nWidth = rect.right - rect.left;
					int nHeight = rect.bottom - rect.top;
					if (!MoveWindow(GetConsoleWindow(), new_x, new_y, nWidth, nHeight, TRUE))
						DKERROR("MoveWindow() failed");
				#endif
			}

	//		undefined resizeTo(long width, long height);
			virtual void resizeTo(const int& width, const int& height) override {
				DKDEBUGFUNC(width, height);
				#if WIN
					RECT rect;
					GetWindowRect(GetConsoleWindow(), &rect);
					int X = rect.left;
					int Y = rect.top;
					int nWidth = width;
					int nHeight = height;
					if (!MoveWindow(GetConsoleWindow(), X, Y, nWidth, nHeight, TRUE))
						DKERROR("MoveWindow() failed");
				#endif
			}

	//		undefined resizeBy(long x, long y);
			virtual void resizeBy(const int& x, const int& y) override {
				DKDEBUGFUNC(x, y);
				#if WIN
					RECT rect;
					GetWindowRect(GetConsoleWindow(), &rect);
					int X = rect.left;
					int Y = rect.top;
					int nWidth = rect.right - rect.left + x;
					int nHeight = rect.bottom - rect.top + y;
					if (!MoveWindow(GetConsoleWindow(), X, Y, nWidth, nHeight, TRUE))
						DKERROR("MoveWindow() failed");
				#endif
			}

	//		// viewport
	//		[Replaceable] readonly attribute long innerWidth;
			// TODO

	//		[Replaceable] readonly attribute long innerHeight;
			// TODO

	//		// viewport scrolling
	//		[Replaceable] readonly attribute double scrollX;
			// TODO
	//
	//		[Replaceable] readonly attribute double pageXOffset;
			// TODO

	//		[Replaceable] readonly attribute double scrollY;
			// TODO

	//		[Replaceable] readonly attribute double pageYOffset;
			// TODO

	//		undefined scroll(optional ScrollToOptions options = {});
	//		undefined scroll(unrestricted double x, unrestricted double y);
			// TODO

	//		undefined scrollTo(optional ScrollToOptions options = {});
	//		undefined scrollTo(unrestricted double x, unrestricted double y);
			// TODO

	//		undefined scrollBy(optional ScrollToOptions options = {});
	//		undefined scrollBy(unrestricted double x, unrestricted double y);
			// TODO

	//		// client
	//		[Replaceable] readonly attribute long screenX;
			// TODO

	//		[Replaceable] readonly attribute long screenLeft;
			// TODO

	//		[Replaceable] readonly attribute long screenY;
			// TODO

	//		[Replaceable] readonly attribute long screenTop;
			// TODO

	//		[Replaceable] readonly attribute long outerWidth;
			virtual const int& outerWidth() override {						// getter
				#if WIN
					RECT rect;
					GetWindowRect(GetConsoleWindow(), &rect);
					_outerWidth = rect.right - rect.left;
				#endif
				return _outerWidth;
			}
			virtual void outerWidth(const int& outerWidth) override {			// setter
				// readonly
			}

	//		[Replaceable] readonly attribute long outerHeight;
			virtual const int& outerHeight() override { 						// getter
				#if WIN
					RECT rect;
					GetWindowRect(GetConsoleWindow(), &rect);
					_outerHeight = rect.bottom - rect.top;
				#endif
				return _outerHeight;
			}
			virtual void outerHeight(const int& outerHeight){		// setter
				//readonly
			}
			

	//		[Replaceable] readonly attribute double devicePixelRatio;
			// TODO
	// };
	

	
	////// DK //////
	void Loop();

	// KeyboardEvent
	DOMString key;
	DOMString code;
	unsigned int location;
	bool ctrlKey;
	bool shiftKey;
	bool altKey;
	bool metaKey;
	bool repeat;
	bool isComposing;
	unsigned int charCode;
	unsigned int keyCode;
	
	// MouseEvent
	int screenX;
	int screenY;
	int clientX;
	int clientY;
	short button;
	unsigned short buttons;
	double pageX;
	double pageY;
	double x;
	double y;
	double offsetX;
	double offsetY;
	double movementX;
	double movementY;
	
	bool button_state[5];
	
	// WheelEvent
	double deltaX;
	double deltaY;
	double deltaZ;
	unsigned int deltaMode;

	// ResizeEvent
	unsigned int columns;
	unsigned int rows;

#if WIN
	// fullScreen
	static WINDOWPLACEMENT wpc;
	static LONG HWNDStyle;
	static LONG HWNDStyleEx;
	
	HANDLE hStdin;
	DWORD fdwSaveOldMode;
	void ErrorExit(LPCSTR);
	void FocusEventProc(FOCUS_EVENT_RECORD);
	void KeyboardEventProc(KEY_EVENT_RECORD);
	void MenuEventProc(MENU_EVENT_RECORD);
	void MouseEventProc(MOUSE_EVENT_RECORD);
	void ResizeEventProc(WINDOW_BUFFER_SIZE_RECORD);
#endif
};
//REGISTER_OBJECT(DKConsoleWindow, true);


#endif //DKConsoleWindow_H