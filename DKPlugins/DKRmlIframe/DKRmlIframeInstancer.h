/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#ifndef DKRmlIframeInstancer_H
#define DKRmlIframeInstancer_H

//WARNING_DISABLE
#include "../Include/RmlUi/Core/ComputedValues.h"
#include "../Include/RmlUi/Core/Element.h"
#include "../Include/RmlUi/Core/ElementDocument.h"
#include "../Include/RmlUi/Core/ElementUtilities.h"
#include "../Include/RmlUi/Core/ElementInstancer.h"
#include "../Include/RmlUi/Core/Geometry.h"
#include "../Include/RmlUi/Core/GeometryUtilities.h"
#include "../Include/RmlUi/Core/PropertyIdSet.h"
#include "../Include/RmlUi/Core/StyleSheet.h"
#include "../Include/RmlUi/Core/URL.h"
//WARNING_ENABLE


class RmlIframe : public Rml::Element 
{
public:
	RmlIframe(const Rml::String& tag) : Rml::Element(tag), dimensions(-1, -1), rect_source(RectSource::None), geometry(this){
		dimensions_scale = 1.0f;
		geometry_dirty = false;
		texture_dirty = true;
	}
	~RmlIframe(){}
	DKString processed;

	/*
	// Sizes the box to the element's inherent size.
	bool GetIntrinsicDimensions(Rml::Vector2f& _dimensions, float& _ratio){
		// Check if we need to reload the texture.
		if (texture_dirty)
			LoadTexture();
		// Calculate the x dimension.
		if (HasAttribute("width"))
			dimensions.x = GetAttribute< float >("width", -1);
		else if (rect_source == RectSource::None)
			dimensions.x = (float)texture.GetDimensions(GetRenderInterface()).x;
		else
			dimensions.x = rect.width;
		// Calculate the y dimension.
		if (HasAttribute("height"))
			dimensions.y = GetAttribute< float >("height", -1);
		else if (rect_source == RectSource::None)
			dimensions.y = (float)texture.GetDimensions(GetRenderInterface()).y;
		else
			dimensions.y = rect.height;
		dimensions *= dimensions_scale;
		// Return the calculated dimensions. If this changes the size of the element, it will result in
		// a call to 'onresize' below which will regenerate the geometry.
		_dimensions = dimensions;
		_ratio = dimensions.x / dimensions.y;
		return true;
	}
	*/

	// Renders the element.
	void OnRender(){
		// Regenerate the geometry if required (this will be set if 'rect' changes but does not result in a resize).
		if (geometry_dirty)
			GenerateGeometry();
		geometry.Render(GetAbsoluteOffset(Rml::Box::CONTENT)); // Render the geometry beginning at this element's content region.
	}

	// Called when attributes on the element are changed.
	void OnAttributeChange(const Rml::ElementAttributes& changed_attributes){  // 1
		// Call through to the base element's OnAttributeChange().
		Element::OnAttributeChange(changed_attributes);
		bool dirty_layout = false;
		// Check for a changed 'src' attribute. If this changes, the old texture handle is released, forcing a reload when the layout is regenerated.
		if (changed_attributes.find("src") != changed_attributes.end() || changed_attributes.find("sprite") != changed_attributes.end()){
			texture_dirty = true;
			dirty_layout = true;
		}
		// Check for a changed 'width' attribute. If this changes, a layout is forced which will recalculate the dimensions.
		if (changed_attributes.find("width") != changed_attributes.end() || changed_attributes.find("height") != changed_attributes.end())
			dirty_layout = true;
		// Check for a change to the 'rect' attribute. If this changes, the coordinates are
		// recomputed and a layout forced. If a sprite is set to source, then that will override any attribute.
		if (changed_attributes.find("rect") != changed_attributes.end()){
			UpdateRect();
			dirty_layout = true; // Rectangle has changed; this will most likely result in a size change, so we need to force a layout.
		}
		if (dirty_layout)
			DirtyLayout();
	}

	void OnPropertyChange(const Rml::PropertyIdSet& changed_properties){ // 4
		Element::OnPropertyChange(changed_properties);
		if (changed_properties.Contains(Rml::PropertyId::ImageColor) || changed_properties.Contains(Rml::PropertyId::Opacity))
			GenerateGeometry();
	}

	void OnChildAdd(Element* child){ // 2
		// Load the texture once we have attached to the document so that it can immediately be found during the call to `Rml::GetTextureSourceList`. The
		// texture won't actually be loaded from the backend before it is shown. However, only do this if we have an active context so that the dp-ratio
		// can be retrieved. If there is no context now the texture loading will be deferred until the next layout update.
		if (child == this && texture_dirty && GetContext())
			LoadTexture();
	}

	// Regenerates the element's geometry.
	void OnResize(){ // 6 
		GenerateGeometry();
	}

	void OnDpRatioChange(){
		texture_dirty = true;
		DirtyLayout();
	}

	void OnStyleSheetChange(){
		if (HasAttribute("sprite")){
			texture_dirty = true;
			DirtyLayout();
		}
	}

	void GenerateGeometry(){ // 5
		// Release the old geometry before specifying the new vertices.
		geometry.Release(true);
		Rml::Vector< Rml::Vertex >& vertices = geometry.GetVertices();
		Rml::Vector< int >& indices = geometry.GetIndices();
		vertices.resize(4);
		indices.resize(6);
		// Generate the texture coordinates.
		Rml::Vector2f texcoords[2];
		if (rect_source != RectSource::None){
			Rml::Vector2f texture_dimensions((float)texture.GetDimensions(GetRenderInterface()).x, (float)texture.GetDimensions(GetRenderInterface()).y);
			if (texture_dimensions.x == 0)
				texture_dimensions.x = 1;
			if (texture_dimensions.y == 0)
				texture_dimensions.y = 1;
			texcoords[0].x = rect.x / texture_dimensions.x;
			texcoords[0].y = rect.y / texture_dimensions.y;
			texcoords[1].x = (rect.x + rect.width) / texture_dimensions.x;
			texcoords[1].y = (rect.y + rect.height) / texture_dimensions.y;
		}
		else{
			texcoords[0] = Rml::Vector2f(0, 0);
			texcoords[1] = Rml::Vector2f(1, 1);
		}
		const Rml::Style::ComputedValues& computed = GetComputedValues();
		float opacity = computed.opacity();
		Rml::Colourb quad_colour = computed.image_color();
		quad_colour.alpha = (Rml::byte)(opacity * (float)quad_colour.alpha);
		Rml::Vector2f quad_size = GetBox().GetSize(Rml::Box::CONTENT).Round();
		Rml::GeometryUtilities::GenerateQuad(&vertices[0], &indices[0], Rml::Vector2f(0, 0), quad_size, quad_colour, texcoords[0], texcoords[1]);
		geometry_dirty = false;

		Rml::String id = GetAttribute< Rml::String >("id", "");
		if (has(processed, id))
			return; //allready processed

		Rml::String src = GetAttribute< Rml::String >("src", "");
		float top = computed.top().value;
		float left = computed.left().value;
		//float bottom = computed.bottom().value;
		//float right = computed.right().value;
		float width = computed.width().value;
		float height = computed.height().value;
		float _width = width ? width : 800;
		float _height = height ? height : 600;

		replace(id, "[CEF]", "");
		DKString data = id + ",";
		data += toString(top);
		data += ",";
		data += toString(left);
		data += ",";
		data += toString(_width);
		data += ",";
		data += toString(_height);
		data += ",";
		data += src;
		DKClass::CallFunc("DKCef::NewBrowser", &data, NULL);
		processed += id + ",";
	}

	bool LoadTexture(){ // 3
		texture_dirty = false;
		geometry_dirty = true;
		dimensions_scale = 1.0f;
		const float dp_ratio = Rml::ElementUtilities::GetDensityIndependentPixelRatio(this);

		//Get the Browser id for the CEF Texture
		const Rml::String id_name = GetAttribute< Rml::String >("id", "");
		if (id_name.empty()){
			texture = Rml::Texture();
			rect_source = RectSource::None;
			return false;
		}
		Rml::URL source_url;
		if (Rml::ElementDocument* document = GetOwnerDocument())
			source_url.SetURL(document->GetSourceURL());
		texture.Set("[CEF]"+id_name, source_url.GetPath());
		dimensions_scale = dp_ratio;
		geometry.SetTexture(&texture);
		return true;
	}

	void UpdateRect(){
		if (rect_source != RectSource::Sprite){
			bool valid_rect = false;
			Rml::String rect_string = GetAttribute< Rml::String >("rect", "");
			if (!rect_string.empty()){
				Rml::StringList coords_list;
				Rml::StringUtilities::ExpandString(coords_list, rect_string, ' ');
				if (coords_list.size() != 4){
					Rml::Log::Message(Rml::Log::LT_WARNING, "Element '%s' has an invalid 'rect' attribute; rect requires 4 space-separated values, found %zu.", GetAddress().c_str(), coords_list.size());
				}
				else{
					rect.x = (float)std::atof(coords_list[0].c_str());
					rect.y = (float)std::atof(coords_list[1].c_str());
					rect.width = (float)std::atof(coords_list[2].c_str());
					rect.height = (float)std::atof(coords_list[3].c_str());
					// We have new, valid coordinates; force the geometry to be regenerated.
					valid_rect = true;
					geometry_dirty = true;
					rect_source = RectSource::Attribute;
				}
			}
			if (!valid_rect){
				rect = {};
				rect_source = RectSource::None;
			}
		}
	}

	Rml::Texture texture; // The texture this element is rendering from.
	Rml::Vector2f dimensions; // The element's computed intrinsic dimensions. If either of these values are set to -1, then that dimension has not been computed yet.
	Rml::Rectangle rect; // The rectangle extracted from the sprite or 'rect' attribute. The rect_source will be None if these have not been specified or are invalid.
	Rml::Geometry geometry;
	enum class RectSource { None, Attribute, Sprite } rect_source; // The geometry used to render this element.
	bool texture_dirty; // True if we need to refetch the texture's source from the element's attributes.
	float dimensions_scale; // A factor which scales the intrinsic dimensions based on the dp-ratio and image scale.
	bool geometry_dirty;
};


class DKRmlIframeInstancer : public Rml::ElementInstancer
{
public:
	virtual ~DKRmlIframeInstancer(){};

	// Instances an element given the tag name and attributes.
	// @param[in] parent The element the new element is destined to be parented to.
	// @param[in] tag The tag of the element to instance.
	// @param[in] attributes Dictionary of attributes.
	// @return A unique pointer to the instanced element.
	Rml::ElementPtr InstanceElement(Rml::Element* RMLUI_UNUSED_PARAMETER(parent), const Rml::String& tag, const Rml::XMLAttributes& RMLUI_UNUSED_PARAMETER(attributes)) override{
		DKDEBUGFUNC(/*parent,*/ tag/*, attributes*/);
		RMLUI_UNUSED(parent);
		RMLUI_UNUSED(attributes);
		RMLUI_ZoneScopedN("DKRmlIframeInstance");
		RmlIframe* dkElement = new RmlIframe(tag);
		return Rml::ElementPtr(static_cast<Rml::Element*>(dkElement));
	}

	// Releases an element instanced by this instancer.
	// @param[in] element The element to release.
	void ReleaseElement(Rml::Element* element) override{
		DKDEBUGFUNC(element);
		RMLUI_ZoneScopedN("DKRmlIframeRelease");
		delete element;
	}
};

#endif //DKRmlIframeInstancer
