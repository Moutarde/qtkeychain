DEFINES += QKEYCHAIN_STATICLIB

HEADERS += \
    $$PWD/keychain_p.h \
    $$PWD/keychain.h \
    $$PWD/qkeychain_export.h

SOURCES += $$PWD/keychain.cpp

win32 {
    SOURCES += $$PWD/keychain_win.cpp
    LIBS += -lcrypt32
} else:macx {
    SOURCES += $$PWD/keychain_mac.cpp
    LIBS += -framework CoreFoundation -framework Security
} else:unix {
    QT += dbus
    HEADERS += $$PWD/gnomekeyring_p.h
    SOURCES += \
        $$PWD/gnomekeyring.cpp \
        $$PWD/keychain_unix.cpp
    DBUS_ADAPTORS += $$PWD/org.kde.KWallet.xml
    DBUS_INTERFACES += $$PWD/org.kde.KWallet.xml
}
