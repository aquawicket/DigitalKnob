#pragma once
#ifndef DKXml_H
#define DKXml_H
#include "DKClass.h"
#include "pugixml.hpp"

typedef pugi::xml_node DKXmlNode;
typedef pugi::xpath_node_set DKXmlNodes;

/////////////////////////////////////
class DKXml : public DKObjectT<DKXml>
{
public:
	void Init();
	void End();

	bool LoadDocument(const DKString& file);
	bool LoadDocumentFromString(const DKString& string);
	bool SaveDocument(DKString& file);
	bool SaveDocumentToString(DKString& string);
	bool SaveNodes(const DKString& xpath, const DKString& path);

	bool FindNode(const DKString& xpath);
	bool GetNode(const DKString& xpath, DKXmlNode& node);
	bool GetNodes(const DKString& xpath, DKXmlNodes& nodes);
	bool GetNodeNames(const DKString& xpath, DKStringArray& arry);
	bool GetAttributeValues(const DKString& xpath, const DKString& attrib, DKStringArray& arry);
	bool GetFullNode(const DKString& xpath, DKString& string);
	bool GetNodeValue(const DKString& xpath, DKString& string);
	bool GetAttribute(const DKXmlNode& node, const DKString& attrib, DKString& string);
	bool GetAttribute(const DKString& xpath, const DKString& attrib, DKString& string);
	bool SetAttribute(DKXmlNode& node, const DKString& attrib, const DKString& value);
	bool SetAttributes(const DKString& xpath, const DKString& attrib, const DKString& value);
	bool GetChildNodeValue(const DKString& xpath, int num, DKString& string);
	bool GetChildAttribute(const DKString& xpath, int num, const DKString& attrib, DKString& string);
	
	bool AppendNode(const DKString& xpath, const DKString& type);
	bool PrependNode(const DKString& xpath, const DKString& type);
	bool RemoveNodes(const DKString& xpath);
	bool RemoveAttributes(const DKString& xpath, const DKString& attrib);
	bool RemoveInners(const DKString& xpath);
	
	pugi::xml_document doc;
};


REGISTER_OBJECT(DKXml, true);

#endif //DKXml_H
