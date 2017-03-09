include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = bordericon
bordericon_FILES = biRootListController.m
bordericon_INSTALL_PATH = /Library/PreferenceBundles
bordericon_FRAMEWORKS = UIKit
bordericon_PRIVATE_FRAMEWORKS = Preferences
bordericon_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/bordericon.plist$(ECHO_END)
