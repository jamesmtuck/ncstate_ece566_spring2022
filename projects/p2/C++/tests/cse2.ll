; ModuleID = 'cse2'
; CHECK-LABEL: source_filename = "cse2"
source_filename = "cse2"
; CHECK-LABEL: @cse2(i8* %0, i32* %1, i64* %2, i32 %3, i64 %4, i8 %5)
define i32 @cse2(i8* %0, i32* %1, i64* %2, i32 %3, i64 %4, i8 %5) {
; CHECK-NEXT: BB
; CHECK-NEXT: ret

BB:
  %6 = lshr i32 0, -1
  %7 = and i32 0, -1
  %8 = udiv i32 %6, %7
  ret i32 %8
}
