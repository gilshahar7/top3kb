FINALPACKAGE = 1
ARCHS = armv7 arm64 arm64e

TWEAK_NAME = Top3KB
Top3KB_OBJCC_FILES = Tweak.xm
Top3KB_FRAMEWORKS = UIKit
Top3KB_CFLAGS = -F$(SYSROOT)/System/Library/CoreServices -fobjc-arc
GO_EASY_ON_ME = 1

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
