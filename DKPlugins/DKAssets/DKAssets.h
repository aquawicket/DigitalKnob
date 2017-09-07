#pragma once
#ifndef DKAssets_H
#define DKAssets_H
#include "DK.h"

///////////////////////////////////////////
class DKAssets : public DKObjectT<DKAssets>
{
public:
	void Init();
	
	//static bool AppendDataPath(const DKString& datapath);
	static bool AquireDataPath(DKString& exepath);
	static bool CheckAssetsPath(const DKString& datapath);
	static bool CopyAssets(const unsigned char* assets, const long int assets_size);
	static bool PackageAssets(DKString& input, DKString& output);
};


REGISTER_OBJECT(DKAssets, true);

#endif //DKAssets_H