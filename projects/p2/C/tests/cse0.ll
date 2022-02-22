; RUN: ./p2 %s out.ll | FileCheck %s

; ModuleID = 'cse0'
; CHECK: source_filename = "cse0"
source_filename = "cse0"

; CHECK-LABEL: @cse0
define void @cse0(i8* %0, i32* %1, i64* %2, i32 %3, i64 %4, i8 %5) {
BB:
; CHECK-NEXT: BB
  %B = lshr i32 %3, %3
  %6 = lshr i32 %3, %3
  %7 = lshr i32 %3, %3
  %8 = lshr i32 %3, %3
  %9 = lshr i32 %3, %3
  %10 = lshr i32 %3, %3
; CHECK-NEXT: ret void
  ret void
}
