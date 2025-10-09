cmake_minimum_required(VERSION 3.25)
project(repo)

set(CMAKE_CXX_STANDARD 17)

add_subdirectory(_CGR)

add_executable(repo main.cpp)
