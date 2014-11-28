APP_NAME = DuktoBerry

CONFIG += qt warn_on cascades10

QT += network

LIBS += -lbb -lbbsystem -lbbdevice -lbbplatform

include(config.pri)
