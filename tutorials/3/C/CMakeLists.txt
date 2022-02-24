cmake_minimum_required(VERSION 3.0)
project("tutorial5")

set(CMAKE_CXX_STANDARD 14)
#set(CMAKE_VERBOSE_MAKEFILE ON)

find_package(LLVM REQUIRED CONFIG)

list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
include(AddLLVM)

add_definitions(${LLVM_DEFINITIONS})
include_directories(${LLVM_INCLUDE_DIRS})

llvm_map_components_to_libnames(llvm_libs analysis bitreader bitwriter codegen core asmparser irreader instcombine instrumentation mc objcarcopts scalaropts support ipo target transformutils vectorize)

include_directories(.)

add_executable(dce dce.c worklist.cpp stats.cpp)
target_link_libraries(dce ${llvm_libs})

add_custom_target(test0.bc ALL
        clang-11 -O0 -Xclang -disable-O0-optnone -c -emit-llvm -o test0.bc ${CMAKE_CURRENT_SOURCE_DIR}/test0.c
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        DEPENDS dce test0.c
      )

enable_testing()

add_test(NAME RunDCE COMMAND dce test0.bc test0-dce.bc )
