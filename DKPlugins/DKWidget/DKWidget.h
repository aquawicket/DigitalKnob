#ifdef USE_DKRocket
#pragma once
#ifndef DKWidget_H
#define DKWidget_H

#include "DK/DK.h"
#include "DKRocket/DKRocket.h"
#include "DKWindow/DKWindow.h"
#include "DKXml/DKXml.h"

//typedef Rocket::Core::Element DKElement;
typedef Rocket::Core::Property DKProperty;
typedef Rocket::Core::ElementList DKElementList;
typedef Rocket::Controls::ElementFormControl DKElementFormControl;
typedef Rocket::Controls::ElementFormControlSelect DKElementFormControlSelect;
typedef Rocket::Controls::ElementFormControlInput DKElementFormControlInput;
typedef Rocket::Core::String DKCString;

///////////////////////////////////////////
class DKWidget : public DKObjectT<DKWidget>
{
public:
	bool Init();
	bool End();

protected:
	static DKRocket* dkRocket;
	Rocket::Core::Element* root;
	
	bool AttachDrags();
	bool AttachEvents();
	bool CreateWidget(DKString& file);
	void RemoveWidget(DKWidget* widget);
	
	
	///////////  Helper functions  //////////////////
public:
	
	//by event
	static bool Id(Rocket::Core::Element* element, const DKString& id);
	static bool Id(DKEvent* event, const DKString& id);
	static bool IdLike(DKEvent* event, const DKString& id);
	static bool Type(DKEvent* event, const DKString& type);
	static bool Value(DKEvent* event, const DKString& id);
	static Rocket::Core::Element* GetElement(DKEvent* event);

	//to string
	static DKString GetId(Rocket::Core::Element* element);
	static DKString GetId(DKEvent* event);
	static DKString GetValue(Rocket::Core::Element* element);
	static DKString GetValue(DKEvent* event);
	static DKString GetValue(const DKString& id);
	static Rocket::Core::Element* GetElement(const DKString& id);
	static bool GetOuterHtml(const DKString& id, DKString& string);
	static bool GetOuterHtml(Rocket::Core::Element* element, DKString& string);

	//by string
	static Rocket::Core::Element* CreateElement(const DKString& tag);
	static DKString CreateElement(const DKString& parent, const DKString& tag, const DKString& id);
	static DKString CreateElementFirst(const DKString& parent, const DKString& tag, const DKString& id);
	static DKString CreateElementBefore(const DKString& element, const DKString& tag, const DKString& id);
	static Rocket::Core::Element* GetElementById(const DKString& id);
	static Rocket::Core::Element* GetElementByTag(const DKString& tag);
	static bool AddEventListener(const DKString& id, const DKString& type);
	static bool AppendChild(const DKString& parent, Rocket::Core::Element* element);
	static bool AppendChild(const DKString& parent, const DKString& element);
	static bool GetAttribute(const DKString& id, const DKString& name, DKString& value);
	static void GetAvailableId(const DKString& id, DKString& out);
	static bool GetClientHeight(const DKString& id, DKString& value);
	static bool GetClientWidth(const DKString& id, DKString& value);
	static bool GetFile(const DKString& id, DKString& file);
	static bool GetFocusElement(DKString& id);
	static bool GetHoverElement(DKString& id);
	static bool GetInnerHtml(const DKString& id, DKString& value);
	static bool GetInnerHtmlString(const DKString& id, DKString& value);
	static bool GetParent(const DKString& id, DKString& parent);
	static bool GetProperty(const DKString& id, const DKString& name, DKString& value);
	static bool GetValue(const DKString& id, DKString& value);
	static bool GetValue(const DKString& id, int& value);
	static bool Hide(const DKString& id);
	static bool InsertBefore(const DKString& parent, Rocket::Core::Element* element);
	static bool InsertBefore(const DKString& parent, const DKString& id);
	static bool PrependChild(const DKString& parent, const DKString& id);
	static bool RemoveAllEventListeners(const DKString& id);
	static bool RemoveElement(const DKString& id);
	static bool RemoveEventListener(const DKString& id, const DKString& type);
	static bool ScrollToBottom(const DKString& id);
	static bool ScrollToTop(const DKString& id);
	static bool SetAttribute(const DKString& id, const DKString& name, const DKString& value);
	static bool SetFile(const DKString& id, const DKString& file);
	static bool SetFocus(DKString& id);
	static bool SetInnerHtml(const DKString& id, const DKString& value);
	static bool SetInnerHtmlString(const DKString& id, const DKString& value);
	static bool SetProperty(const DKString& id, const DKString& name, const DKString& value);
	static bool SetValue(const DKString& id, const DKProperty* value);
	static bool SetValue(const DKString& id, const DKString& value);
	static bool SetValue(const DKString& id, const int& value);
	static bool Show(const DKString& id);
	static bool Toggle(const DKString& id);
	static bool Visible(const DKString& id);
	
	//by element
	static bool AddEventListener(Rocket::Core::Element* element, const DKString& type);
	static bool AppendChild(Rocket::Core::Element* parent, Rocket::Core::Element* element);
	static bool GetAttribute(Rocket::Core::Element* element, const DKString& name, DKString& value);
	static bool GetClientHeight(Rocket::Core::Element* element, DKString& value);
	static bool GetClientWidth(Rocket::Core::Element* element, DKString& value);
	static bool GetFile(Rocket::Core::Element* element, DKString& file);
	static bool GetInnerHtml(Rocket::Core::Element* element, DKString& value);
	static bool GetInnerHtmlString(Rocket::Core::Element* element, DKString& value);
	static bool GetParent(Rocket::Core::Element* element, DKString& parent);
	static bool GetProperty(Rocket::Core::Element* element, const DKString& name, DKString& value);
	static bool GetValue(Rocket::Core::Element* element, DKString& value);
	static bool GetValue(Rocket::Core::Element* element, int& value);
	static bool Hide(Rocket::Core::Element* element);
	static bool InsertBefore(Rocket::Core::Element* parent, Rocket::Core::Element* element);
	static bool PrependChild(Rocket::Core::Element* parent, Rocket::Core::Element* element);
	static bool RemoveEventListener(Rocket::Core::Element* element, const DKString& type);
	static bool ScrollToBottom(Rocket::Core::Element* element);
	static bool ScrollToTop(Rocket::Core::Element* element);
	static bool SetAttribute(Rocket::Core::Element* element, const DKString& name, const DKString& value);
	static bool SetFile(Rocket::Core::Element* element, const DKString& file);
	static bool SetInnerHtml(Rocket::Core::Element* element, const DKString& value);
	static bool SetInnerHtmlString(Rocket::Core::Element* element, const DKString& value);
	static bool SetProperty(Rocket::Core::Element* element, const DKString& name, const DKString& value);
	static bool SetValue(Rocket::Core::Element* element, const DKProperty* prop);
	static bool SetValue(Rocket::Core::Element* element, const DKString& value);
	static bool SetValue(Rocket::Core::Element* element, const int& value);
	static bool Show(Rocket::Core::Element* element);
	static bool Toggle(Rocket::Core::Element* element);
	static bool Visible(Rocket::Core::Element* element);

	//extra
	static DKString Filter(const DKProperty* prop);
	static DKString GetFirstChild(const DKString& id);
	static DKString GetLastChild(const DKString& id);
	static bool AddDragHandle(const DKString& id, const DKString& drag);
	static bool AddResizeHandle(const DKString& id, const DKString& resize);
	static bool BuildOptionsString(const DKString& id, DKString &options);
	static bool BuildStyleString(const DKString& id, DKString &style);
	static bool GetElements(Rocket::Core::Element* parent, DKElementList& elements);
	static bool GetElements(const DKString& id, DKElementList& elements);
	static bool GetElements(const DKString& id, DKStringArray& elements);
	static bool GetMouseElementPosition(Rocket::Core::Element* element, int& x_out, int& y_out);
	static bool GetMouseElementPosition(const DKString& id, int& x_out, int& y_out);
	static bool GetMouseWindowX(int& x_out);
	static bool GetMouseWindowY(int& y_out);
	static bool GetOption(const DKString& id, int n);
	static bool IsChildOf(Rocket::Core::Element* element, Rocket::Core::Element* parent);
	static bool IsChildOf(Rocket::Core::Element* element, const DKString& parent);
	static bool IsChildOf(const DKString& id, const DKString& parent);
	static bool MoveToFront(const DKString& id);
	static bool RemoveDragHandle(const DKString& id);
	static bool RemoveResizeHandle(const DKString& id);
	static bool SetOption(const DKString& id, int n);
	static bool ValidateColor(DKString &value);
	static bool ValidateNumber(DKString &value);
	static bool ValidatePosition(DKString &value);
	static bool ValidateSize(DKString &value);
};


REGISTER_OBJECT(DKWidget, false)

#endif //DKWidget_H
#endif //USE_DKRocket