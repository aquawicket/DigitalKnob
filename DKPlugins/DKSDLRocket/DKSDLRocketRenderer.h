#ifndef RENDERINTERFACESDL2_H
#define RENDERINTERFACESDL2_H
#include <Rocket/Core/RenderInterface.h>
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
class RocketSDL2Renderer : public Rocket::Core::RenderInterface
{
public:
	RocketSDL2Renderer(SDL_Renderer* renderer, SDL_Window* screen);

	/// Called by Rocket when it wants to render geometry that it does not wish to optimise.
	virtual void RenderGeometry(Rocket::Core::Vertex* vertices, int num_vertices, int* indices, int num_indices, Rocket::Core::TextureHandle texture, const Rocket::Core::Vector2f& translation);
	/// Called by Rocket when it wants to enable or disable scissoring to clip content.
	virtual void EnableScissorRegion(bool enable);
	/// Called by Rocket when it wants to change the scissor region.
	virtual void SetScissorRegion(int x, int y, int width, int height);
	/// Called by Rocket when a texture is required by the library.
	virtual bool LoadTexture(Rocket::Core::TextureHandle& texture_handle, Rocket::Core::Vector2i& texture_dimensions, const Rocket::Core::String& source);
	/// Called by Rocket when a texture is required to be built from an internally-generated sequence of pixels.
	virtual bool GenerateTexture(Rocket::Core::TextureHandle& texture_handle, const Rocket::Core::byte* source, const Rocket::Core::Vector2i& source_dimensions);
	/// Called by Rocket when a loaded texture is no longer required.
	virtual void ReleaseTexture(Rocket::Core::TextureHandle texture_handle);

	std::map<Rocket::Core::TextureHandle, DKString> texture_name; //texture to name map


private:
    SDL_Renderer* mRenderer;
    SDL_Window* mScreen;

#ifdef USE_SDL2_gif
	std::vector<SDL_GifAnim*> animations;
#endif
};

#endif
