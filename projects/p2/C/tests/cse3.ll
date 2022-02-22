; ModuleID = 'cse3'
; CHECK-LABEL: source_filename = "cse3"
source_filename = "cse3"
; CHECK-LABEL: @cse3(i8* %0, i32* %1, i64* %2, i32 %3, i64 %4, i8 %5)
define i32 @cse3(i8* %0, i32* %1, i64* %2, i32 %3, i64 %4, i8 %5) {
; CHECK-NEXT: BB
; CHECK: alloca
; CHECK: load
; CHECK-NOT: load
; CHECK-NOT: and
; CHECK-NEXT: ret i32

BB:
  %A = alloca i32, align 4
  %A1 = alloca i32, align 4
  %L = load i32, i32* %A, align 4
  %L2 = load i32, i32* %A, align 4
  %6 = and i32 %L, %L2
  ret i32 %6
}
