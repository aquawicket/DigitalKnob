#pragma once
#ifndef DKAssets_H
#define DKAssets_H

#include "DK/DK.h"

///////////////////////////////////////////
class DKAssets : public DKObjectT<DKAssets>
{
public:
	bool Init();
	
	//static bool AppendDataPath(const DKString& datapath);
	static bool AquireDataPath(DKString& exepath);
	static bool CheckAssetsPath(const DKString& datapath);
	static bool DeployAssets();
	static bool PackageAssets(DKString& input, DKString& output);
};

REGISTER_OBJECT(DKAssets, true);

#endif //DKAssets_H