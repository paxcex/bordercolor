include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BorderIcon
BorderIcon_FILES = Tweak.xm
BorderIcon_FRAMEWORKS = UIKit
BorderIcon_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += bordericon
include $(THEOS_MAKE_PATH)/aggregate.mk
