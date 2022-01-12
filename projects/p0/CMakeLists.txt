cmake_minimum_required(VERSION 3.0)
project("Project0")

set(CMAKE_CXX_STANDARD 14)

#set(CMAKE_VERBOSE_MAKEFILE ON)

find_package(LLVM REQUIRED CONFIG)

list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
include(AddLLVM)

add_definitions(${LLVM_DEFINITIONS})
include_directories(${LLVM_INCLUDE_DIRS})

llvm_map_components_to_libnames(llvm_libs analysis bitreader bitwriter codegen core asmparser irreader instcombine instrumentation mc objcarcopts scalaropts support ipo target transformutils vectorize)

add_executable(p0 p0.cpp)
#add_executable(p0 p0.c)

target_link_libraries(p0 ${llvm_libs})
