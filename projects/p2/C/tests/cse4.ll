; ModuleID = 'cse4'

; CHECK-LABEL: source_filename = "cse4"
source_filename = "cse4"

; CHECK-LABEL: i32 @cse4(i8* %0, i32* %1, i64* %2, i32 %3, i64 %4, i8 %5)
define i32 @cse4(i8* %0, i32* %1, i64* %2, i32 %3, i64 %4, i8 %5) {
; CHECK-NEXT: BB
; CHECK-NEXT: alloca
; CHECK-NEXT: alloca
; CHECK-NEXT: store
; CHECK-NEXT: ret i32

BB:
  %A = alloca i32, align 4
  %A1 = alloca i32, align 4
  store i32 -1, i32* %A, align 4
  %L = load i32, i32* %A, align 4
  %6 = sdiv i32 %L, 255838
  %7 = srem i32 %6, %3
  ret i32 %7
}
