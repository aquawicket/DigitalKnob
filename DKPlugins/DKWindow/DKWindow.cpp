#include "DKWindow/DKWindow.h"

DKWindowProxy& DKWindow::window()			{ return _window ? *_window : *new DKNullWindow(); }	// getter						
void DKWindow::window(DKWindowProxy& window){ _window = &window; }									// setter
				

DKWindowProxy* DKWindow::self()				{ return _self ? *_self : *new DKNullWindow(); }		// getter							
void DKWindow::self(DKWindowProxy* self)	{ _self = &self; }										// setter	