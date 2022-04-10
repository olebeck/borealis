cmake_minimum_required(VERSION 3.2)

project(borealis)

set(CMAKE_CXX_STANDARD 17)

add_library(borealis STATIC
    lib/core/logger.cpp
    lib/core/application.cpp
    lib/core/i18n.cpp
    lib/core/theme.cpp
    lib/core/style.cpp
    lib/core/activity.cpp
    lib/core/platform.cpp
    lib/core/font.cpp
    lib/core/util.cpp
    lib/core/time.cpp
    lib/core/timer.cpp
    lib/core/animation.cpp
    lib/core/task.cpp
    lib/core/view.cpp
    lib/core/box.cpp
    lib/core/bind.cpp

    lib/platforms/glfw/glfw_platform.cpp
    lib/platforms/glfw/glfw_video.cpp
    lib/platforms/glfw/glfw_input.cpp
    lib/platforms/glfw/glfw_font.cpp

    lib/platforms/switch/swkbd.cpp

    lib/views/scrolling_frame.cpp
    lib/views/applet_frame.cpp
    lib/views/tab_frame.cpp
    lib/views/rectangle.cpp
    lib/views/sidebar.cpp
    lib/views/label.cpp
    lib/views/button.cpp
    lib/views/image.cpp
    lib/views/header.cpp

    lib/extern/glad/glad.c
    lib/extern/nanovg-gl/nanovg.c
    lib/extern/tinyxml2/tinyxml2.cpp

    lib/extern/fmt/src/format.cc
    lib/extern/fmt/src/os.cc

    lib/extern/libretro-common/compat/compat_strl.c
    lib/extern/libretro-common/features/features_cpu.c
    lib/extern/libretro-common/encodings/encoding_utf.c

    lib/extern/yoga/src/yoga/event/event.cpp
    lib/extern/yoga/src/yoga/log.cpp
    lib/extern/yoga/src/yoga/Utils.cpp
    lib/extern/yoga/src/yoga/YGConfig.cpp
    lib/extern/yoga/src/yoga/YGEnums.cpp
    lib/extern/yoga/src/yoga/YGLayout.cpp
    lib/extern/yoga/src/yoga/YGNode.cpp
    lib/extern/yoga/src/yoga/YGStyle.cpp
    lib/extern/yoga/src/yoga/YGValue.cpp
    lib/extern/yoga/src/yoga/Yoga.cpp
)

target_include_directories(borealis PUBLIC
    "include"
    "lib/extern/fmt/include"
    "include/borealis/extern"
    "include/borealis/extern/tinyxml2"
    "include/borealis/extern/nanovg-gl"
    "lib/extern/yoga/src"
    "lib/extern/tweeny/include"
)

target_link_directories(borealis PUBLIC # *temp*
    "~/glfw-vita/build"
)

set(GLFW glfw)
if(VITA)
    set(GLFW glfw3)
endif()

target_link_libraries(borealis
    ${GLFW}
    pthread
)

if(VITA)
target_link_libraries(borealis
    #SCE
    SceTouch_stub
    SceCtrl_stub
    SceDisplay_stub

    #PVR_PSP2
    libIMGEGL_stub_weak
    libgpu_es4_ext_stub_weak
    libGLESv2_stub_weak
    m
)
add_definitions(-DVITA)
endif()

add_definitions(-DYG_ENABLE_EVENTS)
add_definitions(-D__GLFW__)