#ifndef DKRMLIFRAMEINSTANCER_H
#define DKRMLIFRAMEINSTANCER_H

#include "DKRmlIframe/DKRmlIframe.h"
#include "DKRmlIframe/ElementIframe.h"
#include "DKRmlIframe/ElementIframeInstancer.h"
#include "../Include/RmlUi/Core/Element.h"
#include "../include/RmlUi/Core/ElementInstancer.h"
#include "../Source/Core/Pool.h"


namespace Rml {

	// Iframe Instancer that creates the provided element type using new and delete. This instancer is typically used for specialized element types.
	
	static Pool< Element > pool_element(200, true);

	class ElementIframeInstancer : public ElementInstancer 
	{
	public:
		virtual ~ElementIframeInstancer() {};

		
		// Instances an element given the tag name and attributes.
		// @param[in] parent The element the new element is destined to be parented to.
		// @param[in] tag The tag of the element to instance.
		// @param[in] attributes Dictionary of attributes.
		// @return A unique pointer to the instanced element.
		Rml::ElementPtr InstanceElement(Rml::Element* RMLUI_UNUSED_PARAMETER(parent), const String& tag, const XMLAttributes& RMLUI_UNUSED_PARAMETER(attributes)) override
		{
			//RMLUI_UNUSED(parent);
			//RMLUI_UNUSED(attributes);
			//RMLUI_ZoneScopedN("ElementIframeInstance");
			Element* ptr = pool_element.AllocateAndConstruct(tag);
			return ElementPtr(ptr);
		}

		// Releases an element instanced by this instancer.
		// @param[in] element The element to release.
		void ReleaseElement(Element* element) override
		{
			RMLUI_ZoneScopedN("ElementIframeRelease");
			delete element;
		}
	};
} //Rml

#endif
