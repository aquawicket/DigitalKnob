#pragma once
#ifndef TEST_DKSdlWindow_H
#define TEST_DKSdlWindow_H

#include "DKSdlWindow/DKSdlWindow.h"


class TEST_DKSdlWindow : public DKObjectT<TEST_DKSdlWindow>
{
public:
	DKSdlWindow dkSdlWindow;
	
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_DKSdlWindow.h //////\n");
		
		printDKSdlWindowProperties(dkSdlWindow);
		
		////// FocusEvent //////
		// https://w3c.github.io/uievents/#events-focus-types
		dkSdlWindow.addEventListener("blur", 				&TEST_DKSdlWindow::onblur);
		dkSdlWindow.addEventListener("focus", 				&TEST_DKSdlWindow::onfocus);
		dkSdlWindow.addEventListener("focusin", 			&TEST_DKSdlWindow::onfocusin);
		dkSdlWindow.addEventListener("focusout", 			&TEST_DKSdlWindow::onfocusout);
		
		////// MouseEvent //////
		// https://w3c.github.io/uievents/#events-mouse-types
		dkSdlWindow.addEventListener("auxclick", 			&TEST_DKSdlWindow::onauxclick);
		dkSdlWindow.addEventListener("click", 				&TEST_DKSdlWindow::onclick);
		dkSdlWindow.addEventListener("contextmenu",			&TEST_DKSdlWindow::oncontextmenu);
		dkSdlWindow.addEventListener("dblclick", 			&TEST_DKSdlWindow::ondblclick);
		dkSdlWindow.addEventListener("mousedown", 			&TEST_DKSdlWindow::onmousedown);
		dkSdlWindow.addEventListener("mouseenter", 			&TEST_DKSdlWindow::onmouseenter);
		dkSdlWindow.addEventListener("mouseleave", 			&TEST_DKSdlWindow::onmouseleave);
		dkSdlWindow.addEventListener("mousemove", 			&TEST_DKSdlWindow::onmousemove);
		dkSdlWindow.addEventListener("mouseout", 			&TEST_DKSdlWindow::onmouseout);
		dkSdlWindow.addEventListener("mouseover", 			&TEST_DKSdlWindow::onmouseover);
		dkSdlWindow.addEventListener("mouseup", 			&TEST_DKSdlWindow::onmouseup);
		
		////// WheelEvent //////
		// https://w3c.github.io/uievents/#events-wheel-types
		dkSdlWindow.addEventListener("wheel", 				&TEST_DKSdlWindow::onwheel);
		
		////// InputEvent //////
		// https://w3c.github.io/uievents/#events-input-types
		dkSdlWindow.addEventListener("beforeinput", 		&TEST_DKSdlWindow::onbeforeinput);
		dkSdlWindow.addEventListener("input", 				&TEST_DKSdlWindow::oninput);
		
		////// KeyboardEvent //////
		// https://w3c.github.io/uievents/#events-keyboard-types
		dkSdlWindow.addEventListener("keydown", 			&TEST_DKSdlWindow::onkeydown);
		dkSdlWindow.addEventListener("keyup", 				&TEST_DKSdlWindow::onkeyup);
		
		////// CompositionEvent //////
		// https://w3c.github.io/uievents/#events-composition-types
		dkSdlWindow.addEventListener("compositionstart",	&TEST_DKSdlWindow::oncompositionstart);
		dkSdlWindow.addEventListener("compositionupdate", 	&TEST_DKSdlWindow::oncompositionupdate);
		dkSdlWindow.addEventListener("compositionend", 		&TEST_DKSdlWindow::oncompositionend);
		
		return true;
	}

	static void printDKSdlWindowProperties(DKSdlWindow& dkSdlWindow){
		DKDEBUGFUNC(dkSdlWindow);
		
		TEST_Window::printWindowProperties(dynamic_cast<DKWindow&>(dkSdlWindow));	//TODO: try to remove the need for dynamic_cast
	}
	
	////// FocusEvent //////
	// https://w3c.github.io/uievents/#events-focus-types
	static bool onblur(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::onblur() \n");
		TEST_FocusEvent::printFocusEventProperties(dynamic_cast<DKFocusEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onfocus(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::onfocus() \n");
		TEST_FocusEvent::printFocusEventProperties(dynamic_cast<DKFocusEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onfocusin(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::onfocusin() \n");
		TEST_FocusEvent::printFocusEventProperties(dynamic_cast<DKFocusEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onfocusout(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::onfocusout() \n");
		TEST_FocusEvent::printFocusEventProperties(dynamic_cast<DKFocusEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// MouseEvent //////
	// https://w3c.github.io/uievents/#events-mouse-types
	static bool onauxclick(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::onauxclick() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onclick(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::onclick() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool oncontextmenu(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::oncontextmenu() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool ondblclick(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::ondblclick() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmousedown(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::onmousedown() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseenter(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::onmouseenter() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseleave(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::onmouseleave() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmousemove(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::onmousemove() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseout(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::onmouseout() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseover(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::onmouseover() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseup(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::onmouseup() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// WheelEvent //////
	// https://w3c.github.io/uievents/#events-wheel-types
	static bool onwheel(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::onwheel() \n");
		TEST_WheelEvent::printWheelEventProperties(dynamic_cast<DKWheelEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// InputEvent //////
	// https://w3c.github.io/uievents/#events-input-types
	static bool onbeforeinput(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::onbeforeinput() \n");
		TEST_InputEvent::printInputEventProperties(dynamic_cast<DKInputEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool oninput(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::oninput() \n");
		TEST_InputEvent::printInputEventProperties(dynamic_cast<DKInputEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// KeyboardEvent //////
	// https://w3c.github.io/uievents/#events-keyboard-types
	static bool onkeydown(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::onkeydown() \n");
		TEST_KeyboardEvent::printKeyboardEventProperties(dynamic_cast<DKKeyboardEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onkeyup(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::onkeyup() \n");
		TEST_KeyboardEvent::printKeyboardEventProperties(dynamic_cast<DKKeyboardEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// CompositionEvent //////
	// https://w3c.github.io/uievents/#events-composition-types
	static bool oncompositionstart(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::oncompositionstart() \n");
		TEST_CompositionEvent::printCompositionEventProperties(dynamic_cast<DKCompositionEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool oncompositionupdate(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::oncompositionupdate() \n");
		TEST_CompositionEvent::printCompositionEventProperties(dynamic_cast<DKCompositionEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool oncompositionend(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DKSdlWindow::oncompositionend() \n");
		TEST_CompositionEvent::printCompositionEventProperties(dynamic_cast<DKCompositionEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
};
REGISTER_OBJECT(TEST_DKSdlWindow, true);


#endif //TEST_DKSdlWindow_H