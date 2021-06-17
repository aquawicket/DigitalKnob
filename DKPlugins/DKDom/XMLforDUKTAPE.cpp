#include <duktape.h>
#include <tinyxml2.h>

using namespace tinyxml2;

// -----------------------------------------------------------------------------
// XmlNode Object structure & utility functions
// -----------------------------------------------------------------------------

#define DUKWIN_XMLNODE_PROTOTYPE "$DukwinXmlNodePrototype"
#define DUKWIN_XMLELEMENT_PROTOTYPE "$DukwinXmlElementPrototype"
#define DUKWIN_XMLDOCUMENT_PROTOTYPE "$DukwinXmlDocumentPrototype"

#define DUKWIN_XMLNODE_PROP "tinyxml2::XMLNode"

struct DukwinXmlNode
{
	XMLNode *handle;
	bool document;
};

static void dukwin_push_document(duk_context *ctx, XMLDocument *handle)
{
	duk_push_object(ctx);
	duk_push_string(ctx, DUKWIN_XMLNODE_PROP);
	DukwinXmlNode *node = static_cast<DukwinXmlNode*>(duk_push_fixed_buffer(ctx, sizeof(DukwinXmlNode)));
	node->handle = static_cast<XMLNode*>(handle);
	node->document = true;
	duk_def_prop(ctx, -3, DUK_DEFPROP_HAVE_VALUE);
	duk_push_string(ctx, "ownerDocument");
	duk_dup(ctx, -2);
	duk_def_prop(ctx, -3, DUK_DEFPROP_HAVE_VALUE);
	// duk_put_prop_string(ctx, -2, DUKWIN_XMLNODE_PROP);
	duk_get_global_string(ctx, DUKWIN_XMLDOCUMENT_PROTOTYPE);
	duk_set_prototype(ctx, -2);
}

static void dukwin_push_node(duk_context *ctx, XMLNode *handle)
{
	duk_push_object(ctx);
	duk_push_string(ctx, DUKWIN_XMLNODE_PROP);
	DukwinXmlNode *node = static_cast<DukwinXmlNode*>(duk_push_fixed_buffer(ctx, sizeof(DukwinXmlNode)));
	node->handle = handle;
	node->document = false;
	duk_def_prop(ctx, -3, DUK_DEFPROP_HAVE_VALUE);
	duk_push_string(ctx, "ownerDocument");
	duk_push_this(ctx);
	duk_get_prop_string(ctx, -1, "ownerDocument");
	duk_remove(ctx, -2);
	duk_def_prop(ctx, -3, DUK_DEFPROP_HAVE_VALUE);
	if (handle->ToElement() != NULL)
	{
		duk_get_global_string(ctx, DUKWIN_XMLELEMENT_PROTOTYPE);
	}
	else
	{
		duk_get_global_string(ctx, DUKWIN_XMLNODE_PROTOTYPE);
	}
	duk_set_prototype(ctx, -2);
}

static DukwinXmlNode* dukwin_get_node(duk_context *ctx, duk_idx_t index)
{
	index = duk_normalize_index(ctx, index);
	DukwinXmlNode *result = NULL;

	if (duk_is_object(ctx, index))
	{
		if (duk_get_prop_string(ctx, index, DUKWIN_XMLNODE_PROP))
		{
			result = static_cast<DukwinXmlNode*>(duk_get_buffer_data(ctx, -1, NULL));
		}
		duk_pop(ctx);
	}

	return result;
}

static DukwinXmlNode* dukwin_get_node_from_this(duk_context *ctx)
{
	duk_push_this(ctx);
	DukwinXmlNode *node = dukwin_get_node(ctx, -1);
	if (node == NULL || node->handle == NULL)
	{
		duk_error(ctx, DUK_ERR_TYPE_ERROR, "invalid DukwinXmlNode Object");
	}
	return node;
}

static XMLElement* dukwin_this_node_as_element(duk_context *ctx)
{
	DukwinXmlNode *node = dukwin_get_node_from_this(ctx);
	XMLElement *elem = node->handle->ToElement();
	if (elem == NULL)
	{
		duk_error(ctx, DUK_ERR_TYPE_ERROR, "DukwinXmlNode Object is not of type Element");
	}
	return elem;
}

static XMLDocument* dukwin_this_node_as_document(duk_context *ctx)
{
	DukwinXmlNode *node = dukwin_get_node_from_this(ctx);
	XMLDocument *elem = node->handle->ToDocument();
	if (elem == NULL)
	{
		duk_error(ctx, DUK_ERR_TYPE_ERROR, "DukwinXmlNode Object is not of type Document");
	}
	return elem;
}

static void dukwin_clean_node(DukwinXmlNode *handle)
{
	if (handle == NULL || !handle->document)
	{
		return;
	}

	XMLDocument *doc = handle->handle->ToDocument();
	if (doc != NULL)
	{
#ifdef DUKWIN_VERBOSE
		printf("finalizing XMLDocument %p (%p)\n", doc, handle->handle);
#endif
		delete doc;
	}
}

// -----------------------------------------------------------------------------
// XML Node Object methods
// -----------------------------------------------------------------------------

static duk_ret_t dukwin_node_finalizer(duk_context *ctx)
{
	DukwinXmlNode *node = dukwin_get_node(ctx, 0);
	dukwin_clean_node(node);
	return 0;
}

static duk_ret_t dukwin_node_tostring(duk_context *ctx)
{
	DukwinXmlNode *node = dukwin_get_node_from_this(ctx);
	
	// duk_push_sprintf(ctx, "[DukwinXmlNode %p]", node);
	
	XMLPrinter printer;
	node->handle->Accept(&printer);
	duk_push_string(ctx, printer.CStr());

	return 1;
}

static duk_ret_t dukwin_node_isroot(duk_context *ctx)
{
	DukwinXmlNode *node = dukwin_get_node_from_this(ctx);
	duk_push_boolean(ctx, node->document);
	return 1;
}

static duk_ret_t dukwin_node_haschildnodes(duk_context *ctx)
{
	DukwinXmlNode *node = dukwin_get_node_from_this(ctx);
	duk_push_boolean(ctx, !node->handle->NoChildren());
	return 1;
}

static duk_ret_t dukwin_node_appendchild(duk_context *ctx)
{
	DukwinXmlNode *node = dukwin_get_node_from_this(ctx);
	
	DukwinXmlNode *child = dukwin_get_node(ctx, 0);
	if (child == NULL || child->handle == NULL)
	{
		duk_error(ctx, DUK_ERR_TYPE_ERROR, "invalid DukwinXmlNode Object as first argument");
	}

	XMLNode *result = node->handle->InsertEndChild(child->handle);
	if (result != NULL)
	{
		dukwin_push_node(ctx, result);
	}
	else
	{
		duk_push_null(ctx);
	}
	return 1;
}

static duk_ret_t dukwin_node_removechild(duk_context *ctx)
{
	DukwinXmlNode *node = dukwin_get_node_from_this(ctx);

	DukwinXmlNode *child = dukwin_get_node(ctx, 0);
	if (child == NULL || child->handle == NULL)
	{
		duk_error(ctx, DUK_ERR_TYPE_ERROR, "invalid DukwinXmlNode Object as first argument");
	}

	node->handle->DeleteChild(child->handle);
	return 0;
}

static duk_ret_t dukwin_node_firstchild(duk_context *ctx)
{
	DukwinXmlNode *node = dukwin_get_node_from_this(ctx);
	const XMLNode *child = node->handle->FirstChild();
	if (child == NULL)
	{
		duk_push_null(ctx);
	}
	else
	{
		dukwin_push_node(ctx, const_cast<XMLNode*>(child));
	}
	return 1;
}

static duk_ret_t dukwin_node_lastchild(duk_context *ctx)
{
	DukwinXmlNode *node = dukwin_get_node_from_this(ctx);
	const XMLNode *child = node->handle->LastChild();
	if (child == NULL)
	{
		duk_push_null(ctx);
	}
	else
	{
		dukwin_push_node(ctx, const_cast<XMLNode*>(child));
	}
	return 1;
}

static duk_ret_t dukwin_node_nextsibling(duk_context *ctx)
{
	DukwinXmlNode *node = dukwin_get_node_from_this(ctx);
	const XMLNode *child = node->handle->NextSibling();
	if (child == NULL)
	{
		duk_push_null(ctx);
	}
	else
	{
		dukwin_push_node(ctx, const_cast<XMLNode*>(child));
	}
	return 1;
}

static duk_ret_t dukwin_node_previoussibling(duk_context *ctx)
{
	DukwinXmlNode *node = dukwin_get_node_from_this(ctx);
	const XMLNode *child = node->handle->PreviousSibling();
	if (child == NULL)
	{
		duk_push_null(ctx);
	}
	else
	{
		dukwin_push_node(ctx, const_cast<XMLNode*>(child));
	}
	return 1;
}

static duk_ret_t dukwin_node_getfirstchildelement(duk_context *ctx)
{
	DukwinXmlNode *node = dukwin_get_node_from_this(ctx);
	const char *tagName = duk_require_string(ctx, 0);

	const XMLNode *child = node->handle->FirstChildElement(tagName);
	if (child == NULL)
	{
		duk_push_null(ctx);
	}
	else
	{
		dukwin_push_node(ctx, const_cast<XMLNode*>(child));
	}
	return 1;
}

static duk_ret_t dukwin_node_getlastchildelement(duk_context *ctx)
{
	DukwinXmlNode *node = dukwin_get_node_from_this(ctx);
	const char *tagName = duk_require_string(ctx, 0);

	const XMLNode *child = node->handle->LastChildElement(tagName);
	if (child == NULL)
	{
		duk_push_null(ctx);
	}
	else
	{
		dukwin_push_node(ctx, const_cast<XMLNode*>(child));
	}
	return 1;
}

static duk_ret_t dukwin_node_parentnode(duk_context *ctx)
{
	DukwinXmlNode *node = dukwin_get_node_from_this(ctx);

	const XMLNode *parent = node->handle->Parent();
	if (parent == NULL)
	{
		duk_push_null(ctx);
	}
	else
	{
		dukwin_push_node(ctx, const_cast<XMLNode*>(parent));
	}
	return 1;
}

static duk_ret_t dukwin_node_parentelement(duk_context *ctx)
{
	DukwinXmlNode *node = dukwin_get_node_from_this(ctx);

	const XMLNode *parent = node->handle->Parent();
	if (parent == NULL || parent->ToElement() == NULL)
	{
		duk_push_null(ctx);
	}
	else
	{
		dukwin_push_node(ctx, const_cast<XMLNode*>(parent));
	}
	return 1;
}

static duk_ret_t dukwin_node_type(duk_context *ctx)
{
	DukwinXmlNode *node = dukwin_get_node_from_this(ctx);
	if (node->handle->ToElement() != NULL)
	{
		duk_push_string(ctx, "element");
	}
	else if (node->handle->ToText() != NULL)
	{
		duk_push_string(ctx, "text");
	}
	else if (node->handle->ToComment() != NULL)
	{
		duk_push_string(ctx, "comment");
	}
	else if (node->handle->ToDocument() != NULL)
	{
		duk_push_string(ctx, "document");
	}
	else if (node->handle->ToDeclaration() != NULL)
	{
		duk_push_string(ctx, "declaration");
	}
	else if (node->handle->ToUnknown() != NULL)
	{
		duk_push_string(ctx, "unknown");
	}
	return 1;
}

static duk_ret_t dukwin_node_value(duk_context *ctx)
{
	DukwinXmlNode *node = dukwin_get_node_from_this(ctx);
	const char *val = node->handle->Value();
	duk_push_string(ctx, val);
	return 1;
}

// -----------------------------------------------------------------------------
// XML Element Object methods
// -----------------------------------------------------------------------------

static duk_ret_t dukwin_element_getattribute(duk_context *ctx)
{
	XMLElement *elem = dukwin_this_node_as_element(ctx);

	const char *attrName = duk_require_string(ctx, 0);
	const char *attrValue = elem->Attribute(attrName);

	if (attrValue != NULL)
	{
		duk_push_string(ctx, attrValue);
	}
	else
	{
		duk_push_null(ctx);
	}
	return 1;
}

static duk_ret_t dukwin_element_setattribute(duk_context *ctx)
{
	XMLElement *elem = dukwin_this_node_as_element(ctx);

	const char *attrName = duk_require_string(ctx, 0);
	const char *attrValue = duk_to_string(ctx, 1);

	elem->SetAttribute(attrName, attrValue);
	return 0;
}

static duk_ret_t dukwin_element_removeattribute(duk_context *ctx)
{
	XMLElement *elem = dukwin_this_node_as_element(ctx);

	const char *attrName = duk_require_string(ctx, 0);
	
	elem->DeleteAttribute(attrName);
	return 0;
}

static duk_ret_t dukwin_element_hasattribute(duk_context *ctx)
{
	XMLElement *elem = dukwin_this_node_as_element(ctx);

	const char *attrName = duk_require_string(ctx, 0);
	const char *attrValue = elem->Attribute(attrName);

	duk_push_boolean(ctx, attrValue != NULL);
	return 1;
}

static duk_ret_t dukwin_element_attributes(duk_context *ctx)
{
	XMLElement *elem = dukwin_this_node_as_element(ctx);

	duk_push_object(ctx);

	for (XMLAttribute *cursor = const_cast<XMLAttribute*>(elem->FirstAttribute()); cursor; cursor = const_cast<XMLAttribute*>(cursor->Next()))
	{
		duk_push_string(ctx, cursor->Value());
		duk_put_prop_string(ctx, -2, cursor->Name());
	}

	return 1;
}

static duk_ret_t dukwin_element_getelementsbytagname(duk_context *ctx)
{
	XMLElement *elem = dukwin_this_node_as_element(ctx);

	const char *tagName = duk_require_string(ctx, 0);
	duk_idx_t arrIdx = duk_push_array(ctx);
	int i = 0;

	for (XMLElement *cursor = elem->FirstChildElement(tagName); cursor; cursor = cursor->NextSiblingElement(tagName))
	{
		dukwin_push_node(ctx, static_cast<XMLNode*>(cursor));
		duk_put_prop_index(ctx, arrIdx, i++);
	}

	return 1;
}

static duk_ret_t dukwin_element_tagname(duk_context *ctx)
{
	XMLElement *elem = dukwin_this_node_as_element(ctx);
	duk_push_string(ctx, elem->Name());
	return 1;
}

// -----------------------------------------------------------------------------
// XML Document Object methods
// -----------------------------------------------------------------------------

static duk_ret_t dukwin_document_createelement(duk_context *ctx)
{
	XMLDocument *doc = dukwin_this_node_as_document(ctx);
	const char *tagName = duk_require_string(ctx, 0);

	XMLElement *elem = doc->NewElement(tagName);

	dukwin_push_node(ctx, elem);
	return 1;
}

static duk_ret_t dukwin_document_createcomment(duk_context *ctx)
{
	XMLDocument *doc = dukwin_this_node_as_document(ctx);
	const char *data = duk_require_string(ctx, 0);

	XMLComment *comment = doc->NewComment(data);

	dukwin_push_node(ctx, comment);
	return 1;
}

static duk_ret_t dukwin_document_createtextnode(duk_context *ctx)
{
	XMLDocument *doc = dukwin_this_node_as_document(ctx);
	const char *data = duk_require_string(ctx, 0);

	XMLText *comment = doc->NewText(data);

	dukwin_push_node(ctx, comment);
	return 1;
}

static duk_ret_t dukwin_document_save(duk_context *ctx)
{
	XMLDocument *doc = dukwin_this_node_as_document(ctx);

	const char *outpath = duk_require_string(ctx, 0);
	bool compact = duk_to_boolean(ctx, 1) != 0;

	XMLError err = doc->SaveFile(outpath, compact);
	if (err != XML_NO_ERROR)
	{
		duk_error(ctx, DUK_ERR_INTERNAL_ERROR, "could not parse XML (%d)", err);
	}

	return 0;
}


// -----------------------------------------------------------------------------
// XML module functions
// -----------------------------------------------------------------------------

static duk_ret_t dukwin_parse_file(duk_context *ctx)
{
	const char *filename = duk_require_string(ctx, 0);
	XMLDocument *doc = new XMLDocument;

	XMLError err = doc->LoadFile(filename);
	if (err != XML_NO_ERROR)
	{
		delete doc;
		duk_error(ctx, DUK_ERR_INTERNAL_ERROR, "could not parse XML file '%s' (%d)", filename, err);
	}

	dukwin_push_document(ctx, doc);
	return 1;
}

static duk_ret_t dukwin_parse(duk_context *ctx)
{
	const char *source = duk_require_string(ctx, 0);
	XMLDocument *doc = new XMLDocument;

	XMLError err = doc->Parse(source);
	if (err != XML_NO_ERROR)
	{
		delete doc;
		duk_error(ctx, DUK_ERR_INTERNAL_ERROR, "could not parse XML (%d)", err);
	}

	dukwin_push_document(ctx, doc);
	return 1;
}

static duk_ret_t dukwin_create_document(duk_context *ctx)
{
	XMLDocument *doc = new XMLDocument;
	dukwin_push_document(ctx, doc);
	return 1;
}

// -----------------------------------------------------------------------------
// XML module declarations
// -----------------------------------------------------------------------------

const duk_function_list_entry dukwin_node_proto[] = {
	{ "toString", dukwin_node_tostring, 0 },
	{ "isRoot", dukwin_node_isroot, 0 },
	{ "hasChildNodes", dukwin_node_haschildnodes, 0 },
	{ "appendChild", dukwin_node_appendchild, 1 },
	{ "removeChild", dukwin_node_removechild, 1 },
	{ "getFirstChildElement", dukwin_node_getfirstchildelement, 1 },
	{ "getLastChildElement", dukwin_node_getlastchildelement, 1 },
	{ NULL, NULL, 0 }
};

const duk_function_list_entry dukwin_element_proto[] = {
	{ "getAttribute", dukwin_element_getattribute, 1 },
	{ "setAttribute", dukwin_element_setattribute, 2 },
	{ "removeAttribute", dukwin_element_removeattribute, 1 },
	{ "hasAttribute", dukwin_element_hasattribute, 1 },
	{ "getElementsByTagName", dukwin_element_getelementsbytagname, 1 },
	{ NULL, NULL, 0 }
};

const duk_function_list_entry dukwin_document_proto[] = {
	{ "createElement", dukwin_document_createelement, 1 },
	{ "createComment", dukwin_document_createcomment, 1 },
	{ "createTextNode", dukwin_document_createtextnode, 1 },
	{ "save", dukwin_document_createtextnode, 2 },
	{ NULL, NULL, 0 }
};

const duk_function_list_entry xml_module[] = {
	{ "parseFile", dukwin_parse_file, 1 },
	{ "parse", dukwin_parse, 1 },
	{ "createDocument", dukwin_create_document, 0 },
	{ NULL, NULL, 0 }
};

static void dukwin_put_getter(duk_context *ctx, const char *prop, duk_c_function getter)
{
	duk_push_string(ctx, prop);
	duk_push_c_function(ctx, getter, 0);
	duk_def_prop(ctx, -3, DUK_DEFPROP_HAVE_GETTER);
}

static void create_prototypes(duk_context *ctx)
{
	// create Node prototype
	duk_push_object(ctx);
	duk_put_function_list(ctx, -1, dukwin_node_proto);
	duk_push_c_function(ctx, dukwin_node_finalizer, 1);
	duk_set_finalizer(ctx, -2);
	dukwin_put_getter(ctx, "firstChild", dukwin_node_firstchild);
	dukwin_put_getter(ctx, "lastChild", dukwin_node_lastchild);
	dukwin_put_getter(ctx, "nextSibling", dukwin_node_nextsibling);
	dukwin_put_getter(ctx, "previousSibling", dukwin_node_previoussibling);
	dukwin_put_getter(ctx, "parentNode", dukwin_node_parentnode);
	dukwin_put_getter(ctx, "parentElement", dukwin_node_parentelement);
	dukwin_put_getter(ctx, "nodeType", dukwin_node_type);
	dukwin_put_getter(ctx, "nodeValue", dukwin_node_value);
	duk_put_global_string(ctx, DUKWIN_XMLNODE_PROTOTYPE);
	// create the Element prototype
	duk_push_object(ctx);
	duk_get_global_string(ctx, DUKWIN_XMLNODE_PROTOTYPE);
	duk_set_prototype(ctx, -2);
	duk_put_function_list(ctx, -1, dukwin_element_proto);
	dukwin_put_getter(ctx, "tagName", dukwin_element_tagname);
	dukwin_put_getter(ctx, "attributes", dukwin_element_attributes);
	duk_put_global_string(ctx, DUKWIN_XMLELEMENT_PROTOTYPE);
	// create the Document prototype
	duk_push_object(ctx);
	duk_get_global_string(ctx, DUKWIN_XMLNODE_PROTOTYPE);
	duk_set_prototype(ctx, -2);
	duk_put_function_list(ctx, -1, dukwin_document_proto);
	duk_put_global_string(ctx, DUKWIN_XMLDOCUMENT_PROTOTYPE);
}

duk_ret_t dukopen_xml(duk_context *ctx)
{
	// create the DukwinFile prototype
	create_prototypes(ctx);
	// use exports table if available
	if (duk_is_object(ctx, 0))
	{
		duk_dup(ctx, 0);
	}
	else
	{
		duk_push_object(ctx);
	}
	// put module functions
	duk_put_function_list(ctx, -1, xml_module);
	return 1;
}