# Minimal qmake support.
# This file is provided as is without any warranty.
# It can break at anytime or be removed without notice.

DEFINES += QTKEYCHAIN_NO_EXPORT

INCLUDEPATH += $$PWD

HEADERS += \
    $$PWD/keychain_p.h \
    $$PWD/keychain.h

SOURCES += \
    $$PWD/keychain.cpp

macx {
    LIBS += "-framework Security" "-framework Foundation"
    SOURCES += $$PWD/keychain_mac.cpp
} else {
    HEADERS += $$PWD/plaintextstore_p.h
    SOURCES += $$PWD/plaintextstore.cpp

    win32 {
        SOURCES += $$PWD/keychain_win.cpp

        LIBS += -lcrypt32 -ladvapi32
        DEFINES += USE_CREDENTIAL_STORE
    } else:unix {
    	QT += dbus

        HEADERS += \
            $$PWD/gnomekeyring_p.h \
            $$PWD/libsecret_p.h

        SOURCES += \
            $$PWD/keychain_unix.cpp \
            $$PWD/gnomekeyring.cpp \
            $$PWD/libsecret.cpp

        DBUS_INTERFACES += $$PWD/org.kde.KWallet.xml
    }
}
