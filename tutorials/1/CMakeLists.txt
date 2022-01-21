cmake_minimum_required(VERSION 3.0)
project("tutorial1")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-deprecated-register")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-deprecated-register")

#set(CMAKE_VERBOSE_MAKEFILE ON)

find_package(BISON)
find_package(FLEX)

BISON_TARGET(Parser expr.y ${CMAKE_CURRENT_BINARY_DIR}/expr.y.cpp)
FLEX_TARGET(Scanner expr.lex ${CMAKE_CURRENT_BINARY_DIR}/expr.lex.cpp)
ADD_FLEX_BISON_DEPENDENCY(Scanner Parser)

include_directories(.)

add_executable(t1 ${BISON_Parser_OUTPUTS} ${FLEX_Scanner_OUTPUTS})
target_link_libraries(t1 y)
