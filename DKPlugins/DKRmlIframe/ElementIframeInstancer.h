#ifndef DKRMLIFRAMEINSTANCER_H
#define DKRMLIFRAMEINSTANCER_H

//#include "DKRmlIframe/ElementIframe.h"
#include "../include/RmlUi/Core/ElementInstancer.h"


/**
	Iframe Instancer that creates the provided element type using new and delete. This instancer
	is typically used for specialized element types.
 */

class ElementIframeInstancer : public Rml::ElementInstancer
{
public:
	~ElementIframeInstancer() {}

	// Instances an element given the tag name and attributes.
	// @param[in] parent The element the new element is destined to be parented to.
	// @param[in] tag The tag of the element to instance.
	// @param[in] attributes Dictionary of attributes.
	// @return A unique pointer to the instanced element.
	
	//Rml::ElementPtr InstanceElement(Rml::Element* parent, const Rml::String& tag, const Rml::XMLAttributes& attributes) override;
	Rml::ElementPtr InstanceElement(Rml::Element* parent, const Rml::String& tag, const Rml::XMLAttributes& attributes) {
		return ElementInstancer::InstanceElement(parent, tag, attributes);
	}

	// Releases an element instanced by this instancer.
	// @param[in] element The element to release.
	
	//void ReleaseElement(Rml::Element* element) override;
	void ReleaseElement(Rml::Element* element) {}
};


#endif
