/* -*-c++-*- */
/**
 * osgAudio - OpenSceneGraph Audio Library
 * (C) Copyright 2009-2011 by Kenneth Mark Bryden
 * (programming by Chris 'Xenon' Hanson, AlphaPixel, LLC xenon at alphapixel.com)
 * based on a fork of:
 * Osg AL - OpenSceneGraph Audio Library
 * Copyright (C) 2004 VRlab, Umeå University
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * Please see COPYING file for special static-link exemption to LGPL.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
 */

#ifndef OSGAUDIO_VERSION_H
#define OSGAUDIO_VERSION_H 1

#include <string>

#include <osgAudio/Export.h>

/**
 * \mainpage
 * osgAudio is an library for integration of 3D sound APIs like OpenAL++ or FMOD into OpenSceneGraph. 
 * This project also includes the OpenAL++ library. OpenAL++ is a C++ abstraction layer
 * on top of OpenAL with additional functionality of reading ogg-files, reference counting etc.
 *
 * OsgAudio has been tested on Windows and Linux. 
 *
 */

#define OSGAUDIO_MAJOR_VERSION (2)
#define OSGAUDIO_MINOR_VERSION (0)
#define OSGAUDIO_SUB_VERSION (0)

// C preprocessor integrated version number.
// The form is Mmmss, where:
//   M is the major version
//   mm is the minor version (zero-padded)
//   ss is the sub version (zero padded)
// Use this in version-specific code, for example:
//   #if( OSGAUDIO_VERSION > 20100 )
//      ... code specific to releases AFTER v2.01
//   #endif
#define OSGAUDIO_VERSION ( \
        ( OSGAUDIO_MAJOR_VERSION * 10000 ) + \
        ( OSGAUDIO_MINOR_VERSION * 100 ) + \
        OSGAUDIO_SUB_VERSION )

///Define whether we are using OpenAL or FMOD

/// Integration of 3D Sound into OpenSceneGraph.
namespace osgAudio {
    OSGAUDIO_EXPORT std::string getVersion();
    OSGAUDIO_EXPORT unsigned int getVersionNumber();
    OSGAUDIO_EXPORT std::string getLibraryName();
} // namespace osgAudio

#endif // OSGAUDIO_VERSION_H

