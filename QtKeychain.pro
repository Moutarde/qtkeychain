TEMPLATE = lib
VERSION = 0.5.0

HEADERS += \
    keychain_p.h \
    keychain.h \
    qkeychain_export.h

SOURCES += \
    keychain.cpp \
    testclient.cpp

win32 {
    SOURCES += keychain_win.cpp
    LIBS += -lcrypt32
} else:macx {
    SOURCES += keychain_mac.cpp
    LIBS += -framework CoreFoundation -framework Security
} else:unix {
    QT += dbus
    HEADERS += gnomekeyring_p.h
    SOURCES += gnomekeyring.cpp keychain_unix.cpp
    DBUS_ADAPTORS += org.kde.KWallet.xml
    DBUS_INTERFACES += org.kde.KWallet.xml
}
