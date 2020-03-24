#pragma once
#ifndef DKSDLRmlRenderer_H
#define DKSDLRmlRenderer_H

#include <Rml/Core/RenderInterface.h>
#include <SDL.h>

#if !defined(ANDROID) && !defined(IOS)
#include "SDL_opengl.h"
#else
#include "SDL_opengles.h"
#endif

#ifdef USE_SDL2_gif
extern "C" {
	#include "SDL2_gif.h"
}
#endif



////////////////////////////////////////////////////////////////
class RmlSDL2Renderer : public Rml::Core::RenderInterface
{
public:
	RmlSDL2Renderer(SDL_Renderer* renderer, SDL_Window* screen);

	/// Called by Rml when it wants to render geometry that it does not wish to optimise.
	virtual void RenderGeometry(Rml::Core::Vertex* vertices, int num_vertices, int* indices, int num_indices, Rml::Core::TextureHandle texture, const Rml::Core::Vector2f& translation);
	/// Called by Rml when it wants to enable or disable scissoring to clip content.
	virtual void EnableScissorRegion(bool enable);
	/// Called by Rml when it wants to change the scissor region.
	virtual void SetScissorRegion(int x, int y, int width, int height);
	/// Called by Rml when a texture is required by the library.
	virtual bool LoadTexture(Rml::Core::TextureHandle& texture_handle, Rml::Core::Vector2i& texture_dimensions, const Rml::Core::String& source);
	/// Called by Rml when a texture is required to be built from an internally-generated sequence of pixels.
	virtual bool GenerateTexture(Rml::Core::TextureHandle& texture_handle, const Rml::Core::byte* source, const Rml::Core::Vector2i& source_dimensions);
	/// Called by Rml when a loaded texture is no longer required.
	virtual void ReleaseTexture(Rml::Core::TextureHandle texture_handle);

	std::map<Rml::Core::TextureHandle, DKString> texture_name; //texture to name map


private:
    SDL_Renderer* mRenderer;
    SDL_Window* mScreen;

#ifdef USE_SDL2_gif
	std::vector<SDL_GifAnim*> animations;
#endif
};

#endif //DKSDLRmlRenderer_H