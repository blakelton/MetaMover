cmake_minimum_required(VERSION 3.5)

project(MetaMover VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets LinguistTools Concurrent)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets LinguistTools Concurrent)

set(TS_FILES MetaMover_en_US.ts)

set(PROJECT_SOURCES
    main.cpp
    metamovermainwindow.cpp
    metamovermainwindow.h
    metamovermainwindow.ui
    exif.cpp
    exif.h
    appconfig.h
    appconfigmanager.h 
    appconfigmanager.cpp
    basicfilehandler.h 
    basicfilehandler.cpp
    photofilehandler.h 
    photofilehandler.cpp
    scanner.h 
    scanner.cpp
    videofilehandler.h 
    videofilehandler.cpp
    ifilehandler.h
    filehandlerfactory.h
    transfermanager.h 
    transfermanager.cpp
    directorytransfer.h 
    directorytransfer.cpp
    resources.qrc
    appicon.rc
    ${TS_FILES}
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(MetaMover
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )

    qt_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ${TS_FILES})
else()
    if(ANDROID)
        add_library(MetaMover SHARED
            ${PROJECT_SOURCES}
        )
    else()
        add_executable(MetaMover
            ${PROJECT_SOURCES}
            appicon.rc
        )
    endif()

    qt5_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ${TS_FILES})
endif()

target_link_libraries(MetaMover PRIVATE Qt${QT_VERSION_MAJOR}::Widgets Qt${QT_VERSION_MAJOR}::Concurrent)

if(${QT_VERSION} VERSION_LESS 6.1.0)
  set(BUNDLE_ID_OPTION MACOSX_BUNDLE_GUI_IDENTIFIER com.example.MetaMover)
endif()

set_target_properties(MetaMover PROPERTIES
    ${BUNDLE_ID_OPTION}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS MetaMover
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(MetaMover)
endif()
