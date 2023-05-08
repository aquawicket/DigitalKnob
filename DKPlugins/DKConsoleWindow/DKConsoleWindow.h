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


class DKConsoleWindow : public DKWindow, public DKObjectT<DKConsoleWindow>
{
public:
	DKConsoleWindow();
	~DKConsoleWindow();
	bool Init();
	bool End();
	
	
	////// Instance properties //////
	// [Window.caches](Read only) https://developer.mozilla.org/en-US/docs/Web/API/caches
	// [Window.clientInformation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
	// [Window.closed](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/closed
	// [Window.console](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/console
	// [Window.credentialless](Read only)(Experimental)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/credentialless
	// [Window.crypto](Read only) https://developer.mozilla.org/en-US/docs/Web/API/crypto_property
	// [Window.customElements](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/customElements
	// [Window.devicePixelRatio](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/devicePixelRatio
	// [Window.document](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/document
	// [Window.frameElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/frameElement
	// [Window.frames](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/frames
	// [Window.fullScreen](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/fullScreen
	// [Window.history](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/History
	// [Window.indexedDB](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/indexedDB
	// [Window.innerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerHeight
	// [Window.innerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerWidth
	// [Window.isSecureContext](Read only) https://developer.mozilla.org/en-US/docs/Web/API/isSecureContext
	// [Window.launchQueue](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/launchQueue
	// [Window.length](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/length
	// [Window.location] https://developer.mozilla.org/en-US/docs/Web/API/Window/location
	// [Window.locationbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/locationbar
	// [Window.localStorage](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage
	// [Window.menubar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/menubar
	// [Window.mozInnerScreenX](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/mozInnerScreenX
	// [Window.mozInnerScreenY](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/mozInnerScreenY
	// [Window.name] https://developer.mozilla.org/en-US/docs/Web/API/Window/name
	// [Window.navigation](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigation
	// [Window.navigator](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
	// [Window.opener] https://developer.mozilla.org/en-US/docs/Web/API/Window/opener
	// [Window.origin](Read only) https://developer.mozilla.org/en-US/docs/Web/API/origin
	// [Window.outerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/outerHeight
	bool outerHeight(unsigned int& _outerHeight, bool set = false) {
		if(set){
			return DKTODO();
		}
		else{
			#if WIN
				RECT rect;
				GetWindowRect(GetConsoleWindow(), &rect);
				_outerHeight = rect.bottom - rect.top;
			#endif
		}
		return true;
	}
	// [Window.outerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/outerWidth
	bool outerWidth(unsigned int& _outerWidth, bool set = false) {
		if(set){
			return DKTODO();
		}
		else{
			#if WIN
				RECT rect;
				GetWindowRect(GetConsoleWindow(), &rect);
				_outerWidth = rect.right - rect.left;
			#endif
		}
		return true;
	}
	// [Window.pageXOffset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/pageXOffset
	// [Window.pageYOffset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/pageYOffset
	// [Window.parent](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/parent
	// [Window.performance](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/performance
	// [Window.personalbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/personalbar
	// [Window.scheduler](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scheduler
	// [Window.screen](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screen
	// [Window.screenX and Window.screenLeft](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screenX
	// [Window.screenY and Window.screenTop](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screenY
	// [Window.scrollbars](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollbars
	// [Window.scrollMaxX](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollMaxX
	// [Window.scrollMaxY](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollMaxY
	// [Window.scrollX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollX
	// [Window.scrollY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollY
	// [Window.self](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/self
	// [Window.sessionStorage] https://developer.mozilla.org/en-US/docs/Web/API/Window/sessionStorage
	// [Window.speechSynthesis](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/speechSynthesis
	// [Window.statusbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/statusbar
	// [Window.toolbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/toolbar
	// [Window.top](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/top
	// [Window.visualViewport](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/visualViewport
	// [Window.window](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/window
	// [window[0], window[1], etc.] https://developer.mozilla.org/en-US/docs/Web/API/Window
	
	
	////// Deprecated properties //////
	// [Window.content and Window._content](Deprecated)(Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window
	// [Window.defaultStatus](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/defaultStatus
	// [Window.event](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/event
	// [Window.external](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/external
	// [Window.orientation](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/orientation
	// [Window.returnValue](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window
	// [Window.sidebar](Deprecated)(Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/sidebar
	// [Window.status](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/status
	
	
	////// Instance methods //////
	// [Window.atob()] https://developer.mozilla.org/en-US/docs/Web/API/Window/atob
	// [Window.alert()] https://developer.mozilla.org/en-US/docs/Web/API/Window/alert
	// [Window.blur()] https://developer.mozilla.org/en-US/docs/Web/API/Window/blur
	bool blur() {
		DKDEBUGFUNC();
		#if WIN
			ShowWindow(GetConsoleWindow(), SW_SHOWMINNOACTIVE);
		#endif
		return true;
	}
	// [Window.btoa()] https://developer.mozilla.org/en-US/docs/Web/API/Window/btoa
	// [Window.cancelAnimationFrame()] https://developer.mozilla.org/en-US/docs/Web/API/Window/cancelAnimationFrame
	// [Window.cancelIdleCallback()] https://developer.mozilla.org/en-US/docs/Web/API/Window/cancelIdleCallback
	// [Window.clearImmediate()] https://developer.mozilla.org/en-US/docs/Web/API/Window/clearImmediate
	// [Window.clearInterval()] https://developer.mozilla.org/en-US/docs/Web/API/Window/clearInterval
	// [Window.clearTimeout()] https://developer.mozilla.org/en-US/docs/Web/API/Window/clearTimeout
	// [Window.close()] https://developer.mozilla.org/en-US/docs/Web/API/Window/close
	bool close() {
		DKDEBUGFUNC();
		#if WIN
			ShowWindow(GetConsoleWindow(), SW_HIDE);
		#endif
		return true;
	}
	// [Window.confirm()] https://developer.mozilla.org/en-US/docs/Web/API/Window/confirm
	// [Window.createImageBitmap()] https://developer.mozilla.org/en-US/docs/Web/API/createImageBitmap
	// [Window.dump()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/dump
	// [Window.fetch()] https://developer.mozilla.org/en-US/docs/Web/API/Window/fetch
	// [Window.find()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/find
	// [Window.focus()] https://developer.mozilla.org/en-US/docs/Web/API/Window/focus
	bool focus() {
		DKDEBUGFUNC();
		#if WIN
			ShowWindow(GetConsoleWindow(), SW_SHOW);
		#endif
		return true;
	}
	// [Window.getComputedStyle()] https://developer.mozilla.org/en-US/docs/Web/API/Window/getComputedStyle
	// [Window.getDefaultComputedStyle()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/getDefaultComputedStyle
	// [Window.getSelection()] https://developer.mozilla.org/en-US/docs/Web/API/Window/getSelection
	// [Window.matchMedia()] https://developer.mozilla.org/en-US/docs/Web/API/Window/matchMedia
	// [Window.moveBy()] https://developer.mozilla.org/en-US/docs/Web/API/Window/moveBy
	bool moveBy(int& _deltaX, int& _deltaY) {
		DKDEBUGFUNC(_deltaX, _deltaY);
		#if WIN
			RECT rect;
			GetWindowRect(GetConsoleWindow(), &rect);
			int X = rect.left + _deltaX;
			int Y = rect.top + _deltaY;
			int nWidth = rect.right - rect.left;
			int nHeight = rect.bottom - rect.top;
			if (!MoveWindow(GetConsoleWindow(), X, Y, nWidth, nHeight, TRUE))
				return DKERROR("MoveWindow() failed");
		#endif
		return true;
	}
	// [Window.moveTo()] https://developer.mozilla.org/en-US/docs/Web/API/Window/moveTo
	bool moveTo(int& _x, int& _y){
		DKDEBUGFUNC(_x, _y);
		#if WIN
			RECT rect;
			GetWindowRect(GetConsoleWindow(), &rect);
			int nWidth = rect.right - rect.left;
			int nHeight = rect.bottom - rect.top;
			if (!MoveWindow(GetConsoleWindow(), _x, _y, nWidth, nHeight, TRUE)){
				return DKERROR("MoveWindow() failed");
			}
		#endif
		return true;
	}
	// [Window.open()] https://developer.mozilla.org/en-US/docs/Web/API/Window/open
	// [Window.postMessage()] https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage
	// [Window.print()] https://developer.mozilla.org/en-US/docs/Web/API/Window/print
	// [Window.prompt()] https://developer.mozilla.org/en-US/docs/Web/API/Window/prompt
	// [Window.queryLocalFonts()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/queryLocalFonts
	// [Window.reportError()] https://developer.mozilla.org/en-US/docs/Web/API/reportError
	// [Window.requestAnimationFrame()] https://developer.mozilla.org/en-US/docs/Web/API/Window/requestAnimationFrame
	// [Window.requestIdleCallback()] https://developer.mozilla.org/en-US/docs/Web/API/Window/requestIdleCallback
	// [Window.resizeBy()] https://developer.mozilla.org/en-US/docs/Web/API/Window/resizeBy
	bool resizeBy(int& _xDelta, int& _yDelta) {
		DKDEBUGFUNC(_xDelta, _yDelta);
		#if WIN
			RECT rect;
			GetWindowRect(GetConsoleWindow(), &rect);
			int X = rect.left;
			int Y = rect.top;
			int nWidth = rect.right - rect.left + _xDelta;
			int nHeight = rect.bottom - rect.top + _yDelta;
			if (!MoveWindow(GetConsoleWindow(), X, Y, nWidth, nHeight, TRUE))
				return DKERROR("MoveWindow() failed");
		#endif
		return true;
	}
	// [Window.resizeTo()] https://developer.mozilla.org/en-US/docs/Web/API/Window/resizeTo
	bool resizeTo(int& _width, int& _height) {
		DKDEBUGFUNC(_width, _height);
		#if WIN
			RECT rect;
			GetWindowRect(GetConsoleWindow(), &rect);
			int X = rect.left;
			int Y = rect.top;
			int nWidth = _width;
			int nHeight = _height;
			if (!MoveWindow(GetConsoleWindow(), X, Y, nWidth, nHeight, TRUE))
				return DKERROR("MoveWindow() failed");
		#endif
		return true;
	}
	// [Window.scroll()] https://developer.mozilla.org/en-US/docs/Web/API/Window/scroll
	// [Window.scrollBy()] https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollBy
	// [Window.scrollByLines()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollByLines
	// [Window.scrollByPages()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollByPages
	// [Window.scrollTo()] https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollTo
	// [Window.setImmediate()] https://developer.mozilla.org/en-US/docs/Web/API/Window/setImmediate
	// [Window.setInterval()] https://developer.mozilla.org/en-US/docs/Web/API/Window/setInterval
	// [Window.setResizable()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window
	// [Window.setTimeout()] https://developer.mozilla.org/en-US/docs/Web/API/Window/setTimeout
	// [Window.sizeToContent()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/sizeToContent
	// [Window.showOpenFilePicker()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/showOpenFilePicker
	// [Window.showSaveFilePicker()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/showSaveFilePicker
	// [Window.showDirectoryPicker()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/showDirectoryPicker
	// [Window.stop()] https://developer.mozilla.org/en-US/docs/Web/API/Window/stop
	// [Window.updateCommands()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/updateCommands


	////// Deprecated methods //////
	// [Window.back()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/back
	// [Window.captureEvents()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/captureEvents
	// [Window.forward()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/forward
	// [Window.releaseEvents()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/releaseEvents
	// [Window.showModalDialog()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/showModalDialog
	
	
	////// DK //////
	void Loop();

	// KeyboardEvent
	bool altKey;
	DKString code;
	bool ctrlKey;
	bool isComposing;
	char key;
	DKString locale;
	unsigned int location;
	bool metaKey;
	bool repeat;
	bool shiftKey;
	//DKString _char;
	//unsigned int charCode;
	//unsigned int keyCode;
	//DKString keyIdentifier;
	//unsigned int keyLocation;
	//unsigned int which;
	
	// MouseEvent
	bool button_state[5];
	unsigned int button;
	unsigned int buttons;
	unsigned int clientX;
	unsigned int clientY;
	//int layerX;
	//int layerY;
	int movementX;
	int movementY;
	int offsetX;
	int offsetY;
	int pageX;
	int pageY;
	DKString relatedTarget;
	unsigned int screenX;
	unsigned int screenY;
	//float mozPressure;
	//DKString mozInputSource;
	//unsigned int webkitForce;
	unsigned int x;
	unsigned int y;

	// WheelEvent
	int deltaX;
	int deltaY;
	int deltaZ;
	unsigned long deltaMode;
	int wheelDelta;
	int wheelDeltaX;
	int wheelDeltaY;

	// FocusEvent
	//DKString relatedTarget;

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
REGISTER_OBJECT(DKConsoleWindow, true);


#endif //DKConsoleWindow_H