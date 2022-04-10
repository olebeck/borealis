cmake_minimum_required(VERSION 3.2)

option(VITA "Build For Vita" OFF)

if(VITA)
    set(CMAKE_TOOLCHAIN_FILE "$ENV{VITASDK}/share/vita.toolchain.cmake" CACHE PATH "VitaSDK toolchain file")
    set(VITASDK_CMAKE_FILE "$ENV{VITASDK}/share/vita.cmake" CACHE PATH "VitaSDK CMake functions file")
    include("${VITASDK_CMAKE_FILE}" REQUIRED)
endif()

project(borealis_demo)

add_subdirectory(library)

add_executable(borealis_demo 
    demo/main.cpp
    demo/main_activity.cpp
    demo/captioned_image.cpp
    demo/recycling_list_tab.cpp
    demo/components_tab.cpp
)

target_link_libraries(borealis_demo
    borealis
)

if(VITA)
    target_compile_definitions(borealis PUBLIC
        BRLS_RESOURCES="app0:/resources/")
else()
    target_compile_definitions(borealis PUBLIC
        BRLS_RESOURCES="../resources/")
endif()

macro(vita_add_files target file_path)
    add_custom_target(add_files ALL
        DEPENDS ${target}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        COMMAND 7z a "${CMAKE_CURRENT_BINARY_DIR}/${target}" ${file_path}
    )
endmacro(vita_add_files)

file(GLOB_RECURSE RESOURCES RELATIVE "${PROJECT_SOURCE_DIR}" "resources/*")

if(NOT VITA)
    macro(vita_create_self)
    endmacro()
    macro(vita_create_vpk)
    endmacro()
endif()

if(VITA)
    vita_create_self(borealis_demo.self borealis_demo UNSAFE)
	vita_create_vpk(borealis_demo.vpk BORE00000 borealis_demo.self
		NAME "borealis_demo"
        FILE module/libGLESv2.suprx module/libGLESv2.suprx
        FILE module/libgpu_es4_ext.suprx module/libgpu_es4_ext.suprx
        FILE module/libIMGEGL.suprx module/libIMGEGL.suprx
        FILE module/libpvrPSP2_WSEGL.suprx module/libpvrPSP2_WSEGL.suprx
    )
    # add RESOURCES to the vpk zip
    vita_add_files(borealis_demo.vpk "resources")
endif()