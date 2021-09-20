//https://developer.mozilla.org/en-US/docs/Web/API/Window

#pragma once
#ifndef DKDomWindow_H
#define DKDomWindow_H

#include "DKDuktape/DKDuktape.h"

class DKDomWindow : public DKObjectT<DKDomWindow>
{
public:
	bool Init();
	// Properties
	static int closed(duk_context* ctx);
	static int console(duk_context* ctx);
	static int controllers(duk_context* ctx);
	static int customElements(duk_context* ctx);
	static int crypto(duk_context* ctx);
	static int devicePixelRatio(duk_context* ctx);
	static int document(duk_context* ctx);
	static int DOMMatrix(duk_context* ctx);
	static int DOMMatrixReadOnly(duk_context* ctx);
	static int DOMPoint(duk_context* ctx);
	static int DOMPointReadOnly(duk_context* ctx);
	static int DOMQuad(duk_context* ctx);
	static int DOMRect(duk_context* ctx);
	static int DOMRectReadOnly(duk_context* ctx);
	static int event(duk_context* ctx);
	static int frameElement(duk_context* ctx);
	static int frames(duk_context* ctx);
	static int fullscreen(duk_context* ctx);
	static int history(duk_context* ctx);
	static int innerHeight(duk_context* ctx);
	static int innerWidth(duk_context* ctx);
	static int isSecureContext(duk_context* ctx);
	static int length(duk_context* ctx);
	static int location(duk_context* ctx);
	static int locationbar(duk_context* ctx);
	static int locationStorage(duk_context* ctx);
	static int menubar(duk_context* ctx);
	static int messageManager(duk_context* ctx);
	static int mozInnerScreenX(duk_context* ctx);
	static int mozInnerScreenY(duk_context* ctx);
	static int name(duk_context* ctx);
	static int navigator(duk_context* ctx);
	static int opener(duk_context* ctx);
	static int outterHeight(duk_context* ctx);
	static int outterWidth(duk_context* ctx);
	static int pageXOffset(duk_context* ctx);
	static int pageYOffset(duk_context* ctx);
	static int parent(duk_context* ctx);
	static int performance(duk_context* ctx);
	static int personalbar(duk_context* ctx);
	static int screen(duk_context* ctx);
	static int screenX(duk_context* ctx);
	static int screenY(duk_context* ctx);
	static int screenLeft(duk_context* ctx);
	static int screenTop(duk_context* ctx);
	static int scrollbars(duk_context* ctx);
	static int scrollMaxX(duk_context* ctx);
	static int scrollMaxY(duk_context* ctx);
	static int scrollX(duk_context* ctx);
	static int scrollY(duk_context* ctx);
	static int self(duk_context* ctx);
	static int sessionStroage(duk_context* ctx);
	static int sidebar(duk_context* ctx);
	static int speechSynthesis(duk_context* ctx);
	static int status(duk_context* ctx);
	static int statusbar(duk_context* ctx);
	static int toolbar(duk_context* ctx);
	static int top(duk_context* ctx);
	static int visualViewport(duk_context* ctx);
	static int window(duk_context* ctx);

	// Deprecated properties
	static int content(duk_context* ctx);
	static int defaultStatus(duk_context* ctx);
	static int dialogArguments(duk_context* ctx);
	static int directories(duk_context* ctx);
	static int globalStorage(duk_context* ctx);
	static int mozAnimationStartTime(duk_context* ctx);
	static int mozPaintCount(duk_context* ctx);
	static int orientation(duk_context* ctx);
	static int pkcs11(duk_context* ctx);
	static int returnValue(duk_context* ctx);

	// Methods
	static int alert(duk_context* ctx);
	static int blur(duk_context* ctx);
	static int cancelAnimationFrame(duk_context* ctx);
	static int cancelIdleCallback(duk_context* ctx);
	static int clearImmediate(duk_context* ctx);
	static int close(duk_context* ctx);
	static int confirm(duk_context* ctx);
	static int dump(duk_context* ctx);
	static int find(duk_context* ctx);
	static int focus(duk_context* ctx);
	static int getComputedStyle(duk_context* ctx);
	static int getDefaultComputedStyle(duk_context* ctx);
	static int getSelection(duk_context* ctx);
	static int matchMedia(duk_context* ctx);
	static int maximize(duk_context* ctx);
	static int minimize(duk_context* ctx);
	static int moveBy(duk_context* ctx);
	static int moveTo(duk_context* ctx);
	static int open(duk_context* ctx);
	static int postMessage(duk_context* ctx);
	static int print(duk_context* ctx);
	static int prompt(duk_context* ctx);
	static int requestAnimationFrame(duk_context* ctx);
	static int requestIdleCallback(duk_context* ctx);
	static int resizeBy(duk_context* ctx);
	static int resizeTo(duk_context* ctx);
	static int scroll(duk_context* ctx);
	static int scrollBy(duk_context* ctx);
	static int scrollByLines(duk_context* ctx);
	static int scrollByPages(duk_context* ctx);
	static int scrollTo(duk_context* ctx);
	static int setImmediate(duk_context* ctx);
	static int setResizeable(duk_context* ctx);
	static int sizeToContent(duk_context* ctx);
	static int stop(duk_context* ctx);
	static int updateCommands(duk_context* ctx);

	// Deprecated methods
	static int back(duk_context* ctx);
	static int captureEvents(duk_context* ctx);
	static int forward(duk_context* ctx);
	static int getAttention(duk_context* ctx);
	static int home(duk_context* ctx);
	static int openDialog(duk_context* ctx);
	static int releaseEvents(duk_context* ctx);
	static int showModalDialog(duk_context* ctx);

	// Event handlers
	//TODO

	// Events
	//TODO
};

REGISTER_OBJECT(DKDomWindow, true)

#endif //DKDomWindow_H