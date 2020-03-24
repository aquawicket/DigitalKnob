#pragma once
#ifndef DKRmlFile_H
#define DKRmlFile_H
#include <Rml/Core/Core.h>
#include "DK/DKFile.h"

///////////////////////////////////////////////////////
class DKRmlFile : public Rml::Core::FileInterface
{
	virtual Rml::Core::FileHandle Open(const Rml::Core::String& path);
	virtual void Close(Rml::Core::FileHandle file);
	virtual size_t Read(void* buffer, size_t size, Rml::Core::FileHandle file);
	virtual bool Seek(Rml::Core::FileHandle file, long offset, int origin);
	virtual size_t Tell(Rml::Core::FileHandle file);
};

#endif //DKRmlFile_H

