set RINGQT_QT512=1
set RINGQT_ANDROID=
set RINGQT_NOCORE=
set RINGQT_NOGUI=
set RINGQT_NOWIDGETS=
set RINGQT_NOTESTLIB=

set RINGQT_NOMULTIMEDIA=1
set RINGQT_NOMULTIMEDIAWIDGETS=1
set RINGQT_NOPRINTSUPPORT=1
set RINGQT_NONETWORK=1
set RINGQT_NOSQL=1
set RINGQT_NOPOSITIONING=1
set RINGQT_NOWEBKITWIDGETS=1
set RINGQT_NOWEBENGINEWIDGETS=1
set RINGQT_NOSERIALPORT=1
set RINGQT_NOAXCONTAINER=1
set RINGQT_NOQUICKWIDGETS=1
set RINGQT_NOQML=1
set RINGQT_NOSPEECH=1
set RINGQT_NOQT3D=1
set RINGQT_NOWEBKIT=1
set RINGQT_NOBLUETOOTH=1
set RINGQT_NOCHARTS=1

ring ..\codegen\parsec.ring classes\qt.cf cpp\src\ring_qt.cpp guilib\ring_qt.ring
cd events
ring qtevents.ring
cd ..
set RINGQT_QT512=