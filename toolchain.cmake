set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NERVER)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

option(USE_ARMGCC "USE_ARMGCC" ON)

if(USE_ARMGCC)
    set(COMPILER_ROOT_PATH G:/Tool/gcc-arm-none-eabi/bin)
    set(CMAKE_C_COMPILER ${COMPILER_ROOT_PATH}/arm-none-eabi-gcc.exe)
    set(CMAKE_CXX_COMPILER ${COMPILER_ROOT_PATH}/arm-none-eabi-g++.exe)
    set(CMAKE_ASM_COMPILER ${COMPILER_ROOT_PATH}/arm-none-eabi-gcc.exe)
    set(CMAKE_OBJCOPY ${COMPILER_ROOT_PATH}/arm-none-eabi-objcopy.exe)
    set(CMAKE_SIZE ${COMPILER_ROOT_PATH}/arm-none-eabi-size.exe)
else()

endif()