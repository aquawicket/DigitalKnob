#pragma once
#ifndef DKArchive_H
#define DKArchive_H
#include "DK.h"

/////////////////////////////////////////////
class DKArchive : public DKObjectT<DKArchive>
{
public:
	void Init(){}
	static bool Extract(const DKString& file, const DKString& path);
	static bool Compress(const DKString& path, const DKString& file);
	static int copy_data(struct archive *ar, struct archive *aw);
};


REGISTER_OBJECT(DKArchive, true);

#endif //DKArchive_H