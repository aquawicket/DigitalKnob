#pragma once
#ifndef TEST_DKSdlWindow_H
#define TEST_DKSdlWindow_H

#include "DKSdlWindow/DKSdlWindow.h"


class TEST_DKSdlWindow : public DKObjectT<TEST_DKSdlWindow>
{
public:
	DKSdlWindow dkSdlWindowA;
	
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_DKSdlWindow.h //////\n");
		
		printDKSdlWindowProperties(dkSdlWindowA);
		
		////// FocusEvent //////
		// https://w3c.github.io/uievents/#events-focus-types
		dkConsoleWindow.addEventListener("blur", 				&TEST_DKSdlWindow::onblur);
		dkConsoleWindow.addEventListener("focus", 				&TEST_DKSdlWindow::onfocus);
		dkConsoleWindow.addEventListener("focusin", 			&TEST_DKSdlWindow::onfocusin);
		dkConsoleWindow.addEventListener("focusout", 			&TEST_DKSdlWindow::onfocusout);
		
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
};
REGISTER_OBJECT(TEST_DKSdlWindow, true);


#endif //TEST_DKSdlWindow_H