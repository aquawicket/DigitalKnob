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

#include "DKRmlTestElements/DKButtonElement.h"
#include "../Include/RmlUi/Core/ComputedValues.h"
#include "../Include/RmlUi/Core/ElementDocument.h"
#include "../Include/RmlUi/Core/ElementUtilities.h"
#include "../Include/RmlUi/Core/GeometryUtilities.h"
#include "../Include/RmlUi/Core/PropertyIdSet.h"
#include "../Include/RmlUi/Core/StyleSheet.h"
#include "../Include/RmlUi/Core/URL.h"
//#include "../TextureDatabase.h"

namespace Rml {

// Constructs a new DKImg.
DKButtonElement::DKButtonElement(const String& tag) : Element(tag), dimensions(-1, -1), rect_source(RectSource::None), geometry(this)
{
	dimensions_scale = 1.0f;
	geometry_dirty = false;
	texture_dirty = true;
}

DKButtonElement::~DKButtonElement()
{
}

// Sizes the box to the element's inherent size.
bool DKButtonElement::GetIntrinsicDimensions(Vector2f& _dimensions, float& _ratio)
{
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

// Renders the element.
void DKButtonElement::OnRender()
{
	// Regenerate the geometry if required (this will be set if 'rect' changes but does not result in a resize).
	if (geometry_dirty)
		GenerateGeometry();

	// Render the geometry beginning at this element's content region.
	geometry.Render(GetAbsoluteOffset(Box::CONTENT));
}

// Called when attributes on the element are changed.
void DKButtonElement::OnAttributeChange(const ElementAttributes& changed_attributes)
{
	// Call through to the base element's OnAttributeChange().
	Element::OnAttributeChange(changed_attributes);

	bool dirty_layout = false;

	// Check for a changed 'src' attribute. If this changes, the old texture handle is released,
	// forcing a reload when the layout is regenerated.
	if (changed_attributes.find("src") != changed_attributes.end() ||
		changed_attributes.find("sprite") != changed_attributes.end())
	{
		texture_dirty = true;
		dirty_layout = true;
	}

	// Check for a changed 'width' attribute. If this changes, a layout is forced which will
	// recalculate the dimensions.
	if (changed_attributes.find("width") != changed_attributes.end() ||
		changed_attributes.find("height") != changed_attributes.end())
	{
		dirty_layout = true;
	}

	// Check for a change to the 'rect' attribute. If this changes, the coordinates are
	// recomputed and a layout forced. If a sprite is set to source, then that will override any attribute.
	if (changed_attributes.find("rect") != changed_attributes.end())
	{
		UpdateRect();

		// Rectangle has changed; this will most likely result in a size change, so we need to force a layout.
		dirty_layout = true;
	}

	if (dirty_layout)
		DirtyLayout();
}

void DKButtonElement::OnPropertyChange(const PropertyIdSet& changed_properties)
{
    Element::OnPropertyChange(changed_properties);

    if (changed_properties.Contains(PropertyId::ImageColor) ||
        changed_properties.Contains(PropertyId::Opacity)){
        GenerateGeometry();
    }
}

void DKButtonElement::OnChildAdd(Element* child)
{
	// Load the texture once we have attached to the document so that it can immediately be found during the call to `Rml::GetTextureSourceList`. The
	// texture won't actually be loaded from the backend before it is shown. However, only do this if we have an active context so that the dp-ratio
	// can be retrieved. If there is no context now the texture loading will be deferred until the next layout update.
	if (child == this && texture_dirty && GetContext())
	{
		LoadTexture();
	}
}

// Regenerates the element's geometry.
void DKButtonElement::OnResize()
{
	GenerateGeometry();
}

void DKButtonElement::OnDpRatioChange()
{
	texture_dirty = true;
	DirtyLayout();
}

void DKButtonElement::OnStyleSheetChange()
{
	if (HasAttribute("sprite"))
	{
		texture_dirty = true;
		DirtyLayout();
	}
}

void DKButtonElement::GenerateGeometry()
{
	// Release the old geometry before specifying the new vertices.
	geometry.Release(true);

	Vector< Vertex >& vertices = geometry.GetVertices();
	Vector< int >& indices = geometry.GetIndices();

	vertices.resize(4);
	indices.resize(6);

	// Generate the texture coordinates.
	Vector2f texcoords[2];
	if (rect_source != RectSource::None)
	{
		Vector2f texture_dimensions((float) texture.GetDimensions(GetRenderInterface()).x, (float) texture.GetDimensions(GetRenderInterface()).y);
		if (texture_dimensions.x == 0)
			texture_dimensions.x = 1;
		if (texture_dimensions.y == 0)
			texture_dimensions.y = 1;

		texcoords[0].x = rect.x / texture_dimensions.x;
		texcoords[0].y = rect.y / texture_dimensions.y;

		texcoords[1].x = (rect.x + rect.width) / texture_dimensions.x;
		texcoords[1].y = (rect.y + rect.height) / texture_dimensions.y;
	}
	else
	{
		texcoords[0] = Vector2f(0, 0);
		texcoords[1] = Vector2f(1, 1);
	}

	const ComputedValues& computed = GetComputedValues();

	float opacity = computed.opacity();
	Colourb quad_colour = computed.image_color();
    quad_colour.alpha = (byte)(opacity * (float)quad_colour.alpha);
	
	Vector2f quad_size = GetBox().GetSize(Box::CONTENT).Round();

	GeometryUtilities::GenerateQuad(&vertices[0], &indices[0], Vector2f(0, 0), quad_size, quad_colour, texcoords[0], texcoords[1]);

	geometry_dirty = false;
}

bool DKButtonElement::LoadTexture()
{
	texture_dirty = false;
	geometry_dirty = true;
	dimensions_scale = 1.0f;

	const float dp_ratio = ElementUtilities::GetDensityIndependentPixelRatio(this);

	// Check for a sprite first, this takes precedence.
	const String sprite_name = GetAttribute< String >("sprite", "");
	if (!sprite_name.empty())
	{
		// Load sprite.
		bool valid_sprite = false;

		if (ElementDocument* document = GetOwnerDocument())
		{
			if (const StyleSheet* style_sheet = document->GetStyleSheet())
			{
				if (const Sprite* sprite = style_sheet->GetSprite(sprite_name))
				{
					rect = sprite->rectangle;
					rect_source = RectSource::Sprite;
					texture = sprite->sprite_sheet->texture;
					dimensions_scale = sprite->sprite_sheet->display_scale * dp_ratio;
					valid_sprite = true;
				}
			}
		}

		if (!valid_sprite)
		{
			texture = Texture();
			rect_source = RectSource::None;
			UpdateRect();
			Log::Message(Log::LT_WARNING, "Could not find sprite '%s' specified in img element %s", sprite_name.c_str(), GetAddress().c_str());
			return false;
		}
	}
	else
	{
		// Load image from source URL.
		const String source_name = GetAttribute< String >("src", "");
		if (source_name.empty())
		{
			texture = Texture();
			rect_source = RectSource::None;
			return false;
		}

		URL source_url;

		if (ElementDocument* document = GetOwnerDocument())
			source_url.SetURL(document->GetSourceURL());

		texture.Set(source_name, source_url.GetPath());

		dimensions_scale = dp_ratio;
	}

	// Set the texture onto our geometry object.
	geometry.SetTexture(&texture);

	return true;
}

void DKButtonElement::UpdateRect()
{
	if(rect_source != RectSource::Sprite)
	{
		bool valid_rect = false;

		String rect_string = GetAttribute< String >("rect", "");
		if (!rect_string.empty())
		{
			StringList coords_list;
			StringUtilities::ExpandString(coords_list, rect_string, ' ');

			if (coords_list.size() != 4)
			{
				Log::Message(Log::LT_WARNING, "Element '%s' has an invalid 'rect' attribute; rect requires 4 space-separated values, found %zu.", GetAddress().c_str(), coords_list.size());
			}
			else
			{
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

		if (!valid_rect)
		{
			rect = {};
			rect_source = RectSource::None;
		}
	}
}

} // namespace Rml
