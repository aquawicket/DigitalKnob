#pragma once
#ifndef DKRocketFile_H
#define DKRocketFile_H
#include <Rocket/Core.h>
#include "DK/DKFile.h"

///////////////////////////////////////////////////////
class DKRocketFile : public Rocket::Core::FileInterface
{
	virtual Rocket::Core::FileHandle Open(const Rocket::Core::String& path);
	virtual void Close(Rocket::Core::FileHandle file);
	virtual size_t Read(void* buffer, size_t size, Rocket::Core::FileHandle file);
	virtual bool Seek(Rocket::Core::FileHandle file, long offset, int origin);
	virtual size_t Tell(Rocket::Core::FileHandle file);
};

#endif //DKRocketFile_H

