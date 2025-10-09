cmake_minimum_required(VERSION 3.25.2)
project(CGUebungen VERSION 0.1.0)


include_directories(
        "C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.42.34433/include"
        "C:/Program Files (x86)/Windows Kits/10/Include/14.42.34433/ucrt"
        "C:/Program Files (x86)/Windows Kits/10/Include/14.42.34433/um"
        "C:/Program Files (x86)/Windows Kits/10/Include/14.42.34433/shared"
)


include(common.cmake)
set(common_included true)
add_subdirectory(SORS)

#Alle Unterverzeichnisse von CGR_Uebungen
message("${PROJECT_SOURCE_DIR}/CGR_Uebungen/*")
FILE(GLOB Uebungen "${PROJECT_SOURCE_DIR}/CGR_Uebungen/*")
#Alle Unterverzeichnisse von examplesbasic
message("${PROJECT_SOURCE_DIR}/examplesbasic/*")
FILE(GLOB ExamplesBasic "${PROJECT_SOURCE_DIR}/examplesbasic/*")
#Alle Unterverzeichnisse von vorlesungsbeispiele
message("${PROJECT_SOURCE_DIR}/vorlesungsbeispiele/*")
FILE(GLOB vorlesungsbeispiele "${PROJECT_SOURCE_DIR}/vorlesungsbeispiele/*")

# Alle Unterverzeichnisse in Uebungen und anderen hinzufügen
FOREACH(subdir ${Uebungen})
    IF(IS_DIRECTORY ${subdir})
        message("${subdir}")
        add_subdirectory(${subdir})
    ENDIF()
ENDFOREACH()

FOREACH(subdir ${ExamplesBasic})
    IF(IS_DIRECTORY ${subdir})
        message("${subdir}")
        add_subdirectory(${subdir})
    ENDIF()
ENDFOREACH()

FOREACH(subdir ${vorlesungsbeispiele})
    IF(IS_DIRECTORY ${subdir})
        message("${subdir}")
        add_subdirectory(${subdir})
    ENDIF()
ENDFOREACH()
