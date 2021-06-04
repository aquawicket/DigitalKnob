#pragma once
#ifndef DKAssets_H
#define DKAssets_H

#include "DK/DK.h"

//Used to load assets header from main app
extern std::string ASSETS_H;
extern size_t ASSETS_H_SIZE;

class DKAssets : public DKObjectT<DKAssets>{
public:
	bool Init();
	
	//static bool AppendDataPath(const DKString& datapath);
	static bool DeployAssets();
	static bool GetAssetsPath(DKString& path);
	static bool GetDataPath(DKString& path);
	static bool PackageAssets(DKString& dataFolder, DKString& headerFile);
};

REGISTER_OBJECT(DKAssets, true);

#endif //DKAssets_H