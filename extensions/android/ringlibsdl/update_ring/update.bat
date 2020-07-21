rem	Simple Batch file to update Ring in the Android-LibSDL Version 
rem	Author : Mahmoud Fayed <msfclipper@yahoo.com>

copy ..\..\..\..\language\src\*.c ..\project\jni\ring\src\
copy ..\..\..\ringsdl\ring_libsdl.c ..\project\jni\ring\src\
copy ring_ext.c ..\project\jni\ring\src\
copy ..\..\..\..\language\include\*.h ..\project\jni\ring\include\
copy ring_ext.h ..\project\jni\ring\include\
copy ..\..\..\..\ringlibs\gameengine\gameengine.ring ..\project\assets\
copy ..\..\..\..\ringlibs\gameengine\gameengine.rh ..\project\assets\
copy ..\..\..\..\ringlibs\gameengine\classes\*.ring ..\project\assets\classes
copy ..\..\..\..\ringlibs\gameengine\gl_allegro.ring ..\project\assets\
copy ..\..\..\..\ringlibs\gameengine\gl_libsdl.ring ..\project\assets\
copy ..\..\..\ringsdl\libsdl.ring ..\project\assets\
copy ..\..\..\ringsdl\ring_libsdl.rh ..\project\assets\
copy ..\..\..\ringsdl\sdl.rh ..\project\assets\