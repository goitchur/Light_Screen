cmake_minimum_required(VERSION 3.28)

cmake_policy(SET CMP0123 NEW)

set(CMAKE_SYSTEM_NAME Generic)
set(CPU_CORE cortex-m3)
set(CMAKE_SYSTEM_PROCESSOR ${CPU_CORE})

set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_LIST_DIR}/toolchain.cmake)

project(Light_Screen C ASM)

string(TOUPPER ${CMAKE_BUILD_TYPE} BUILD_TYPE_UPPER)
if(${BUILD_TYPE_UPPER} STREQUAL "RELEASE")
    add_compile_options(-Os)
else()
    add_compile_options(-Og -g)
endif()

add_compile_definitions(
    USE_FULL_LL_DRIVER 
    HSE_VALUE=8000000 
    HSE_STARTUP_TIMEOUT=100 
    LSE_STARTUP_TIMEOUT=5000 
    LSE_VALUE=32768 
    HSI_VALUE=8000000 
    LSI_VALUE=40000 
    VDD_VALUE=3300 
    PREFETCH_ENABLE=1 
    STM32F103xB
)

include_directories(
    ${CMAKE_CURRENT_LIST_DIR}/Core/Inc
    ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Inc
    ${CMAKE_CURRENT_LIST_DIR}/Drivers/CMSIS/Device/Include
    ${CMAKE_CURRENT_LIST_DIR}/Drivers/CMSIS/Include
    ${CMAKE_CURRENT_LIST_DIR}/Device/Inc
    ${CMAKE_CURRENT_LIST_DIR}/Common/Inc
)

file(GLOB SOURCE_FILE
    ${CMAKE_CURRENT_LIST_DIR}/Common/Src/*.c
    ${CMAKE_CURRENT_LIST_DIR}/Core/Src/*.c
    ${CMAKE_CURRENT_LIST_DIR}/Device/Src/*.c
    ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/*.c
)

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/Output)
set(HEX_FILE ${EXECUTABLE_OUTPUT_PATH}/${PROJECT_NAME}.hex)
set(BIN_FILE ${EXECUTABLE_OUTPUT_PATH}/${PROJECT_NAME}.bin)
set(MAP_FILE ${EXECUTABLE_OUTPUT_PATH}/${PROJECT_NAME}.map)

if(USE_ARMGCC)
    set(STARTUP_FILE ${CMAKE_CURRENT_LIST_DIR}/Drivers/startup_stm32f103xb.s)
    set(LINKER_SCRIPT ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F103C8Tx_FLASH.ld)

    add_compile_options(
        -mcpu=${CPU_CORE}
        -mthumb
        -mthumb-interwork
        -ffunction-sections
        -fdata-sections
        -fno-common
        -fmessage-length=0
    )

    add_link_options(
        -Wl,-Map=${MAP_FILE}
        -Wl,--print-memory-usage
        -Wl,--gc-sections
        -T ${LINKER_SCRIPT}
    )
else()

endif()

add_executable(${PROJECT_NAME}.elf ${SOURCE_FILE} ${STARTUP_FILE})
set_target_properties(${PROJECT_NAME}.elf PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${EXECUTABLE_OUTPUT_PATH}
)

if(USE_ARMGCC)
    add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${PROJECT_NAME}.elf> ${HEX_FILE}
        COMMAND ${CMAKE_OBJCOPY} -Obinary $<TARGET_FILE:${PROJECT_NAME}.elf> ${BIN_FILE}
        COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${PROJECT_NAME}.elf>        
    )
else()

endif()