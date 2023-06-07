#pragma once
#ifndef TEST_DKSdlWindow_H
#define TEST_DKSdlWindow_H

#include "DKSdlWindow/DKSdlWindow.h"


class TEST_DKSdlWindow //: public DKObjectT<TEST_DKSdlWindow>
{
public:
	DKSdlWindow* dkSdlWindow;
	
	TEST_DKSdlWindow(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKSdlWindow.h //////");
		
		dkSdlWindow = new DKSdlWindow();
		dkSdlWindow->screen(TEST_Screen::_screen);
		
		printDKSdlWindowProperties(*dkSdlWindow);
		
		////// FocusEvent //////
		// https://w3c.github.io/uievents/#events-focus-types
		dkSdlWindow->addEventListener("blur", 				&TEST_DKSdlWindow::onblur);
		dkSdlWindow->addEventListener("focus", 				&TEST_DKSdlWindow::onfocus);
		dkSdlWindow->addEventListener("focusin", 			&TEST_DKSdlWindow::onfocusin);
		dkSdlWindow->addEventListener("focusout", 			&TEST_DKSdlWindow::onfocusout);
		
		////// MouseEvent //////
		// https://w3c.github.io/uievents/#events-mouse-types
		dkSdlWindow->addEventListener("auxclick", 			&TEST_DKSdlWindow::onauxclick);
		dkSdlWindow->addEventListener("click", 				&TEST_DKSdlWindow::onclick);
		dkSdlWindow->addEventListener("contextmenu",		&TEST_DKSdlWindow::oncontextmenu);
		dkSdlWindow->addEventListener("dblclick", 			&TEST_DKSdlWindow::ondblclick);
		dkSdlWindow->addEventListener("mousedown", 			&TEST_DKSdlWindow::onmousedown);
		dkSdlWindow->addEventListener("mouseenter", 		&TEST_DKSdlWindow::onmouseenter);
		dkSdlWindow->addEventListener("mouseleave", 		&TEST_DKSdlWindow::onmouseleave);
		dkSdlWindow->addEventListener("mousemove", 			&TEST_DKSdlWindow::onmousemove);
		dkSdlWindow->addEventListener("mouseout", 			&TEST_DKSdlWindow::onmouseout);
		dkSdlWindow->addEventListener("mouseover", 			&TEST_DKSdlWindow::onmouseover);
		dkSdlWindow->addEventListener("mouseup", 			&TEST_DKSdlWindow::onmouseup);
		
		////// WheelEvent //////
		// https://w3c.github.io/uievents/#events-wheel-types
		dkSdlWindow->addEventListener("wheel", 				&TEST_DKSdlWindow::onwheel);
		
		////// InputEvent //////
		// https://w3c.github.io/uievents/#events-input-types
		dkSdlWindow->addEventListener("beforeinput", 		&TEST_DKSdlWindow::onbeforeinput);
		dkSdlWindow->addEventListener("input", 				&TEST_DKSdlWindow::oninput);
		
		////// KeyboardEvent //////
		// https://w3c.github.io/uievents/#events-keyboard-types
		dkSdlWindow->addEventListener("keydown", 			&TEST_DKSdlWindow::onkeydown);
		dkSdlWindow->addEventListener("keyup", 				&TEST_DKSdlWindow::onkeyup);
		
		////// CompositionEvent //////
		// https://w3c.github.io/uievents/#events-composition-types
		dkSdlWindow->addEventListener("compositionstart",	&TEST_DKSdlWindow::oncompositionstart);
		dkSdlWindow->addEventListener("compositionupdate", 	&TEST_DKSdlWindow::oncompositionupdate);
		dkSdlWindow->addEventListener("compositionend", 	&TEST_DKSdlWindow::oncompositionend);
	}

	static void printDKSdlWindowProperties(DKSdlWindow& dkSdlWindow){
		//DKDEBUGFUNC(dkSdlWindow);
		
		TEST_Window::printWindowProperties(dynamic_cast<DKWindow&>(dkSdlWindow));					//TODO: try to remove the need for dynamic_cast
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

//DKSdlWindow& window;	// global window variable (TODO)



#endif //TEST_DKSdlWindow_H