#pragma once
#ifndef DKRmlFile_H
#define DKRmlFile_H
#include <RmlUi/Core.h>
#include "DK/DKFile.h"

class DKRmlFile : public Rml::FileInterface{
	virtual Rml::FileHandle Open(const Rml::String& path);
	virtual void Close(Rml::FileHandle file);
	virtual size_t Read(void* buffer, size_t size, Rml::FileHandle file);
	virtual bool Seek(Rml::FileHandle file, long offset, int origin);
	virtual size_t Tell(Rml::FileHandle file);
};

#endif //DKRmlFile_H
