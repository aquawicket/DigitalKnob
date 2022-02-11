/*
 * This source file is part of RmlUi, the HTML/CSS Interface Middleware
 *
 * For the latest information, see http://github.com/mikke89/RmlUi
 *
 * Copyright (c) 2008-2010 Nuno Silva
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

#include "RenderInterface.h"
#include <SDL_image.h>
#include <RmlUi/Core.h>
#include "GifAnimate.h"

RenderInterface::RenderInterface(SDL_Renderer* sdlRenderer, SDL_Window* sdlWindow)
{
    mSdlRenderer = sdlRenderer;
    mSdlWindow = sdlWindow;

    SDL_GetRendererOutputSize(mSdlRenderer, &mWidth, &mHeight);

    mScisorRect.x = 0;
    mScisorRect.y = 0;
    mScisorRect.w = mWidth;
    mScisorRect.h = mHeight;
}

// Called by RmlUi when it wants to render geometry that it does not wish to optimise.
void RenderInterface::RenderGeometry(Rml::Vertex* vertices, int num_vertices, int* indices, int num_indices, const Rml::TextureHandle texture, const Rml::Vector2f& translation)
{
    SDL_Texture* sdlTexture = GetGifAnimation(texture);
    if (sdlTexture == nullptr)
    {
        sdlTexture = (SDL_Texture*)texture;
    }

    int sz = sizeof(vertices[0]);
    int off1 = offsetof(Rml::Vertex, position);
    int off2 = offsetof(Rml::Vertex, colour);
    int off3 = offsetof(Rml::Vertex, tex_coord);

    //Crate a vector to position the texture's translation
    std::vector<Rml::Vector2f> pos;
    for (int i = 0; i < num_vertices; ++i) 
    {
        pos.push_back(Rml::Vector2f(vertices[i].position.x + translation.x, vertices[i].position.y + translation.y));
    }
    Rml::Vector2f* position = &pos[0];
    int szPos = sizeof(position[0]);

    SDL_RenderGeometryRaw(mSdlRenderer, sdlTexture,
         (float*)(position), szPos,
         (const SDL_Color*)((Uint8*)vertices + off2), sz,
         (float*)((Uint8*)vertices + off3), sz,
         num_vertices, indices, num_indices, 4);
}

// Called by RmlUi when it wants to compile geometry it believes will be static for the foreseeable future.
Rml::CompiledGeometryHandle RenderInterface::CompileGeometry(Rml::Vertex* vertices, int num_vertices, int* indices, int num_indices, Rml::TextureHandle texture)
{
    return (Rml::CompiledGeometryHandle) nullptr;
}

// Called by RmlUi when it wants to render application-compiled geometry.
void RenderInterface::RenderCompiledGeometry(Rml::CompiledGeometryHandle geometry, const Rml::Vector2f& translation)
{

}

// Called by RmlUi when it wants to release application-compiled geometry.
void RenderInterface::ReleaseCompiledGeometry(Rml::CompiledGeometryHandle geometry)
{

}

// Called by RmlUi when it wants to enable or disable scissoring to clip content.		
void RenderInterface::EnableScissorRegion(bool enable)
{
    if (enable) 
    {
       SDL_RenderSetClipRect(mSdlRenderer, &mScisorRect);
    } else 
    {
        SDL_RenderSetClipRect(mSdlRenderer, NULL);
    }
}

// Called by RmlUi when it wants to change the scissor region.		
void RenderInterface::SetScissorRegion(int x, int y, int width, int height)
{
    //int w_width, w_height;
    //SDL_GetWindowSize(mScreen, &w_width, &w_height);
    mScisorRect.x = x;
    mScisorRect.y = y;
    mScisorRect.w = width;
    mScisorRect.h = height;
}

// Called by RmlUi when a texture is required by the library.		
bool RenderInterface::LoadTexture(Rml::TextureHandle& texture_handle, Rml::Vector2i& texture_dimensions, const Rml::String& source)
{
    if(LoadGifAnimation(mSdlRenderer, source, texture_handle, texture_dimensions))
    {
        return true;
    }
    
    Rml::FileInterface* fileInterface = Rml::GetFileInterface();
    Rml::FileHandle fileHandle = fileInterface->Open(source);
    if (!fileHandle)
    {
        printf("Error loading file\n");
        return false;
    }

    fileInterface->Seek(fileHandle, 0, SEEK_END);
    size_t bufferSize = fileInterface->Tell(fileHandle);
    fileInterface->Seek(fileHandle, 0, SEEK_SET);

    char* buffer = new char[bufferSize];
    fileInterface->Read(buffer, bufferSize, fileHandle);
    
    size_t i;
    for (i = source.length() - 1; i > 0; i--)
    {
        if (source[i] == '.')
            break;
    }

    Rml::String extension = source.substr(i + 1, source.length() - i);

    SDL_Surface* sdlSurface = IMG_LoadTyped_RW(SDL_RWFromMem(buffer, int(bufferSize)), 1, extension.c_str());
    fileInterface->Close(fileHandle);
    if (sdlSurface)
    {
        SDL_Texture* sdlTexture = SDL_CreateTextureFromSurface(mSdlRenderer, sdlSurface);
        if (sdlTexture)
        {
            texture_handle = (Rml::TextureHandle)sdlTexture;
            texture_dimensions = Rml::Vector2i(sdlSurface->w, sdlSurface->h);
            SDL_FreeSurface(sdlSurface);
        }
        else
        {
            return false;
        }
        return true;
    }
 
    return false;
}

// Called by RmlUi when a texture is required to be built from an internally-generated sequence of pixels.
bool RenderInterface::GenerateTexture(Rml::TextureHandle& texture_handle, const Rml::byte* source, const Rml::Vector2i& source_dimensions)
{
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

    SDL_Surface* sdlSurface = SDL_CreateRGBSurfaceFrom ( (void*)source, source_dimensions.x, source_dimensions.y, 32, source_dimensions.x*4, rmask, gmask, bmask, amask);
    SDL_Texture* sdlTexture = SDL_CreateTextureFromSurface(mSdlRenderer, sdlSurface);
    SDL_SetTextureBlendMode(sdlTexture, SDL_BLENDMODE_BLEND);
    SDL_FreeSurface(sdlSurface);
    texture_handle = (Rml::TextureHandle)sdlTexture;
    return true;
}

// Called by RmlUi when a loaded texture is no longer required.		
void RenderInterface::ReleaseTexture(Rml::TextureHandle texture_handle)
{
    SDL_DestroyTexture( (SDL_Texture*)texture_handle);
}

void RenderInterface::SetTransform(const Rml::Matrix4f* transform)
{

}
