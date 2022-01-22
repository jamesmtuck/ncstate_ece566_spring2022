function(p1_failure name)
   add_test(NAME Fail-${name}
      COMMAND ${CMAKE_CURRENT_BINARY_DIR}/../p1 ${CMAKE_CURRENT_SOURCE_DIR}/${name}.p1 ${CMAKE_CURRENT_BINARY_DIR}/${name}.bc
      )
   set_tests_properties(Fail-${name} PROPERTIES WILL_FAIL TRUE)
endfunction(p1_failure)

p1_failure(fail_1)
p1_failure(fail_2)
p1_failure(fail_3)
p1_failure(fail_4)


add_executable(llvm-inst-count llvm-inst-count.cpp)
target_link_libraries(llvm-inst-count ${llvm_libs})

function(do_test target name result)
  add_test(NAME ${name} COMMAND ${target} )
  set_tests_properties(${name}
    PROPERTIES PASS_REGULAR_EXPRESSION ${result}
    )
endfunction(do_test)

function(p1_test name class result)
   add_custom_command(
      OUTPUT ${name}.bc
      COMMAND p1 ${CMAKE_CURRENT_SOURCE_DIR}/${name}.p1 ${CMAKE_CURRENT_BINARY_DIR}/${name}.bc
      DEPENDS p1 ${CMAKE_CURRENT_SOURCE_DIR}/${name}.p1
      )
   add_custom_command(
      OUTPUT ${name}.bc.o
      COMMAND clang-11 -c -o ${CMAKE_CURRENT_BINARY_DIR}/${name}.bc.o ${CMAKE_CURRENT_BINARY_DIR}/${name}.bc
      DEPENDS ${name}.bc
      )
   add_executable(${name} ${CMAKE_CURRENT_BINARY_DIR}/${name}.bc.o ${name}.c)
   do_test(${name} ${class}-${name} ${result})
endfunction(p1_test)

function(p1_simple_test name class)
   add_custom_command(
      OUTPUT ${name}.bc
      COMMAND p1 ${CMAKE_CURRENT_SOURCE_DIR}/${name}.p1 ${CMAKE_CURRENT_BINARY_DIR}/${name}.bc
      DEPENDS p1 ${CMAKE_CURRENT_SOURCE_DIR}/${name}.p1
      )
   add_custom_command(
      OUTPUT ${name}.bc.o
      COMMAND clang-11 -c -o ${CMAKE_CURRENT_BINARY_DIR}/${name}.bc.o ${CMAKE_CURRENT_BINARY_DIR}/${name}.bc
      DEPENDS ${name}.bc
      )
   add_executable(${name} ${CMAKE_CURRENT_BINARY_DIR}/${name}.bc.o ${name}.c)
   add_test(NAME ${class}-${name} COMMAND ${name} )
   add_test(NAME InstCount-${name} COMMAND ${CMAKE_CURRENT_BINARY_DIR}/llvm-inst-count ${CMAKE_CURRENT_BINARY_DIR}/${name}.bc)
endfunction(p1_simple_test)

p1_simple_test(test_0 466)
p1_simple_test(test_1 466)
p1_simple_test(test_2 466)
p1_simple_test(test_3 466)
p1_simple_test(test_4 466)
p1_simple_test(test_5 466)
p1_simple_test(test_6 466)
p1_simple_test(test_7 466)
p1_simple_test(test_8 466)
p1_simple_test(test_15 466)

p1_simple_test(test_9 566)
p1_simple_test(test_10 566)
p1_simple_test(test_11 566)
p1_simple_test(test_12 566)
p1_simple_test(test_13 566)
p1_simple_test(test_14 566)
p1_simple_test(test_16 566)
p1_simple_test(test_17 566)
p1_simple_test(flip 566)
p1_simple_test(syndrome_ecc 566)
p1_simple_test(into_ecc 566)



