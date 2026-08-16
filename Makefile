TARGET = iphone:clang:latest:14.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = 8BallMod

8BallMod_FILES = Tweak.x
8BallMod_CFLAGS = -fobjc-arc
8BallMod_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS)/makefiles/tweak.mk
