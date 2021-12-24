#pragma once
#ifndef DKSFMLRmlRenderer_H
#define DKSFMLRmlRenderer_H

#include <RmlUi/Core.h>
//#include <SFML.h>

#if !defined(ANDROID) && !defined(IOS)
#include "SFML_opengl.h"
#else
#include "SFML_opengles.h"
#endif

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