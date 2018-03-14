GO_EASY_ON_ME = 1
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MakeCydiaBuyAgain
MakeCydiaBuyAgain_FILES = Tweak.xm
MakeCydiaBuyAgain_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk


after-install::
	install.exec "killall -HUP SpringBoard"
