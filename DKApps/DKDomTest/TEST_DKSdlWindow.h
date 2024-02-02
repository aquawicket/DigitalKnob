#pragma once
#ifndef TEST_DKSDLWindow_H
#define TEST_DKSDLWindow_H

#include "DKSDLWindow/DKSDLWindow.h"


class TEST_DKSDLWindow //: public DKObjectT<TEST_DKSDLWindow>
{
public:
	static DKSDLWindow* _dkSdlWindow;
	//static std::unique_ptr<DKSDLWindow> _dkSdlWindow;
	//static std::shared_ptr<DKSDLWindow> _dkSdlWindow;
	
	TEST_DKSDLWindow(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKSDLWindow.h //////");
		
		_dkSdlWindow = new DKSDLWindow();
		//_dkSdlWindow = std::make_unique<DKSDLWindow>();
		//_dkSdlWindow = std::make_shared<DKSDLWindow>();	
		
		
		_dkSdlWindow->screen(TEST_Screen::_screen);
		printDKSDLWindowProperties(_dkSdlWindow);
		
		////// FocusEvent //////
		// https://w3c.github.io/uievents/#events-focus-types
		_dkSdlWindow->addEventListener("blur", 				&TEST_DKSDLWindow::onblur);
		_dkSdlWindow->addEventListener("focus", 			&TEST_DKSDLWindow::onfocus);
		_dkSdlWindow->addEventListener("focusin", 			&TEST_DKSDLWindow::onfocusin);
		_dkSdlWindow->addEventListener("focusout", 			&TEST_DKSDLWindow::onfocusout);
		
		////// MouseEvent //////
		// https://w3c.github.io/uievents/#events-mouse-types
		_dkSdlWindow->addEventListener("auxclick", 			&TEST_DKSDLWindow::onauxclick);
		_dkSdlWindow->addEventListener("click", 			&TEST_DKSDLWindow::onclick);
		_dkSdlWindow->addEventListener("contextmenu",		&TEST_DKSDLWindow::oncontextmenu);
		_dkSdlWindow->addEventListener("dblclick", 			&TEST_DKSDLWindow::ondblclick);
		_dkSdlWindow->addEventListener("mousedown", 		&TEST_DKSDLWindow::onmousedown);
		_dkSdlWindow->addEventListener("mouseenter", 		&TEST_DKSDLWindow::onmouseenter);
		_dkSdlWindow->addEventListener("mouseleave", 		&TEST_DKSDLWindow::onmouseleave);
		_dkSdlWindow->addEventListener("mousemove", 		&TEST_DKSDLWindow::onmousemove);
		_dkSdlWindow->addEventListener("mouseout", 			&TEST_DKSDLWindow::onmouseout);
		_dkSdlWindow->addEventListener("mouseover", 		&TEST_DKSDLWindow::onmouseover);
		_dkSdlWindow->addEventListener("mouseup", 			&TEST_DKSDLWindow::onmouseup);
		
		////// WheelEvent //////
		// https://w3c.github.io/uievents/#events-wheel-types
		_dkSdlWindow->addEventListener("wheel", 				&TEST_DKSDLWindow::onwheel);
		
		////// InputEvent //////
		// https://w3c.github.io/uievents/#events-input-types
		_dkSdlWindow->addEventListener("beforeinput", 		&TEST_DKSDLWindow::onbeforeinput);
		_dkSdlWindow->addEventListener("input", 			&TEST_DKSDLWindow::oninput);
		
		////// KeyboardEvent //////
		// https://w3c.github.io/uievents/#events-keyboard-types
		_dkSdlWindow->addEventListener("keydown", 			&TEST_DKSDLWindow::onkeydown);
		_dkSdlWindow->addEventListener("keyup", 			&TEST_DKSDLWindow::onkeyup);
		
		////// CompositionEvent //////
		// https://w3c.github.io/uievents/#events-composition-types
		_dkSdlWindow->addEventListener("compositionstart",	&TEST_DKSDLWindow::oncompositionstart);
		_dkSdlWindow->addEventListener("compositionupdate", &TEST_DKSDLWindow::oncompositionupdate);
		_dkSdlWindow->addEventListener("compositionend", 	&TEST_DKSDLWindow::oncompositionend);
	}
	
	~TEST_DKSDLWindow(){
		delete _dkSdlWindow;
	}

	static void printDKSDLWindowProperties(DKSDLWindow* dkSdlWindow){
		DKDEBUGFUNC(dkSdlWindow);
		
		console.log("dkSdlWindow = "				+toString(dkSdlWindow));
		
		TEST_Window::printWindowProperties(dkSdlWindow);
	}
	
	////// FocusEvent //////
	// https://w3c.github.io/uievents/#events-focus-types
	static bool onblur(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::onblur()");
		TEST_FocusEvent::printFocusEventProperties(dynamic_cast<DKFocusEvent*>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onfocus(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::onfocus()");
		TEST_FocusEvent::printFocusEventProperties(dynamic_cast<DKFocusEvent*>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onfocusin(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::onfocusin()");
		TEST_FocusEvent::printFocusEventProperties(dynamic_cast<DKFocusEvent*>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onfocusout(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::onfocusout()");
		TEST_FocusEvent::printFocusEventProperties(dynamic_cast<DKFocusEvent*>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// MouseEvent //////
	// https://w3c.github.io/uievents/#events-mouse-types
	static bool onauxclick(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::onauxclick()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent*>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onclick(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::onclick()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent*>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool oncontextmenu(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::oncontextmenu()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent*>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool ondblclick(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::ondblclick()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent*>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmousedown(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::onmousedown()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent*>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseenter(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::onmouseenter()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent*>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseleave(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::onmouseleave()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent*>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmousemove(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::onmousemove()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent*>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseout(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::onmouseout()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent*>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseover(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::onmouseover()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent*>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseup(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::onmouseup()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent*>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// WheelEvent //////
	// https://w3c.github.io/uievents/#events-wheel-types
	static bool onwheel(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::onwheel()");
		TEST_WheelEvent::printWheelEventProperties(dynamic_cast<DKWheelEvent*>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// InputEvent //////
	// https://w3c.github.io/uievents/#events-input-types
	static bool onbeforeinput(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::onbeforeinput()");
		TEST_InputEvent::printInputEventProperties(dynamic_cast<DKInputEvent*>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool oninput(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::oninput()");
		TEST_InputEvent::printInputEventProperties(dynamic_cast<DKInputEvent*>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// KeyboardEvent //////
	// https://w3c.github.io/uievents/#events-keyboard-types
	static bool onkeydown(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::onkeydown()");
		TEST_KeyboardEvent::printKeyboardEventProperties(dynamic_cast<DKKeyboardEvent*>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onkeyup(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::onkeyup()");
		TEST_KeyboardEvent::printKeyboardEventProperties(dynamic_cast<DKKeyboardEvent*>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// CompositionEvent //////
	// https://w3c.github.io/uievents/#events-composition-types
	static bool oncompositionstart(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::oncompositionstart()");
		TEST_CompositionEvent::printCompositionEventProperties(dynamic_cast<DKCompositionEvent*>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool oncompositionupdate(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::oncompositionupdate()");
		TEST_CompositionEvent::printCompositionEventProperties(dynamic_cast<DKCompositionEvent*>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool oncompositionend(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSDLWindow::oncompositionend()");
		TEST_CompositionEvent::printCompositionEventProperties(dynamic_cast<DKCompositionEvent*>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
};
//REGISTER_OBJECT(TEST_DKSDLWindow, true);

DKSDLWindow* TEST_DKSDLWindow::_dkSdlWindow;
//std::unique_ptr<DKSDLWindow> TEST_DKSDLWindow::_dkSdlWindow;
//std::shared_ptr<DKSDLWindow> TEST_DKSDLWindow::_dkSdlWindow;

//DKSDLWindow& window;	// global window variable (TODO)



#endif //TEST_DKSDLWindow_H