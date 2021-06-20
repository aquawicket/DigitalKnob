#pragma once
#ifndef DKArchive_H
#define DKArchive_H
#include "DK/DK.h"

class DKArchive : public DKObjectT<DKArchive>
{
public:
	bool Init();
	bool End();
	
	static bool Compress(const DKString& path, const DKString& file);
	static bool Extract(const DKString& file, const DKString& path);
	static int copy_data(struct archive *ar, struct archive *aw);
};


REGISTER_OBJECT(DKArchive, true);

#endif //DKArchive_H