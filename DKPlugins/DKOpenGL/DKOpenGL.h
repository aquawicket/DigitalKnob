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
#ifndef DKOpenGL_H
#define DKOpenGL_H

#include "DK/DK.h"

WARNING_DISABLE
#ifdef __has_include
	#if __has_include(<GL/glew.h>)
		#include <GL/glew.h>					// glew
	#endif

	#if __has_include(<GL/gl.h>)
		#include <GL/gl.h>						// OpenGL
	#elif __has_include(<OpenGL/gl.h>)
		#include <OpenGL/gl.h>					// OpenGL
	#elif __has_include(<GLES2/gl2.h>)
		#include <GLES2/gl2.h>					// OpenGLES 2
	#elif __has_include(<OpenGLES/ES2/gl.h>)
		#include <OpenGLES/ES2/gl.h>			// OpenGLES 2
	#elif __has_include(<GLES/gl.h>)
		#include <GLES/gl.h>					// OpenGLES 1
	#elif __has_include(<OpenGLES/ES1/gl.h>)
		#include <OpenGLES/ES1/gl.h>			// OpenGLES 1
	#else
		//#error No suitable OpenGL/GLES headers found
		DKMSG("No suitable OpenGL/GLES headers found")
	#endif
	
	#if __has_include(<GL/glu.h>)
		#include <GL/glu.h>						// glu
	#elif __has_include(<OpenGL/glu.h>)
		#include <OpenGL/glu.h>					// glu
	#endif
#endif
WARNING_ENABLE


#endif //DKOpenGL_H
