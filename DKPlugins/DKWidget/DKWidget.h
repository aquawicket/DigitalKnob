#pragma once
#ifndef DKWidget_H
#define DKWidget_H
#include "DK.h"
#include "DKRocket.h"
#include "DKWindow.h"
#include "DKXml.h"

typedef Rocket::Core::Element DKElement;
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
	void Init();
	void End();

protected:
	static DKRocket* dkRocket;
	DKElement* root;
	bool CreateWidget(const DKString& file);
	void RemoveWidget(DKWidget* widget);
	bool AttachEvents();
	bool AttachDrags();
	
	///////////  Helper functions  //////////////////
public:
	//void ResizeIframe(DKEvent* event);
	//void Hyperlink(DKEvent* event);
	
	//by event
	static bool Type(DKEvent* event, const DKString& type);
	static bool Id(DKEvent* event, const DKString& id);
	static bool IdLike(DKEvent* event, const DKString& id);
	static bool Id(DKElement* element, const DKString& id);
	static bool Value(DKEvent* event, const DKString& id);
	static DKElement* GetElement(DKEvent* event);

	//to string
	static DKString GetId(DKElement* element);
	static DKString GetId(DKEvent* event);
	static DKString GetValue(DKEvent* event);
	static DKString GetValue(const DKString& id);
	static DKString GetValue(DKElement* element);
	static DKElement* GetElement(const DKString& id);
	static bool GetOuterHtml(const DKString& id, DKString& string);
	static bool GetOuterHtml(DKElement* element, DKString& string);

	//by string
	static DKElement* CreateElement(const DKString& tag);
	static DKString CreateElement(const DKString& parent, const DKString& tag, const DKString& id);
	static DKString CreateElementFirst(const DKString& parent, const DKString& tag, const DKString& id);
	static DKString CreateElementBefore(const DKString& element, const DKString& tag, const DKString& id);
	static void GetAvailableId(const DKString& id, DKString& out);
	static DKElement* GetElementById(const DKString& id);
	static bool GetFile(const DKString& id, DKString& file);
	static bool SetFile(const DKString& id, const DKString& file);
	static bool GetFocusElement(DKString& id);
	static bool GetHoverElement(DKString& id);
	static bool Visible(const DKString& id);
	static bool Toggle(const DKString& id);
	static bool Show(const DKString& id);
	static bool Hide(const DKString& id);
	static bool GetParent(const DKString& id, DKString& parent);
	static bool AppendChild(const DKString& parent, const DKString& element);
	static bool AppendChild(const DKString& parent, DKElement* element);
	static bool PrependChild(const DKString& parent, const DKString& id);
	static bool InsertBefore(const DKString& parent, const DKString& id);
	static bool InsertBefore(const DKString& parent, DKElement* element);
	static bool RemoveElement(const DKString& id);
	static bool AddEventListener(const DKString& id, const DKString& type);
	static bool RemoveEventListener(const DKString& id, const DKString& type);
	static bool RemoveAllEventListeners(const DKString& id);
	static bool GetAttribute(const DKString& id, const DKString& name, DKString& value);
	static bool SetAttribute(const DKString& id, const DKString& name, const DKString& value);
	static bool GetProperty(const DKString& id, const DKString& name, DKString& value);
	static bool SetProperty(const DKString& id, const DKString& name, const DKString& value);
	static bool GetInnerHtml(const DKString& id, DKString& value);
	static bool GetInnerHtmlString(const DKString& id, DKString& value);
	static bool SetInnerHtml(const DKString& id, const DKString& value);
	static bool SetInnerHtmlString(const DKString& id, const DKString& value);
	static bool GetValue(const DKString& id, DKString& value);
	static bool SetValue(const DKString& id, const DKString& value);
	static bool GetValue(const DKString& id, int& value);
	static bool SetValue(const DKString& id, const int& value);
	static bool SetValue(const DKString& id, const DKProperty* value);
	
	//by element
	static bool GetFile(DKElement* element, DKString& file);
	static bool SetFile(DKElement* element, const DKString& file);
	static bool Visible(DKElement* element);
	static bool Toggle(DKElement* element);
	static bool Show(DKElement* element);
	static bool Hide(DKElement* element);
	static bool GetParent(DKElement* element, DKString& parent);
	static bool AppendChild(DKElement* parent, DKElement* element);
	static bool PrependChild(DKElement* parent, DKElement* element);
	static bool InsertBefore(DKElement* parent, DKElement* element);
	static bool AddEventListener(DKElement* element, const DKString& type);
	static bool RemoveEventListener(DKElement* element, const DKString& type);
	static bool GetAttribute(DKElement* element, const DKString& name, DKString& value);
	static bool SetAttribute(DKElement* element, const DKString& name, const DKString& value);
	static bool GetProperty(DKElement* element, const DKString& name, DKString& value);
	static bool SetProperty(DKElement* element, const DKString& name, const DKString& value);
	static bool GetInnerHtml(DKElement* element, DKString& value);
	static bool GetInnerHtmlString(DKElement* element, DKString& value);
	static bool SetInnerHtml(DKElement* element, const DKString& value);
	static bool SetInnerHtmlString(DKElement* element, const DKString& value);
	static bool GetValue(DKElement* element, DKString& value);
	static bool SetValue(DKElement* element, const DKString& value);
	static bool GetValue(DKElement* element, int& value);
	static bool SetValue(DKElement* element, const int& value);
	static bool SetValue(DKElement* element, const DKProperty* prop);

	//extra
	static bool IsChildOf(const DKString& id, const DKString& parent);
	static bool IsChildOf(DKElement* element, const DKString& parent);
	static bool IsChildOf(DKElement* element, DKElement* parent);
	static bool GetMouseWindowX(int& x_out);
	static bool GetMouseWindowY(int& y_out);
	static bool GetMouseElementPosition(const DKString& id, int& x_out, int& y_out);
	static bool GetMouseElementPosition(DKElement* element, int& x_out, int& y_out);
	static bool MoveToFront(const DKString& id);
	static DKString Filter(const DKProperty* prop);
	static bool ValidateSize(DKString &value);
	static bool ValidatePosition(DKString &value);
	static bool ValidateNumber(DKString &value);
	static bool ValidateColor(DKString &value);
	static bool AddDragHandle(const DKString& id, const DKString& drag);
	static bool RemoveDragHandle(const DKString& id);
	static bool AddResizeHandle(const DKString& id, const DKString& resize);
	static bool RemoveResizeHandle(const DKString& id);
	static DKString GetFirstChild(const DKString& id);
	static bool GetElements(const DKString& id, DKStringArray& elements);
	static bool GetElements(const DKString& id, DKElementList& elements);
	static bool GetElements(DKElement* parent, DKElementList& elements);
	static bool GetOption(const DKString& id, int n);
	static bool SetOption(const DKString& id, int n);
	
	static bool BuildStyleString(const DKString& id, DKString &style);
	static bool BuildOptionsString(const DKString& id, DKString &options);
};


REGISTER_OBJECT(DKWidget, false)

#endif //DKWidget_H