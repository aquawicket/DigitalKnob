#ifndef IFRAME_INSTANCER_H
#define IFRAME_INSTANCER_H

#include <RmlUi/Core/XMLNodeHandler.h>

class ElementInstancerIframe : public ElementInstancer
{
public:
	virtual ~ElementInstancerIframe() {}

	ElementPtr InstanceElement(Element* RMLUI_UNUSED_PARAMETER(parent), const String& tag, const XMLAttributes& RMLUI_UNUSED_PARAMETER(attributes)) override
	{
		RMLUI_UNUSED(parent);
		RMLUI_UNUSED(attributes);
		RMLUI_ZoneScopedN("ElementIframeInstance");
		return ElementPtr(new T(tag));
	}

	void ReleaseElement(Element* element) override
	{
		RMLUI_ZoneScopedN("ElementIframeRelease");
		delete element;
	}
};

#endif //IFRAME_INSTANCER_H