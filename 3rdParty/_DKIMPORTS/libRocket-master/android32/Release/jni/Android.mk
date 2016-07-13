FREETYPE := freetype-2.5.5
LOCAL_PATH := $(call my-dir)

#####################
include $(CLEAR_VARS)
LOCAL_MODULE := RocketControls
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../../Include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../$(FREETYPE)/include
LOCAL_CPPFLAGS := -DANDROID
LOCAL_CPPFLAGS += -DROCKET_STATIC_LIB
LOCAL_CPPFLAGS += -DROCKET_SHORT_INDICES
LOCAL_CPPFLAGS += -DRocketCore_EXPORTS
LOCAL_CPPFLAGS += -DRocketControls_EXPORTS
LOCAL_CPPFLAGS += -DRocketDebugger_EXPORTS
LOCAL_CPPFLAGS += -DRocketFreeType_EXPORTS
LOCAL_CPPFLAGS += -DRocketBitmapFont_EXPORTS
LOCAL_SRC_FILES := \
	$(LOCAL_PATH)/../../../../Source/Controls/Clipboard.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/Controls.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/DataFormatter.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/DataQuery.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/DataSource.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/DataSourceListener.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/ElementDataGrid.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/ElementDataGridCell.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/ElementDataGridExpandButton.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/ElementDataGridRow.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/ElementForm.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/ElementFormControl.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/ElementFormControlDataSelect.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/ElementFormControlInput.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/ElementFormControlSelect.cpp\
	$(LOCAL_PATH)/../../../../Source/Controls/ElementFormControlTextArea.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/ElementTabSet.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/ElementTextSelection.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/InputType.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/InputTypeButton.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/InputTypeCheckbox.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/InputTypeRadio.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/InputTypeRange.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/InputTypeSubmit.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/InputTypeText.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/SelectOption.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/WidgetDropDown.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/WidgetSlider.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/WidgetSliderInput.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/WidgetTextInput.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/WidgetTextInputMultiLine.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/WidgetTextInputSingleLine.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/WidgetTextInputSingleLinePassword.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/XMLNodeHandlerDataGrid.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/XMLNodeHandlerTabSet.cpp \
	$(LOCAL_PATH)/../../../../Source/Controls/XMLNodeHandlerTextArea.cpp
include $(BUILD_STATIC_LIBRARY)


#####################
include $(CLEAR_VARS)
LOCAL_MODULE := RocketCore
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../../Include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../$(FREETYPE)/include
LOCAL_CPPFLAGS := -DANDROID
LOCAL_CPPFLAGS += -DROCKET_STATIC_LIB
LOCAL_CPPFLAGS += -DROCKET_SHORT_INDICES
LOCAL_CPPFLAGS += -DRocketCore_EXPORTS
LOCAL_CPPFLAGS += -DRocketControls_EXPORTS
LOCAL_CPPFLAGS += -DRocketDebugger_EXPORTS
LOCAL_CPPFLAGS += -DRocketFreeType_EXPORTS
LOCAL_CPPFLAGS += -DRocketBitmapFont_EXPORTS
LOCAL_SRC_FILES := \
	$(LOCAL_PATH)/../../../../Source/Core/BaseXMLParser.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/BitmapFont/FontFace.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/BitmapFont/FontFaceHandle.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/BitmapFont/FontFaceLayer.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/BitmapFont/FontFamily.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/BitmapFont/FontParser.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/BitmapFont/FontProvider.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Box.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Clock.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Context.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ContextInstancer.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ContextInstancerDefault.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ConvolutionFilter.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Core.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Decorator.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/DecoratorInstancer.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/DecoratorNone.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/DecoratorNoneInstancer.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/DecoratorTiled.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/DecoratorTiledBox.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/DecoratorTiledBoxInstancer.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/DecoratorTiledHorizontal.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/DecoratorTiledHorizontalInstancer.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/DecoratorTiledImage.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/DecoratorTiledImageInstancer.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/DecoratorTiledInstancer.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/DecoratorTiledVertical.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/DecoratorTiledVerticalInstancer.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Dictionary.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/DocumentHeader.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Element.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ElementBackground.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ElementBorder.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ElementDecoration.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ElementDefinition.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ElementDocument.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ElementHandle.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ElementImage.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ElementInstancer.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ElementReference.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ElementScroll.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ElementStyle.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ElementStyleCache.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ElementText.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ElementTextDefault.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ElementUtilities.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Event.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/EventDispatcher.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/EventInstancer.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/EventInstancerDefault.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/EventListenerInstancer.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Factory.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/FileInterface.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/FileInterfaceDefault.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/FontDatabase.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/FontEffect.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/FontEffectInstancer.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/FontEffectNone.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/FontEffectNoneInstancer.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/FontEffectOutline.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/FontEffectOutlineInstancer.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/FontEffectShadow.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/FontEffectShadowInstancer.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/FontFace.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/FontFaceHandle.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/FontFaceLayer.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/FontFamily.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/FontProvider.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Freetype/FontFace.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Freetype/FontFaceHandle.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Freetype/FontFamily.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Freetype/FontProvider.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Geometry.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/GeometryDatabase.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/GeometryUtilities.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/LayoutBlockBox.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/LayoutBlockBoxSpace.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/LayoutEngine.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/LayoutInlineBox.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/LayoutInlineBoxText.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/LayoutLineBox.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Log.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Math.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Plugin.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/PluginRegistry.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/precompiled.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Property.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/PropertyDefinition.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/PropertyDictionary.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/PropertyParserColour.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/PropertyParserKeyword.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/PropertyParserNumber.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/PropertyParserString.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/PropertySpecification.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/ReferenceCountable.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/RenderInterface.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Stream.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StreamFile.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StreamMemory.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/String.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StringCache.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StringUtilities.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StyleSheet.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StyleSheetFactory.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StyleSheetNode.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StyleSheetNodeSelector.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StyleSheetNodeSelectorEmpty.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StyleSheetNodeSelectorFirstChild.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StyleSheetNodeSelectorFirstOfType.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StyleSheetNodeSelectorLastChild.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StyleSheetNodeSelectorLastOfType.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StyleSheetNodeSelectorNthChild.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StyleSheetNodeSelectorNthLastChild.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StyleSheetNodeSelectorNthLastOfType.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StyleSheetNodeSelectorNthOfType.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StyleSheetNodeSelectorOnlyChild.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StyleSheetNodeSelectorOnlyOfType.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StyleSheetParser.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/StyleSheetSpecification.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/SystemInterface.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Template.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/TemplateCache.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Texture.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/TextureDatabase.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/TextureLayout.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/TextureLayoutRectangle.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/TextureLayoutRow.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/TextureLayoutTexture.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/TextureResource.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/UnicodeRange.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/URL.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/Variant.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/WidgetSlider.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/WidgetSliderScroll.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/WString.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/XMLNodeHandler.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/XMLNodeHandlerBody.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/XMLNodeHandlerDefault.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/XMLNodeHandlerHead.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/XMLNodeHandlerTemplate.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/XMLParser.cpp \
	$(LOCAL_PATH)/../../../../Source/Core/XMLParseTools.cpp
include $(BUILD_STATIC_LIBRARY)

	
#####################
include $(CLEAR_VARS)
LOCAL_MODULE := RocketDebugger
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../../Include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../$(FREETYPE)/include
LOCAL_CPPFLAGS := -DANDROID
LOCAL_CPPFLAGS += -DROCKET_STATIC_LIB
LOCAL_CPPFLAGS += -DROCKET_SHORT_INDICES
LOCAL_CPPFLAGS += -DRocketCore_EXPORTS
LOCAL_CPPFLAGS += -DRocketControls_EXPORTS
LOCAL_CPPFLAGS += -DRocketDebugger_EXPORTS
LOCAL_CPPFLAGS += -DRocketFreeType_EXPORTS
LOCAL_CPPFLAGS += -DRocketBitmapFont_EXPORTS
LOCAL_SRC_FILES := \
	$(LOCAL_PATH)/../../../../Source/Debugger/Debugger.cpp \
	$(LOCAL_PATH)/../../../../Source/Debugger/ElementContextHook.cpp \
	$(LOCAL_PATH)/../../../../Source/Debugger/ElementInfo.cpp \
	$(LOCAL_PATH)/../../../../Source/Debugger/ElementLog.cpp \
	$(LOCAL_PATH)/../../../../Source/Debugger/Geometry.cpp \
	$(LOCAL_PATH)/../../../../Source/Debugger/Plugin.cpp \
	$(LOCAL_PATH)/../../../../Source/Debugger/SystemInterface.cpp
include $(BUILD_STATIC_LIBRARY)
