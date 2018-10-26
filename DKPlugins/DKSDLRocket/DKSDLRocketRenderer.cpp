#include <Rocket/Core/Core.h>
#include <SDL_image.h>
#include "DK/DK.h"
#include "DK/DKString.h"
#include "DKSDLRocket/DKSDLRocketRenderer.h"
#include "DKSDLWindow/DKSDLWindow.h"

#if !defined(IOS) && !defined(ANDROID)
static PFNGLUSEPROGRAMOBJECTARBPROC glUseProgramObjectARB;
#endif

//////////////////////////////////////////////////////////////////////////////////
RocketSDL2Renderer::RocketSDL2Renderer(SDL_Renderer* renderer, SDL_Window* screen)
{
	DKDEBUGFUNC(renderer, screen);
    mRenderer = renderer;
    mScreen = screen;
}

// Called by Rocket when it wants to render geometry that it does not wish to optimise.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void RocketSDL2Renderer::RenderGeometry(Rocket::Core::Vertex* vertices, int num_vertices, int* indices, int num_indices, const Rocket::Core::TextureHandle texture, const Rocket::Core::Vector2f& translation)
{
	//DKDEBUGFUNC(vertices, num_vertices, indices, num_indices, texture, translation);
#if !defined(IOS) && !defined(ANDROID)
    // DISABLE SDL Shaders
	DKSDLWindow* dkSdlWindow = DKSDLWindow::Instance("DKSDLWindow0");
	if(!has(dkSdlWindow->gl_vendor, "Microsoft")){
		glUseProgramObjectARB = (PFNGLUSEPROGRAMOBJECTARBPROC) SDL_GL_GetProcAddress("glUseProgramObjectARB");
		glUseProgramObjectARB(0);  //FIXME: this crashes on Microsoft Generic GDI drivers
	}
#endif 

    glPushMatrix();
    glTranslatef(translation.x, translation.y, 0);
 
    std::vector<Rocket::Core::Vector2f> Positions(num_vertices);
    std::vector<Rocket::Core::Colourb> Colors(num_vertices);
    std::vector<Rocket::Core::Vector2f> TexCoords(num_vertices);
    float texw, texh;
 
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR); 

    SDL_Texture* sdl_texture = NULL;
    if(texture){
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        sdl_texture = (SDL_Texture*)texture;

		//Cef
		//The id is mapped to the texture in texture_name
		//If the id contains iframe_ , it is a cef image
		//Update the texture with DKSDLCef::GetTexture(id);
		///////////////////////////////////////////////////////////
		if(has(texture_name[texture],"iframe_")){
			DKString id = texture_name[texture];
			replace(id,"iframe_","");
			
			struct DKTexture{ SDL_Texture* texture; };
			DKTexture output;
			if(!DKClass::CallFunc("DKSDLCef::GetTexture", &id, &output)){ return; }
			sdl_texture = output.texture;
		}

		if(!sdl_texture){ return; }
        if(SDL_GL_BindTexture(sdl_texture, &texw, &texh) == -1){
			DKERROR("SDL_GL_BindTexture: "+DKString(SDL_GetError())+"\n");
		}
    }
 
    for(int  i = 0; i < num_vertices; i++) {
        Positions[i] = vertices[i].position;
        Colors[i] = vertices[i].colour;
        if(sdl_texture){
            TexCoords[i].x = vertices[i].tex_coord.x * texw;
            TexCoords[i].y = vertices[i].tex_coord.y * texh;
        }
        else TexCoords[i] = vertices[i].tex_coord;
    };

#if defined(ANDROID) || defined(IOS)
	unsigned short newIndicies[num_indices];
    for (int i = 0; i < num_indices; i++)
    {
      newIndicies[i] = (unsigned short) indices[i];
    }
#endif
 
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_COLOR_ARRAY);
    glVertexPointer(2, GL_FLOAT, 0, &Positions[0]);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, &Colors[0]);
    glTexCoordPointer(2, GL_FLOAT, 0, &TexCoords[0]);
 
    glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
#if defined(ANDROID) || defined(IOS)
	glDrawElements(GL_TRIANGLES, num_indices, GL_UNSIGNED_SHORT, newIndicies);
#else
    glDrawElements(GL_TRIANGLES, num_indices, GL_UNSIGNED_INT, indices);
#endif
    //glDisableClientState(GL_VERTEX_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);

    if(sdl_texture){
        SDL_GL_UnbindTexture(sdl_texture);
        glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    }
 
    glColor4f(1.0, 1.0, 1.0, 1.0);
    glPopMatrix();
	
#ifdef USE_SDL2_gif
	for(unsigned int i=0; i<animations.size(); ++i){
		SDL_GIFAnimAuto(animations[i]);
	}
#endif

/*
    glDisable(GL_BLEND);
*/
	// Reset blending and draw a fake point just outside the screen to let SDL know that it needs to reset its state in case it wants to render a texture 
    SDL_SetRenderDrawBlendMode(mRenderer, SDL_BLENDMODE_NONE);
    SDL_RenderDrawPoint(mRenderer, -1, -1);
}


// Called by Rocket when it wants to enable or disable scissoring to clip content.
/////////////////////////////////////////////////////////
void RocketSDL2Renderer::EnableScissorRegion(bool enable)
{
	//DKDEBUGFUNC(enable);
    if (enable)
        glEnable(GL_SCISSOR_TEST);
    else
        glDisable(GL_SCISSOR_TEST);
}

// Called by Rocket when it wants to change the scissor region.
//////////////////////////////////////////////////////////////////////////////
void RocketSDL2Renderer::SetScissorRegion(int x, int y, int width, int height)
{
	//DKDEBUGFUNC(x, y, width, height);
    int w_width, w_height;
    SDL_GetWindowSize(mScreen, &w_width, &w_height);
    glScissor(x, w_height - (y + height), width, height);
}

// Called by Rocket when a texture is required by the library.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool RocketSDL2Renderer::LoadTexture(Rocket::Core::TextureHandle& texture_handle, Rocket::Core::Vector2i& texture_dimensions, const Rocket::Core::String& source)
{
	DKDEBUGFUNC(texture_handle, texture_dimensions, "Rocket::Core::String&");
	//CEF Texture
	//The source variable is the id of the iframe. It will contain iframe_ in it's id.
	//We will map that id to the texture handle for later use. 
	if(has(source.CString(),"iframe_")){
		texture_handle = reinterpret_cast<Rocket::Core::TextureHandle>(&source);
		texture_name[texture_handle] = source.CString();
		return true;
	}

	Rocket::Core::FileInterface* file_interface = Rocket::Core::GetFileInterface();
    Rocket::Core::FileHandle file_handle = file_interface->Open(source);
    if (!file_handle)
        return false;

    file_interface->Seek(file_handle, 0, SEEK_END);
    size_t buffer_size = file_interface->Tell(file_handle);
    file_interface->Seek(file_handle, 0, SEEK_SET);

    char* buffer = new char[buffer_size];
    file_interface->Read(buffer, buffer_size, file_handle);
    file_interface->Close(file_handle);

#ifdef USE_SDL2_gif
	std::string src = source.CString();
	if(has(src,".gif")){
		animations.push_back(SDL_GIFAnimLoad_RW(SDL_RWFromMem(buffer, buffer_size), mRenderer));
		SDL_Texture *texture = SDL_GIFTexture(animations[animations.size()-1]);
		SDL_GIFLoopMode(animations[animations.size()-1], GIF_REPEAT_FOR);
		if(texture){
		    texture_handle = (Rocket::Core::TextureHandle) texture;
			int w, h;
			SDL_QueryTexture(texture, NULL, NULL, &w, &h);
		    texture_dimensions = Rocket::Core::Vector2i(w, h);
		}
		else{
			return false;
		}

		texture_name[texture_handle] = source.CString();
		return true;
	}
	else{
#endif
		SDL_Texture *texture = IMG_LoadTexture_RW(mRenderer, SDL_RWFromMem(buffer, buffer_size), 1);
	    if(texture){
		    texture_handle = (Rocket::Core::TextureHandle) texture;
			int w, h;
			SDL_QueryTexture(texture, NULL, NULL, &w, &h);
		    texture_dimensions = Rocket::Core::Vector2i(w, h);
		}
		else{
			return false;
		}
		texture_name[texture_handle] = source.CString();
		return true;

#ifdef USE_SDL2_gif
	}
    return false;
#endif
}

// Called by Rocket when a texture is required to be built from an internally-generated sequence of pixels.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool RocketSDL2Renderer::GenerateTexture(Rocket::Core::TextureHandle& texture_handle, const Rocket::Core::byte* source, const Rocket::Core::Vector2i& source_dimensions)
{
	DKDEBUGFUNC(texture_handle, source, source_dimensions);
    #if SDL_BYTEORDER == SDL_BIG_ENDIAN
        Uint32 rmask = 0xff000000;
        Uint32 gmask = 0x00ff0000;
        Uint32 bmask = 0x0000ff00;
        Uint32 amask = 0x000000ff;
    #else
        Uint32 rmask = 0x000000ff;
        Uint32 gmask = 0x0000ff00;
        Uint32 bmask = 0x00ff0000;
        Uint32 amask = 0xff000000;
    #endif

    SDL_Surface *surface = SDL_CreateRGBSurfaceFrom ((void*) source, source_dimensions.x, source_dimensions.y, 32, source_dimensions.x*4, rmask, gmask, bmask, amask);
    SDL_Texture *texture = SDL_CreateTextureFromSurface(mRenderer, surface);
    SDL_SetTextureBlendMode(texture, SDL_BLENDMODE_BLEND);
    SDL_FreeSurface(surface);
    texture_handle = (Rocket::Core::TextureHandle) texture;
    return true;
}

// Called by Rocket when a loaded texture is no longer required.
///////////////////////////////////////////////////////////////////////////////////
void RocketSDL2Renderer::ReleaseTexture(Rocket::Core::TextureHandle texture_handle)
{
	DKDEBUGFUNC(texture_handle);
    SDL_DestroyTexture((SDL_Texture*) texture_handle);
}
