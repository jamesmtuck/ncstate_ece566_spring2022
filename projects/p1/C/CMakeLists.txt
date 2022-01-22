cmake_minimum_required(VERSION 3.0)
project("project1")

set(CMAKE_CXX_STANDARD 14)
#set(CMAKE_VERBOSE_MAKEFILE ON)

find_package(BISON)
find_package(FLEX)

find_package(LLVM REQUIRED CONFIG)

list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
include(AddLLVM)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-deprecated-register ")

add_definitions(${LLVM_DEFINITIONS})
include_directories(${LLVM_INCLUDE_DIRS})

llvm_map_components_to_libnames(llvm_libs analysis bitreader bitwriter codegen core asmparser irreader instcombine instrumentation mc objcarcopts scalaropts support ipo target transformutils vectorize)


BISON_TARGET(Parser p1.y ${CMAKE_CURRENT_BINARY_DIR}/p1.y.c)
FLEX_TARGET(Scanner p1.lex ${CMAKE_CURRENT_BINARY_DIR}/p1.lex.c)
ADD_FLEX_BISON_DEPENDENCY(Scanner Parser)

include_directories(.)

add_executable(p1 p1.c ${BISON_Parser_OUTPUTS} ${FLEX_Scanner_OUTPUTS})
target_link_libraries(p1 y l ${llvm_libs})


enable_testing()
add_test(NAME Usage COMMAND p1)
set_tests_properties(Usage
   PROPERTIES PASS_REGULAR_EXPRESSION "Usage:"
   )

add_subdirectory(tests)
