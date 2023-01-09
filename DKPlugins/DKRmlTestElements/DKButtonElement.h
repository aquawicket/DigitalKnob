/*
 * This source file is part of RmlUi, the HTML/CSS Interface Middleware
 *
 * For the latest information, see http://github.com/mikke89/RmlUi
 *
 * Copyright (c) 2008-2010 CodePoint Ltd, Shift Technology Ltd
 * Copyright (c) 2019 The RmlUi Team, and contributors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#ifndef DKButtonElement_H
#define DKButtonElement_H

#include "../Include/RmlUi/Core/Header.h"
#include "../Include/RmlUi/Core/Element.h"
#include "../Include/RmlUi/Core/EventListener.h"
#include "../Include/RmlUi/Core/ElementDocument.h"
#include "../Include/RmlUi/Core/ElementInstancer.h"
#include "../Include/RmlUi/Core/Geometry.h"
#include "../Include/RmlUi/Core/Texture.h"
#include "../Include/RmlUi/Core/Spritesheet.h"
#include "../Source/Core/Elements/InputType.h"

namespace Rml {

/**
	A button input type handler. The only functionality a button provides over a normal element is the ability
	to be disabled. This prevents 'click' events on this element and the ability to receive focus.

	@author Peter Curry
 */

class DKButtonElement : public InputType
{
public:
	DKButtonElement(ElementFormControlInput* element);
	virtual ~DKButtonElement();

	/// Returns if this value should be submitted with the form.
	/// @return True if the form control is to be submitted, false otherwise.
	bool IsSubmitted() override;

	/// Checks for necessary functional changes in the control as a result of the event.
	/// @param[in] event The event to process.
	void ProcessDefaultAction(Event& event) override;

	/// Sizes the dimensions to the element's inherent size.
	/// @return False.
	bool GetIntrinsicDimensions(Vector2f& dimensions, float& ratio) override;
};


class DKButtonInstancer : public ElementInstancer
{
public:
	virtual ~DKButtonInstancer() {};

	// Instances an element given the tag name and attributes.
	// @param[in] parent The element the new element is destined to be parented to.
	// @param[in] tag The tag of the element to instance.
	// @param[in] attributes Dictionary of attributes.
	// @return A unique pointer to the instanced element.
	Rml::ElementPtr InstanceElement(Rml::Element* RMLUI_UNUSED_PARAMETER(parent), const Rml::String& tag, const Rml::XMLAttributes& RMLUI_UNUSED_PARAMETER(attributes)) override{
		RMLUI_UNUSED(parent);
		RMLUI_UNUSED(attributes);
		RMLUI_ZoneScopedN("DKButtonInstance");
		//DKButtonElement* element = new DKButtonElement(tag);
		//return Rml::ElementPtr(static_cast<Rml::Element*>(element));
		return NULL;
	}

	// Releases an element instanced by this instancer.
	// @param[in] element The element to release.
	void ReleaseElement(Rml::Element* element) override{
		RMLUI_ZoneScopedN("DKButtonRelease");
		delete element;
	}
};


} // namespace Rml
#endif
