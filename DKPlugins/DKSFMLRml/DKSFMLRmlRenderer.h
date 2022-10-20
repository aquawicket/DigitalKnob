/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2022 Digitalknob Team, and contributors
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

#pragma once
#ifndef DKSFMLRmlRenderer_H
#define DKSFMLRmlRenderer_H

#include <RmlUi/Core.h>
//#include <SFML.h>

//#if !defined(ANDROID) && !defined(IOS)
//#include "SFML_opengl.h"
	#include "SFML/Graphics.hpp"
//#else
//	#include "SFML_opengles.h"
//#endif

#ifdef USE_SFML2_gif
extern "C" {
	#include "SFML2_gif.h"
}
#endif

class RmlSFML2Renderer : public Rml::RenderInterface
{
public:
	RmlSFML2Renderer(SFML_Renderer* renderer, SFML_Window* screen);

	/// Called by Rml when it wants to render geometry that it does not wish to optimise.
	virtual void RenderGeometry(Rml::Vertex* vertices, int num_vertices, int* indices, int num_indices, Rml::TextureHandle texture, const Rml::Vector2f& translation);
	/// Called by Rml when it wants to enable or disable scissoring to clip content.
	virtual void EnableScissorRegion(bool enable);
	/// Called by Rml when it wants to change the scissor region.
	virtual void SetScissorRegion(int x, int y, int width, int height);
	/// Called by Rml when a texture is required by the library.
	virtual bool LoadTexture(Rml::TextureHandle& texture_handle, Rml::Vector2i& texture_dimensions, const Rml::String& source);
	/// Called by Rml when a texture is required to be built from an internally-generated sequence of pixels.
	virtual bool GenerateTexture(Rml::TextureHandle& texture_handle, const Rml::byte* source, const Rml::Vector2i& source_dimensions);
	/// Called by Rml when a loaded texture is no longer required.
	virtual void ReleaseTexture(Rml::TextureHandle texture_handle);

	std::map<Rml::TextureHandle, DKString> texture_name; //texture to name map

private:
    SFML_Renderer* mRenderer;
    SFML_Window* mScreen;

#ifdef USE_SFML2_gif
	std::vector<SFML_GifAnim*> animations;
#endif
};

#endif //DKSFMLRmlRenderer_H