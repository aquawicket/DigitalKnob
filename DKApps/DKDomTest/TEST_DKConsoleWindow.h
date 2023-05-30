#pragma once
#ifndef TEST_DKConsoleWindow_H
#define TEST_DKConsoleWindow_H

#include "DKConsoleWindow/DKConsoleWindow.h"


class TEST_DKConsoleWindow : public DKObjectT<TEST_DKConsoleWindow>
{
public:
	DKConsoleWindow dkConsoleWindow;

	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_DKConsoleWindow.h ////// \n");
		
		printDKConsoleWindowProperties(dkConsoleWindow);
		
		////// FocusEvent //////
		// https://w3c.github.io/uievents/#events-focus-types
		dkConsoleWindow.addEventListener("blur", 				&TEST_DKConsoleWindow::onblur);
		dkConsoleWindow.addEventListener("focus", 				&TEST_DKConsoleWindow::onfocus);
		dkConsoleWindow.addEventListener("focusin", 			&TEST_DKConsoleWindow::onfocusin);
		dkConsoleWindow.addEventListener("focusout", 			&TEST_DKConsoleWindow::onfocusout);
		
		////// MouseEvent //////
		// https://w3c.github.io/uievents/#events-mouse-types
		dkConsoleWindow.addEventListener("auxclick", 			&TEST_DKConsoleWindow::onauxclick);
		dkConsoleWindow.addEventListener("click", 				&TEST_DKConsoleWindow::onclick);
		dkConsoleWindow.addEventListener("contextmenu",			&TEST_DKConsoleWindow::oncontextmenu);
		dkConsoleWindow.addEventListener("dblclick", 			&TEST_DKConsoleWindow::ondblclick);
		dkConsoleWindow.addEventListener("mousedown", 			&TEST_DKConsoleWindow::onmousedown);
		dkConsoleWindow.addEventListener("mouseenter", 			&TEST_DKConsoleWindow::onmouseenter);
		dkConsoleWindow.addEventListener("mouseleave", 			&TEST_DKConsoleWindow::onmouseleave);
		dkConsoleWindow.addEventListener("mousemove", 			&TEST_DKConsoleWindow::onmousemove);
		dkConsoleWindow.addEventListener("mouseout", 			&TEST_DKConsoleWindow::onmouseout);
		dkConsoleWindow.addEventListener("mouseover", 			&TEST_DKConsoleWindow::onmouseover);
		dkConsoleWindow.addEventListener("mouseup", 			&TEST_DKConsoleWindow::onmouseup);
		
		////// WheelEvent //////
		// https://w3c.github.io/uievents/#events-wheel-types
		dkConsoleWindow.addEventListener("wheel", 				&TEST_DKConsoleWindow::onwheel);
		
		////// InputEvent //////
		// https://w3c.github.io/uievents/#events-input-types
		dkConsoleWindow.addEventListener("beforeinput", 		&TEST_DKConsoleWindow::onbeforeinput);
		dkConsoleWindow.addEventListener("input", 				&TEST_DKConsoleWindow::oninput);
		
		////// KeyboardEvent //////
		// https://w3c.github.io/uievents/#events-keyboard-types
		dkConsoleWindow.addEventListener("keydown", 			&TEST_DKConsoleWindow::onkeydown);
		dkConsoleWindow.addEventListener("keyup", 				&TEST_DKConsoleWindow::onkeyup);
		
		////// CompositionEvent //////
		// https://w3c.github.io/uievents/#events-composition-types
		dkConsoleWindow.addEventListener("compositionstart",	&TEST_DKConsoleWindow::oncompositionstart);
		dkConsoleWindow.addEventListener("compositionupdate", 	&TEST_DKConsoleWindow::oncompositionupdate);
		dkConsoleWindow.addEventListener("compositionend", 		&TEST_DKConsoleWindow::oncompositionend);
		
		return true;
	}

	static void printDKConsoleWindowProperties(DKConsoleWindow& dkConsoleWindow){
		DKDEBUGFUNC(dkConsoleWindow);
		//DKINFO("dkConsoleWindow.columns() = "	+toString(dkConsoleWindow.columns())	+"\n");		// TODO
		//DKINFO("dkConsoleWindow.rows() = "	+toString(dkConsoleWindow.rows())		+"\n");		// TODO
		
		TEST_Window::printWindowProperties(dynamic_cast<DKWindow&>(dkConsoleWindow));	//TODO: try to remove the need for dynamic_cast
	}
	
	////// FocusEvent //////
	// https://w3c.github.io/uievents/#events-focus-types
	static bool onblur(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::onblur() \n");
		TEST_FocusEvent::printFocusEventProperties(dynamic_cast<DKFocusEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onfocus(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::onfocus() \n");
		TEST_FocusEvent::printFocusEventProperties(dynamic_cast<DKFocusEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onfocusin(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::onfocusin() \n");
		TEST_FocusEvent::printFocusEventProperties(dynamic_cast<DKFocusEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onfocusout(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::onfocusout() \n");
		TEST_FocusEvent::printFocusEventProperties(dynamic_cast<DKFocusEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// MouseEvent //////
	// https://w3c.github.io/uievents/#events-mouse-types
	static bool onauxclick(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::onauxclick() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onclick(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::onclick() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool oncontextmenu(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::oncontextmenu() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool ondblclick(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::ondblclick() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmousedown(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::onmousedown() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseenter(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::onmouseenter() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseleave(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::onmouseleave() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmousemove(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::onmousemove() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseout(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::onmouseout() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseover(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::onmouseover() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onmouseup(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::onmouseup() \n");
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// WheelEvent //////
	// https://w3c.github.io/uievents/#events-wheel-types
	static bool onwheel(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::onwheel() \n");
		TEST_WheelEvent::printWheelEventProperties(dynamic_cast<DKWheelEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// InputEvent //////
	// https://w3c.github.io/uievents/#events-input-types
	static bool onbeforeinput(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::onbeforeinput() \n");
		TEST_InputEvent::printInputEventProperties(dynamic_cast<DKInputEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool oninput(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::oninput() \n");
		TEST_InputEvent::printInputEventProperties(dynamic_cast<DKInputEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// KeyboardEvent //////
	// https://w3c.github.io/uievents/#events-keyboard-types
	static bool onkeydown(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::onkeydown() \n");
		TEST_KeyboardEvent::printKeyboardEventProperties(dynamic_cast<DKKeyboardEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool onkeyup(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::onkeyup() \n");
		TEST_KeyboardEvent::printKeyboardEventProperties(dynamic_cast<DKKeyboardEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
	
	////// CompositionEvent //////
	// https://w3c.github.io/uievents/#events-composition-types
	static bool oncompositionstart(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::oncompositionstart() \n");
		TEST_CompositionEvent::printCompositionEventProperties(dynamic_cast<DKCompositionEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool oncompositionupdate(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::oncompositionupdate() \n");
		TEST_CompositionEvent::printCompositionEventProperties(dynamic_cast<DKCompositionEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
	static bool oncompositionend(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("\nTEST_DKConsoleWindow::oncompositionend() \n");
		TEST_CompositionEvent::printCompositionEventProperties(dynamic_cast<DKCompositionEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
		
};
REGISTER_OBJECT(TEST_DKConsoleWindow, true);


#endif //TEST_DKConsoleWindow_H