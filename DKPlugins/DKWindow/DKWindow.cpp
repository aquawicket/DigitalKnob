#include "DKWindow/DKWindow.h"

// the current browsing context
// [LegacyUnforgeable] readonly attribute WindowProxy window;
DKWindowProxy* 	DKWindow::window()						{ return _window; }		// getter						
void 			DKWindow::window(DKWindowProxy* window)	{ _window = window; }	// setter
				
// [Replaceable] readonly attribute WindowProxy self;
DKWindowProxy* 	DKWindow::self()						{ return _self; }		// getter							
void 			DKWindow::self(DKWindowProxy* self)		{ _self = self; }		// setter	

// other browsing contexts
// [Replaceable] readonly attribute WindowProxy frames;
DKWindowProxy* 	DKWindow::frames()						{ return _frames; }		// getter							
void 			DKWindow::frames(DKWindowProxy* frames)	{ _frames = frames; }	// setter

// [LegacyUnforgeable] readonly attribute WindowProxy? top;
DKWindowProxy* 	DKWindow::top()							{ return _top; }		// getter							
void 			DKWindow::top(DKWindowProxy* top)		{ _top = top; }			// setter

// [Replaceable] readonly attribute WindowProxy? parent;
DKWindowProxy* 	DKWindow::parent()						{ return _parent; }		// getter							
void 			DKWindow::parent(DKWindowProxy* parent)	{ _parent = parent; }	// setter