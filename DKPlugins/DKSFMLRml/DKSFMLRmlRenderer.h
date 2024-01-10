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
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#pragma once
#ifndef DKSFMLRmlRenderer_H
#define DKSFMLRmlRenderer_H

// NOTE: uncomment this only when you want to use the
// OpenGL Extension Wrangler Library (GLEW)
//#define ENABLE_GLEW

//WARNING_DISABLE
// if the OpenGL Extension Wrangler Library (GLEW) should be used include it
#ifdef ENABLE_GLEW
	#include <GL/glew.h>
#endif
#include <RmlUi/Core/RenderInterface.h>
#include <SFML/Graphics.hpp>
// if the OpenGL Extension Wrangler Library (GLEW) should not be used
// include the standard OpenGL library
//#ifndef ENABLE_GLEW
//#include "../../../shell/include/ShellOpenGL.h"
//#endif
#ifdef HAVE_SFML_gif
extern "C" {
	#include "SFML_gif.h"
}
#endif
//WARNING_ENABLE


class RmlSFMLRenderer : public Rml::RenderInterface
{
public:
	RmlSFMLRenderer();

	/// Sets the window
	void SetWindow(sf::RenderWindow *Window);

	/// Returns the currently assigned window
	sf::RenderWindow *GetWindow();

	/// Called by RmlUi when it wants to render geometry that it does not wish to optimise.
	void RenderGeometry(Rml::Vertex* vertices, int num_vertices, int* indices, int num_indices, Rml::TextureHandle texture, const Rml::Vector2f& translation) override;

	/// Called by RmlUi when it wants to compile geometry it believes will be static for the forseeable future.
	Rml::CompiledGeometryHandle CompileGeometry(Rml::Vertex* vertices, int num_vertices, int* indices, int num_indices, Rml::TextureHandle texture) override;

	/// Called by RmlUi when it wants to render application-compiled geometry.
	void RenderCompiledGeometry(Rml::CompiledGeometryHandle geometry, const Rml::Vector2f& translation) override;
	/// Called by RmlUi when it wants to release application-compiled geometry.
	void ReleaseCompiledGeometry(Rml::CompiledGeometryHandle geometry) override;

	/// Called by RmlUi when it wants to enable or disable scissoring to clip content.
	void EnableScissorRegion(bool enable) override;
	/// Called by RmlUi when it wants to change the scissor region.
	void SetScissorRegion(int x, int y, int width, int height) override;

	/// Called by RmlUi when a texture is required by the library.
	bool LoadTexture(Rml::TextureHandle& texture_handle, Rml::Vector2i& texture_dimensions, const Rml::String& source) override;
	/// Called by RmlUi when a texture is required to be built from an internally-generated sequence of pixels.
	bool GenerateTexture(Rml::TextureHandle& texture_handle, const Rml::byte* source, const Rml::Vector2i& source_dimensions) override;
	/// Called by RmlUi when a loaded texture is no longer required.
	void ReleaseTexture(Rml::TextureHandle texture_handle) override;

private:
	void initViewport();

private:
	sf::RenderWindow *MyWindow;

#ifdef HAVE_SFML_gif
	std::vector<SFML_GifAnim*> animations;
#endif
};

#endif //DKSFMLRmlRenderer_H