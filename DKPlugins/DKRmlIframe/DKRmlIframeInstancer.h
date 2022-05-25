#ifndef DKRMLIFRAMEINSTANCER_H
#define DKRMLIFRAMEINSTANCER_H

#include "DKRmlIframe/ElementIframe.h"
#include "../include/RmlUi/Core/ElementInstancer.h"

namespace Rml {

/**
	Iframe Instancer that creates the provided element type using new and delete. This instancer
	is typically used for specialized element types.
 */

class ElementInstancerIframe : public ElementInstancer
{
public:
	virtual ~ElementInstancerIframe() {}

	// Instances an element given the tag name and attributes.
	// @param[in] parent The element the new element is destined to be parented to.
	// @param[in] tag The tag of the element to instance.
	// @param[in] attributes Dictionary of attributes.
	// @return A unique pointer to the instanced element.
	virtual Rml::ElementPtr InstanceElement(Rml::Element* parent, const Rml::String& tag, const Rml::XMLAttributes& attributes) override;

	// Releases an element instanced by this instancer.
	// @param[in] element The element to release.
	virtual void ReleaseElement(Rml::Element* element) override;
};

} // namespace Rml
#endif
