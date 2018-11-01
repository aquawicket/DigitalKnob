#pragma once
#ifndef DKXml_H
#define DKXml_H
#include "DK/DKClass.h"
#include "libxml/HTMLparser.h"
#include "pugixml.hpp"

typedef pugi::xml_node DKXmlNode;
typedef pugi::xpath_node_set DKXmlNodes;

/////////////////////////////////////
class DKXml : public DKObjectT<DKXml>
{
public:
	bool Init();
	bool End();

	bool AppendNode(const DKString& xpath, const DKString& type);
	bool FindNode(const DKString& xpath);
	bool GetAttribute(const DKString& xpath, const DKString& attrib, DKString& string);
	bool GetAttribute(const DKXmlNode& node, const DKString& attrib, DKString& string);
	bool GetAttributeValues(const DKString& xpath, const DKString& attrib, DKStringArray& arry);
	bool GetChildAttribute(const DKString& xpath, int num, const DKString& attrib, DKString& string);
	bool GetChildNodeValue(const DKString& xpath, int num, DKString& string);
	bool GetFullNode(const DKString& xpath, DKString& string);
	bool GetNode(const DKString& xpath, DKXmlNode& node);
	bool GetNodeNames(const DKString& xpath, DKStringArray& arry);
	bool GetNodeValue(const DKString& xpath, DKString& string);
	bool GetNodes(const DKString& xpath, DKXmlNodes& nodes);
	bool LoadDocument(const DKString& file);
	bool LoadDocumentFromString(const DKString& string);
	bool PrependNode(const DKString& xpath, const DKString& type);
	bool RemoveAttributes(const DKString& xpath, const DKString& attrib);
	bool RemoveInners(const DKString& xpath);
	bool RemoveNodes(const DKString& xpath);
	bool SaveDocument(DKString& file);
	bool SaveDocumentToString(DKString& string);
	bool SaveNodes(const DKString& xpath, const DKString& path);
	bool SetAttribute(DKXmlNode& node, const DKString& attrib, const DKString& value);
	bool SetAttributes(const DKString& xpath, const DKString& attrib, const DKString& value);
	
	pugi::xml_document doc;
};


REGISTER_OBJECT(DKXml, true);

#endif //DKXml_H
