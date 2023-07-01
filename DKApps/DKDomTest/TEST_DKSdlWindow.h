#pragma once
#ifndef TEST_DKSdlWindow_H
#define TEST_DKSdlWindow_H

#include "DKSdlWindow/DKSdlWindow.h"


class TEST_DKSdlWindow //: public DKObjectT<TEST_DKSdlWindow>
{
public:
	static DKSdlWindow* _dkSdlWindow;
	//static std::unique_ptr<DKSdlWindow> _dkSdlWindow;
	//static std::shared_ptr<DKSdlWindow> _dkSdlWindow;
	
	TEST_DKSdlWindow(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKSdlWindow.h //////");
		
		_dkSdlWindow = new DKSdlWindow();
		//_dkSdlWindow = std::make_unique<DKSdlWindow>();
		//_dkSdlWindow = std::make_shared<DKSdlWindow>();	
		
		
		_dkSdlWindow->screen(TEST_Screen::_screen);
		printDKSdlWindowProperties(*_dkSdlWindow);
		
		////// FocusEvent //////
		// https://w3c.github.io/uievents/#events-focus-types
		_dkSdlWindow->addEventListener("blur", 				&TEST_DKSdlWindow::onblur);
		_dkSdlWindow->addEventListener("focus", 				&TEST_DKSdlWindow::onfocus);
		_dkSdlWindow->addEventListener("focusin", 			&TEST_DKSdlWindow::onfocusin);
		_dkSdlWindow->addEventListener("focusout", 			&TEST_DKSdlWindow::onfocusout);
		
		////// MouseEvent //////
		// https://w3c.github.io/uievents/#events-mouse-types
		_dkSdlWindow->addEventListener("auxclick", 			&TEST_DKSdlWindow::onauxclick);
		_dkSdlWindow->addEventListener("click", 				&TEST_DKSdlWindow::onclick);
		_dkSdlWindow->addEventListener("contextmenu",		&TEST_DKSdlWindow::oncontextmenu);
		_dkSdlWindow->addEventListener("dblclick", 			&TEST_DKSdlWindow::ondblclick);
		_dkSdlWindow->addEventListener("mousedown", 			&TEST_DKSdlWindow::onmousedown);
		_dkSdlWindow->addEventListener("mouseenter", 		&TEST_DKSdlWindow::onmouseenter);
		_dkSdlWindow->addEventListener("mouseleave", 		&TEST_DKSdlWindow::onmouseleave);
		_dkSdlWindow->addEventListener("mousemove", 			&TEST_DKSdlWindow::onmousemove);
		_dkSdlWindow->addEventListener("mouseout", 			&TEST_DKSdlWindow::onmouseout);
		_dkSdlWindow->addEventListener("mouseover", 			&TEST_DKSdlWindow::onmouseover);
		_dkSdlWindow->addEventListener("mouseup", 			&TEST_DKSdlWindow::onmouseup);
		
		////// WheelEvent //////
		// https://w3c.github.io/uievents/#events-wheel-types
		_dkSdlWindow->addEventListener("wheel", 				&TEST_DKSdlWindow::onwheel);
		
		////// InputEvent //////
		// https://w3c.github.io/uievents/#events-input-types
		_dkSdlWindow->addEventListener("beforeinput", 		&TEST_DKSdlWindow::onbeforeinput);
		_dkSdlWindow->addEventListener("input", 				&TEST_DKSdlWindow::oninput);
		
		////// KeyboardEvent //////
		// https://w3c.github.io/uievents/#events-keyboard-types
		_dkSdlWindow->addEventListener("keydown", 			&TEST_DKSdlWindow::onkeydown);
		_dkSdlWindow->addEventListener("keyup", 				&TEST_DKSdlWindow::onkeyup);
		
		////// CompositionEvent //////
		// https://w3c.github.io/uievents/#events-composition-types
		_dkSdlWindow->addEventListener("compositionstart",	&TEST_DKSdlWindow::oncompositionstart);
		_dkSdlWindow->addEventListener("compositionupdate", 	&TEST_DKSdlWindow::oncompositionupdate);
		_dkSdlWindow->addEventListener("compositionend", 	&TEST_DKSdlWindow::oncompositionend);
	}
	
	~TEST_DKSdlWindow(){
		delete _dkSdlWindow;
	}

	static void printDKSdlWindowProperties(DKSdlWindow& dkSdlWindow){
		DKDEBUGFUNC(dkSdlWindow);
		
		console.log("dkSdlWindow = "				+toString(dkSdlWindow));
		
		TEST_Window::printWindowProperties(dkSdlWindow);
	}
	
	////// FocusEvent //////
	// https://w3c.github.io/uievents/#events-focus-types
	static bool onblur(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::onblur()");
		TEST_FocusEvent::printFocusEventProperties(dynamic_cast<DKFocusEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onfocus(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::onfocus()");
		TEST_FocusEvent::printFocusEventProperties(dynamic_cast<DKFocusEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onfocusin(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::onfocusin()");
		TEST_FocusEvent::printFocusEventProperties(dynamic_cast<DKFocusEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onfocusout(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::onfocusout()");
		TEST_FocusEvent::printFocusEventProperties(dynamic_cast<DKFocusEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// MouseEvent //////
	// https://w3c.github.io/uievents/#events-mouse-types
	static bool onauxclick(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::onauxclick()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onclick(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::onclick()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool oncontextmenu(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::oncontextmenu()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool ondblclick(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::ondblclick()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmousedown(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::onmousedown()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseenter(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::onmouseenter()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseleave(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::onmouseleave()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmousemove(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::onmousemove()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseout(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::onmouseout()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseover(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::onmouseover()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseup(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::onmouseup()");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// WheelEvent //////
	// https://w3c.github.io/uievents/#events-wheel-types
	static bool onwheel(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::onwheel()");
		TEST_WheelEvent::printWheelEventProperties(dynamic_cast<DKWheelEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// InputEvent //////
	// https://w3c.github.io/uievents/#events-input-types
	static bool onbeforeinput(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::onbeforeinput()");
		TEST_InputEvent::printInputEventProperties(dynamic_cast<DKInputEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool oninput(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::oninput()");
		TEST_InputEvent::printInputEventProperties(dynamic_cast<DKInputEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// KeyboardEvent //////
	// https://w3c.github.io/uievents/#events-keyboard-types
	static bool onkeydown(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::onkeydown()");
		TEST_KeyboardEvent::printKeyboardEventProperties(dynamic_cast<DKKeyboardEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onkeyup(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::onkeyup()");
		TEST_KeyboardEvent::printKeyboardEventProperties(dynamic_cast<DKKeyboardEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// CompositionEvent //////
	// https://w3c.github.io/uievents/#events-composition-types
	static bool oncompositionstart(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::oncompositionstart()");
		TEST_CompositionEvent::printCompositionEventProperties(dynamic_cast<DKCompositionEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool oncompositionupdate(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::oncompositionupdate()");
		TEST_CompositionEvent::printCompositionEventProperties(dynamic_cast<DKCompositionEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool oncompositionend(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_DKSdlWindow::oncompositionend()");
		TEST_CompositionEvent::printCompositionEventProperties(dynamic_cast<DKCompositionEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
};
//REGISTER_OBJECT(TEST_DKSdlWindow, true);

DKSdlWindow* TEST_DKSdlWindow::_dkSdlWindow;
//std::unique_ptr<DKSdlWindow> TEST_DKSdlWindow::_dkSdlWindow;
//std::shared_ptr<DKSdlWindow> TEST_DKSdlWindow::_dkSdlWindow;

//DKSdlWindow& window;	// global window variable (TODO)



#endif //TEST_DKSdlWindow_H