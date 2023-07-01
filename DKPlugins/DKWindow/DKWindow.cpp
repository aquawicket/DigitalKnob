#include "DKWindow/DKWindow.h"

// the current browsing context
// [LegacyUnforgeable] readonly attribute WindowProxy window;
DKWindowProxy* 	DKWindow::window()						{ return _window ? _window : new DKNullWindow(); }		// getter						
void 			DKWindow::window(DKWindowProxy* window)	{ _window = window; }									// setter
				
// [Replaceable] readonly attribute WindowProxy self;
DKWindowProxy* 	DKWindow::self()						{ return _self ? _self : new DKNullWindow(); }			// getter							
void 			DKWindow::self(DKWindowProxy* self)		{ _self = self; }										// setter	

// other browsing contexts
// [Replaceable] readonly attribute WindowProxy frames;
DKWindowProxy* 	DKWindow::frames()						{ return _frames ? _frames : new DKNullWindow(); }		// getter							
void 			DKWindow::frames(DKWindowProxy* frames)	{ _frames = frames; }									// setter

// [LegacyUnforgeable] readonly attribute WindowProxy? top;
DKWindowProxy* 	DKWindow::top()							{ return _top ? _top : new DKNullWindow(); }			// getter							
void 			DKWindow::top(DKWindowProxy* top)		{ _top = top; }											// setter

// [Replaceable] readonly attribute WindowProxy? parent;
DKWindowProxy* 	DKWindow::parent()						{ return _parent ? _parent : new DKNullWindow(); }		// getter							
void 			DKWindow::parent(DKWindowProxy* parent)	{ _parent = parent; }									// setter